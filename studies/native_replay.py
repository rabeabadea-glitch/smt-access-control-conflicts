"""Replay the frozen-order outputs of the order study in the real engines.

For every case and both pair-selection rules, the committed output (or the
original policy kept after a refusal) is exported to Rego and run in OPA, and,
when no request can be both permitted and denied, exported to XACML and run in
Balana. Every request of the frozen truth table is evaluated. Engine decisions
are compared with the output model (fidelity) and with the frozen target
(repair success); the two are reported separately.

Usage (from the package root, with OPA and BALANA_CP set):
  python studies/native_replay.py
"""
import json
import os
import subprocess
import xml.etree.ElementTree as ET

from common import RESULTS, CASES, read, save, decide, load_case, tool_paths

OPA = os.environ['OPA']
CP = os.environ['BALANA_CP']
STUDY = RESULTS / 'order_study'
OUT = RESULTS / 'native_replay'


def run():
    from research import rego, xacml
    from pcproof.model import decision
    summary = {'tools': tool_paths(), 'rows': {}}
    for case in CASES:
        _, truth = load_case(case)
        requests = [row['request'] for row in truth]
        targets = [row['expected_final_decision'] for row in truth]
        for mode in ('listed', 'settled'):
            model = read(STUDY / 'frozen_order_outputs' / f'{case}_{mode}.json')
            folder = OUT / case / mode
            folder.mkdir(parents=True, exist_ok=True)
            expected = [decide(model, r) for r in requests]
            assert expected == [decision(model, r)['decision'] for r in requests], 'evaluators disagree'
            row = {'requests': len(requests)}
            conditions, wrapper, manifest = rego.generate(model)
            (folder / 'conditions.rego').write_text(conditions)
            (folder / 'decision.rego').write_text(wrapper)
            (folder / 'OPA_inputs.json').write_text(json.dumps({'cases': requests}))
            proc = subprocess.run([OPA, 'eval', '--format=json', '--strict-builtin-errors',
                                   '-d', str(folder / 'conditions.rego'), '-d', str(folder / 'decision.rego'),
                                   '-d', str(folder / 'OPA_inputs.json'),
                                   '[r | x := data.cases[_]; r := data.thesis.result with input as x]'],
                                  capture_output=True, timeout=600)
            (folder / 'OPA.stdout.json').write_bytes(proc.stdout)
            opa = json.loads(proc.stdout)['result'][0]['expressions'][0]['value'] if proc.returncode == 0 else []
            row['opa_returncode'] = proc.returncode
            row['opa_model_mismatches'] = sum(a['decision'] != b for a, b in zip(opa, expected)) + abs(len(opa) - len(expected))
            row['opa_target_mismatches'] = sum(a['decision'] != t for a, t in zip(opa, targets))
            recovered = rego.roundtrip(conditions, wrapper, manifest)
            row['rego_roundtrip_mismatches'] = sum(decision(recovered, r) != decision(model, r) for r in requests)
            try:
                policy = folder / 'target.xml'
                attrs = xacml.export_cpm(model, policy)
                recovered = xacml.import_cpm_pair(policy)
                row['xacml_roundtrip_mismatches'] = sum(decision(recovered, r) != decision(model, r) for r in requests)
                lines = []
                for i, r in enumerate(requests):
                    req = folder / f'{i:03}.request.xml'
                    xacml.request_xml(r, attrs, req)
                    lines.append('\t'.join([str(i), str(policy), str(req), str(folder / f'{i:03}.response.xml')]))
                (folder / 'Balana_manifest.tsv').write_text('\n'.join(lines) + '\n')
                subprocess.run(['java', '-Xmx1024m', '-cp', CP, 'BalanaBatch', str(folder / 'Balana_manifest.tsv')],
                               capture_output=True, timeout=1200)
                bal = []
                for i in range(len(requests)):
                    labels = [(n.text or '').strip() for n in ET.parse(folder / f'{i:03}.response.xml').getroot().iter()
                              if xacml.local(n) == 'Decision']
                    bal.append(labels[0] if len(labels) == 1 else 'NO_SINGLE_DECISION')
                row['xacml_export'] = 'EXPORTED'
                row['balana_model_mismatches'] = sum(a != b for a, b in zip(bal, expected))
                row['balana_target_mismatches'] = sum(a != t for a, t in zip(bal, targets))
            except Exception as exc:
                row['xacml_export'] = 'REFUSED: ' + type(exc).__name__ + ': ' + str(exc)[:200]
            summary['rows'][f'{case}/{mode}'] = row
            print(case, mode, row, flush=True)
    save(OUT / 'summary.json', summary)


if __name__ == '__main__':
    run()
