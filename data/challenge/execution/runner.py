"""Execute an immutable finite challenge with four internal ablations.

No published competing method is reproduced. All writes remain in execution.
"""
from pathlib import Path
import argparse
import collections
import copy
import datetime
import hashlib
import json
import os
import subprocess
import sys
import time
import traceback
import xml.etree.ElementTree as ET

sys.dont_write_bytecode = True
E = Path(__file__).resolve().parent
D = E.parent/'design'
W = E.parents[2]
sys.path.insert(0, str(W/'src'))
from pcproof.model import normalize, decision, evaluate, fingerprint, conj, neg, transitive
from pcproof.verify import audit
from research import xacml, rego, workflow

METHODS = ('no_edit', 'configured_precedence', 'unchecked_subtraction', 'checked_refinement')
MAX_ITERATIONS = 100
TIMEOUT_MS = 10000


def utc(): return datetime.datetime.now(datetime.timezone.utc).isoformat()
def sha(p): return hashlib.sha256(Path(p).read_bytes()).hexdigest()
def read(p): return json.loads(Path(p).read_text(encoding='utf-8-sig'))
def save(p, value):
    p = Path(p)
    p.parent.mkdir(parents=True, exist_ok=True)
    p.write_text(json.dumps(value, indent=2), encoding='utf-8')


def design_unchanged():
    manifest = read(D/'manifest.json')
    return all(sha(D/relative) == digest for relative, digest in manifest['files'].items())


def current_source_hashes():
    return {str(p.relative_to(W)): sha(p) for folder in ('src/pcproof', 'src/research')
            for p in sorted((W/folder).glob('*.py'))}


def source_aliases(model, descriptors):
    mapping = {xacml.sid(d['Category'], d['AttributeId'], d['DataType'], d.get('Issuer', '')): name
               for name, d in descriptors.items()}
    actual = set(model['attributes'])
    if not actual <= set(mapping): raise ValueError('Unknown imported XACML attribute hashes')
    result = copy.deepcopy(model)
    result['rules'] = [{**r, 'condition': xacml.remap_expr(r['condition'], mapping)} for r in result['rules']]
    result['validity'] = xacml.remap_expr(result['validity'], mapping)
    return result, {key: mapping[key] for key in actual}


def imported_case(case):
    folder = E/'cases'/case['case_id']
    if case['input_path']:
        model = normalize(read(D/case['input_path']))
        # Per-source views use actual frozen CPM predicates, not oracle tables.
        for sid in model['sources']:
            source = copy.deepcopy(model)
            source['sources'] = {sid: source['sources'][sid]}
            source['rules'] = [r for r in source['rules'] if r['source'] == sid]
            source['precedence'] = []
            source['invariants'] = []
            save(folder/'source_imports'/f'{sid}.json', normalize(source))
        return model
    merged = {'schema_version': 'cpm-1', 'attributes': copy.deepcopy(case['attributes']),
              'sources': {}, 'rules': [], 'precedence': read(D/case['governance_path'])['precedence'],
              'invariants': read(D/case['requirements_path'])}
    for asset in case['source_assets']:
        path = D/asset['path']
        sid = asset['source_id']
        if asset['format'] == 'xacml':
            original = xacml.parse_file(path, sid)
            model, mapping = source_aliases(original['cpm'], asset['descriptors'])
            save(folder/'source_imports'/f'{sid}.raw_import.json', original)
            details = {'format': 'xacml', 'source_path': str(path), 'source_sha256': sha(path),
                       'hash_to_alias': mapping, 'raw_rules': original['raw_rule_count'],
                       'compiled_rules': len(model['rules'])}
        else:
            manifest = read(D/asset['manifest_path'])
            model = rego.import_rego(path.read_text(encoding='utf-8'), manifest)
            details = {'format': 'rego', 'source_path': str(path), 'source_sha256': sha(path),
                       'manifest_path': str(D/asset['manifest_path']), 'manifest_sha256': sha(D/asset['manifest_path']),
                       'compiled_rules': len(model['rules'])}
        if set(model['sources']) != {sid}: raise ValueError('Source identity changed during import')
        model['attributes'] = copy.deepcopy(case['attributes'])
        model = normalize(model)
        save(folder/'source_imports'/f'{sid}.json', model)
        save(folder/'source_imports'/f'{sid}.mapping.json', details)
        merged['sources'].update(model['sources'])
        merged['rules'].extend(model['rules'])
    model = normalize(merged)
    if len(model['rules']) != case['anticipated_compiled_rule_count']:
        raise ValueError('Unexpected compiled rule count')
    return model


