"""Rule retirement in the 12-case frozen challenge, for every method.

A rule is retired by an output when it applies to no request of the case's
complete finite request space (the frozen truth table). A nonempty rule is
forced to retire when every request it applies to has a frozen target decision
different from its effect: any output that meets the full target while only
narrowing rules must then empty it (Proposition 4.7).

No edit, source-order compilation and unchecked subtraction are re-run exactly
as in the frozen runner; the two checked variants are read from the order
study's frozen-order outputs.

Usage (from the package root):  python studies/retirement_study.py
"""
import copy

from common import (RESULTS, CASES, MAX_ITERATIONS, TIMEOUT_MS, save, read, ev, decide, load_case,
                    frozen_choices, score)

OUT = RESULTS / 'retirement'


def unchecked(model, choices_list):
    """Mirror of the frozen runner's unchecked subtraction (first pair in list order, no safety checks)."""
    from pcproof.model import normalize, conj, neg
    from pcproof.verify import audit
    current = copy.deepcopy(model)
    choices = {frozenset(c.values()): c for c in choices_list}
    for step in range(MAX_ITERATIONS + 1):
        scan = audit(current, 'exhaustive', TIMEOUT_MS)
        if scan['label'] in ('INVALID_OR_UNRESOLVED_REQUEST_SPACE', 'UNRESOLVED'):
            return 'UNRESOLVED_SCAN', current, step
        positive = [r for r in scan['results'] if r['status'] == 'SAT']
        if not positive:
            return 'OUTPUT', current, step
        if step == MAX_ITERATIONS:
            return 'ITERATION_LIMIT_REACHED', current, step
        found = next((r for r in positive if frozenset(r['pair']) in choices), None)
        if found is None:
            return 'UNFINISHED', current, step
        c = choices[frozenset(found['pair'])]
        ids = {r['id']: r for r in current['rules']}
        candidate = copy.deepcopy(current)
        loser = next(r for r in candidate['rules'] if r['id'] == c['loser'])
        loser['condition'] = conj(ids[c['loser']]['condition'], neg(ids[c['winner']]['condition']))
        current = normalize(candidate)


def run():
    from research import workflow
    table = {}
    for case in CASES:
        model, truth = load_case(case)
        requests = [t['request'] for t in truth]
        empty_before = sorted(r['id'] for r in model['rules'] if not any(ev(r['condition'], q) for q in requests))
        forced = sorted(r['id'] for r in model['rules'] if r['id'] not in empty_before and
                        not any(ev(r['condition'], t['request']) and t['expected_final_decision'] == r['effect'] for t in truth))
        auth = frozen_choices(case)
        pre = workflow.apply_precedence(model, auth['precedence'], TIMEOUT_MS)
        pre_out = pre['policy'] if pre.get('committed') else model
        status, unc, steps = unchecked(model, auth['refinement']['choices'])
        # As in the frozen runner, an unfinished unchecked run retains the original policy.
        outputs = {'no_edit': ('BASELINE_UNCHANGED', model), 'source_order': (pre['status'], pre_out),
                   'unchecked': (status, unc if status == 'OUTPUT' else model)}
        for mode in ('listed', 'settled'):
            outputs['checked_' + mode] = (None, read(RESULTS / 'order_study/frozen_order_outputs' / f'{case}_{mode}.json'))
        row = {'rules': len(model['rules']), 'empty_before': empty_before, 'forced_to_retire': forced, 'methods': {}}
        for name, (st, out) in outputs.items():
            s = score(out, truth)
            newly = [r for r in s['retired_rules'] if r not in empty_before]
            row['methods'][name] = {'status': st, 'meets_full_target': not (s['target_mismatches'] or s['contract_violations']
                                                                              or s['conflict_requests'] or s['pure_decision_changes']),
                                    'target_mismatches': s['target_mismatches'],
                                    'ordinary_label_differences': s['ordinary_label_differences'],
                                    'newly_retired': newly}
        row['unchecked_emitted_newly_retired'] = [r for r in score(unc, truth)['retired_rules'] if r not in empty_before]
        row['unchecked_steps'] = steps
        table[case] = row
        print(case, len(model['rules']), 'forced', len(forced), 'empty0', len(empty_before),
              {k: len(v['newly_retired']) for k, v in row['methods'].items()}, flush=True)
    save(OUT / 'summary.json', table)


if __name__ == '__main__':
    run()
