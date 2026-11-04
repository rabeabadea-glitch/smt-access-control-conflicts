"""Bounded checked refinement with settled-winner pair selection.

Added in the final revision (October 2026) after the order-robustness study
showed that ``research.workflow.refine_bounded`` can accept or reject the same
case depending on the order in which rules are listed.  That function repairs
the first conflicting pair it meets in rule-list order.  If the winner of that
pair is itself narrowed later, the earlier cut on the loser was made with a
larger winner region than the final one.

This module keeps every safety check of ``refine_bounded`` unchanged and
replaces only the choice of the next pair:

* only conflicting pairs with an authorized direction are considered;
* a pair is eligible only when its winner is *settled*, meaning the winner is
  not the loser of any other open authorized conflict;
* among eligible pairs, the smallest (winner id, loser id) is taken.

Because the choice depends on rule identifiers and on the set of open
conflicts, never on list positions, the sequence of edits is the same for
every ordering of the input rules.  If no winner is settled, the authorized
directions contain a cycle among the open conflicts and the transaction is
rejected instead of guessing.

The original module is deliberately left byte-identical so that the frozen
challenge evidence remains verifiable against its recorded source hashes.
"""
from __future__ import annotations

import copy

from pcproof.model import normalize, fingerprint, conj, neg, InputError
from pcproof.verify import Verifier, audit
from pcproof.repair import invariant_checks
from research.workflow import _approval_ok, _violation, _diagnostic_overlap

SELECTION_RULE = 'settled_winner_then_smallest_identifier'


def _pair_key(row):
    return frozenset(row['pair'])


def select_pair(positive, choices):
    """Return (row, reason).  ``row`` is None when no pair may be taken.

    ``positive`` holds the SAT rows of the current exhaustive scan and
    ``choices`` maps frozenset({winner, loser}) to the authorized choice.
    """
    authorized = [row for row in positive if _pair_key(row) in choices]
    if not authorized:
        return None, 'NO_AUTHORIZED_DIRECTION_FOR_REMAINING_CONFLICTS'
    open_losers = {choices[_pair_key(row)]['loser'] for row in authorized}
    settled = [row for row in authorized if choices[_pair_key(row)]['winner'] not in open_losers]
    if not settled:
        return None, 'CYCLIC_AUTHORIZED_DIRECTIONS_AMONG_OPEN_CONFLICTS'
    best = min(settled, key=lambda row: (choices[_pair_key(row)]['winner'], choices[_pair_key(row)]['loser']))
    return best, None