def authorization(model, case_id):
    closure = transitive((edge['higher'], edge['lower']) for edge in model['precedence'])
    choices = []
    rules = model['rules']
    for i, left in enumerate(rules):
        for right in rules[i+1:]:
            if left['source'] == right['source'] or left['effect'] == right['effect']: continue
            if (left['source'], right['source']) in closure: winner, loser = left, right
            elif (right['source'], left['source']) in closure: winner, loser = right, left
            else: continue
            choices.append({'winner': winner['id'], 'loser': loser['id']})
    common = {'approval_id': 'FROZEN_SYNTHETIC_CHALLENGE_'+case_id, 'policy_sha256': fingerprint(model)}
    return {'precedence': {**common, 'operation': 'apply_precedence', 'edges': copy.deepcopy(model['precedence'])},
            'refinement': {**common, 'operation': 'bounded_refinement', 'choices': choices}}


def prepare():
    if (E/'protocol.json').exists(): raise RuntimeError('Preparation already exists')
    assert design_unchanged()
    protocol = {'prepared_utc': utc(), 'kind': 'Fresh frozen finite challenge, internal ablations only',
        'methods': list(METHODS), 'max_iterations': MAX_ITERATIONS, 'solver_timeout_ms_per_query': TIMEOUT_MS,
        'directions': 'All opposite-effect cross-source rule pairs whose source direction is in the transitive closure of frozen governance edges. No direction inferred from outcomes or expected labels. Incomparable and same-source pairs receive no direction.',
        'unchecked_sequence': 'At each step run the same fresh exhaustive cross-source scan, choose the first SAT pair authorized by the frozen choices, narrow loser by NOT(current winner), and continue. Omit loser nonempty, locality, invariant and final-contract safety guards. Stops are retained, not called successful repairs.',
        'no_edit': 'Retain original model; no accepted repair transaction claimed.',
        'precedence': 'Execute current workflow.apply_precedence with exact frozen edges and current model fingerprint. Its status is reported separately from externally evaluated specification satisfaction.',
        'checked': 'Execute current workflow.refine_bounded unchanged. Rejection returns original as committed output; tentative states are retained only within trace.',
        'outputs': 'All four resulting committed/retained models receive exhaustive finite comparison and Rego export/reimport/native replay. Every output attempts XACML export; possible Conflict receives explicit unsupported outcome. Native outputs compare both with the actual model and frozen target, so rejected retention is never counted as target success.',
        'native_source': 'For four mixed cases, evaluate every actual XACML source in Balana and every actual source Rego definition in OPA on all64 complete case requests. Rego decision wrapper observes frozen entry endpoints; it does not substitute imported CPM predicates.',
        'classification': 'Commit with zero target mismatch/requirements violation/conflict/pure-change=correct acceptance. Commit with any endpoint failure=wrong acceptance. Rejection on C06/C07/C08/C09/C12=justified refusal under frozen requirements/direction restrictions; other refusal=conservative rejection. Baseline output statuses separate. Native import/export correctness separately recorded.',
        'limits': 'Synthetic retrospectively designed challenge; no published-method replication, novelty proof, performance/scalability claim or independent population accuracy.',
        'runner_sha256': sha(__file__), 'current_source_hashes': current_source_hashes(),
        'design_manifest_sha256': sha(D/'manifest.json'), 'design_FREEZE_sha256': sha(D/'FREEZE.json')}
    save(E/'protocol.json', protocol)
    imports = []
    auth = {}
    for case in read(D/'cases.json'):
        folder = E/'cases'/case['case_id']
        start = time.perf_counter()
        try:
            model = imported_case(case)
            save(folder/'imported_model.json', model)
            truth = read(D/case['truth_table_path'])
            source_rows = []
            for index, expected in enumerate(truth):
                observed = {}
                for sid in model['sources']:
                    source = read(folder/'source_imports'/f'{sid}.json')
                    observed[sid] = decision(source, expected['request'])['decision']
                source_rows.append({'request_index': index, 'request': expected['request'],
                    'source_expected': expected['source_decisions'], 'source_actual': observed,
                    'source_matches': observed == expected['source_decisions'],
                    'union_expected': expected['original_union_decision'],
                    'union_actual': decision(model, expected['request'])['decision']})
            save(folder/'import_finite_rows.json', source_rows)
            auth[case['case_id']] = authorization(model, case['case_id'])
            imports.append({'case_id': case['case_id'], 'status': 'IMPORTED',
                'model_sha256': fingerprint(model), 'model_file_sha256': sha(folder/'imported_model.json'),
                'compiled_rules': len(model['rules']), 'sources': len(model['sources']), 'requests': len(truth),
                'source_decision_mismatches': sum(not row['source_matches'] for row in source_rows),
                'union_decision_mismatches': sum(row['union_actual'] != row['union_expected'] for row in source_rows),
                'elapsed_seconds': time.perf_counter()-start})
        except Exception as exc:
            save(folder/'import_error.json', {'exception': type(exc).__name__, 'message': str(exc), 'traceback': traceback.format_exc()})
            imports.append({'case_id': case['case_id'], 'status': 'IMPORT_ERROR', 'error': str(exc)})
    save(E/'input_manifest.json', {'prepared_utc': utc(), 'design_files': read(D/'manifest.json')['files'],
        'imports': imports, 'all_design_files_unchanged': design_unchanged()})
    save(E/'frozen_authorizations.json', auth)
    freeze = {str(path.relative_to(E)): sha(path) for path in sorted(E.rglob('*')) if path.is_file()}
    save(E/'PRE_EXECUTION_FREEZE.json', {'frozen_utc': utc(), 'files': freeze})
    print(json.dumps({'phase': 'prepared', 'imports': imports}, indent=2), flush=True)


