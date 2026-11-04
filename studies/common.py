"""Shared paths and an independent decision evaluator for the final-revision studies.

The evaluator below is written separately from pcproof.model.decision and is
used for scoring, so scoring does not rely on the code under test.
Run every study from the package root:  python studies/<name>.py
Environment: Z3_LIBRARY (path to libz3), OPA (path to the opa binary),
BALANA_CP (classpath for tools/xacml/classes and tools/xacml/lib/*).
"""
import hashlib
import json
import os
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SRC = ROOT / 'src'
DATA = ROOT / 'data'
RESULTS = ROOT / 'results'
CHALLENGE = DATA / 'challenge'
sys.path.insert(0, str(SRC))

MAX_ITERATIONS = 100   # as in the frozen challenge protocol
TIMEOUT_MS = 10000     # as in the frozen challenge protocol
CASES = [f'C{i:02}' for i in range(1, 13)]


def read(path):
    return json.loads(Path(path).read_text(encoding='utf-8-sig'))


def save(path, value):
    path = Path(path)
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(value, indent=2), encoding='utf-8')


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def source_hashes():
    return {str(p.relative_to(ROOT)).replace('\\', '/'): sha(p)
            for folder in ('src/pcproof', 'src/research', 'src/extensions') for p in sorted((ROOT / folder).glob('*.py'))}


def tool_paths():
    return {'Z3_LIBRARY': os.environ.get('Z3_LIBRARY'), 'OPA': os.environ.get('OPA'), 'BALANA_CP': os.environ.get('BALANA_CP')}


def ev(e, r):
    if e is True or e is False:
        return e
    op = e['op']
    if op == 'and':
        return all(ev(x, r) for x in e['args'])
    if op == 'or':
        return any(ev(x, r) for x in e['args'])
    if op == 'not':
        return not ev(e['arg'], r)
    a, b = r[e['attr']], e['value']
    return {'eq': a == b, 'ne': a != b, 'lt': a < b, 'le': a <= b, 'gt': a > b, 'ge': a >= b}[op]


def decide(p, r):
    effects = {x['effect'] for x in p['rules'] if ev(x['condition'], r)}
    if len(effects) == 2:
        return 'Conflict'
    return effects.pop() if effects else 'NotApplicable'


def load_case(case_id):
    from pcproof.model import normalize
    imported = CHALLENGE / 'execution/cases' / case_id / 'imported_model.json'
    source = imported if imported.exists() else CHALLENGE / 'design/cases' / case_id / 'input.json'
    model = normalize(read(source))
    truth = read(CHALLENGE / 'design/cases' / case_id / 'expected_truth_table.json')
    return model, truth


def frozen_choices(case_id):
    return read(CHALLENGE / 'execution/frozen_authorizations.json')[case_id]


def score(output, truth):
    """Endpoints of the frozen challenge, computed with the independent evaluator."""
    decisions = [decide(output, row['request']) for row in truth]
    mismatches = sum(d != row['expected_final_decision'] for d, row in zip(decisions, truth))
    ordinary = sum(d != row['expected_final_decision'] for d, row in zip(decisions, truth)
                   if row['expected_final_decision'] is not None)
    violations = 0
    for inv in output['invariants']:
        for d, row in zip(decisions, truth):
            if ev(inv['when'], row['request']) and d != inv['required']:
                violations += 1
    pure = sum(row['original_union_decision'] in ('Permit', 'Deny') and d != row['original_union_decision']
               for d, row in zip(decisions, truth))
    retired = sorted(r['id'] for r in output['rules'] if not any(ev(r['condition'], row['request']) for row in truth))
    return {'target_mismatches': mismatches, 'ordinary_label_differences': ordinary, 'contract_violations': violations,
            'conflict_requests': decisions.count('Conflict'), 'pure_decision_changes': pure,
            'retired_rules': retired,
            'decision_signature': hashlib.sha256(json.dumps(decisions).encode()).hexdigest()}


def canonical_hash(policy):
    """Hash of the rule set ignoring list order (rules sorted by identifier)."""
    rules = sorted(policy['rules'], key=lambda r: r['id'])
    return hashlib.sha256(json.dumps(rules, sort_keys=True).encode()).hexdigest()
