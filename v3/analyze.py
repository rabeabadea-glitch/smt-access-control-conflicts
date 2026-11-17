"""Turn the pair tables into the tables and the figure of the article.

Reads results/pairs_<dataset>.json (written by funnel.py) and writes
  results/summary.json          every number quoted in the article
  results/table1_benchmark.csv  one row per dataset
  results/table2_ablation.csv   one row per dataset and filter variant
  results/sweep_similarity.csv, results/sweep_entity.csv
  results/fig1_funnel.png, results/fig2_threshold_sweep.png
All metrics are computed over the eligible pairs only (opposite effects; and
different sources in the cross-framework corpus). "Recall" is the share of the
conflicts found by exhaustive Z3 that a filter lets through to the solver.
"""
from __future__ import annotations
import csv
import json
import statistics
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
OUT = HERE / 'results'
ORDER = ['GEYSERS', 'KMarket', 'Continue-A', 'Pluto', 'Fedora', 'Synthetic360', 'CrossFramework']
E, N = 0.65, 0.25
GOVERNED = [('GDPR-17-erase-governed', 'AMLD-40-retain-cdd-governed'),
            ('PCI-8-3-9-rotate-password-governed', 'NIST-63B-no-forced-rotation-governed'),
            ('GDPR-15-subject-access-governed', 'AMLD-39-tipping-off-governed'),
            ('AMLD-investigator-full-pan-governed', 'PCI-3-3-mask-pan-governed'),
            ('GDPR-6-restrict-transfer-ungoverned', 'DORA-19-report-incident-governed')]


def load(name):
    path = OUT / f'pairs_{name}.json'
    return json.loads(path.read_text()) if path.exists() else None


def metrics(rows, keep):
    kept = [r for r in rows if keep(r)]
    total = sum(r['status'] == 'SAT' for r in rows)
    tp = sum(r['status'] == 'SAT' for r in kept)
    precision = tp / len(kept) if kept else None
    recall = tp / total if total else None
    f1 = (2 * precision * recall / (precision + recall)) if precision and recall else (0.0 if total and kept else None)
    return {'kept': len(kept), 'conflicts_kept': tp, 'conflicts_lost': total - tp,
            'recall': recall, 'precision': precision, 'f1': f1,
            'pairs_removed_percent': round(100 * (1 - len(kept) / len(rows)), 2) if rows else None,
            'solver_seconds': round(sum(r['solve_ms'] for r in kept) / 1000, 2)}


def variants(has_e, e=E, n=N):
    sim = (lambda r: r['cosine'] >= e)
    ent = (lambda r: r['jaccard'] >= n)
    sco = (lambda r: r['scope'])
    out = {'exhaustive (no filter)': lambda r: True}
    if has_e:
        out['similarity only'] = sim
    out['entity overlap only'] = ent
    out['scope query only'] = sco
    if has_e:
        out['without scope query (similarity + entity)'] = lambda r: sim(r) and ent(r)
        out['without entity overlap (similarity + scope)'] = lambda r: sim(r) and sco(r)
    out['without similarity (entity + scope)'] = lambda r: ent(r) and sco(r)
    if has_e:
        out['all three filters'] = lambda r: sim(r) and ent(r) and sco(r)
    out['TF-IDF baseline'] = lambda r: r['tfidf'] >= 0.30
    out['keyword baseline'] = lambda r: r['keyword'] >= 0.20
    out['older shared-attribute SPARQL gate'] = lambda r: r['graph']
    return out


