"""Settled-winner pair selection (extensions.settled_refinement).

The chained example has priority A > B > C. Repairing (B, C) before (A, B)
subtracts B's original region from C and empties C, so the frozen listed-order
loop refuses that rule order. The settled-winner loop narrows B first and keeps
a nonempty C for every rule order.
"""
import copy
import itertools
import json
import unittest

from pcproof.model import normalize, fingerprint, decision
from research import workflow
from extensions.settled_refinement import refine_settled, select_pair, SELECTION_RULE


def atom(value):
    return {'op': 'eq', 'attr': 'x', 'value': value}


def anyof(*values):
    return {'op': 'or', 'args': [atom(v) for v in values]} if len(values) > 1 else atom(values[0])


def source():
    return {'kind': 'synthetic', 'citation': 'unit test', 'mapping_status': 'constructed'}


def chained(order):
    rules = {
        'A': {'id': 'A', 'source': 'A', 'effect': 'Deny', 'condition': anyof(1)},
        'B': {'id': 'B', 'source': 'B', 'effect': 'Permit', 'condition': anyof(0, 1)},
        'C': {'id': 'C', 'source': 'C', 'effect': 'Deny', 'condition': anyof(0, 1)},
    }
    return normalize({
        'schema_version': 'cpm-1', 'attributes': {'x': {'type': 'int', 'min': 0, 'max': 2}},
        'sources': {s: source() for s in 'ABC'}, 'rules': [rules[k] for k in order],
        'precedence': [{'higher': 'A', 'lower': 'B', 'approval_id': 'TEST'},
                       {'higher': 'B', 'lower': 'C', 'approval_id': 'TEST'}],
        'invariants': [{'id': 'deny-1', 'required': 'Deny', 'when': atom(1)},
                       {'id': 'permit-0', 'required': 'Permit', 'when': atom(0)}]})


def approval(p, choices=None):
    return {'approval_id': 'TEST', 'policy_sha256': fingerprint(p), 'operation': 'bounded_refinement',
            'choices': choices or [{'winner': 'A', 'loser': 'B'}, {'winner': 'B', 'loser': 'C'}]}


def canonical(policy):
    return json.dumps(sorted(policy['rules'], key=lambda r: r['id']), sort_keys=True)


class SettledRefinementTests(unittest.TestCase):
    def test_listed_order_can_empty_a_loser(self):
        p = chained('BCA')
        before = copy.deepcopy(p)
        result = workflow.refine_bounded(p, approval(p), 10, 2000)
        self.assertEqual(result['status'], 'REJECTED')
        self.assertEqual(result['reason'], 'REPAIR_REMOVES_ALL_LOSER_BEHAVIOR_OR_UNRESOLVED')
        self.assertEqual(p, before)

    def test_settled_accepts_every_rule_order_with_identical_output(self):
        outputs = set()
        for order in itertools.permutations('ABC'):
            p = chained(''.join(order))
            result = refine_settled(p, approval(p), 10, 2000)
            self.assertEqual(result['status'], 'ACCEPTED', order)
            self.assertEqual(result['selection_rule'], SELECTION_RULE)
            outputs.add(canonical(result['policy']))
            self.assertEqual([decision(result['policy'], {'x': v})['decision'] for v in range(3)],
                             ['Permit', 'Deny', 'NotApplicable'])
        self.assertEqual(len(outputs), 1)

    def test_settled_uses_final_winner_condition(self):
        p = chained('CBA')
        result = refine_settled(p, approval(p), 10, 2000)
        first, second = result['iterations']
        self.assertEqual(first['choice'], {'winner': 'A', 'loser': 'B'})
        self.assertEqual(second['choice'], {'winner': 'B', 'loser': 'C'})
        c = next(r for r in result['policy']['rules'] if r['id'] == 'C')
        only_c = {**result['policy'], 'rules': [c]}
        self.assertEqual([v for v in range(3) if decision(only_c, {'x': v})['decision'] == 'Deny'], [1])

    def test_cyclic_directions_are_refused_without_mutation(self):
        effects = {'A': 'Permit', 'B': 'Deny', 'C': 'Permit', 'D': 'Deny'}
        p = normalize({
            'schema_version': 'cpm-1', 'attributes': {'x': {'type': 'int', 'min': 0, 'max': 2}},
            'sources': {s: source() for s in 'ABCD'},
            'rules': [{'id': s, 'source': s, 'effect': e, 'condition': anyof(0, 1)} for s, e in effects.items()],
            'precedence': [],
            'invariants': [{'id': 'deny-1', 'required': 'Deny', 'when': atom(1)},
                           {'id': 'permit-0', 'required': 'Permit', 'when': atom(0)}]})
        cycle = [{'winner': 'A', 'loser': 'B'}, {'winner': 'B', 'loser': 'C'},
                 {'winner': 'C', 'loser': 'D'}, {'winner': 'D', 'loser': 'A'}]
        before = copy.deepcopy(p)
        result = refine_settled(p, approval(p, cycle), 10, 2000)
        self.assertEqual(result['reason'], 'CYCLIC_AUTHORIZED_DIRECTIONS_AMONG_OPEN_CONFLICTS')
        self.assertFalse(result['committed'])
        self.assertEqual(p, before)

    def test_stale_policy_hash_rejected(self):
        p = chained('ABC')
        stale = approval(p)
        stale['policy_sha256'] = '0' * 64
        result = refine_settled(p, stale, 10, 2000)
        self.assertEqual(result['reason'], 'STALE_OR_WRONG_POLICY_HASH')
        self.assertFalse(result['committed'])

    def test_selector_ignores_unauthorized_pairs_and_list_position(self):
        rows = [{'pair': ['C', 'B']}, {'pair': ['X', 'Y']}, {'pair': ['B', 'A']}]
        choices = {frozenset(['A', 'B']): {'winner': 'A', 'loser': 'B'},
                   frozenset(['B', 'C']): {'winner': 'B', 'loser': 'C'}}
        for permuted in itertools.permutations(rows):
            row, reason = select_pair(list(permuted), choices)
            self.assertIsNone(reason)
            self.assertEqual(set(row['pair']), {'A', 'B'})
        self.assertEqual(select_pair([{'pair': ['X', 'Y']}], choices),
                         (None, 'NO_AUTHORIZED_DIRECTION_FOR_REMAINING_CONFLICTS'))


if __name__ == '__main__':
    unittest.main()
