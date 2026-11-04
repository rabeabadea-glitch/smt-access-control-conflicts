"""Regressions for source-import singleton selectors and accepted controls.

XACML designators without Issuer select values from every issuer.  Treating
that selector and a named issuer as independent scalar attributes admits
requests outside the importer's total-singleton profile.
"""
import itertools
from pathlib import Path
import tempfile
import unittest
import xml.etree.ElementTree as ET

from pcproof.model import decision
from research import xacml


def designator(parent, issuer='', attribute='urn:test:role'):
    attributes = {
        'Category': 'urn:test:subject', 'AttributeId': attribute,
        'DataType': xacml.XS+'string', 'MustBePresent': 'true',
    }
    if issuer:
        attributes['Issuer'] = issuer
    return xacml.el(parent, 'AttributeDesignator', attributes)


def source_policy(selectors, location='condition'):
    """Build a single Permit rule with conjunctive equality predicates.

    selectors consists of (issuer, attribute identifier, expected literal).
    Repeated descriptors deliberately use the same internal attribute.
    """
    root = ET.Element('{'+xacml.NS+'}Policy', {
        'PolicyId': 'urn:test:intake-selectors', 'Version': '1.0',
        'RuleCombiningAlgId': 'urn:oasis:names:tc:xacml:1.0:rule-combining-algorithm:first-applicable',
    })
    xacml.el(root, 'Target')
    rule = xacml.el(root, 'Rule', {'RuleId': 'urn:test:permit', 'Effect': 'Permit'})
    if location == 'target':
        container = xacml.el(xacml.el(xacml.el(rule, 'Target'), 'AnyOf'), 'AllOf')
        for issuer, attribute, literal in selectors:
            match = xacml.el(container, 'Match', {'MatchId': xacml.FN+'string-equal'})
            xacml.el(match, 'AttributeValue', {'DataType': xacml.XS+'string'}, literal)
            designator(match, issuer, attribute)
    else:
        condition = xacml.el(rule, 'Condition')
        container = xacml.el(condition, 'Apply', {'FunctionId': xacml.FN+'and'}) if len(selectors) > 1 else condition
        for issuer, attribute, literal in selectors:
            comparison = xacml.el(container, 'Apply', {'FunctionId': xacml.FN+'string-equal'})
            one = xacml.el(comparison, 'Apply', {'FunctionId': xacml.FN+'string-one-and-only'})
            designator(one, issuer, attribute)
            xacml.el(comparison, 'AttributeValue', {'DataType': xacml.XS+'string'}, literal)
    return root


def import_tree(tree, directory):
    path = Path(directory)/'policy.xml'
    ET.ElementTree(tree).write(path, encoding='utf-8', xml_declaration=True)
    return xacml.parse_file(path)


class SourceSelectorIntakeTests(unittest.TestCase):
    def assert_overlap_rejected(self, tree):
        with tempfile.TemporaryDirectory() as directory:
            with self.assertRaisesRegex(xacml.Unsupported, 'Overlapping attribute designators'):
                import_tree(tree, directory)

    def assert_positive_matches(self, selectors, location='condition', attribute_count=2):
        with tempfile.TemporaryDirectory() as directory:
            tree = source_policy(selectors, location)
            model = import_tree(tree, directory)
            self.assertEqual(len(model['attributes']), attribute_count)
            expected = {xacml.sid('urn:test:subject', attribute, xacml.XS+'string', issuer): literal
                        for issuer, attribute, literal in selectors}
            for values in itertools.product(*(model['domains'][name]['values'] for name in model['attributes'])):
                request = dict(zip(model['attributes'], values))
                label = 'Permit' if all(request[name] == literal for name, literal in expected.items()) else 'NotApplicable'
                self.assertEqual(decision(model['cpm'], request)['decision'], label)
                self.assertEqual(xacml.decision_xml(tree, request), label)
            return model

    def test_condition_wildcard_named_overlap_rejected_in_both_orders(self):
        selectors = [('', 'urn:test:role', 'red'), ('urn:test:issuer-A', 'urn:test:role', 'blue')]
        for order in (selectors, selectors[::-1]):
            with self.subTest(order=order):
                self.assert_overlap_rejected(source_policy(order))

    def test_target_wildcard_named_overlap_rejected_in_both_orders(self):
        selectors = [('', 'urn:test:role', 'red'), ('urn:test:issuer-A', 'urn:test:role', 'blue')]
        for order in (selectors, selectors[::-1]):
            with self.subTest(order=order):
                self.assert_overlap_rejected(source_policy(order, 'target'))

    def test_overlap_across_target_and_condition_rejected(self):
        for target_issuer, condition_issuer in (('', 'urn:test:issuer-A'), ('urn:test:issuer-A', '')):
            with self.subTest(target_issuer=target_issuer):
                tree = source_policy([(target_issuer, 'urn:test:role', 'red')], 'target')
                condition_tree = source_policy([(condition_issuer, 'urn:test:role', 'blue')])
                xacml.child(tree, 'Rule').append(xacml.child(xacml.child(condition_tree, 'Rule'), 'Condition'))
                self.assert_overlap_rejected(tree)

    def test_distinct_named_issuers_remain_accepted(self):
        self.assert_positive_matches([('urn:test:issuer-A', 'urn:test:role', 'red'),
                                      ('urn:test:issuer-B', 'urn:test:role', 'blue')])

    def test_repeated_identical_wildcard_condition_remains_one_attribute(self):
        self.assert_positive_matches([('', 'urn:test:role', 'red')]*2, attribute_count=1)

    def test_repeated_identical_named_target_remains_one_attribute(self):
        self.assert_positive_matches([('urn:test:issuer-A', 'urn:test:role', 'red')]*2,
                                     location='target', attribute_count=1)

    def test_ordinary_distinct_attribute_source_remains_accepted(self):
        self.assert_positive_matches([('', 'urn:test:role', 'red'), ('', 'urn:test:department', 'blue')])

    def test_no_designator_source_retains_valid_dummy_mapping(self):
        tree = source_policy([('', 'urn:test:role', 'red')])
        rule = xacml.child(tree, 'Rule')
        rule.remove(xacml.child(rule, 'Condition'))
        with tempfile.TemporaryDirectory() as directory:
            model = import_tree(tree, directory)
            self.assertEqual(model['domains'], {'dummy': {'type': 'bool'}})
            for value in (False, True):
                self.assertEqual(decision(model['cpm'], {'dummy': value})['decision'], 'Permit')


if __name__ == '__main__':
    unittest.main()
