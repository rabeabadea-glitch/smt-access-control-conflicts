"""Rule-order robustness of checked refinement on the 12 frozen challenge cases.

Two pair-selection rules are compared on identical inputs:
  listed  - research.workflow.refine_bounded, the frozen thesis code (first
            conflicting authorized pair in rule-list order);
  settled - extensions.settled_refinement.refine_settled (winner must be
            settled; ties broken by rule identifiers).
Each case is run in its frozen rule order and in N seeded permutations of the
rule list. Only the list order changes: rules, authorized directions, contracts,
iteration limit and solver timeout are those of the frozen protocol.
Scoring uses the independent evaluator in common.py over the frozen truth
tables, which enumerate the complete finite request space of every case.

Usage (from the package root):
  python studies/order_study.py prepare <permutations>
  python studies/order_study.py run [workers]
  python studies/order_study.py summarize
"""
import copy
import json
import multiprocessing as mp
import random
import sys
import time
import collections

from common import (RESULTS, CASES, MAX_ITERATIONS, TIMEOUT_MS, read, save, sha, source_hashes,
                    load_case, frozen_choices, score, canonical_hash, CHALLENGE)

OUT = RESULTS / 'order_study'
SEED = 20261027   # fixed before the run; differs from the examiner probe seed 20261026
MODES = ('listed', 'settled')


def prepare(n):
    if (OUT / 'protocol.json').exists():
        raise SystemExit('Protocol already written; delete results/order_study to start again.')
    design = read(CHALLENGE / 'design/manifest.json')['files']
    assert all(sha(CHALLENGE / 'design' / f) == h for f, h in design.items()), 'frozen design changed'
    save(OUT / 'protocol.json', {
        'purpose': 'Does acceptance of checked refinement depend on the order in which rules are listed?',
        'cases': CASES, 'permutations_per_case': n, 'seed': SEED,
        'permutation_rule': "random.Random(f'{seed}:{case}:{k}').shuffle(rules), k = 0..N-1; order 'frozen' = imported order",
        'modes': {'listed': 'research.workflow.refine_bounded (frozen thesis code)',
                  'settled': 'extensions.settled_refinement.refine_settled (final revision)'},
        'max_iterations': MAX_ITERATIONS, 'timeout_ms': TIMEOUT_MS,
        'inputs': 'frozen imported models (C01-C04) or frozen design inputs (C05-C12); frozen authorized directions',
        'endpoints': 'status, reason, steps, target mismatches, contract violations, Conflict requests, '
                     'pure-decision changes, retired rules, decision signature, canonical output hash',
        'scoring': 'independent evaluator (studies/common.py) over the complete frozen truth tables',
        'source_hashes': source_hashes(),
        'design_manifest_sha256': sha(CHALLENGE / 'design/manifest.json'),
        'authorizations_sha256': sha(CHALLENGE / 'execution/frozen_authorizations.json'),
        'note': 'The settled rule was designed after the examiner probe exposed the order effect on C04. '
                'The 12 cases are therefore not a blind test of it; see also the regression and case-study runs.'})


def job(args):
    case_id, k, mode = args
    from pcproof.model import normalize, fingerprint
    from research import workflow
    from extensions.settled_refinement import refine_settled
    model, truth = load_case(case_id)
    rules = copy.deepcopy(model['rules'])
    if k >= 0:
        random.Random(f'{SEED}:{case_id}:{k}').shuffle(rules)
    q = normalize({**copy.deepcopy(model), 'rules': rules})
    approval = {'approval_id': 'ORDER_STUDY_' + case_id, 'policy_sha256': fingerprint(q),
                'operation': 'bounded_refinement', 'choices': frozen_choices(case_id)['refinement']['choices']}
    run = workflow.refine_bounded if mode == 'listed' else refine_settled
    started = time.perf_counter()
    result = run(q, approval, MAX_ITERATIONS, TIMEOUT_MS)
    elapsed = time.perf_counter() - started
    committed = bool(result.get('committed'))
    output = result['policy'] if committed else q
    row = {'case_id': case_id, 'order': 'frozen' if k < 0 else k, 'mode': mode,
           'rule_order': [r['id'] for r in q['rules']], 'status': result['status'], 'reason': result.get('reason'),
           'committed': committed, 'steps': len(result.get('iterations', [])),
           'output_canonical_sha256': canonical_hash(output) if committed else None,
           'elapsed_seconds_diagnostic': round(elapsed, 2)}
    row.update(score(output, truth))
    if k < 0:
        row['output_model'] = output
        row['trace'] = [{'iteration': i['iteration'], 'choice': i['choice']} for i in result.get('iterations', [])]
    return row


