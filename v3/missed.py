"""Why the resemblance filters miss conflicts: sort every opposite-effect pair by how its two rules relate.

  python v3/missed.py            (after funnel.py; writes results/missed_conflicts.json)

Shapes, tested in this order on the rules as the pipeline compares them (inherited Targets included):
  catch-all          one rule has no condition at all, so it applies to every request
  narrow vs broad    the terms of one rule are a subset of the other's: the narrow rule repeats
                     the broad rule and adds conditions (an exception to it)
  different attrs    each rule constrains an attribute the other leaves free
  other              everything else
A term is an attribute or an attribute-value literal, as in the entity-overlap stage.
A conflict is lost when the similarity-first order drops it: cosine < 0.65 or entity overlap < 0.25.
Uses only the stored pair tables and the intake; runs no solver and no model.
"""
import json
import sys
from collections import Counter, defaultdict
from pathlib import Path

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE))
sys.path.insert(0, str(HERE.parent / 'src'))
import funnel  # noqa: E402
import intake  # noqa: E402
from research import screening  # noqa: E402

SETS = ['Continue-A', 'Pluto', 'Fedora', 'KMarket', 'CrossFramework']
SHAPES = ['catch-all', 'narrow vs broad', 'different attributes', 'other']


def shape(a, b, mapping):
    if a['condition'] is True or b['condition'] is True:
        return 'catch-all'
    ea, eb = screening.entities(a['condition'], mapping), screening.entities(b['condition'], mapping)
    if ea <= eb or eb <= ea:
        return 'narrow vs broad'
    aa = {e for e in ea if e.startswith('attribute:')}
    ab = {e for e in eb if e.startswith('attribute:')}
    if not (aa <= ab or ab <= aa):
        return 'different attributes'
    return 'other'


def main():
    out = {'thresholds': {'cosine': funnel.EMBED_THRESHOLD, 'entity_overlap': funnel.ENTITY_THRESHOLD}, 'datasets': {}}
    for name in SETS:
        path, sources = funnel.DATASETS[name]
        m = intake.load(path, sources)
        rules, mapping = {r['id']: r for r in m['display']['rules']}, m['mapping']
        rows = json.loads((HERE / 'results' / f'pairs_{name}.json').read_text())['rows']
        t = defaultdict(Counter)
        cos = defaultdict(list)
        for r in rows:
            k = shape(rules[r['pair'][0]], rules[r['pair'][1]], mapping)
            sat = r['status'] == 'SAT'
            low_cos, low_ent = r['cosine'] < funnel.EMBED_THRESHOLD, r['jaccard'] < funnel.ENTITY_THRESHOLD
            t[k]['pairs'] += 1
            t[k]['conflicts'] += sat
            t[k]['lost'] += sat and (low_cos or low_ent)
            t[k]['lost_by_similarity'] += sat and low_cos
            t[k]['lost_by_entity_overlap'] += sat and low_ent
            t[k]['kept_by_scope_query'] += sat and r['scope']
            if sat:
                cos[k].append(r['cosine'])
        out['datasets'][name] = {k: dict(t[k], max_cosine_of_conflicts=round(max(cos[k]), 3) if cos[k] else None)
                                 for k in SHAPES if k in t}
    tot = Counter()
    for d in out['datasets'].values():
        for k, v in d.items():
            tot[k + ': conflicts'] += v['conflicts']
            tot[k + ': lost'] += v['lost']
    out['totals'] = dict(tot)
    assert tot['other: conflicts'] == 0, 'a conflict outside the three shapes'
    assert all(v['kept_by_scope_query'] == v['conflicts'] for d in out['datasets'].values() for v in d.values())
    (HERE / 'results' / 'missed_conflicts.json').write_text(json.dumps(out, indent=1))
    print(json.dumps(out['totals'], indent=1))
    return out


if __name__ == '__main__':
    main()
