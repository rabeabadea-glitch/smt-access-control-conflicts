"""End-to-end case study on the hand-written cross-source corpus (25 rules, 7 sources).

Input: data/policies/cross_source_corpus.xml
(the author's own XACML encoding of selected GDPR, AMLD, PCI DSS, NIST SP 800-63B,
SOX and DORA clauses, with the clause-to-rule table in docs/regulatory_mapping.md).

Each top-level Policy is one source. Rules keep their raw applicability (Target and
Condition); the PolicySet combining algorithm is deliberately not applied, because
the corpus is built to expose cross-source overlaps.

Resolution inputs written for this case study (see SPEC below) are explicit
experimental configuration traced to the corpus mapping document. They are not
legal advice and not an organisational approval.

Scenario A uses all 25 rules. Scenario B removes the two ungoverned F2 rules, as the
mapping document recommends retranslating that family with the sole-factor scope
(the governed F2 rules stay in the policy).

Usage (from the package root, with OPA and BALANA_CP set):  python studies/case_study.py
"""
import copy
import hashlib
import itertools
import json
import random
import subprocess
import sys
import time
import xml.etree.ElementTree as ET
from pathlib import Path

import numpy as np

import os
from common import DATA, RESULTS
CORPUS, OUT, OPA, BALANA_CP = DATA / 'policies' / 'cross_source_corpus.xml', RESULTS / 'case_study', os.environ['OPA'], os.environ['BALANA_CP']
from pcproof.model import normalize, fingerprint, transitive, decision  # noqa: E402
from pcproof.verify import audit  # noqa: E402
from research import xacml, rego, workflow  # noqa: E402
from extensions.settled_refinement import refine_settled  # noqa: E402

TIMEOUT_MS = 10000
MAX_ITERATIONS = 100
SAMPLE_SEED = 20261027
OUT.mkdir(parents=True, exist_ok=True)

READABLE = {
    'urn:oasis:names:tc:xacml:1.0:action:action-id': 'action',
    'urn:corp:resource:record-type': 'record_type',
    'urn:corp:resource:contains-pii': 'contains_pii',
    'urn:corp:resource:under-legal-hold': 'legal_hold',
    'urn:corp:subject:role': 'role',
    'urn:corp:resource:str-flag': 'str_flag',
    'urn:corp:env:documented-purpose': 'documented_purpose',
    'urn:corp:resource:retention-age-years': 'retention_age_years',
    'urn:corp:env:legal-basis': 'legal_basis',
    'urn:corp:env:legitimate-need': 'legitimate_need',
    'urn:corp:env:password-age-days': 'password_age_days',
    'urn:corp:env:sole-factor': 'sole_factor',
    'urn:corp:env:compromise-evidence': 'compromise_evidence',
}


def eq(a, v): return {'op': 'eq', 'attr': a, 'value': v}
def lt(a, v): return {'op': 'lt', 'attr': a, 'value': v}
def ge(a, v): return {'op': 'ge', 'attr': a, 'value': v}
def AND(*x): return {'op': 'and', 'args': list(x)}


