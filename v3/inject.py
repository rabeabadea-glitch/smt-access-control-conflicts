"""Injected rule pairs whose label is known by construction, not from the solver.

Three kinds of rule are planted into a copy of a policy file (seeded, repeatable):

  twin      copies the scope of an existing rule R and flips the effect, so
            (R, twin) fires on every request of R: a conflict;
  pinned    fires on exactly one request q on which R fires (every attribute is
            pinned to its value in q), with the opposite effect: a conflict that
            looks nothing like R;
  nearmiss  like pinned, but one attribute that R needs is changed first, so R
            does not fire on the pinned request: not a conflict.

The request q is drawn with the solver-free enumerator of independent_check.py.
The planted file then goes through the normal v3 path (intake, CPM, Z3) and the
answers are compared with the labels above. The same pairs are also shown to the
screening stages, which gives their recall on conflicts they were not tuned on.

Usage:  python v3/inject.py <dataset> [per_kind=100] [seed=20261112]
"""
from __future__ import annotations
import copy
import json
import random
import sys
import xml.etree.ElementTree as ET
from pathlib import Path

import numpy as np

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE))
import funnel  # noqa: E402
import intake  # noqa: E402
import structural  # noqa: E402
from independent_check import Space, rules as xml_rules  # noqa: E402
from pcproof.model import conj  # noqa: E402
from pcproof.verify import Verifier  # noqa: E402
from research import screening  # noqa: E402

NS = 'urn:oasis:names:tc:xacml:3.0:core:schema:wd-17'
FN = 'urn:oasis:names:tc:xacml:1.0:function:'
ET.register_namespace('', NS)


def q(name):
    return '{%s}%s' % (NS, name)


def value_of(space, key, point, fresh):
    cs = space.sorted[key]
    if point[0] == 'c':
        return cs[point[1]]
    if point[0] == 'other':
        return fresh
    if space.kind[key] == 'integer':
        return cs[0] - 1 if point[1] < 0 else cs[point[1]] + 1
    raise ValueError('injection supports integer gaps only')


def draw(space, grid, rng, fresh):
    """One request (axis key -> value) on which the rule with this grid fires."""
    cells = np.argwhere(grid)
    cell = cells[rng.randrange(len(cells))]
    request = {}
    for axis, key in enumerate(space.axes):
        i = int(cell[axis]) if grid.shape[axis] > 1 else rng.randrange(len(space.points[key]))
        request[key] = (i, value_of(space, key, space.points[key][i], fresh))
    return request


def fires(space, rule, request):
    """Evaluate one rule on one concrete request whose values are constants of the space."""
    grid = space.grid(rule)
    cell = []
    for axis, key in enumerate(space.axes):
        if grid.shape[axis] == 1:
            cell.append(0)
        else:
            cell.append(space.points[key].index(('c', space.sorted[key].index(request[key]))))
    return bool(grid[tuple(cell)])


def pin(request, effect, rid):
    policy = ET.Element(q('Policy'), {'PolicyId': 'urn:v3:injected:' + rid, 'Version': '1.0',
                                      'RuleCombiningAlgId': 'urn:oasis:names:tc:xacml:3.0:rule-combining-algorithm:deny-overrides'})
    ET.SubElement(policy, q('Target'))
    rule = ET.SubElement(policy, q('Rule'), {'RuleId': rid, 'Effect': effect})
    target = ET.SubElement(rule, q('Target'))
    for key, (_, value) in request.items():
        kind = key[2].rsplit('#', 1)[-1]
        match = ET.SubElement(ET.SubElement(ET.SubElement(target, q('AnyOf')), q('AllOf')), q('Match'), {'MatchId': FN + kind + '-equal'})
        ET.SubElement(match, q('AttributeValue'), {'DataType': key[2]}).text = str(value)
        attrib = {'AttributeId': key[1], 'DataType': key[2], 'MustBePresent': 'false'}
        if key[0]:
            attrib['Category'] = key[0]
        ET.SubElement(match, q('AttributeDesignator'), attrib)
    return policy


def twin(rule, effect, rid):
    policy = ET.Element(q('Policy'), {'PolicyId': 'urn:v3:injected:' + rid, 'Version': '1.0',
                                      'RuleCombiningAlgId': 'urn:oasis:names:tc:xacml:3.0:rule-combining-algorithm:deny-overrides'})
    target = ET.SubElement(policy, q('Target'))
    for t in rule['targets']:
        if t is not None:
            for anyof in t:
                target.append(copy.deepcopy(anyof))
    out = ET.SubElement(policy, q('Rule'), {'RuleId': rid, 'Effect': effect})
    ET.SubElement(out, q('Target'))
    if rule['condition'] is not None:
        ET.SubElement(out, q('Condition')).append(copy.deepcopy(rule['condition']))
    return policy