def main(elapsed_seconds=None):
    summary = {'thresholds': {'similarity': E, 'entity_overlap': N, 'tfidf': 0.30, 'keyword': 0.20, 'solver_budget_ms': 2000},
               'datasets': {}}
    bench, abl, sweep_e, sweep_n = [], [], [], []
    all_ms, statuses = [], {}
    for name in ORDER:
        t = load(name)
        if t is None:
            continue
        rows = t['rows']
        has_e = bool(rows) and rows[0]['cosine'] is not None
        ms = [r['solve_ms'] for r in rows]
        all_ms += ms
        for r in rows:
            statuses[r['status']] = statuses.get(r['status'], 0) + 1
        d = {'rules': t['stats']['rules'], 'permit': t['stats']['permit'], 'deny': t['stats']['deny'],
             'all_pairs': t['all_pairs'], 'eligible_pairs': len(rows),
             'conflicts': sum(r['status'] == 'SAT' for r in rows), 'dead_rules': t['dead_rules'],
             'sources': t['stats']['sources'], 'attributes': t['stats']['attributes'],
             'skipped_elements': t['stats']['skipped_elements'],
             'designators_without_category': t['stats']['designators_without_category'],
             'rank_coded_attributes': t['stats']['rank_coded_attributes'],
             'solver': {'calls': len(rows), 'seconds': round(sum(ms) / 1000, 2),
                        'median_ms': round(statistics.median(ms), 2) if ms else None,
                        'max_ms': round(max(ms), 2) if ms else None,
                        'not_sat_or_unsat': sum(r['status'] not in ('SAT', 'UNSAT') for r in rows)},
             'variants': {k: metrics(rows, f) for k, f in variants(has_e).items()}}
        d['model_file'] = t.get('model_file')
        d['z3'] = t.get('z3')
        if has_e:       # pairs reaching each stage, in the similarity-first order and reordered
            steps, kept = [], rows
            for label, f in (('similarity', lambda r: r['cosine'] >= E), ('entity overlap', lambda r: r['jaccard'] >= N),
                             ('scope query', lambda r: r['scope'])):
                kept = [r for r in kept if f(r)]
                steps.append({'stage': label, 'kept': len(kept), 'conflicts_kept': sum(r['status'] == 'SAT' for r in kept)})
            d['cascade_original'] = steps
        if name == 'CrossFramework':       # the witness printed in the introduction, with readable attribute names
            import funnel
            import intake
            from pcproof.verify import attr_mentions
            m = intake.load(*funnel.DATASETS[name])
            row = next(r for r in rows if set(r['pair']) == {'GDPR-17-erase-ungoverned', 'AMLD-40-retain-txn'})
            both = [r for r in m['display']['rules'] if r['id'] in row['pair']]
            used = attr_mentions(both[0]['condition']) | attr_mentions(both[1]['condition'])
            d['intro_witness'] = {m['mapping'][k]['AttributeId'].rsplit(':', 1)[-1]: v for k, v in row['witness'].items() if k in used}
            d['intro_witness_status'] = row['status']
        if name == 'CrossFramework':       # the five pairs whose translations keep the legal exception
            by_pair = {frozenset(r['pair']): r for r in rows}
            d['governed_pairs'] = [{'pair': list(g), 'status': by_pair[frozenset(g)]['status'],
                                    'cosine': by_pair[frozenset(g)]['cosine'], 'scope': by_pair[frozenset(g)]['scope']}
                                   for g in GOVERNED]
            if has_e:
                ranked = sorted(rows, key=lambda r: -r['cosine'])
                d['most_similar_pairs'] = [{'pair': r['pair'], 'cosine': round(r['cosine'], 3), 'status': r['status']} for r in ranked[:5]]
        d['cascade_reordered'] = [{'stage': 'scope query', 'kept': d['variants']['scope query only']['kept'],
                                   'conflicts_kept': d['variants']['scope query only']['conflicts_kept']}]
        summary['datasets'][name] = d
        full = d['variants'].get('all three filters', {})
        bench.append({'dataset': name, 'rules': d['rules'], 'all_pairs': d['all_pairs'], 'eligible_pairs': d['eligible_pairs'],
                      'conflicts': d['conflicts'],
                      'filters_kept': full.get('kept'), 'filters_conflicts_kept': full.get('conflicts_kept'),
                      'filters_recall': full.get('recall'), 'filters_precision': full.get('precision'), 'filters_f1': full.get('f1'),
                      'scope_kept': d['variants']['scope query only']['kept'], 'scope_recall': d['variants']['scope query only']['recall'],
                      'tfidf_kept': d['variants']['TF-IDF baseline']['kept'], 'tfidf_recall': d['variants']['TF-IDF baseline']['recall'],
                      'tfidf_f1': d['variants']['TF-IDF baseline']['f1'],
                      'keyword_kept': d['variants']['keyword baseline']['kept'], 'keyword_recall': d['variants']['keyword baseline']['recall'],
                      'keyword_f1': d['variants']['keyword baseline']['f1'],
                      'exhaustive_solver_seconds': d['solver']['seconds']})
        for k, m in d['variants'].items():
            abl.append({'dataset': name, 'variant': k, **m})
        if has_e:
            for th in [x / 100 for x in range(30, 96, 5)]:
                alone = metrics(rows, lambda r, th=th: r['cosine'] >= th)
                chain = metrics(rows, lambda r, th=th: r['cosine'] >= th and r['jaccard'] >= N and r['scope'])
                sweep_e.append({'dataset': name, 'threshold': th, 'kept': alone['kept'], 'share_kept': alone['kept'] / len(rows), 'recall': alone['recall'],
                                'precision': alone['precision'], 'f1': alone['f1'],
                                'all_three_kept': chain['kept'], 'all_three_recall': chain['recall']})
        for th in [x / 100 for x in range(5, 71, 5)]:
            alone = metrics(rows, lambda r, th=th: r['jaccard'] >= th)
            sweep_n.append({'dataset': name, 'threshold': th, 'kept': alone['kept'], 'share_kept': alone['kept'] / len(rows) if rows else None, 'recall': alone['recall'],
                            'precision': alone['precision'], 'f1': alone['f1']})
        if has_e and d['conflicts']:
            sat = sorted(r['cosine'] for r in rows if r['status'] == 'SAT')
            uns = sorted(r['cosine'] for r in rows if r['status'] == 'UNSAT')
            d['cosine'] = {'conflict_min': round(sat[0], 3), 'conflict_median': round(statistics.median(sat), 3), 'conflict_max': round(sat[-1], 3),
                           'non_conflict_median': round(statistics.median(uns), 3) if uns else None,
                           'non_conflict_max': round(uns[-1], 3) if uns else None,
                           'largest_threshold_keeping_every_conflict': round(sat[0], 3)}
        if d['conflicts']:
            sat = sorted(r['jaccard'] for r in rows if r['status'] == 'SAT')
            d['jaccard'] = {'conflict_min': round(sat[0], 3), 'conflict_median': round(statistics.median(sat), 3), 'conflict_max': round(sat[-1], 3)}
    summary['solver_all_datasets'] = {'calls': len(all_ms), 'statuses': statuses,
                                      'median_ms': round(statistics.median(all_ms), 2), 'p99_ms': round(sorted(all_ms)[int(0.99 * len(all_ms))], 2),
                                      'max_ms': round(max(all_ms), 2), 'seconds': round(sum(all_ms) / 1000, 1)}
    for extra in ('replay_summary.json',):
        if (OUT / extra).exists():
            summary['replay'] = json.loads((OUT / extra).read_text())
    for name in ORDER:
        for kind, folder in (('independent', 'independent'), ('injection', 'injection'), ('timing', 'timing')):
            path = OUT / folder / (f'{name}.json' if kind == 'independent' else f'{name}_summary.json')
            if path.exists():
                summary.setdefault(kind, {})[name] = json.loads(path.read_text())
    tot = {'obligations_and_advice_skipped': sum(d['skipped_elements']['ObligationExpressions'] + d['skipped_elements']['AdviceExpressions'] for d in summary['datasets'].values()),
           'descriptions_skipped': sum(d['skipped_elements']['Description'] for d in summary['datasets'].values()),
           'designators_without_category': sum(d['designators_without_category'] for d in summary['datasets'].values()),
           'conflicts': sum(d['conflicts'] for d in summary['datasets'].values()),
           'eligible_pairs': sum(d['eligible_pairs'] for d in summary['datasets'].values())}
    if 'replay' in summary:
        tot['witnesses'] = sum(r['witnesses'] for r in summary['replay'].values())
        tot['balana_confirmed'] = sum(r.get('balana', {}).get('pairs_confirmed', 0) for r in summary['replay'].values())
        tot['opa_confirmed'] = sum(r.get('opa', {}).get('pairs_confirmed', 0) for r in summary['replay'].values())
    if 'independent' in summary:
        ind = summary['independent'].values()
        tot['enumerated_pairs'] = sum(x['enumerated_pairs'] for x in ind)
        tot['enumeration_disagreements'] = sum(len(x['enumeration_disagreements']) for x in ind)
        tot['searched_pairs'] = sum(x['searched_pairs'] for x in ind)
        tot['search_disagreements'] = sum(len(x['search_disagreements']) for x in ind)
        tot['search_undecided'] = sum(x['search_undecided'] for x in ind)
    if 'injection' in summary:
        kinds = [k for x in summary['injection'].values() for k in x['kinds'].items()]
        tot['planted'] = sum(k['planted'] for _, k in kinds)
        tot['planted_solver_correct'] = sum(k['solver_correct'] for _, k in kinds)
        tot['planted_enumerator_correct'] = sum(k['enumerator_correct'] for _, k in kinds)
        conf = [k for _, k in kinds if k['conflict_by_construction']]
        tot['planted_conflicts'] = sum(k['planted'] for k in conf)
        tot['planted_conflicts_kept_by_scope_query'] = sum(k['kept_by_scope_query'] for k in conf)
        tot['planted_conflicts_kept_by_entity_overlap'] = sum(k['kept_by_entity_overlap'] for k in conf)
        if all(k['kept_by_similarity'] is not None for k in conf):
            tot['planted_conflicts_kept_by_similarity'] = sum(k['kept_by_similarity'] for k in conf)
            tot['planted_conflicts_kept_by_all_three'] = sum(k['kept_by_all_three'] for k in conf)
        miss = [k for _, k in kinds if not k['conflict_by_construction']]
        tot['planted_near_misses'] = sum(k['planted'] for k in miss)
        tot['planted_near_misses_dropped_by_scope_query'] = sum(k['planted'] - k['kept_by_scope_query'] for k in miss)
    summary['totals'] = tot
    summary['sweeps'] = {'similarity': {}, 'entity': {}}
    for kind, table in (('similarity', sweep_e), ('entity', sweep_n)):
        for r in table:
            summary['sweeps'][kind].setdefault(r['dataset'], {})[str(r['threshold'])] = {'kept': r['kept'], 'share_kept': r['share_kept'], 'recall': r['recall']}
    earlier = HERE.parent / 'results' / 'earlier' / 'prior_tool_comparison' / 'summary.json'
    if earlier.exists():       # bounded comparison with the SMT tool of Turkmen et al., run for the thesis (not a v3 result)
        e = json.loads(earlier.read_text())
        summary['prior_tool_earlier'] = {'cases': e['cases'], 'prior_status_counts': e['prior_status_counts'],
                                         'prior_verdicts_matching': e['prior_resolved_labels_matching_finite'],
                                         'own_label_mismatches': e['native_label_mismatches'], 'completed_utc': e['completed_utc']}
    check = OUT / 'model_check.json'
    if check.exists():
        summary['model_check'] = json.loads(check.read_text())
    ci = OUT / 'ci_gate_output.txt'
    if ci.exists():
        summary['ci_output'] = ci.read_text().rstrip('\n').split('\n')
    if elapsed_seconds is not None:
        summary['run_minutes'] = round(elapsed_seconds / 60)
    (OUT / 'summary.json').write_text(json.dumps(summary, indent=1))
    for fname, table in (('table1_benchmark.csv', bench), ('table2_ablation.csv', abl),
                         ('sweep_similarity.csv', sweep_e), ('sweep_entity.csv', sweep_n)):
        if table:
            with open(OUT / fname, 'w', newline='') as f:
                w = csv.DictWriter(f, fieldnames=list(table[0]))
                w.writeheader()
                w.writerows(table)
    figure(sweep_e, sweep_n)
    funnel_figure(summary)
    return summary