def run(workers):
    protocol = read(OUT / 'protocol.json')
    assert protocol['source_hashes'] == source_hashes(), 'source changed after the protocol was written'
    n = protocol['permutations_per_case']
    jobs = [(c, k, m) for c in CASES for k in range(-1, n) for m in MODES]
    rows_path = OUT / 'rows.jsonl'
    done = set()
    if rows_path.exists():
        for line in rows_path.read_text().splitlines():
            r = json.loads(line)
            done.add((r['case_id'], -1 if r['order'] == 'frozen' else r['order'], r['mode']))
    jobs = [j for j in jobs if j not in done]
    heavy = {'C04': 0, 'C03': 1, 'C01': 2, 'C02': 3}
    jobs.sort(key=lambda j: heavy.get(j[0], 9))
    with mp.Pool(workers) as pool, rows_path.open('a') as handle:
        for row in pool.imap_unordered(job, jobs):
            model = row.pop('output_model', None)
            trace = row.pop('trace', None)
            if model is not None:
                save(OUT / 'frozen_order_outputs' / f"{row['case_id']}_{row['mode']}.json", model)
                save(OUT / 'frozen_order_traces' / f"{row['case_id']}_{row['mode']}.json", trace)
            handle.write(json.dumps(row) + '\n')
            handle.flush()
            print(row['case_id'], row['order'], row['mode'], row['status'], row['reason'], row['steps'],
                  row['target_mismatches'], len(row['retired_rules']), row['elapsed_seconds_diagnostic'], flush=True)


def summarize():
    rows = [json.loads(line) for line in (OUT / 'rows.jsonl').read_text().splitlines()]
    n = read(OUT / 'protocol.json')['permutations_per_case']
    table = {}
    for case in CASES:
        table[case] = {}
        for mode in MODES:
            sel = [r for r in rows if r['case_id'] == case and r['mode'] == mode]
            frozen = next(r for r in sel if r['order'] == 'frozen')
            perms = [r for r in sel if r['order'] != 'frozen']
            assert len(perms) == n, (case, mode, len(perms))
            accepted = [r for r in sel if r['committed']]
            table[case][mode] = {
                'frozen_order': {k: frozen[k] for k in ('status', 'reason', 'steps', 'target_mismatches',
                                                        'contract_violations', 'conflict_requests',
                                                        'pure_decision_changes', 'retired_rules')},
                'runs': len(sel), 'accepted_runs': len(accepted),
                'outcomes': dict(collections.Counter(f"{r['status']}/{r['reason']}" for r in sel)),
                'accepted_with_any_endpoint_failure': sum(1 for r in accepted if r['target_mismatches'] or r['contract_violations']
                                                          or r['conflict_requests'] or r['pure_decision_changes']),
                'distinct_accepted_outputs': len({r['output_canonical_sha256'] for r in accepted}),
                'distinct_decision_signatures': len({r['decision_signature'] for r in sel}),
                'step_range': [min(r['steps'] for r in sel), max(r['steps'] for r in sel)],
                'retired_rules_max': max(len(r['retired_rules']) for r in sel)}
    save(OUT / 'summary.json', {'permutations_per_case': n, 'runs_per_case_and_mode': n + 1, 'cases': table})
    for case in CASES:
        print(case, {m: (table[case][m]['accepted_runs'], table[case][m]['runs'], table[case][m]['distinct_accepted_outputs'],
                         table[case][m]['accepted_with_any_endpoint_failure']) for m in MODES})


if __name__ == '__main__':
    action = sys.argv[1]
    if action == 'prepare':
        prepare(int(sys.argv[2]))
    elif action == 'run':
        run(int(sys.argv[2]) if len(sys.argv) > 2 else 2)
    else:
        summarize()