def unchecked(model, approval):
    current = copy.deepcopy(model)
    choices = {frozenset(choice.values()): choice for choice in approval['choices']}
    result = {'status': 'UNFINISHED', 'committed': False, 'operation': 'unchecked_subtraction',
              'before_sha256': fingerprint(model), 'iterations': []}
    for step in range(MAX_ITERATIONS+1):
        scan = audit(current, 'exhaustive', TIMEOUT_MS)
        if scan['label'] in ('INVALID_OR_UNRESOLVED_REQUEST_SPACE', 'UNRESOLVED'):
            result.update(reason='UNRESOLVED_SCAN', final_scan=scan); break
        positive = [row for row in scan['results'] if row['status'] == 'SAT']
        if not positive:
            result.update(status='OUTPUT', committed=True, reason='NO_CROSS_SOURCE_OVERLAPS_LEFT', final_scan=scan); break
        if step == MAX_ITERATIONS:
            result.update(reason='ITERATION_LIMIT_REACHED', final_scan=scan); break
        found = next((row for row in positive if frozenset(row['pair']) in choices), None)
        if found is None:
            result.update(reason='NO_AUTHORIZED_DIRECTION_FOR_REMAINING_CONFLICTS', final_scan=scan); break
        choice = choices[frozenset(found['pair'])]
        ids = {rule['id']: rule for rule in current['rules']}
        candidate = copy.deepcopy(current)
        loser = next(rule for rule in candidate['rules'] if rule['id'] == choice['loser'])
        loser['condition'] = conj(ids[choice['loser']]['condition'], neg(ids[choice['winner']]['condition']))
        candidate = normalize(candidate)
        result['iterations'].append({'iteration': step+1, 'choice': choice, 'before_sha256': fingerprint(current),
                                     'after_sha256': fingerprint(candidate), 'overlap_before': found})
        current = candidate
    result['tentative_steps'] = len(result['iterations'])
    # Unchecked ablation emits its candidate even if its loop is unfinished.
    result['emitted_candidate'] = current
    if result['committed']:
        result['policy'] = current
        result['after_sha256'] = fingerprint(current)
    return result