def run(name, per_kind=100, seed=20261112):
    path, sources = funnel.DATASETS[name]
    rng = random.Random(f'{seed}:{name}')
    tree = ET.parse(path)
    root = tree.getroot()
    space = Space(root)
    originals = xml_rules(root, sources)
    planted = []
    for kind in ('twin', 'pinned', 'nearmiss'):
        k = 0
        while k < per_kind:
            r = originals[rng.randrange(len(originals))]
            grid = space.grid(r)
            if not grid.any():
                continue
            rid = f'inj-{kind}-{k:03}'
            flipped = 'Deny' if r['effect'] == 'Permit' else 'Permit'
            if kind == 'twin':
                element, label = twin(r, flipped, rid), True
            else:
                request = draw(space, grid, rng, '__injected_other__')
                if kind == 'nearmiss':
                    needed = [a for a, key in enumerate(space.axes) if grid.shape[a] > 1]
                    moved = False
                    for a in rng.sample(needed, len(needed)):
                        key = space.axes[a]
                        cell = [request[x][0] if grid.shape[i] > 1 else 0 for i, x in enumerate(space.axes)]
                        options = [i for i in range(len(space.points[key])) if not grid[tuple(cell[:a] + [i] + cell[a + 1:])]]
                        options = [i for i in options if space.points[key][i][0] in ('c', 'other') or space.kind[key] == 'integer']
                        if options:
                            i = rng.choice(options)
                            request[key] = (i, value_of(space, key, space.points[key][i], '__injected_other__'))
                            moved = True
                            break
                    if not moved:
                        continue
                element, label = pin(request, flipped, rid), kind == 'pinned'
            root.append(element)
            planted.append({'kind': kind, 'original': r['id'], 'injected': rid, 'conflict_by_construction': label,
                            'request': None if kind == 'twin' else {json.dumps(key): value for key, (_, value) in request.items()}})
            k += 1
    out_dir = funnel.OUT / 'injection'
    out_dir.mkdir(parents=True, exist_ok=True)
    planted_file = out_dir / f'{name}_planted.xml'
    tree.write(planted_file, encoding='utf-8', xml_declaration=True)
    # ---- the pipeline under test ------------------------------------------------
    m = intake.load(planted_file, sources)
    ids = {r['id']: r for r in m['cpm']['rules']}
    shown = {r['id']: r for r in m['display']['rules']}
    v = Verifier(m['cpm'], funnel.SOLVER_BUDGET_MS)
    # ---- solver-free label from the planted file --------------------------------
    root2 = ET.parse(planted_file).getroot()
    space2 = Space(root2)
    by_id = {r['id']: r for r in xml_rules(root2, sources)}
    pairs = [(shown[p['original']], shown[p['injected']]) for p in planted]
    scope_kept = structural.kept_pairs([r for pair in pairs for r in pair], pairs)
    vec = {}
    if (funnel.MODEL_DIR / 'onnx' / 'model.onnx').exists():
        wanted = sorted({r['id'] for pair in pairs for r in pair})
        vectors, _ = screening.Embedder(funnel.MODEL_DIR).encode([screening.verbalize(shown[i]['condition'], m['mapping']) for i in wanted])
        vec = dict(zip(wanted, vectors))
    for p in planted:
        a, b = p['original'], p['injected']
        p['solver'] = v.check(conj(ids[a]['condition'], ids[b]['condition']))['status']
        if p['kind'] == 'twin':
            p['enumerator'] = bool((space2.grid(by_id[a]) & space2.grid(by_id[b])).any())
        else:       # the planted rule fires on one request only: evaluate the original rule on it
            p['enumerator'] = fires(space2, by_id[a], {tuple(json.loads(k)): x for k, x in p['request'].items()})
        p['jaccard'] = screening.entity_score(screening.entities(shown[a]['condition'], m['mapping']),
                                              screening.entities(shown[b]['condition'], m['mapping']))
        p['cosine'] = float(vec[a] @ vec[b]) if vec else None
        p['scope'] = tuple(sorted((a, b))) in scope_kept
    summary = {'dataset': name, 'seed': seed, 'per_kind': per_kind, 'kinds': {}}
    for kind in ('twin', 'pinned', 'nearmiss'):
        rows = [p for p in planted if p['kind'] == kind]
        truth = rows[0]['conflict_by_construction']
        e = [p['cosine'] is None or p['cosine'] >= funnel.EMBED_THRESHOLD for p in rows]
        n = [p['jaccard'] >= funnel.ENTITY_THRESHOLD for p in rows]
        s = [p['scope'] for p in rows]
        summary['kinds'][kind] = {
            'planted': len(rows), 'conflict_by_construction': truth,
            'solver_correct': sum((p['solver'] == 'SAT') == truth for p in rows),
            'enumerator_correct': sum(p['enumerator'] == truth for p in rows),
            'kept_by_scope_query': sum(s), 'kept_by_entity_overlap': sum(n),
            'kept_by_similarity': sum(e) if vec else None,
            'kept_by_all_three': sum(x and y and z for x, y, z in zip(e, n, s)) if vec else None}
    (out_dir / f'{name}_rows.json').write_text(json.dumps(planted, indent=1))
    (out_dir / f'{name}_summary.json').write_text(json.dumps(summary, indent=1))
    return summary


if __name__ == '__main__':
    name = sys.argv[1]
    per_kind = int(sys.argv[2]) if len(sys.argv) > 2 else 100
    seed = int(sys.argv[3]) if len(sys.argv) > 3 else 20261112
    print(json.dumps(run(name, per_kind, seed), indent=1))