def figure(sweep_e, sweep_n):
    """Figure 2: for each cut-off, the share of conflicts kept (solid) and of pairs kept (dashed)."""
    try:
        import matplotlib
        matplotlib.use('Agg')
        import matplotlib.pyplot as plt
    except ImportError:
        return
    panels = [('(a) Similarity cut-off (cosine)', sweep_e, E), ('(b) Entity-overlap cut-off (Jaccard)', sweep_n, N)]
    panels = [p for p in panels if p[1]]
    if not panels:
        return
    plt.rcParams.update({'font.size': 10.5})
    fig, axes = plt.subplots(1, len(panels), figsize=(4.5 * len(panels), 3.9), squeeze=False)
    colors = {'Continue-A': '#1f3b73', 'CrossFramework': '#bc4749'}
    labels = {'Continue-A': 'Continue-A', 'CrossFramework': 'Cross-framework corpus'}
    handles = []
    for ax, (title, sweep, chosen) in zip(axes[0], panels):
        handles = []
        for name in ('Continue-A', 'CrossFramework'):
            rows = [r for r in sweep if r['dataset'] == name and r['recall'] is not None]
            if rows:
                x = [r['threshold'] for r in rows]
                handles += ax.plot(x, [r['recall'] for r in rows], marker='o', ms=4, lw=1.9, color=colors[name],
                                   label=labels[name] + ': conflicts kept')
                handles += ax.plot(x, [r['share_kept'] for r in rows], ls='--', lw=1.5, color=colors[name],
                                   label=labels[name] + ': pairs sent to the solver')
        ax.axvline(chosen, color='#555555', ls=':', lw=1.3)
        ax.text(chosen + 0.01, 1.075, f'used: {chosen}', color='#444444', fontsize=9.5, va='center')
        ax.set_title(title, fontsize=11, pad=14)
        ax.set_xlabel('Cut-off')
        ax.set_ylabel('Share')
        ax.set_ylim(0, 1.13)
        ax.set_yticks([0, 0.2, 0.4, 0.6, 0.8, 1.0])
        ax.grid(alpha=0.3)
        for side in ('top', 'right'):
            ax.spines[side].set_visible(False)
    fig.legend(handles=handles, loc='lower center', ncol=2, frameon=False, fontsize=9.5)
    fig.tight_layout(rect=(0, 0.13, 1, 1))
    fig.savefig(OUT / 'fig2_threshold_sweep.png', dpi=300)
    plt.close(fig)