def finite_result(case, model, output):
    truth = read(D/case['truth_table_path'])
    rows = []
    for index, expected in enumerate(truth):
        request = expected['request']
        label = decision(output, request)['decision']
        violations = [inv['id'] for inv in output['invariants']
                      if evaluate(inv['when'], request) and label != inv['required']]
        pure = expected['original_union_decision'] in ('Permit', 'Deny')
        rows.append({'request_index': index, 'request': request, 'original_expected': expected['original_union_decision'],
            'target_expected': expected['expected_final_decision'], 'required': expected['required'],
            'actual_decision': label, 'contract_violations': violations,
            'target_matches': label == expected['expected_final_decision'],
            'pure_original_preserved': not pure or label == expected['original_union_decision'], 'original_was_pure': pure})
    return rows


def run_methods():
    frozen = read(E/'PRE_EXECUTION_FREEZE.json')
    assert all(sha(E/path) == digest for path, digest in frozen['files'].items())
    assert current_source_hashes() == read(E/'protocol.json')['current_source_hashes']
    assert design_unchanged()
    auths = read(E/'frozen_authorizations.json')
    for case in read(D/'cases.json'):
        folder = E/'cases'/case['case_id']
        if not (folder/'imported_model.json').exists(): continue
        model = read(folder/'imported_model.json')
        auth = auths[case['case_id']]
        for method in METHODS:
            target = folder/'methods'/method
            if (target/'result.json').exists(): raise RuntimeError('Method output already exists')
            start = time.perf_counter()
            supplied = copy.deepcopy(model)
            try:
                if method == 'no_edit': result = {'status': 'BASELINE_UNCHANGED', 'committed': False, 'reason': 'NO_REPAIR_ATTEMPT', 'before_sha256': fingerprint(supplied)}
                elif method == 'configured_precedence': result = workflow.apply_precedence(supplied, auth['precedence'], TIMEOUT_MS)
                elif method == 'unchecked_subtraction': result = unchecked(supplied, auth['refinement'])
                else: result = workflow.refine_bounded(supplied, auth['refinement'], MAX_ITERATIONS, TIMEOUT_MS)
            except Exception as exc:
                result = {'status': 'ERROR', 'committed': False, 'reason': 'EXECUTION_EXCEPTION',
                          'exception': type(exc).__name__, 'message': str(exc), 'traceback': traceback.format_exc()}
            elapsed = time.perf_counter()-start
            output = result['policy'] if result.get('committed') else model
            # Preserve unchecked emitted candidates separately even if unfinished;
            # the primary retained output follows the same atomic-output convention.
            if method == 'unchecked_subtraction' and 'emitted_candidate' in result:
                save(target/'unchecked_emitted_candidate.json', result['emitted_candidate'])
            rows = finite_result(case, model, output)
            committed = bool(result.get('committed'))
            mismatch = sum(not row['target_matches'] for row in rows)
            violations = sum(len(row['contract_violations']) for row in rows)
            conflicts = sum(row['actual_decision'] == 'Conflict' for row in rows)
            pure_changes = sum(not row['pure_original_preserved'] for row in rows)
            if method == 'no_edit': classification = 'BASELINE_UNCHANGED'
            elif committed: classification = 'CORRECT_ACCEPTANCE' if not (mismatch or violations or conflicts or pure_changes) else 'WRONG_ACCEPTANCE'
            elif result['status'] == 'ERROR': classification = 'ERROR'
            elif case['case_id'] in ('C06', 'C07', 'C08', 'C09', 'C12'): classification = 'JUSTIFIED_REFUSAL_UNDER_FROZEN_DIRECTIONS_OR_REQUIREMENTS'
            else: classification = 'CONSERVATIVE_REJECTION'
            metrics = {'case_id': case['case_id'], 'method': method, 'classification': classification,
                'status': result['status'], 'committed': committed, 'reason': result.get('reason'),
                'compiled_rules': len(model['rules']), 'requests': len(rows), 'target_mismatches': mismatch,
                'contract_violation_occurrences': violations, 'conflict_requests': conflicts,
                'pure_original_decision_changes': pure_changes, 'input_model_unchanged': supplied == model,
                'input_hash_before': fingerprint(model), 'input_hash_after': fingerprint(supplied),
                'output_hash': fingerprint(output), 'rejected_output_is_original': committed or output == model,
                'tentative_steps': len(result.get('iterations', [])), 'elapsed_seconds_diagnostic': elapsed}
            save(target/'result.json', result)
            save(target/'output_model.json', output)
            save(target/'finite_rows.json', rows)
            save(target/'metrics.json', metrics)
            print(json.dumps(metrics), flush=True)
    run_controls(auths)


