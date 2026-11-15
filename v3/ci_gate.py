"""CI gate: fail the build when a policy change introduces a reachable conflict.

  python v3/ci_gate.py <baseline.xml> <changed.xml> [file|policy]

Both files go through the v3 path: per-rule intake into the Common Policy Model,
the SPARQL scope query (sound: it only drops pairs that cannot overlap), then Z3
on every pair the query keeps. A pair that is a conflict in the changed file and
was not one in the baseline is a regression. For each regression the gate prints
the two rules and the witness request (the attributes the two rules mention; the
full request is written as JSON next to the changed file) and exits with status 1. Otherwise it exits with status 0.
"""
from __future__ import annotations
import json
import sys
import textwrap
import time
from pathlib import Path

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE))
import funnel  # noqa: E402
import intake  # noqa: E402
import structural  # noqa: E402
from pcproof.model import conj  # noqa: E402
from pcproof.verify import Verifier, attr_mentions  # noqa: E402


def conflicts(path, sources):
    m = intake.load(path, sources)
    cpm, shown = m['cpm'], m['display']['rules']
    ids = {r['id']: r for r in cpm['rules']}
    pairs = funnel.eligible(shown, sources)
    kept = structural.kept_pairs(shown, pairs)
    v = Verifier(cpm, funnel.SOLVER_BUDGET_MS)
    found, unresolved = {}, []
    for a, b in pairs:
        key = tuple(sorted((a['id'], b['id'])))
        if key not in kept:
            continue
        ans = v.check(conj(ids[a['id']]['condition'], ids[b['id']]['condition']))
        if ans['status'] == 'SAT':
            used = attr_mentions(a['condition']) | attr_mentions(b['condition'])
            name = {k: m['mapping'][k]['AttributeId'].rsplit(':', 1)[-1] for k in ans['witness']}
            found[key] = {'shown': {name[k]: x for k, x in ans['witness'].items() if k in used},
                          'full': {name[k]: x for k, x in ans['witness'].items()}}
        elif ans['status'] != 'UNSAT':
            unresolved.append(key)
    return found, unresolved, {'rules': len(shown), 'pairs': len(pairs), 'solver_calls': len(kept)}


def main(baseline, changed, sources='file'):
    t = time.perf_counter()
    before, _, _ = conflicts(baseline, sources)
    after, unresolved, stats = conflicts(changed, sources)
    new = {k: w for k, w in after.items() if k not in before}
    calls = stats['solver_calls']
    print(f"policy gate: {stats['rules']} rules, {stats['pairs']} opposite-effect pairs, "
          f"{calls} solver call{'' if calls == 1 else 's'}, {time.perf_counter() - t:.1f} s")
    for (a, b), witness in sorted(new.items()):
        print(f'NEW CONFLICT  {a}  x  {b}')
        shown = ', '.join(f'{k}={x}' for k, x in sorted(witness['shown'].items()))
        print(textwrap.fill(shown, 72, initial_indent='  witness request: ', subsequent_indent=' ' * 19, break_on_hyphens=False))
        Path(str(changed) + f'.witness.{a}.{b}.json').write_text(json.dumps(witness['full'], indent=1, sort_keys=True))
    for a, b in unresolved:
        print(f'UNRESOLVED    {a}  x  {b}  (solver gave no answer inside the budget)')
    if new or unresolved:
        print(f'FAIL: {len(new)} new conflict(s), {len(unresolved)} unresolved pair(s)')
        return 1
    print('PASS: no new conflict')
    return 0


if __name__ == '__main__':
    sys.exit(main(*sys.argv[1:4]))
