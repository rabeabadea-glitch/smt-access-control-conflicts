"""Compare the listed and settled reruns of the earlier repair families case by case.

For every case the status, refusal reason, number of edits, independent request
checks and the decisions of the committed policy on every request of its finite
domain are compared. Usage (from the package root):  python studies/compare_regression.py
"""
import glob
import itertools
import json
from pathlib import Path

from common import RESULTS, save, decide

OUT = RESULTS / 'workflow_regression'


def domain(p):
    names = list(p['attributes'])
    vals = []
    for a in names:
        d = p['attributes'][a]
        vals.append(d['values'] if d['type'] == 'enum' else ([False, True] if d['type'] == 'bool' else list(range(d['min'], d['max'] + 1))))
    return [dict(zip(names, v)) for v in itertools.product(*vals)]


def key(case):
    r = case['result']
    pol = r.get('policy') if r.get('committed') else case['input']
    return (r['status'], r.get('reason'), len(r.get('iterations', [])), [decide(pol, q) for q in domain(case['input'])])


report = {}
for family, pattern in (('first_family', 'cases/*.json'), ('second_family', '*.json')):
    rows, diffs = 0, []
    for f in sorted(glob.glob(str(OUT / family / 'listed' / pattern))):
        name = Path(f).name
        g = OUT / family / 'settled' / Path(f).relative_to(OUT / family / 'listed')
        a, b = json.loads(Path(f).read_text()), json.loads(g.read_text())
        if 'result' not in a:
            continue
        rows += 1
        if key(a) != key(b):
            diffs.append(name)
    report[family] = {'cases_compared': rows, 'cases_with_any_difference': diffs}
first = {r: json.loads((OUT / 'first_family' / r / 'summary.json').read_text()) for r in ('listed', 'settled')}
report['first_family_primary_controls_identical'] = [
    {k: c[k] for k in ('name', 'status', 'reason', 'steps')} for c in first['listed']['primary_cases']] == [
    {k: c[k] for k in ('name', 'status', 'reason', 'steps')} for c in first['settled']['primary_cases']]
report['first_family_totals'] = {r: {k: first[r][k] for k in ('generated_repair_cases', 'generated_repair_accepted', 'generated_repair_steps',
                                                               'generated_repair_independent_requests', 'precedence_independent_requests',
                                                               'precedence_disagreements', 'precedence_remaining_conflicts')} for r in first}
save(OUT / 'comparison.json', report)
print(json.dumps(report, indent=1))