def run_controls(auths):
    folder = E/'controls'
    results = []
    for control in read(D/'controls/controls.json'):
        code = control['control_id']
        detail = {'control': control, 'started_utc': utc()}
        try:
            if code == 'U01':
                rego.import_rego((D/control['input']).read_text(encoding='utf-8'), read(D/control['manifest']))
                detail.update(status='UNEXPECTED_ACCEPT', passed=False)
            elif code == 'G01':
                normalize(read(D/control['input']))
                detail.update(status='UNEXPECTED_ACCEPT', passed=False)
            elif code == 'S01':
                original = read(E/'cases/C05/imported_model.json')
                changed = copy.deepcopy(original)
                next(rule for rule in changed['rules'] if rule['id'] == 'A_r1')['effect'] = 'Deny'
                changed = normalize(changed)
                save(folder/'S01_changed_input.json', changed)
                before = fingerprint(changed)
                result = workflow.refine_bounded(changed, auths['C05']['refinement'], MAX_ITERATIONS, TIMEOUT_MS)
                detail.update(status=result['status'], result=result, original_canonical_hash=fingerprint(original),
                    frozen_file_sha256=sha(D/'cases/C05/input.json'), changed_canonical_hash=before,
                    input_unchanged=fingerprint(changed) == before,
                    passed=not result.get('committed') and result.get('reason') == 'STALE_OR_WRONG_POLICY_HASH')
            else:
                original = read(E/'cases/C01/imported_model.json')
                result = workflow.refine_bounded(original, auths['C01']['refinement'], 0, TIMEOUT_MS)
                detail.update(status=result['status'], result=result, passed=not result.get('committed'))
        except Exception as exc:
            detail.update(status='EXPLICIT_REJECTION', exception=type(exc).__name__, reason=str(exc),
                          traceback=traceback.format_exc(), passed=code in ('U01', 'G01'))
        save(folder/(code+'.json'), detail)
        results.append(detail)
    save(folder/'summary.json', {'control_count': len(results), 'passed': sum(row['passed'] for row in results), 'rows': results})


def source_wrapper(manifest):
    lines = ['package '+manifest['package'], 'import rego.v1', 'default source_permit := false', 'default source_deny := false']
    for rule in manifest['rules']:
        lines.append('source_'+rule['effect'].lower()+' if { '+rule['entry']+' }')
    lines += ['source_decision := "Conflict" if { source_permit; source_deny }',
              'source_decision := "Permit" if { source_permit; not source_deny }',
              'source_decision := "Deny" if { source_deny; not source_permit }',
              'source_decision := "NotApplicable" if { not source_permit; not source_deny }']
    return '\n'.join(lines)+'\n'


def run_opa(folder, modules, query):
    command = [str(W/'tools/opa/opa_windows_amd64.exe'), 'eval', '--format=json', '--strict-builtin-errors']
    for path in modules: command += ['-d', str(path)]
    command += ['-d', str(folder/'OPA_inputs.json'), query]
    try:
        run = subprocess.run(command, capture_output=True, timeout=300)
        (folder/'OPA.stdout.json').write_bytes(run.stdout)
        (folder/'OPA.stderr.txt').write_bytes(run.stderr)
        actual = json.loads(run.stdout)['result'][0]['expressions'][0]['value'] if run.returncode == 0 else []
        return {'returncode': run.returncode, 'command': command, 'actual': actual, 'error': None if run.returncode == 0 else 'NONZERO_EXIT'}
    except Exception as exc:
        return {'returncode': None, 'command': command, 'actual': [], 'error': type(exc).__name__+': '+str(exc)}