# Resolution configuration. Each edge and requirement cites the corpus mapping row it comes from.
PRECEDENCE = [
    {'higher': 'AMLD', 'lower': 'GDPR', 'basis': 'F1 GDPR Art. 17(3)(b) legal-obligation exception; F4 GDPR Art. 23(1)(e) restriction'},
    {'higher': 'AMLD', 'lower': 'PCI_DSS', 'basis': 'F5 PCI DSS Req 3.3 legitimate-business-need exception covers investigators'},
    {'higher': 'PCI_DSS', 'lower': 'GDPR', 'basis': 'F3 documented resolution path: PCI Req 10 logging is a documented purpose'},
    {'higher': 'SOX', 'lower': 'GDPR', 'basis': 'F6 by analogy with F1: statutory retention limits erasure/purge (researcher assumption; no governed variant in corpus)'},
    {'higher': 'DORA', 'lower': 'GDPR', 'basis': 'F7 GDPR Art. 6(1)(c) legal-obligation basis for incident reporting'},
]
REQUIREMENTS = [
    {'id': 'F1-retain-transaction-records', 'required': 'Deny',
     'when': AND(eq('action', 'erase'), eq('record_type', 'transaction-record'), lt('retention_age_years', 5)), 'basis': 'AMLD Art. 40(1)'},
    {'id': 'F1-erase-after-retention', 'required': 'Permit',
     'when': AND(eq('action', 'erase'), eq('record_type', 'transaction-record'), eq('contains_pii', 'true'), ge('retention_age_years', 5)), 'basis': 'GDPR Art. 17(1) outside the retention period'},
    {'id': 'F4-no-tipping-off', 'required': 'Deny',
     'when': AND(eq('role', 'data-subject'), eq('action', 'read'), eq('record_type', 'customer-file'), eq('str_flag', 'true')), 'basis': 'AMLD Art. 39(1)'},
    {'id': 'F4-subject-access', 'required': 'Permit',
     'when': AND(eq('role', 'data-subject'), eq('action', 'read'), eq('record_type', 'customer-file'), eq('contains_pii', 'true'), eq('str_flag', 'false')), 'basis': 'GDPR Art. 15(1) when no STR is filed'},
    {'id': 'F5-investigator-full-pan', 'required': 'Permit',
     'when': AND(eq('role', 'investigator'), eq('action', 'display-full-pan'), eq('record_type', 'cardholder-data')), 'basis': 'PCI DSS Req 3.3 legitimate-need exception'},
    {'id': 'F3-log-chd-access', 'required': 'Permit',
     'when': AND(eq('action', 'log'), eq('record_type', 'chd-access-event')), 'basis': 'PCI DSS Req 10.2'},
    {'id': 'F6-retain-audit-workpapers', 'required': 'Deny',
     'when': AND(eq('action', 'purge'), eq('record_type', 'audit-workpaper'), lt('retention_age_years', 7)), 'basis': 'SOX s.802'},
    {'id': 'F7-report-incident', 'required': 'Permit',
     'when': AND(eq('action', 'transmit'), eq('record_type', 'incident-report')), 'basis': 'DORA Art. 19(1)'},
    {'id': 'INT-guest-no-config-write', 'required': 'Deny',
     'when': AND(eq('role', 'guest'), eq('action', 'write'), eq('record_type', 'system-config')), 'basis': 'internal benign control'},
]
F2_UNGOVERNED = {'PCI-8-3-9-rotate-password', 'NIST-63B-no-forced-rotation'}


def save(name, value):
    path = OUT / name
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(value, indent=2), encoding='utf-8')


def build_model():
    imported = xacml.parse_file(str(CORPUS), 'corpus')
    mapping = {h: READABLE[d['AttributeId']] for h, d in imported['attributes'].items()}
    descriptors = {READABLE[d['AttributeId']]: {k: d[k] for k in ('Category', 'AttributeId', 'DataType', 'Issuer') if k in d}
                   for d in imported['attributes'].values()}
    sources, rules = {}, []
    for raw in imported['raw_rules']:
        _, policyset, policy, rule_id = raw['id'].split('/')
        sources.setdefault(policy, {'kind': 'internal', 'citation': 'cross_source_corpus.xml Policy ' + policy,
                                    'mapping_status': 'author-written clause translation; see docs/regulatory_mapping.md'})
        rules.append({'id': rule_id, 'source': policy, 'effect': raw['effect'],
                      'condition': xacml.remap_expr(raw['local_condition'], mapping)})
    domains = {mapping[h]: d for h, d in imported['domains'].items()}
    model = {'schema_version': 'cpm-1', 'attributes': domains, 'sources': sources, 'rules': rules,
             'precedence': [{'higher': e['higher'], 'lower': e['lower'], 'approval_id': 'CASE_STUDY_CONFIGURATION_NOT_AN_APPROVAL'} for e in PRECEDENCE],
             'invariants': [{k: r[k] for k in ('id', 'required', 'when')} for r in REQUIREMENTS]}
    return normalize(model), descriptors


