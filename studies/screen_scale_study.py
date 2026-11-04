"""Screening at scale: does serial semantic screening ever pay for itself?

For every input and repetition a fresh Python process measures, in this order:
  1. serial E AND N AND G screening (includes model loading and embedding),
  2. SMT checks of the screened candidate pairs only,
  3. sound necessary-equality screening plus its candidate checks,
  4. the complete exhaustive pair audit (also used as the reference labels).
Triage-only cost = screen + candidate checks (no certificate).
Certified cost   = triage-only cost + exhaustive audit (needed for a scoped certificate).

Inputs: the eight earlier scaling workloads (disjoint/interval at 10, 30, 100, 300 rules)
and a new heterogeneous family generated here with seed 20261027 at 30, 100 and 300 rules.

Usage (from the package root):  python studies/screen_scale_study.py <repetitions>
(the script calls itself with --worker <input json> <src dir> <model dir> <result json> for each run)
"""
import json
import random
import subprocess
import sys
import time
from pathlib import Path

SEED = 20261027


def heterogeneous(n):
    rng = random.Random(f'{SEED}:{n}')
    enums = {f'field_{k}': {'type': 'enum', 'values': [f'v{j}' for j in range(5)]} for k in range(8)}
    ints = {'level': {'type': 'int', 'min': 0, 'max': 20}, 'age': {'type': 'int', 'min': 0, 'max': 20}}
    attrs = {**enums, **ints}
    rules = []
    for i in range(n):
        chosen = rng.sample(sorted(attrs), rng.choice([2, 3]))
        atoms = []
        for a in chosen:
            if a in ints:
                lo = rng.randrange(0, 18)
                hi = rng.randrange(lo, 21)
                atoms += [{'op': 'ge', 'attr': a, 'value': lo}, {'op': 'le', 'attr': a, 'value': hi}]
            else:
                atoms.append({'op': 'eq' if rng.random() < 0.85 else 'ne', 'attr': a, 'value': rng.choice(attrs[a]['values'])})
        rules.append({'id': f'h{i:04}', 'source': f'S{i % 4}', 'effect': rng.choice(['Permit', 'Deny']),
                      'condition': {'op': 'and', 'args': atoms}})
    return {'schema_version': 'cpm-1', 'attributes': attrs,
            'sources': {f'S{k}': {'kind': 'synthetic', 'citation': 'heterogeneous scaling family, seed 20261027',
                                  'mapping_status': 'constructed'} for k in range(4)},
            'rules': rules}


def worker(input_path, src, model_dir, result_path):
    sys.path.insert(0, src)
    started = time.perf_counter()
    from pcproof.model import normalize
    from pcproof.verify import audit, Verifier, screen
    from research.screening import ScreeningSession
    p = normalize(json.loads(Path(input_path).read_text()))
    out = {'input': str(input_path), 'rules': len(p['rules'])}
    t = time.perf_counter()
    s = ScreeningSession(model_dir).screen(p, 'E_AND_N_AND_G')
    out['serial_screen_ms'] = (time.perf_counter() - t) * 1000
    out['serial_phase_ms'] = s['phase_ms']
    out['eligible_pairs'] = s['eligible_pairs']
    ids = {r['id']: r for r in p['rules']}
    v = Verifier(p, 2000)
    t = time.perf_counter()
    serial_labels = {tuple(pair): v.pair(ids[pair[0]], ids[pair[1]])['status'] for pair in s['kept_pairs']}
    out['serial_candidate_ms'] = (time.perf_counter() - t) * 1000
    out['serial_kept'] = len(s['kept_pairs'])
    t = time.perf_counter()
    kept, dropped = screen(p, 'exact')
    exact_labels = {(a['id'], b['id']): v.pair(a, b)['status'] for a, b in kept}
    out['exact_screen_and_candidate_ms'] = (time.perf_counter() - t) * 1000
    out['exact_kept'] = len(kept)
    t = time.perf_counter()
    full = audit(p, 'exhaustive', 2000)
    out['exhaustive_ms'] = (time.perf_counter() - t) * 1000
    labels = {tuple(r['pair']): r['status'] for r in full['results']}
    sat = {k for k, x in labels.items() if x == 'SAT'}
    out['sat_pairs'] = len(sat)
    out['unresolved_pairs'] = sum(x not in ('SAT', 'UNSAT') for x in labels.values())
    out['serial_retained_sat'] = sum(1 for k in serial_labels if k in sat)
    out['exact_retained_sat'] = sum(1 for k in exact_labels if k in sat)
    out['label_disagreements'] = sum(labels.get(k) != x for k, x in {**serial_labels, **exact_labels}.items())
    out['worker_ms'] = (time.perf_counter() - started) * 1000
    Path(result_path).write_text(json.dumps(out, indent=2))


def main():
    sys.path.insert(0, str(Path(__file__).resolve().parent))
    from common import ROOT, DATA, RESULTS, SRC
    inputs, src, model_dir, out = DATA / 'scaling_inputs', str(SRC), str(ROOT / 'models' / 'all-MiniLM-L6-v2'), RESULTS / 'screen_scale'
    reps = int(sys.argv[1])
    out.mkdir(parents=True, exist_ok=True)
    gen = out / 'heterogeneous_inputs'
    gen.mkdir(exist_ok=True)
    workloads = []
    for n in (30, 100, 300):
        path = gen / f'heterogeneous-{n:03}.json'
        path.write_text(json.dumps(heterogeneous(n), indent=1))
        workloads.append(('heterogeneous', n, path))
    for family in ('disjoint', 'interval'):
        for n in (30, 100, 300):
            workloads.append((family, n, inputs / f'{family}-{n:03}.json'))
    runs = [(f, n, path, rep) for rep in range(reps) for f, n, path in workloads]
    random.Random(SEED).shuffle(runs)
    for f, n, path, rep in runs:
        target = out / 'raw' / f'{f}-{n:03}-rep{rep}.json'
        target.parent.mkdir(exist_ok=True)
        if target.exists():
            continue
        t = time.perf_counter()
        run = subprocess.run([sys.executable, '-B', __file__, '--worker', str(path), src, model_dir, str(target)],
                             capture_output=True, text=True, timeout=3600)
        wall = (time.perf_counter() - t) * 1000
        if run.returncode:
            (out / 'raw' / f'{f}-{n:03}-rep{rep}.error.txt').write_text(run.stderr)
            print('FAILED', f, n, rep, run.stderr[-500:], flush=True)
            continue
        record = json.loads(target.read_text())
        record.update(family=f, rep=rep, outer_wall_ms=wall)
        target.write_text(json.dumps(record, indent=2))
        print(f, n, rep, round(record['serial_screen_ms']), round(record['serial_candidate_ms']),
              round(record['exhaustive_ms']), record['serial_kept'], record['eligible_pairs'],
              record['serial_retained_sat'], record['sat_pairs'], flush=True)


if __name__ == '__main__':
    if sys.argv[1] == '--worker':
        worker(*sys.argv[2:6])
    else:
        main()