def native():
    if (E/'native_jobs_before_Balana.json').exists(): raise RuntimeError('Native execution already prepared')
    assert design_unchanged()
    assert current_source_hashes() == read(E/'protocol.json')['current_source_hashes']
    balana_jobs = []
    native_summaries = []
    for case in read(D/'cases.json'):
        case_id = case['case_id']
        truth = read(D/case['truth_table_path'])
        requests = [row['request'] for row in truth]
        if not case['input_path']:
            for asset in case['source_assets']:
                sid = asset['source_id']
                folder = E/'source_native'/case_id/sid
                folder.mkdir(parents=True, exist_ok=False)
                expected = [row['source_decisions'][sid] for row in truth]
                summary = {'endpoint': 'source', 'case_id': case_id, 'source_id': sid, 'format': asset['format'],
                           'requests': len(requests), 'expected': expected}
                if asset['format'] == 'xacml':
                    for index, request in enumerate(requests):
                        req = folder/f'{index:03}.request.xml'
                        xacml.request_xml(request, asset['descriptors'], req)
                        balana_jobs.append({'id': f'source_{case_id}_{sid}_{index}', 'endpoint': 'source',
                            'case_id': case_id, 'source_id': sid, 'index': index, 'policy': str(D/asset['path']),
                            'request': str(req), 'response': str(folder/f'{index:03}.response.xml'),
                            'expected_model': expected[index], 'expected_target': expected[index], 'summary_folder': str(folder)})
                    summary['Balana_status'] = 'PENDING'
                else:
                    manifest = read(D/asset['manifest_path'])
                    (folder/'source_wrapper.rego').write_text(source_wrapper(manifest), encoding='utf-8')
                    save(folder/'OPA_inputs.json', {'cases': requests})
                    result = run_opa(folder, [D/asset['path'], folder/'source_wrapper.rego'],
                        '[r | x := data.cases[_]; r := data.'+manifest['package']+'.source_decision with input as x]')
                    actual = result.pop('actual')
                    summary.update(OPA=result, OPA_actual=actual,
                        OPA_mismatches=sum(a != b for a, b in zip(actual, expected))+abs(len(actual)-len(expected)))
                save(folder/'summary.json', summary)
                native_summaries.append(str(folder/'summary.json'))
        for method in METHODS:
            parent = E/'cases'/case_id/'methods'/method
            if not (parent/'output_model.json').exists(): continue
            model = read(parent/'output_model.json')
            folder = parent/'native'
            folder.mkdir(exist_ok=False)
            expected_model = [decision(model, request) for request in requests]
            expected_target = [row['expected_final_decision'] for row in truth]
            save(folder/'OPA_inputs.json', {'cases': requests})
            conditions, wrapper, manifest = rego.generate(model)
            (folder/'conditions.rego').write_text(conditions, encoding='utf-8')
            (folder/'decision.rego').write_text(wrapper, encoding='utf-8')
            save(folder/'manifest.json', manifest)
            summary = {'endpoint': 'target', 'case_id': case_id, 'method': method, 'requests': len(requests),
                       'expected_model': expected_model, 'expected_target': expected_target}
            try:
                recovered = rego.roundtrip(conditions, wrapper, manifest)
                save(folder/'rego_reimported_model.json', recovered)
                summary['Rego_roundtrip_full_record_mismatches'] = sum(decision(recovered, request) != row for request, row in zip(requests, expected_model))
            except Exception as exc:
                summary['Rego_roundtrip_error'] = type(exc).__name__+': '+str(exc)
            result = run_opa(folder, [folder/'conditions.rego', folder/'decision.rego'], '[r | x := data.cases[_]; r := data.thesis.result with input as x]')
            actual = result.pop('actual')
            summary.update(OPA=result, OPA_actual=actual,
                OPA_model_mismatches=sum(a != b for a, b in zip(actual, expected_model))+abs(len(actual)-len(expected_model)),
                OPA_target_mismatches=sum(a['decision'] != b for a, b in zip(actual, expected_target))+abs(len(actual)-len(expected_target)))
            try:
                policy = folder/'target.xml'
                attrs = xacml.export_cpm(model, policy)
                recovered = xacml.import_cpm_pair(policy)
                save(folder/'xacml_reimported_model.json', recovered)
                summary['XACML_export_status'] = 'EXPORTED'
                summary['XACML_roundtrip_full_record_mismatches'] = sum(decision(recovered, request) != row for request, row in zip(requests, expected_model))
                for index, request in enumerate(requests):
                    req = folder/f'{index:03}.request.xml'
                    xacml.request_xml(request, attrs, req)
                    balana_jobs.append({'id': f'target_{case_id}_{method}_{index}', 'endpoint': 'target',
                        'case_id': case_id, 'method': method, 'index': index, 'policy': str(policy),
                        'request': str(req), 'response': str(folder/f'{index:03}.response.xml'),
                        'expected_model': expected_model[index]['decision'], 'expected_target': expected_target[index], 'summary_folder': str(folder)})
                summary['Balana_status'] = 'PENDING'
            except Exception as exc:
                summary['XACML_export_status'] = 'EXPLICIT_UNSUPPORTED_OR_ERROR'
                summary['XACML_export_exception'] = type(exc).__name__
                summary['XACML_export_reason'] = str(exc)
                summary['Balana_status'] = 'NOT_RUN_INTERFACE_REJECTED'
            save(folder/'summary.json', summary)
            native_summaries.append(str(folder/'summary.json'))
    save(E/'native_jobs_before_Balana.json', balana_jobs)
    save(E/'native_summaries.json', native_summaries)
    manifest = E/'Balana_manifest.tsv'
    manifest.write_text('\n'.join('\t'.join([job['id'], job['policy'], job['request'], job['response']]) for job in balana_jobs)+'\n', encoding='utf-8')
    command = [str(W/'tools/xacml/azul_jdk/zulu21.52.203-ca-jdk21.0.12.1-win_x64/bin/java.exe'), '-Xmx1024m',
        '-cp', os.pathsep.join([str(W/'tools/xacml/classes'), str(W/'tools/xacml/lib/*')]), 'BalanaBatch', str(manifest)]
    started = time.perf_counter()
    try:
        run = subprocess.run(command, capture_output=True, timeout=600)
        (E/'Balana.stdout.tsv').write_bytes(run.stdout)
        (E/'Balana.stderr.txt').write_bytes(run.stderr)
        process = {'returncode': run.returncode, 'command': command, 'error': None, 'elapsed_seconds_diagnostic': time.perf_counter()-started}
    except Exception as exc:
        process = {'returncode': None, 'command': command, 'error': type(exc).__name__+': '+str(exc), 'elapsed_seconds_diagnostic': time.perf_counter()-started}
    save(E/'Balana_process.json', process)
    rows = []
    for job in balana_jobs:
        try:
            labels = [(node.text or '').strip() for node in ET.parse(job['response']).getroot().iter() if xacml.local(node) == 'Decision']
            actual = labels[0] if len(labels) == 1 else 'NO_SINGLE_DECISION'
            error = None
        except Exception as exc:
            actual = 'NO_NATIVE_RESPONSE'; error = type(exc).__name__+': '+str(exc)
        rows.append({**job, 'actual': actual, 'matches_model': actual == job['expected_model'],
                     'matches_target': actual == job['expected_target'], 'response_sha256': sha(job['response']) if Path(job['response']).exists() else None, 'error': error})
    save(E/'Balana_rows.json', rows)
    for path in native_summaries:
        summary = read(path)
        selected = [row for row in rows if row['summary_folder'] == str(Path(path).parent)]
        if selected:
            summary.update(Balana_status='EXECUTED', Balana_evaluations=len(selected),
                Balana_model_mismatches=sum(not row['matches_model'] for row in selected),
                Balana_target_mismatches=sum(not row['matches_target'] for row in selected),
                Balana_actual_counts=dict(collections.Counter(row['actual'] for row in selected)))
            save(Path(path).parent/'rows.json', selected)
        save(path, summary)
    print(json.dumps({'phase': 'native', 'Balana_requests': len(rows), 'model_mismatches': sum(not row['matches_model'] for row in rows), 'process': process}, indent=2), flush=True)


