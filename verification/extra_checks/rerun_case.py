"""Independent re-check of the cross-source case study (Sections 6.2 and 6.4.4).

For scenario A (all 25 rules) and scenario B (F2 re-translated), this script:
  1. rebuilds the model and compares it with the saved one;
  2. evaluates every rule with numpy over the complete request grid (31,492,800 requests)
     and lists the eligible pairs whose regions overlap on a valid request;
  3. runs a fresh exhaustive Z3 scan and compares its SAT pairs with the grid pairs and
     with the pairs recorded in results/case_study/summary.json;
  4. checks that every solver witness lies inside both of its rules;
  5. recounts the Conflict requests before repair;
  6. re-runs settled-winner repair and, when it is accepted, counts the requests whose
     decision changes.

It writes nothing. About one minute on a laptop.

Usage, from the package folder:
    python verification/extra_checks/rerun_case.py [package folder]

Needs numpy and Z3_LIBRARY set as in the main README. OPA and Balana are not used.
"""
import copy
import itertools
import json
import os
import sys
import time
from pathlib import Path

PKG = Path(sys.argv[1] if len(sys.argv) > 1 else Path(__file__).resolve().parents[2]).resolve()
os.environ.setdefault('OPA', 'unused')
os.environ.setdefault('BALANA_CP', 'unused')
sys.path[:0] = [str(PKG / 'src'), str(PKG / 'studies')]

import numpy as np
import case_study as cs
from pcproof.model import normalize
from pcproof.verify import audit
from extensions.settled_refinement import refine_settled

t0 = time.time()
model, _ = cs.build_model()
saved = json.load(open(PKG / 'results/case_study/model_scenario_A.json', encoding='utf-8'))
print('rebuilt model == saved model:', normalize(model) == normalize(saved))
summ = json.load(open(PKG / 'results/case_study/summary.json', encoding='utf-8'))

b = copy.deepcopy(model)
b['rules'] = [r for r in b['rules'] if r['id'] not in cs.F2_UNGOVERNED]
for name, m in [('A_all_25_rules', normalize(model)), ('B_F2_retranslated', normalize(b))]:
    g = cs.Grid(m)
    valid = g.full(g.ev(m['validity'])) if m.get('validity') not in (None, True) else np.ones(g.shape, bool)
    print(f'\n== {name}: grid size {g.size:,}, valid requests {int(valid.sum()):,}')
    regions = {r['id']: (g.full(g.ev(r['condition'])) & valid) for r in m['rules']}
    eligible = [(x, y) for x, y in itertools.combinations(m['rules'], 2)
                if x['effect'] != y['effect'] and x['source'] != y['source']]
    grid_pairs = {frozenset((x['id'], y['id'])) for x, y in eligible
                  if (regions[x['id']] & regions[y['id']]).any()}
    a = audit(m, 'exhaustive', cs.TIMEOUT_MS)
    smt_pairs = {frozenset(r['pair']) for r in a['results'] if r['status'] == 'SAT'}
    rec_pairs = {frozenset(p) for p in summ[name]['sat_pairs']}
    print('eligible pairs:', len(eligible), '| grid overlapping:', len(grid_pairs),
          '| solver SAT now:', len(smt_pairs), '| recorded:', len(rec_pairs))
    print('grid == solver == recorded:', grid_pairs == smt_pairs == rec_pairs,
          '| unresolved:', sum(r['status'] not in ('SAT', 'UNSAT') for r in a['results']))
    bad = 0
    for r in a['results']:
        if r['status'] == 'SAT':
            w = r['witness']
            idx = tuple(g.values[k].index(w[k]) for k in g.names)
            bad += not (regions[r['pair'][0]][idx] and regions[r['pair'][1]][idx])
    print('witnesses outside both regions:', bad)
    codes, _, _ = g.decisions(m)
    conf = int(((codes == 3) & valid).sum())
    print('Conflict requests before repair:', f'{conf:,}', 'recorded:',
          f"{summ[name]['methods']['no_edit']['decision_counts']['Conflict']:,}")
    _, ref = cs.authorization(m)
    res = refine_settled(m, ref, cs.MAX_ITERATIONS, cs.TIMEOUT_MS)
    rec = summ[name]['methods']['checked_settled']
    print('settled re-run:', res['status'], res['reason'], 'steps', res.get('tentative_steps'),
          '| recorded:', rec['status'], rec['reason'], rec['steps'])
    if res['status'] == 'ACCEPTED':
        oc, _, _ = g.decisions(res['policy'])
        changed = int(((oc != codes) & valid).sum())
        fromconf = int(((oc != codes) & (codes == 3) & valid).sum())
        print('after repair: Conflict', int(((oc == 3) & valid).sum()), '| changed', f'{changed:,}',
              '| changed from Conflict', f'{fromconf:,}')
print('\nseconds', round(time.time() - t0, 1))