def refine_settled(raw, approval, max_iterations=20, timeout_ms=2000):
    """Same contract and checks as ``refine_bounded``; different pair selection."""
    p = normalize(raw)
    result = {'status': 'REJECTED', 'committed': False, 'operation': 'bounded_refinement',
              'selection_rule': SELECTION_RULE, 'before_sha256': fingerprint(p),
              'iterations': [], 'checks': {}}

    def stop(reason):
        result['reason'] = reason
        result['tentative_steps'] = len(result['iterations'])
        return result

    if type(max_iterations) is not int or not 1 <= max_iterations <= 1000:
        return stop('INVALID_ITERATION_LIMIT')
    error = _approval_ok(approval, p, 'bounded_refinement', ('choices',))
    if error:
        return stop(error)
    if not isinstance(approval['choices'], list):
        return stop('INVALID_AUTHORIZED_CHOICES')
    ids = {r['id']: r for r in p['rules']}
    choices = {}
    for choice in approval['choices']:
        if not isinstance(choice, dict) or set(choice) != {'winner', 'loser'}:
            return stop('INVALID_AUTHORIZED_CHOICES')
        if not all(type(v) is str and v in ids for v in choice.values()):
            return stop('UNKNOWN_RULE')
        w, l = ids[choice['winner']], ids[choice['loser']]
        if w['effect'] == l['effect'] or w['source'] == l['source']:
            return stop('INELIGIBLE_AUTHORIZED_PAIR')
        key = frozenset(choice.values())
        if key in choices:
            return stop('DUPLICATE_AUTHORIZED_PAIR')
        choices[key] = choice
    if not p['invariants'] or {i['required'] for i in p['invariants']} != {'Permit', 'Deny'}:
        return stop('BOTH_RESTRICTION_AND_ACCESS_CONTRACTS_REQUIRED')
    v = Verifier(p, timeout_ms)
    reachable = [{'id': i['id'], 'query': v.check(i['when'])} for i in p['invariants']]
    result['checks']['contract_antecedents'] = reachable
    if any(x['query']['status'] != 'SAT' for x in reachable):
        return stop('UNREACHABLE_OR_UNRESOLVED_CONTRACT')

    current = copy.deepcopy(p)
    seen = {fingerprint(current)}
    for step_no in range(max_iterations + 1):
        scan = audit(current, 'exhaustive', timeout_ms)
        if scan['label'] in ('INVALID_OR_UNRESOLVED_REQUEST_SPACE', 'UNRESOLVED'):
            result['checks']['last_scan'] = scan
            return stop('UNRESOLVED_OR_INVALID_REQUEST_SPACE')
        positive = [r for r in scan['results'] if r['status'] == 'SAT']
        if not positive:
            contracts = invariant_checks(current, timeout_ms)
            result['checks'].update(final=scan, contracts=contracts,
                                    diagnostic_overlap=_diagnostic_overlap(current, timeout_ms))
            if not all(c['passed'] for c in contracts):
                return stop('FINAL_CONTRACT_VIOLATION_OR_UNRESOLVED')
            if scan['label'] != 'CROSS_SOURCE_CONFLICT_FREE_WITHIN_SCOPE':
                return stop('FINAL_CERTIFICATION_FAILED')
            result.update(status='ACCEPTED', committed=True,
                          reason='BOUNDED_TRANSACTION_AND_EXHAUSTIVE_CHECK_PASSED',
                          approval_id=approval['approval_id'], after_sha256=fingerprint(current),
                          policy=current, tentative_steps=len(result['iterations']))
            return result
        if step_no == max_iterations:
            result['checks']['last_scan'] = scan
            return stop('ITERATION_LIMIT_REACHED')
        found, reason = select_pair(positive, choices)
        if found is None:
            result['checks']['last_scan'] = scan
            return stop(reason)
        choice = choices[_pair_key(found)]
        curr_ids = {r['id']: r for r in current['rules']}
        winner, loser = curr_ids[choice['winner']], curr_ids[choice['loser']]
        candidate = copy.deepcopy(current)
        edited = next(r for r in candidate['rules'] if r['id'] == loser['id'])
        edited['condition'] = conj(loser['condition'], neg(winner['condition']))
        entry = {'iteration': step_no + 1, 'choice': choice, 'before_sha256': fingerprint(current),
                 'overlap_before': found, 'checks': {}}
        try:
            candidate = normalize(candidate)
        except InputError as exc:
            entry['candidate_error'] = str(exc)
            result['iterations'].append(entry)
            return stop('CANDIDATE_OUTSIDE_SUPPORTED_FRAGMENT')
        after_hash = fingerprint(candidate)
        entry['after_sha256'] = after_hash
        if after_hash in seen:
            result['iterations'].append(entry)
            return stop('REPEATED_STATE')
        seen.add(after_hash)
        post = Verifier(candidate, timeout_ms)
        pre = Verifier(current, timeout_ms)
        new_rule = next(r for r in candidate['rules'] if r['id'] == loser['id'])
        alive = post.check(new_rule['condition'])
        local = pre.check(conj(loser['condition'], neg(new_rule['condition']), neg(winner['condition'])))
        pair_after = post.pair(new_rule, next(r for r in candidate['rules'] if r['id'] == winner['id']))
        entry['checks'].update(loser_nonempty=alive, outside_overlap_removed=local, pair_after=pair_after)
        if alive['status'] != 'SAT':
            result['iterations'].append(entry)
            return stop('REPAIR_REMOVES_ALL_LOSER_BEHAVIOR_OR_UNRESOLVED')
        if local['status'] != 'UNSAT' or pair_after['status'] != 'UNSAT':
            result['iterations'].append(entry)
            return stop('PAIR_NOT_RESOLVED_OR_NONLOCAL_OR_UNRESOLVED')
        no_new = []
        for inv in current['invariants']:
            query = post.check(conj(_violation(candidate, inv), neg(_violation(current, inv))))
            no_new.append({'id': inv['id'], 'new_violation_region': query})
        entry['checks']['contract_violation_nonexpansion'] = no_new
        result['iterations'].append(entry)
        if any(x['new_violation_region']['status'] != 'UNSAT' for x in no_new):
            return stop('NEW_CONTRACT_VIOLATION_OR_UNRESOLVED')
        current = candidate
    raise AssertionError('Bounded loop should always return at or before its limit')