def summarize():
    methods = [read(path) for path in sorted((E/'cases').glob('*/methods/*/metrics.json'))]
    native_rows = [read(path) for path in read(E/'native_summaries.json')]
    source_native = [row for row in native_rows if row['endpoint'] == 'source']
    target_native = [row for row in native_rows if row['endpoint'] == 'target']
    summary = {'completed_utc': utc(), 'substantive_cases': 12, 'finite_requests_per_method': sum(case['request_count'] for case in read(D/'cases.json')),
        'methods': {method: {'runs': sum(row['method'] == method for row in methods),
            'classification_counts': dict(collections.Counter(row['classification'] for row in methods if row['method'] == method)),
            'target_mismatch_occurrences': sum(row['target_mismatches'] for row in methods if row['method'] == method),
            'contract_violation_occurrences': sum(row['contract_violation_occurrences'] for row in methods if row['method'] == method),
            'pure_original_decision_changes': sum(row['pure_original_decision_changes'] for row in methods if row['method'] == method),
            'committed_cases': [row['case_id'] for row in methods if row['method'] == method and row['committed']]}
            for method in METHODS}, 'case_method_rows': methods,
        'controls': read(E/'controls/summary.json'),
        'source_native': {'OPA_evaluations': sum(len(row.get('OPA_actual', [])) for row in source_native),
            'OPA_mismatches': sum(row.get('OPA_mismatches', 0) for row in source_native),
            'Balana_evaluations': sum(row.get('Balana_evaluations', 0) for row in source_native),
            'Balana_mismatches': sum(row.get('Balana_model_mismatches', 0) for row in source_native)},
        'target_native': {'OPA_evaluations': sum(len(row.get('OPA_actual', [])) for row in target_native),
            'OPA_model_mismatches': sum(row.get('OPA_model_mismatches', 0) for row in target_native),
            'OPA_target_mismatches': sum(row.get('OPA_target_mismatches', 0) for row in target_native),
            'Balana_evaluations': sum(row.get('Balana_evaluations', 0) for row in target_native),
            'Balana_model_mismatches': sum(row.get('Balana_model_mismatches', 0) for row in target_native),
            'Balana_target_mismatches': sum(row.get('Balana_target_mismatches', 0) for row in target_native),
            'XACML_explicit_rejections': sum(row.get('XACML_export_status') == 'EXPLICIT_UNSUPPORTED_OR_ERROR' for row in target_native),
            'Rego_roundtrip_mismatches': sum(row.get('Rego_roundtrip_full_record_mismatches', 0) for row in target_native),
            'XACML_roundtrip_mismatches': sum(row.get('XACML_roundtrip_full_record_mismatches', 0) for row in target_native)},
        'all_inputs_unchanged': all(row['input_model_unchanged'] for row in methods),
        'all_rejected_outputs_original': all(row['rejected_output_is_original'] for row in methods),
        'all_design_files_unchanged': design_unchanged(),
        'all_source_files_unchanged': current_source_hashes() == read(E/'protocol.json')['current_source_hashes'],
        'interpretation': 'Native model agreement is an interface endpoint; it does not turn a wrong target or original retained after rejection into successful repair. Repetitions, requests and languages are dependent.'}
    save(E/'summary.json', summary)
    save(E/'execution_manifest.json', {'sealed_utc': utc(), 'files': {str(path.relative_to(E)): sha(path) for path in sorted(E.rglob('*')) if path.is_file() and path.name != 'execution_manifest.json'}})
    print(json.dumps({key: value for key, value in summary.items() if key not in ('case_method_rows', 'controls')}, indent=2), flush=True)


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('phase', choices=('prepare', 'methods', 'native', 'summarize'))
    args = parser.parse_args()
    {'prepare': prepare, 'methods': run_methods, 'native': native, 'summarize': summarize}[args.phase]()
