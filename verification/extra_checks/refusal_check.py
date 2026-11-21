"""Why were the 17 listed-order runs of the chained-priority benchmark refused? (Section 6.4.3)

The refusal reason REPAIR_REMOVES_ALL_LOSER_BEHAVIOR_OR_UNRESOLVED is given in two situations:
the narrowed losing rule applies to no request (the loser_nonempty query is UNSAT), or the
solver gave no answer (UNKNOWN or timeout). This script re-runs every refused run from its
recorded rule order and prints the status of that query, so the two situations can be told apart.

It writes nothing.

Usage, from the package folder:
    python verification/extra_checks/refusal_check.py [package folder]

Needs results/chain_study/rows.jsonl and results/chain_study/cases/, as written by
studies/chain_study.py, and Z3_LIBRARY set as in the main README.
"""
import collections
import copy
import json
import os
import sys
from pathlib import Path

root = Path(sys.argv[1] if len(sys.argv) > 1 else Path(__file__).resolve().parents[2]).resolve()
os.environ.setdefault('OPA', 'unused')
os.environ.setdefault('BALANA_CP', 'unused')
sys.path[:0] = [str(root / 'src'), str(root / 'studies')]
os.chdir(root)

from pcproof.model import normalize, fingerprint
from research import workflow
from common import read, MAX_ITERATIONS, TIMEOUT_MS
from chain_study import OUT, orders

tally = collections.Counter()
refused = 0
for line in open('results/chain_study/rows.jsonl', encoding='utf-8'):
    row = json.loads(line)
    if row['status'] == 'ACCEPTED':
        continue
    refused += 1
    cid = row['case_id']
    model = read(OUT / 'cases' / cid / 'input.json')
    choices = read(OUT / 'cases' / cid / 'authorized_choices.json')
    order = orders(cid, model)[row['order']]
    assert order == row['rule_order'], (cid, row['order'])
    pos = {k: i for i, k in enumerate(order)}
    listed = {**copy.deepcopy(model), 'rules': sorted(copy.deepcopy(model['rules']), key=lambda x: pos[x['id']])}
    q = normalize(listed)
    approval = {'approval_id': 'CHECK', 'policy_sha256': fingerprint(q),
                'operation': 'bounded_refinement', 'choices': choices}
    res = workflow.refine_bounded(q, approval, MAX_ITERATIONS, TIMEOUT_MS)
    status = res['iterations'][-1]['checks']['loser_nonempty']['status']
    same = res['reason'] == row['reason']
    tally[(same, status)] += 1
    print(f"{cid} order {row['order']} ({row['mode']}): reason {res['reason']}, "
          f"same as recorded: {same}, loser_nonempty = {status}", flush=True)

print(f'\nrefused runs in rows.jsonl: {refused}')
print('summary (reason reproduced, loser_nonempty status):', dict(tally))