def funnel_figure(summary, name='Continue-A'):
    """Figure 1: the stages, and the pairs that reach each one on Continue-A in both orders."""
    try:
        import matplotlib
        matplotlib.use('Agg')
        import matplotlib.pyplot as plt
        from matplotlib.patches import FancyBboxPatch
    except ImportError:
        return
    d = summary['datasets'].get(name)
    if not d or 'cascade_original' not in d:
        return
    n0, total = d['eligible_pairs'], d['conflicts']
    orig, reo = d['cascade_original'], d['cascade_reordered'][0]
    GREY, NAVY, TEAL, RED, DARK = '#6c757d', '#2f4b7c', '#2a9d8f', '#bc4749', '#333333'
    fmt = lambda x: f'{x:,}'
    first = ('XACML 3.0 rules\n→ Common\nPolicy Model', f'{fmt(n0)} opposite-\neffect pairs', GREY)
    last = ('Witness replayed\nin Balana\nand OPA', '', DARK)
    top = [first,
           (f'Similarity\n(cosine ≥ {E})', f'{fmt(orig[0]["kept"])} pairs', NAVY),
           (f'Entity overlap\n(Jaccard ≥ {N})', f'{fmt(orig[1]["kept"])} pairs', NAVY),
           ('SPARQL\nscope query', f'{fmt(orig[2]["kept"])} pairs', TEAL),
           ('Z3', f'{fmt(orig[2]["conflicts_kept"])} of {fmt(total)}\nconflicts found', RED), last]
    bottom = [first,
              ('SPARQL\nscope query', f'{fmt(reo["kept"])} pairs', TEAL),
              ('Z3', f'{fmt(reo["conflicts_kept"])} of {fmt(total)}\nconflicts found', RED), last]
    w, h, gap = 1.42, 0.95, 0.2
    fig, ax = plt.subplots(figsize=(9.6, 4.35))
    ax.set_xlim(0, 6 * w + 5 * gap + 0.1)
    ax.set_ylim(0, 4.6)
    ax.axis('off')

    def row(items, y, title, xs=None):
        ax.text(0.05, y + h + 0.26, title, fontsize=11, fontweight='bold', color='#222222', va='center')
        xs = xs or [0.05 + i * (w + gap) for i in range(len(items))]
        for i, ((label, count, color), x) in enumerate(zip(items, xs)):
            ax.add_patch(FancyBboxPatch((x, y), w, h, boxstyle='round,pad=0.02,rounding_size=0.06', fc=color, ec='none'))
            ax.text(x + w / 2, y + h / 2, label, ha='center', va='center', color='white', fontsize=10, fontweight='bold')
            if count:
                ax.text(x + w / 2, y - 0.1, count, ha='center', va='top', color='#222222', fontsize=10)
            if i + 1 < len(items):
                ax.annotate('', xy=(xs[i + 1] - 0.02, y + h / 2), xytext=(x + w + 0.02, y + h / 2),
                            arrowprops=dict(arrowstyle='-|>', color='#333333', lw=1.3))
        return xs
    xs = row(top, 2.75, 'Similarity-first order: the lossy filters come first')
    row(bottom, 0.65, 'Reordered: the sound filter first, similarity only ranks the findings', [xs[0], xs[3], xs[4], xs[5]])
    fig.subplots_adjust(left=0.01, right=0.99, top=0.99, bottom=0.01)
    fig.savefig(OUT / 'fig1_funnel.png', dpi=300)
    plt.close(fig)


if __name__ == '__main__':
    s = main(float(sys.argv[2]) if len(sys.argv) > 2 and sys.argv[1] == '--elapsed' else None)
    for name, d in s['datasets'].items():
        print(name, d['rules'], d['eligible_pairs'], d['conflicts'])
        for k, m in d['variants'].items():
            if m['recall'] is not None or m['kept']:
                print(f"   {k:45s} kept {m['kept']:6d}  conflicts {m['conflicts_kept']:4d}  recall {m['recall'] if m['recall'] is None else round(m['recall'],3)}  precision {m['precision'] if m['precision'] is None else round(m['precision'],3)}")
    print(json.dumps(s['solver_all_datasets']))