def authorization(model):
    closure = transitive((e['higher'], e['lower']) for e in model['precedence'])
    choices = []
    for left, right in itertools.combinations(model['rules'], 2):
        if left['source'] == right['source'] or left['effect'] == right['effect']:
            continue
        if (left['source'], right['source']) in closure:
            choices.append({'winner': left['id'], 'loser': right['id']})
        elif (right['source'], left['source']) in closure:
            choices.append({'winner': right['id'], 'loser': left['id']})
    common = {'approval_id': 'CASE_STUDY_CONFIGURATION_NOT_AN_APPROVAL', 'policy_sha256': fingerprint(model)}
    return ({**common, 'operation': 'apply_precedence', 'edges': copy.deepcopy(model['precedence'])},
            {**common, 'operation': 'bounded_refinement', 'choices': choices})


def unchecked(model, approval):
    current = copy.deepcopy(model)
    choices = {frozenset(c.values()): c for c in approval['choices']}
    steps = 0
    for _ in range(MAX_ITERATIONS + 1):
        scan = audit(current, 'exhaustive', TIMEOUT_MS)
        positive = [r for r in scan['results'] if r['status'] == 'SAT']
        if not positive:
            return {'status': 'OUTPUT', 'reason': 'NO_CROSS_SOURCE_OVERLAPS_LEFT', 'steps': steps, 'policy': current}
        found = next((r for r in positive if frozenset(r['pair']) in choices), None)
        if found is None:
            return {'status': 'UNFINISHED', 'reason': 'NO_AUTHORIZED_DIRECTION_FOR_REMAINING_CONFLICTS', 'steps': steps, 'policy': current}
        c = choices[frozenset(found['pair'])]
        ids = {r['id']: r for r in current['rules']}
        candidate = copy.deepcopy(current)
        loser = next(r for r in candidate['rules'] if r['id'] == c['loser'])
        loser['condition'] = {'op': 'and', 'args': [ids[c['loser']]['condition'], {'op': 'not', 'arg': ids[c['winner']]['condition']}]}
        current = normalize(candidate)
        steps += 1
    return {'status': 'UNFINISHED', 'reason': 'ITERATION_LIMIT_REACHED', 'steps': steps, 'policy': current}


# ---- independent finite oracle over the complete declared request space (numpy) ----
class Grid:
    def __init__(self, model):
        self.names = list(model['attributes'])
        self.domains = model['attributes']
        self.shape = []
        self.values = {}
        for a in self.names:
            d = self.domains[a]
            vals = d['values'] if d['type'] == 'enum' else ([False, True] if d['type'] == 'bool' else list(range(d['min'], d['max'] + 1)))
            self.values[a] = vals
            self.shape.append(len(vals))
        self.size = int(np.prod(self.shape))

    def axis(self, a):
        k = self.names.index(a)
        shape = [1] * len(self.names)
        shape[k] = self.shape[k]
        return k, shape

    def atom(self, e):
        k, shape = self.axis(e['attr'])
        vals = self.values[e['attr']]
        op, c = e['op'], e['value']
        if self.domains[e['attr']]['type'] == 'enum':
            hits = np.array([(v == c) if op == 'eq' else (v != c) for v in vals])
        else:
            f = {'eq': lambda v: v == c, 'ne': lambda v: v != c, 'lt': lambda v: v < c, 'le': lambda v: v <= c,
                 'gt': lambda v: v > c, 'ge': lambda v: v >= c}[op]
            hits = np.array([f(v) for v in vals])
        return hits.reshape(shape)

    def ev(self, e):
        if e is True or e is False:
            return np.full([1] * len(self.names), e)
        op = e['op']
        if op == 'and':
            out = np.full([1] * len(self.names), True)
            for x in e['args']:
                out = out & self.ev(x)
            return out
        if op == 'or':
            out = np.full([1] * len(self.names), False)
            for x in e['args']:
                out = out | self.ev(x)
            return out
        if op == 'not':
            return ~self.ev(e['arg'])
        return self.atom(e)

    def full(self, arr):
        return np.broadcast_to(arr, self.shape)

    def decisions(self, model):
        permit = np.zeros(self.shape, dtype=bool)
        deny = np.zeros(self.shape, dtype=bool)
        for r in model['rules']:
            m = self.full(self.ev(r['condition']))
            if r['effect'] == 'Permit':
                permit |= m
            else:
                deny |= m
        # 0 NotApplicable, 1 Permit, 2 Deny, 3 Conflict
        return (permit.astype(np.int8) + 2 * deny.astype(np.int8)), permit, deny

    def request(self, flat_index):
        idx = np.unravel_index(flat_index, self.shape)
        return {a: self.values[a][int(i)] for a, i in zip(self.names, idx)}


