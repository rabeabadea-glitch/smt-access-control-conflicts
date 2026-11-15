"""Replay every solver witness in two real policy engines.

For each SAT pair of a pair table the witness request is sent to
  * Balana 1.2.24 (XACML PDP): once against a policy that holds only rule A with
    its inherited Targets, once against a policy that holds only rule B. The pair
    passes when Balana answers A's effect and B's effect (one Permit, one Deny).
    The two policies are cut from the original XML, not from the CPM.
  * OPA 1.21.2: against the Rego generated from the CPM by src/research/rego.py.
    The pair passes when OPA answers "Conflict" and lists both rules as matched.

Environment: OPA (path to the opa binary), BALANA_CP (classpath, see README).
Usage:  python v3/replay.py <dataset> [<dataset> ...]
"""
from __future__ import annotations
import copy
import json
import os
import subprocess
import sys
import xml.etree.ElementTree as ET
from pathlib import Path

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE))
import funnel  # noqa: E402
import intake  # noqa: E402
from independent_check import rules as xml_rules, kid  # noqa: E402
from research import rego, xacml  # noqa: E402

NS = 'urn:oasis:names:tc:xacml:3.0:core:schema:wd-17'
ET.register_namespace('', NS)


def single_rule_policy(rule, path):
    policy = ET.Element('{%s}Policy' % NS, {
        'PolicyId': 'urn:v3:replay', 'Version': '1.0',
        'RuleCombiningAlgId': 'urn:oasis:names:tc:xacml:3.0:rule-combining-algorithm:deny-overrides'})
    target = ET.SubElement(policy, '{%s}Target' % NS)
    for t in rule['targets']:
        if t is not None:
            for anyof in t:
                target.append(copy.deepcopy(anyof))
    out = ET.SubElement(policy, '{%s}Rule' % NS, {'RuleId': 'urn:v3:replay:rule', 'Effect': rule['effect']})
    ET.SubElement(out, '{%s}Target' % NS)
    if rule['condition'] is not None:
        ET.SubElement(out, '{%s}Condition' % NS).append(copy.deepcopy(rule['condition']))
    ET.ElementTree(policy).write(path, encoding='utf-8', xml_declaration=True)


def run(name):
    path, sources = funnel.DATASETS[name]
    table = json.loads((funnel.OUT / f'pairs_{name}.json').read_text())
    sat = [r for r in table['rows'] if r['status'] == 'SAT']
    out = {'dataset': name, 'witnesses': len(sat)}
    if not sat:
        return out
    m = intake.load(path, sources)
    folder = funnel.OUT / 'replay' / name
    folder.mkdir(parents=True, exist_ok=True)
    # ---- Balana ---------------------------------------------------------------
    by_id = {r['id']: r for r in xml_rules(ET.parse(path).getroot(), sources)}
    index = {rid: i for i, rid in enumerate(by_id)}
    lines, expected = [], []
    for k, row in enumerate(sat):
        request = folder / f'{k:04}.request.xml'
        xacml.request_xml(row['witness'], m['mapping'], request)
        for side, rid in enumerate(row['pair']):
            policy = folder / f'rule_{index[rid]:04}.xml'
            if not policy.exists():
                single_rule_policy(by_id[rid], policy)
            lines.append('\t'.join([f'{k}:{side}', str(policy), str(request), str(folder / f'{k:04}.{side}.response.xml')]))
            expected.append(by_id[rid]['effect'])
    manifest = folder / 'Balana_manifest.tsv'
    manifest.write_text('\n'.join(lines) + '\n')
    proc = subprocess.run(['java', '-Xmx1024m', '-cp', os.environ['BALANA_CP'], 'BalanaBatch', str(manifest)],
                          capture_output=True, text=True, timeout=3600)
    got = []
    for line in lines:
        response = Path(line.split('\t')[3])
        labels = [(n.text or '').strip() for n in ET.parse(response).getroot().iter() if n.tag.rsplit('}', 1)[-1] == 'Decision'] if response.exists() else []
        got.append(labels[0] if len(labels) == 1 else 'NO_SINGLE_DECISION')
    pairs_ok = sum(got[2 * k] == expected[2 * k] and got[2 * k + 1] == expected[2 * k + 1] for k in range(len(sat)))
    out['balana'] = {'evaluations': len(lines), 'returncode': proc.returncode, 'pairs_confirmed': pairs_ok,
                     'pairs_not_confirmed': len(sat) - pairs_ok,
                     'decisions': {d: got.count(d) for d in sorted(set(got))}}
    # ---- OPA -------------------------------------------------------------------
    conditions, wrapper, _ = rego.generate(m['cpm'])
    (folder / 'conditions.rego').write_text(conditions)
    (folder / 'decision.rego').write_text(wrapper)
    (folder / 'OPA_inputs.json').write_text(json.dumps({'cases': [r['witness'] for r in sat]}))
    proc = subprocess.run([os.environ['OPA'], 'eval', '--format=json', '--strict-builtin-errors',
                           '-d', str(folder / 'conditions.rego'), '-d', str(folder / 'decision.rego'),
                           '-d', str(folder / 'OPA_inputs.json'),
                           '[r | x := data.cases[_]; r := data.thesis.result with input as x]'],
                          capture_output=True, timeout=3600)
    (folder / 'OPA.stdout.json').write_bytes(proc.stdout)
    answers = json.loads(proc.stdout)['result'][0]['expressions'][0]['value'] if proc.returncode == 0 else []
    ok = sum(a['decision'] == 'Conflict' and set(r['pair']) <= set(a['matched']) for a, r in zip(answers, sat))
    out['opa'] = {'evaluations': len(answers), 'returncode': proc.returncode, 'pairs_confirmed': ok,
                  'pairs_not_confirmed': len(sat) - ok}
    return out


if __name__ == '__main__':
    results = [run(n) for n in sys.argv[1:]]
    for r in results:
        print(json.dumps(r))
    done = funnel.OUT / 'replay_summary.json'
    prior = json.loads(done.read_text()) if done.exists() else {}
    prior.update({r['dataset']: r for r in results})
    done.write_text(json.dumps(prior, indent=1))
