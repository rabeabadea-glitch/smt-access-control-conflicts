"""Wall-clock cost of every filter variant of the ablation, one fresh process per repetition.

A variant is an ordered list of filter stages followed by Z3 on the pairs they keep:
  exhaustive            Z3 on every eligible pair (the reference)
  similarity            similarity -> Z3
  entity                entity overlap -> Z3
  scope                 scope query -> Z3                      (the reordered funnel)
  no_similarity         entity overlap -> scope query -> Z3
  no_entity             similarity -> scope query -> Z3
  no_scope              similarity -> entity overlap -> Z3
  original              similarity -> entity overlap -> scope query -> Z3   (order of the first submission)
Each stage sees only the pairs the previous stage kept. Stage costs:
  similarity   load all-MiniLM-L6-v2, embed every rule once, cosine for the pairs it is given
  entity       entity sets of every rule, Jaccard for the pairs it is given
  scope        RDF view of the rules still in play + SPARQL scope query
  solver       Z3 on the surviving pairs
Intake (XML -> Common Policy Model) is timed once per repetition and is common to all variants.

Usage:  python v3/timing.py <dataset> <repetitions>
"""
from __future__ import annotations
import json
import statistics
import subprocess
import sys
import time
from pathlib import Path

HERE = Path(__file__).resolve().parent
VARIANTS = {
    'exhaustive': [],
    'similarity': ['similarity'],
    'entity': ['entity'],
    'scope': ['scope'],
    'no_similarity': ['entity', 'scope'],
    'no_entity': ['similarity', 'scope'],
    'no_scope': ['similarity', 'entity'],
    'original': ['similarity', 'entity', 'scope'],
}


def worker(name, result_path):
    sys.path.insert(0, str(HERE))
    import funnel
    import intake
    import structural
    from pcproof.model import conj
    from pcproof.verify import Verifier
    from research import screening
    out = {}
    path, sources = funnel.DATASETS[name]
    t = time.perf_counter()
    m = intake.load(path, sources)
    out['intake'] = time.perf_counter() - t
    cpm, shown, mapping = m['cpm'], m['display']['rules'], m['mapping']
    ids = {r['id']: r for r in cpm['rules']}
    pairs = funnel.eligible(shown, sources)
    v = Verifier(cpm, funnel.SOLVER_BUDGET_MS)
    has_model = (funnel.MODEL_DIR / 'onnx' / 'model.onnx').exists()

    def solver(ps):
        return sum(v.check(conj(ids[a['id']]['condition'], ids[b['id']]['condition']))['status'] == 'SAT' for a, b in ps)

    def similarity(ps):
        emb = screening.Embedder(funnel.MODEL_DIR)
        vectors, _ = emb.encode([screening.verbalize(r['condition'], mapping) for r in shown])
        vec = {r['id']: vectors[i] for i, r in enumerate(shown)}
        return [(a, b) for a, b in ps if float(vec[a['id']] @ vec[b['id']]) >= funnel.EMBED_THRESHOLD]

    def entity(ps):
        ents = {r['id']: screening.entities(r['condition'], mapping) for r in shown}
        return [(a, b) for a, b in ps if screening.entity_score(ents[a['id']], ents[b['id']]) >= funnel.ENTITY_THRESHOLD]

    def scope(ps):
        wanted = {r['id'] for pair in ps for r in pair}
        keys = structural.kept_pairs([r for r in shown if r['id'] in wanted], ps)
        return [(a, b) for a, b in ps if tuple(sorted((a['id'], b['id']))) in keys]

    stage = {'similarity': similarity, 'entity': entity, 'scope': scope}
    out['pairs'] = len(pairs)
    out['variants'] = {}
    for label, stages in VARIANTS.items():
        if 'similarity' in stages and not has_model:
            continue
        kept, steps, total = pairs, [], 0.0
        for s in stages:
            t0 = time.perf_counter()
            kept = stage[s](kept)
            dt = time.perf_counter() - t0
            total += dt
            steps.append({'stage': s, 'seconds': dt, 'kept': len(kept)})
        t0 = time.perf_counter()
        sat = solver(kept)
        dt = time.perf_counter() - t0
        out['variants'][label] = {'steps': steps, 'solver_calls': len(kept), 'solver_seconds': dt,
                                  'filter_seconds': total, 'total_seconds': total + dt, 'conflicts_found': sat}
    Path(result_path).write_text(json.dumps(out))


def main(name, reps):
    out_dir = HERE / 'results' / 'timing'
    out_dir.mkdir(parents=True, exist_ok=True)
    runs = []
    for rep in range(reps):
        target = out_dir / f'{name}_rep{rep}.json'
        subprocess.run([sys.executable, '-B', __file__, '--worker', name, str(target)], check=True, timeout=7200)
        runs.append(json.loads(target.read_text()))

    def med(values):
        return round(statistics.median(values), 3)
    summary = {'dataset': name, 'repetitions': reps, 'pairs': runs[0]['pairs'],
               'intake_seconds': med([r['intake'] for r in runs]), 'variants': {}}
    for label in runs[0]['variants']:
        first = runs[0]['variants'][label]
        for r in runs:      # counts must not depend on the repetition
            other = r['variants'][label]
            assert [s['kept'] for s in other['steps']] == [s['kept'] for s in first['steps']]
            assert other['conflicts_found'] == first['conflicts_found']
        summary['variants'][label] = {
            'steps': [{'stage': s['stage'], 'kept': s['kept'],
                       'seconds': med([r['variants'][label]['steps'][i]['seconds'] for r in runs])}
                      for i, s in enumerate(first['steps'])],
            'solver_calls': first['solver_calls'], 'conflicts_found': first['conflicts_found'],
            'filter_seconds': med([r['variants'][label]['filter_seconds'] for r in runs]),
            'solver_seconds': med([r['variants'][label]['solver_seconds'] for r in runs]),
            'total_seconds': med([r['variants'][label]['total_seconds'] for r in runs]),
            'total_seconds_min_max': [round(min(r['variants'][label]['total_seconds'] for r in runs), 3),
                                      round(max(r['variants'][label]['total_seconds'] for r in runs), 3)]}
    (out_dir / f'{name}_summary.json').write_text(json.dumps(summary, indent=1))
    print(json.dumps(summary, indent=1))


if __name__ == '__main__':
    if sys.argv[1] == '--worker':
        worker(sys.argv[2], sys.argv[3])
    else:
        main(sys.argv[1], int(sys.argv[2]))