LABEL = {0: 'NotApplicable', 1: 'Permit', 2: 'Deny', 3: 'Conflict'}


def oracle_report(grid, original, output, base_codes):
    codes, _, _ = grid.decisions(output)
    counts = {LABEL[k]: int((codes == k).sum()) for k in range(4)}
    violations = {}
    for inv in output['invariants']:
        region = grid.full(grid.ev(inv['when']))
        want = 1 if inv['required'] == 'Permit' else 2
        violations[inv['id']] = int((region & (codes != want)).sum())
    pure = (base_codes == 1) | (base_codes == 2)
    retired = [r['id'] for r in output['rules'] if not grid.full(grid.ev(r['condition'])).any()]
    changed = codes != base_codes
    return {'decision_counts': counts, 'contract_violation_requests': violations,
            'changed_requests': int(changed.sum()), 'changed_from_conflict': int((changed & (base_codes == 3)).sum()),
            'pure_decisions_changed': int((changed & pure).sum()), 'retired_rules': retired}, codes


def run_opa(folder, model, requests):
    conditions, wrapper, manifest = rego.generate(model)
    (folder / 'conditions.rego').write_text(conditions)
    (folder / 'decision.rego').write_text(wrapper)
    (folder / 'OPA_inputs.json').write_text(json.dumps({'cases': requests}))
    recovered = rego.roundtrip(conditions, wrapper, manifest)
    roundtrip_mismatch = sum(decision(recovered, r) != decision(model, r) for r in requests)
    cmd = [OPA, 'eval', '--format=json', '--strict-builtin-errors', '-d', str(folder / 'conditions.rego'), '-d',
           str(folder / 'decision.rego'), '-d', str(folder / 'OPA_inputs.json'),
           '[r | x := data.cases[_]; r := data.thesis.result with input as x]']
    run = subprocess.run(cmd, capture_output=True, timeout=600)
    (folder / 'OPA.stderr.txt').write_bytes(run.stderr)
    actual = json.loads(run.stdout)['result'][0]['expressions'][0]['value'] if run.returncode == 0 else []
    return actual, roundtrip_mismatch, run.returncode


def run_balana(folder, model, requests):
    policy = folder / 'target.xml'
    attrs = xacml.export_cpm(model, policy)
    recovered = xacml.import_cpm_pair(policy)
    roundtrip_mismatch = sum(decision(recovered, r) != decision(model, r) for r in requests)
    lines = []
    for i, r in enumerate(requests):
        req = folder / f'requests/{i:04}.xml'
        req.parent.mkdir(exist_ok=True)
        xacml.request_xml(r, attrs, req)
        lines.append('\t'.join([f'{i}', str(policy), str(req), str(folder / f'responses/{i:04}.xml')]))
    (folder / 'Balana_manifest.tsv').write_text('\n'.join(lines) + '\n')
    run = subprocess.run(['java', '-Xmx1024m', '-cp', BALANA_CP, 'BalanaBatch', str(folder / 'Balana_manifest.tsv')],
                         capture_output=True, timeout=1800)
    (folder / 'Balana.stderr.txt').write_bytes(run.stderr)
    actual = []
    for i in range(len(requests)):
        try:
            labels = [(n.text or '').strip() for n in ET.parse(folder / f'responses/{i:04}.xml').getroot().iter() if xacml.local(n) == 'Decision']
            actual.append(labels[0] if len(labels) == 1 else 'NO_SINGLE_DECISION')
        except Exception:
            actual.append('NO_NATIVE_RESPONSE')
    return actual, roundtrip_mismatch


