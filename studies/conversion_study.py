"""Documented conversions of two named artifacts that the strict importer rejected.

GEYSERS (15 rules): AttributeDesignator elements lack the Category attribute and the
PolicySet lacks the Target element, both required by XACML 3.0, so neither the importer
nor Balana can read the file. The conversion adds an empty Target where it is missing,
Category from the attribute identifier (resource-type -> resource, action-id -> action)
and MustBePresent="false". Nothing else changes.

KMarket (5 rules): the file uses AdviceExpressions and ObligationExpressions, which
are outside the decision-only profile. The conversion removes those containers to give
a decision-only view. Advice and obligations are real operational output, so the
converted file is NOT equivalent to the original for a PEP; only the Permit/Deny/
NotApplicable decision is compared. Balana is run on both files to check that the
decision is unchanged.

For each converted file: whole-policy import, the project's direct XML evaluator,
the compiled CPM, actual Balana on the converted XML and actual OPA on generated Rego
are compared on the complete declared request space (or a seeded sample if larger
than 20,000 requests).

Usage (from the package root, with OPA and BALANA_CP set):  python studies/conversion_study.py
"""
import copy
import itertools
import json
import random
import subprocess
import sys
import xml.etree.ElementTree as ET
from pathlib import Path

import os
from common import DATA as _DATA, RESULTS
DATA, OUT, OPA, BALANA_CP = _DATA / 'policies', RESULTS / 'conversion_study', os.environ['OPA'], os.environ['BALANA_CP']
from pcproof.model import decision  # noqa: E402
from pcproof.verify import audit  # noqa: E402
from research import xacml, rego  # noqa: E402

NS = 'urn:oasis:names:tc:xacml:3.0:core:schema:wd-17'
ET.register_namespace('', NS)
OUT.mkdir(parents=True, exist_ok=True)
CAT = {'resource': 'urn:oasis:names:tc:xacml:3.0:attribute-category:resource',
       'action': 'urn:oasis:names:tc:xacml:3.0:attribute-category:action'}


def convert_geysers(tree):
    log = {'category_added': 0, 'must_be_present_added': 0, 'empty_target_added': 0}
    for node in list(tree.iter('{%s}PolicySet' % NS)) + list(tree.iter('{%s}Policy' % NS)):
        if node.find('{%s}Target' % NS) is None:
            position = 1 if len(node) and node[0].tag == '{%s}Description' % NS else 0
            node.insert(position, ET.Element('{%s}Target' % NS))
            log['empty_target_added'] += 1
    for d in tree.iter('{%s}AttributeDesignator' % NS):
        if 'Category' not in d.attrib:
            aid = d.get('AttributeId')
            if '/resource/' in aid or ':resource:' in aid:
                d.set('Category', CAT['resource'])
            elif ':action:' in aid:
                d.set('Category', CAT['action'])
            else:
                raise ValueError('No documented category rule for ' + aid)
            log['category_added'] += 1
        if 'MustBePresent' not in d.attrib:
            d.set('MustBePresent', 'false')
            log['must_be_present_added'] += 1
    return log


def convert_kmarket(tree):
    log = {'advice_containers_removed': 0, 'obligation_containers_removed': 0}
    for parent in tree.iter():
        for c in list(parent):
            if c.tag == '{%s}AdviceExpressions' % NS:
                parent.remove(c)
                log['advice_containers_removed'] += 1
            elif c.tag == '{%s}ObligationExpressions' % NS:
                parent.remove(c)
                log['obligation_containers_removed'] += 1
    return log


def requests_for(cpm):
    names = list(cpm['attributes'])
    lists = []
    for a in names:
        d = cpm['attributes'][a]
        lists.append(d['values'] if d['type'] == 'enum' else ([False, True] if d['type'] == 'bool' else list(range(d['min'], d['max'] + 1))))
    size = 1
    for x in lists:
        size *= len(x)
    if size <= 20000:
        return [dict(zip(names, v)) for v in itertools.product(*lists)], size, 'complete'
    rng = random.Random(20261027)
    return [{a: rng.choice(x) for a, x in zip(names, lists)} for _ in range(2048)], size, 'seeded sample of 2048'


def balana(folder, policy, attrs, requests, tag):
    lines = []
    for i, r in enumerate(requests):
        req = folder / 'requests' / f'{i:05}.xml'
        req.parent.mkdir(parents=True, exist_ok=True)
        if not req.exists():
            xacml.request_xml(r, attrs, req)
        lines.append('\t'.join([f'{tag}{i}', str(policy), str(req), str(folder / f'responses_{tag}' / f'{i:05}.xml')]))
    manifest = folder / f'Balana_{tag}.tsv'
    manifest.write_text('\n'.join(lines) + '\n')
    run = subprocess.run(['java', '-Xmx1024m', '-cp', BALANA_CP, 'BalanaBatch', str(manifest)], capture_output=True, timeout=3600)
    (folder / f'Balana_{tag}.stderr.txt').write_bytes(run.stderr)
    out = []
    for i in range(len(requests)):
        try:
            labels = [(n.text or '').strip() for n in ET.parse(folder / f'responses_{tag}' / f'{i:05}.xml').getroot().iter() if xacml.local(n) == 'Decision']
            out.append(labels[0] if len(labels) == 1 else 'NO_SINGLE_DECISION')
        except Exception:
            out.append('NO_NATIVE_RESPONSE')
    return out


def main():
    summary = {}
    for name, filename, converter in (('GEYSERS', 'GEYSERS.xml', convert_geysers), ('KMarket', 'KMarket.xml', convert_kmarket)):
        folder = OUT / name
        folder.mkdir(parents=True, exist_ok=True)
        original = DATA / filename
        row = {'original': 'data/policies/' + filename}
        try:
            xacml.parse_file(str(original), name)
            row['original_import'] = 'ACCEPTED'
        except Exception as exc:
            row['original_import'] = 'REJECTED: ' + str(exc)[:200]
        tree = ET.parse(original)
        row['conversion'] = converter(tree)
        converted = folder / f'{name}_converted.xml'
        tree.write(converted, encoding='UTF-8', xml_declaration=True)
        parsed = xacml.parse_file(str(converted), name)
        cpm = parsed['cpm']
        row['converted_import'] = 'ACCEPTED'
        row['literal_rules'] = parsed['raw_rule_count']
        requests, size, kind = requests_for(cpm)
        row['request_space'] = size
        row['requests'] = len(requests)
        row['request_selection'] = kind
        root = ET.parse(converted).getroot()
        direct = [xacml.decision_xml(root, r) for r in requests]
        model = [decision(cpm, r)['decision'] for r in requests]
        row['direct_xml_vs_cpm_mismatches'] = sum(a != b for a, b in zip(direct, model))
        row['decision_counts'] = {k: model.count(k) for k in sorted(set(model))}
        bal = balana(folder, converted, parsed['attributes'], requests, 'converted')
        row['balana_converted_vs_cpm_mismatches'] = sum(a != b for a, b in zip(bal, model))
        orig_bal = balana(folder, original, parsed['attributes'], requests, 'original')
        row['balana_original_outcomes'] = {k: orig_bal.count(k) for k in sorted(set(orig_bal))}
        row['balana_original_vs_converted_mismatches'] = sum(a != b for a, b in zip(orig_bal, bal))
        conditions, wrapper, manifest = rego.generate(cpm)
        (folder / 'conditions.rego').write_text(conditions)
        (folder / 'decision.rego').write_text(wrapper)
        (folder / 'OPA_inputs.json').write_text(json.dumps({'cases': requests}))
        run = subprocess.run([OPA, 'eval', '--format=json', '--strict-builtin-errors', '-d', str(folder / 'conditions.rego'),
                              '-d', str(folder / 'decision.rego'), '-d', str(folder / 'OPA_inputs.json'),
                              '[r | x := data.cases[_]; r := data.thesis.result with input as x]'], capture_output=True, timeout=600)
        opa = json.loads(run.stdout)['result'][0]['expressions'][0]['value'] if run.returncode == 0 else []
        row['opa_vs_cpm_mismatches'] = sum(a['decision'] != b for a, b in zip(opa, model)) + abs(len(opa) - len(model))
        # within-source leaf diagnostics (raw leaves, combining ignored): how many opposite-effect leaf pairs overlap
        leaves = copy.deepcopy(cpm)
        leaves['rules'] = [{'id': f'leaf{i}', 'source': f'leaf{i}', 'effect': x['effect'], 'condition': x['local_condition']}
                           for i, x in enumerate(parsed['raw_rules'])]
        leaves['sources'] = {r['source']: {'kind': 'internal', 'citation': 'leaf', 'mapping_status': 'diagnostic'} for r in leaves['rules']}
        from pcproof.model import normalize
        scan = audit(normalize(leaves), 'exhaustive', 2000)
        row['leaf_opposite_effect_pairs'] = scan['eligible_pairs']
        row['leaf_overlapping_pairs'] = sum(r['status'] == 'SAT' for r in scan['results'])
        summary[name] = row
        print(name, json.dumps(row), flush=True)
    (OUT / 'summary.json').write_text(json.dumps(summary, indent=2))


if __name__ == '__main__':
    main()