def main():
    model, descriptors = build_model()
    save('model_scenario_A.json', model)
    save('resolution_configuration.json', {'precedence': PRECEDENCE, 'requirements': REQUIREMENTS,
                                           'scenario_B_removed_rules': sorted(F2_UNGOVERNED),
                                           'note': 'Written for this case study from docs/regulatory_mapping.md; not legal advice; not an approval.'})
    save('attribute_descriptors.json', descriptors)
    scenarios = {'A_all_25_rules': model}
    b = copy.deepcopy(model)
    b['rules'] = [r for r in b['rules'] if r['id'] not in F2_UNGOVERNED]
    scenarios['B_F2_retranslated'] = normalize(b)
    summary = {}
    rng = random.Random(SAMPLE_SEED)
    for name, m in scenarios.items():
        folder = OUT / name
        grid = Grid(m)
        base_codes, _, _ = grid.decisions(m)
        detection = audit(m, 'exhaustive', TIMEOUT_MS)
        sat = [r for r in detection['results'] if r['status'] == 'SAT']
        save(f'{name}/detection.json', detection)
        prec_auth, ref_auth = authorization(m)
        results = {}
        runs = {
            'no_edit': lambda: {'status': 'BASELINE_UNCHANGED', 'committed': False},
            'configured_precedence': lambda: workflow.apply_precedence(m, prec_auth, TIMEOUT_MS),
            'unchecked_subtraction': lambda: unchecked(m, ref_auth),
            'checked_listed': lambda: workflow.refine_bounded(m, ref_auth, MAX_ITERATIONS, TIMEOUT_MS),
            'checked_settled': lambda: refine_settled(m, ref_auth, MAX_ITERATIONS, TIMEOUT_MS),
        }
        # request sample for engines: every SAT witness plus seeded random requests
        sample = [r['witness'] for r in sat]
        for _ in range(2000):
            sample.append(grid.request(rng.randrange(grid.size)))
        for method, call in runs.items():
            t = time.perf_counter()
            res = call()
            elapsed = time.perf_counter() - t
            if method == 'unchecked_subtraction':
                output = res['policy']
            else:
                output = res['policy'] if res.get('committed') else m
            report, codes = oracle_report(grid, m, output, base_codes)
            row = {'status': res['status'], 'reason': res.get('reason'), 'committed': bool(res.get('committed')),
                   'steps': res.get('steps', len(res.get('iterations', []))), 'elapsed_seconds_diagnostic': round(elapsed, 2), **report}
            save(f'{name}/{method}/output_model.json', output)
            save(f'{name}/{method}/result.json', {k: v for k, v in res.items() if k != 'policy'})
            engine_folder = folder / method / 'native'
            engine_folder.mkdir(parents=True, exist_ok=True)
            expected = [LABEL[int(codes.reshape(-1)[np.ravel_multi_index(tuple(grid.values[a].index(r[a]) for a in grid.names), grid.shape)])] for r in sample]
            try:
                opa, rt, rc = run_opa(engine_folder, output, sample)
                row['opa'] = {'requests': len(sample), 'returncode': rc, 'mismatches': sum(x['decision'] != y for x, y in zip(opa, expected)) + abs(len(opa) - len(expected)), 'rego_roundtrip_mismatches': rt}
            except Exception as exc:
                row['opa'] = {'error': type(exc).__name__ + ': ' + str(exc)}
            try:
                bal, rt = run_balana(engine_folder, output, sample)
                row['balana'] = {'requests': len(sample), 'mismatches': sum(x != y for x, y in zip(bal, expected)), 'xacml_roundtrip_mismatches': rt}
            except Exception as exc:
                row['balana'] = {'export': 'REJECTED', 'reason': type(exc).__name__ + ': ' + str(exc)[:300]}
            results[method] = row
            print(name, method, row['status'], row['reason'], row['steps'], row['decision_counts']['Conflict'],
                  sum(row['contract_violation_requests'].values()), len(row['retired_rules']), row.get('opa'), row.get('balana'), flush=True)
        summary[name] = {'rules': len(m['rules']), 'sources': len(m['sources']), 'request_space': grid.size,
                         'eligible_pairs': detection['eligible_pairs'], 'sat_pairs': [r['pair'] for r in sat],
                         'authorized_choices': len(ref_auth['choices']), 'methods': results}
    save('summary.json', summary)


if __name__ == '__main__':
    main()
