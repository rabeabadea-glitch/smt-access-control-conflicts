"""Independent labels for rule pairs, computed straight from the XACML XML.

This file imports nothing from src/ and nothing from intake.py or funnel.py: no
Common Policy Model, no SMT-LIB, no Z3. It re-reads the XML and decides, for two
rules, whether one request can fire both, in two unrelated ways:

  enumerate()  evaluates both rules on every request of the finite request space
               (one representative value per region of every attribute), using
               numpy broadcasting over the attributes the two rules mention;
  search()     treats each rule as a conjunction of AnyOf groups, each group a
               union of AllOf boxes, and searches for one non-empty intersection.

Representative values: an attribute compared only by equality gets its policy
constants plus one value that equals none of them. An attribute compared by
order gets, for constants c1 < ... < cn, the points below c1, each ci, each open
interval (ci, ci+1) and above cn; an integer interval with no integer in it is
left out. Every comparison in the policy is constant on each point, so the two
procedures are exact for this fragment.

A request carries one value per attribute, so T-is-in(c, a) holds on the point c
of a, and T-at-least-one-member-of(T-bag(c1..cn), a) on the points c1..cn.

Usage:  python v3/independent_check.py <pairs_json> <xacml_file> [file|policy]
        (writes results/independent/<dataset>.json)
"""
from __future__ import annotations
import itertools
import json
import sys
import time
import xml.etree.ElementTree as ET
from pathlib import Path

import numpy as np

FN = 'urn:oasis:names:tc:xacml:1.0:function:'
ORDER = {'less-than': lambda a, b: a < b, 'less-than-or-equal': lambda a, b: a <= b,
         'greater-than': lambda a, b: a > b, 'greater-than-or-equal': lambda a, b: a >= b,
         'equal': lambda a, b: a == b}
GRID_LIMIT = 4_000_000
NODE_LIMIT = 2_000_000


def tag(e):
    return e.tag.rsplit('}', 1)[-1]


def kid(e, name):
    return next((c for c in e if tag(c) == name), None)


def cast(text, datatype):
    kind = datatype.rsplit('#', 1)[-1]
    text = text or ''
    if kind == 'integer':
        return int(text.strip())
    if kind == 'double':
        return float(text.strip())
    return text if kind == 'string' else text.strip()


def split(function_id):
    name = function_id[len(FN):]
    for tail in sorted(ORDER, key=len, reverse=True):
        if name.endswith('-' + tail):
            return name[:-len(tail) - 1], tail
    raise ValueError('function outside the fragment: ' + function_id)


class Space:
    """Finite request space: one axis per attribute, one point per region."""

    def __init__(self, root):
        self.constants, self.ordered, self.kind = {}, set(), {}
        for e in root.iter():
            if tag(e) in ('Match', 'Apply'):
                member = self.members(e)
                if member:
                    self.constants.setdefault(member[0], set()).update(member[1])
                    self.kind[member[0]] = member[0][2].rsplit('#', 1)[-1]
                    continue
                pair = self.operands(e)
                if pair:
                    key, const, tail, _ = pair
                    self.constants.setdefault(key, set()).add(const)
                    self.kind[key] = key[2].rsplit('#', 1)[-1]
                    if tail != 'equal':
                        self.ordered.add(key)
        self.axes = sorted(self.constants)
        self.points = {}
        for key in self.axes:
            cs = sorted(self.constants[key])
            if key not in self.ordered:
                self.points[key] = [('c', i) for i in range(len(cs))] + [('other', 0)]
            else:
                pts = [('gap', -1)]
                for i, c in enumerate(cs):
                    pts.append(('c', i))
                    if i + 1 < len(cs) and self.kind[key] == 'integer' and cs[i + 1] == c + 1:
                        continue        # no integer strictly between two neighbours
                    pts.append(('gap', i))
                self.points[key] = pts
        self.sorted = {k: sorted(v) for k, v in self.constants.items()}

    @staticmethod
    def members(e):
        """(attribute key, constants) for T-is-in(c, a) and T-at-least-one-member-of(T-bag(c..), a), else None."""
        fid = e.get('FunctionId', '') if tag(e) == 'Apply' else ''
        if len(e) != 2:
            return None
        if fid.endswith('-is-in') and tag(e[0]) == 'AttributeValue' and tag(e[1]) == 'AttributeDesignator':
            values, des = [e[0]], e[1]
        elif fid.endswith('-at-least-one-member-of'):
            bag, des = (e[0], e[1]) if tag(e[0]) == 'Apply' else (e[1], e[0])
            if not (tag(bag) == 'Apply' and bag.get('FunctionId', '').endswith('-bag') and len(bag)
                    and all(tag(v) == 'AttributeValue' for v in bag) and tag(des) == 'AttributeDesignator'):
                raise ValueError('membership outside the fragment')
            values = list(bag)
        else:
            return None
        key = (des.get('Category') or '', des.get('AttributeId'), des.get('DataType'))
        if any(v.get('DataType') != key[2] for v in values):
            raise ValueError('membership datatype mismatch')
        return key, [cast(v.text, v.get('DataType')) for v in values]

    @staticmethod
    def operands(e):
        """(attribute key, constant, comparison tail, constant_is_first) or None."""
        fid = e.get('MatchId') if tag(e) == 'Match' else e.get('FunctionId', '')
        if not fid or not fid.startswith(FN) or fid in (FN + 'and', FN + 'or', FN + 'not') or fid.endswith('-one-and-only'):
            return None
        if fid.endswith(('-bag', '-is-in', '-at-least-one-member-of')):
            return None                       # handled by members()
        _, tail = split(fid)
        if len(e) != 2:
            raise ValueError('comparison arity')

        def unwrap(x):
            if tag(x) == 'Apply' and x.get('FunctionId', '').endswith('-one-and-only'):
                return x[0]
            return x
        first, second = unwrap(e[0]), unwrap(e[1])
        if tag(first) == 'AttributeValue' and tag(second) == 'AttributeDesignator':
            value, des, const_first = first, second, True
        elif tag(first) == 'AttributeDesignator' and tag(second) == 'AttributeValue':
            value, des, const_first = second, first, False
        else:
            raise ValueError('comparison must relate one attribute to one constant')
        key = (des.get('Category') or '', des.get('AttributeId'), des.get('DataType'))
        return key, cast(value.text, value.get('DataType')), tail, const_first

    def holds(self, key, point, const, tail, const_first):
        """Truth of the comparison on one representative point."""
        cs = self.sorted[key]
        j = cs.index(const)
        if point[0] == 'other':
            return False                      # equality with a value outside the constants
        rank = 2 * point[1] if point[0] == 'c' else 2 * point[1] + 1   # constants even, gaps odd
        a, b = (2 * j, rank) if const_first else (rank, 2 * j)
        return ORDER[tail](a, b)

    def mask(self, e):
        member = self.members(e)
        if member:
            key, consts = member
            return key, np.array([any(self.holds(key, p, c, 'equal', True) for c in consts) for p in self.points[key]], dtype=bool)
        key, const, tail, const_first = self.operands(e)
        return key, np.array([self.holds(key, p, const, tail, const_first) for p in self.points[key]], dtype=bool)

    def lift(self, key, vector):
        shape = [1] * len(self.axes)
        shape[self.axes.index(key)] = len(vector)
        return vector.reshape(shape)

    # ---- request enumeration -------------------------------------------------
    def grid_target(self, target):
        out = np.ones([1] * len(self.axes), dtype=bool)
        if target is None:
            return out
        for anyof in target:
            alt = np.zeros([1] * len(self.axes), dtype=bool)
            for allof in anyof:
                box = np.ones([1] * len(self.axes), dtype=bool)
                for m in allof:
                    box = box & self.lift(*self.mask(m))
                alt = alt | box
            out = out & alt
        return out

    def grid_condition(self, e):
        fid = e.get('FunctionId', '')
        if fid == FN + 'and':
            out = np.ones([1] * len(self.axes), dtype=bool)
            for c in e:
                out = out & self.grid_condition(c)
            return out
        if fid == FN + 'or':
            out = np.zeros([1] * len(self.axes), dtype=bool)
            for c in e:
                out = out | self.grid_condition(c)
            return out
        if fid == FN + 'not':
            return ~self.grid_condition(e[0])
        return self.lift(*self.mask(e))

    def grid(self, rule):
        out = np.ones([1] * len(self.axes), dtype=bool)
        for t in rule['targets']:
            out = out & self.grid_target(t)
        if rule['condition'] is not None:
            out = out & self.grid_condition(rule['condition'])
        return out

    def mentioned(self, rule):
        """Attributes a rule compares, read from the XML (its grid has one axis per such attribute)."""
        keys = set()
        parts = [t for t in rule['targets'] if t is not None] + ([rule['condition']] if rule['condition'] is not None else [])
        for part in parts:
            for e in [part] + list(part.iter()):
                if tag(e) in ('Match', 'Apply'):
                    pair = self.members(e) or self.operands(e)
                    if pair:
                        keys.add(pair[0])
        return keys

    # ---- box search ----------------------------------------------------------
    def groups(self, rule):
        """Rule as a list of groups; a group is a list of boxes {attribute: bitmask}."""
        out = []
        for t in rule['targets']:
            if t is None:
                continue
            for anyof in t:
                boxes = []
                for allof in anyof:
                    box = {}
                    for m in allof:
                        key, vec = self.mask(m)
                        bits = int(sum(1 << i for i, x in enumerate(vec) if x))
                        box[key] = box.get(key, (1 << len(vec)) - 1) & bits
                    boxes.append(box)
                out.append(boxes)
        c = rule['condition']
        if c is not None:
            keys = self.mentioned({'targets': [], 'condition': c})
            if len(keys) != 1:
                raise ValueError('search() handles conditions over one attribute only')
            vec = self.grid_condition(c).reshape(-1)     # truth of the condition on each point of that attribute
            out.append([{next(iter(keys)): int(sum(1 << i for i, x in enumerate(vec) if x))}])
        return out


def search(groups, budget=NODE_LIMIT):
    """True if one box per group can be chosen with a non-empty intersection."""
    groups = sorted(groups, key=len)
    nodes = 0

    def go(i, state):
        nonlocal nodes
        if i == len(groups):
            return True
        for box in groups[i]:
            nodes += 1
            if nodes > budget:
                raise TimeoutError
            new, ok = dict(state), True
            for key, bits in box.items():
                bits &= new.get(key, -1)
                if bits == 0:
                    ok = False
                    break
                new[key] = bits
            if ok and go(i + 1, new):
                return True
        return False
    return go(0, {})


def rules(root, sources):
    """Rules in document order, ids built exactly as the article reports them."""
    found = []

    def walk(e, chain, path, top):
        chain = chain + [kid(e, 'Target')]
        if tag(e) == 'Rule':
            c = kid(e, 'Condition')
            found.append({'rule_id': e.get('RuleId'), 'path': path, 'top': top, 'effect': e.get('Effect'),
                          'targets': chain, 'condition': c[0] if c is not None else None})
            return
        ident = e.get('PolicyId') or e.get('PolicySetId')
        for c in e:
            if tag(c) in ('Policy', 'PolicySet', 'Rule'):
                walk(c, chain, path + '/' + str(ident), top or (ident if path else None))
    walk(root, [], '', None)
    counts, used = {}, set()
    for r in found:
        counts[r['rule_id']] = counts.get(r['rule_id'], 0) + 1
    for r in found:
        rid = r['rule_id'] if counts[r['rule_id']] == 1 else r['path'].strip('/') + '/' + str(r['rule_id'])
        base, n = rid, 1
        while rid in used:
            n += 1
            rid = f'{base}#{n}'
        used.add(rid)
        r['id'] = rid
        r['source'] = (r['top'] or 'file') if sources == 'policy' else 'file'
    return found


def check(pairs_json, xacml_file, sources='file'):
    table = json.loads(Path(pairs_json).read_text())
    root = ET.parse(xacml_file).getroot()
    space = Space(root)
    rs = {r['id']: r for r in rules(root, sources)}
    cells = 1
    for k in space.axes:
        cells *= len(space.points[k])
    out = {'dataset': table['dataset'], 'request_space': cells, 'rules': len(rs), 'pairs': len(table['rows']),
           'enumerated_pairs': 0, 'enumeration_disagreements': [], 'searched_pairs': 0, 'search_disagreements': [],
           'search_undecided': 0, 'dead_rules_by_search': None}
    t = time.perf_counter()
    grids, groups = {}, {}

    def grid(i):
        if i not in grids:
            cells = 1
            for key in space.mentioned(rs[i]):
                cells *= len(space.points[key])
            grids[i] = space.grid(rs[i]) if cells <= GRID_LIMIT else None   # too large to enumerate: search() only
        return grids[i]

    def group(i):
        if i not in groups:
            groups[i] = space.groups(rs[i])
        return groups[i]
    for row in table['rows']:
        a, b = row['pair']
        solver = row['status'] == 'SAT'
        ga, gb = grid(a), grid(b)
        size = int(np.prod(np.broadcast_shapes(ga.shape, gb.shape))) if ga is not None and gb is not None else GRID_LIMIT + 1
        if size <= GRID_LIMIT:
            out['enumerated_pairs'] += 1
            if bool((ga & gb).any()) != solver:
                out['enumeration_disagreements'].append(row['pair'])
        try:
            found = search(group(a) + group(b))
            out['searched_pairs'] += 1
            if found != solver:
                out['search_disagreements'].append(row['pair'])
        except TimeoutError:
            out['search_undecided'] += 1
    dead, undecided = 0, 0
    for i in rs:
        try:
            dead += not search(group(i))
        except TimeoutError:
            undecided += 1
    out['dead_rules_by_search'] = dead
    out['dead_rules_undecided'] = undecided
    out['dead_rules_by_solver'] = table['dead_rules']
    out['seconds'] = round(time.perf_counter() - t, 1)
    return out


if __name__ == '__main__':
    result = check(sys.argv[1], sys.argv[2], sys.argv[3] if len(sys.argv) > 3 else 'file')
    out = Path(__file__).resolve().parent / 'results' / 'independent'
    out.mkdir(parents=True, exist_ok=True)
    (out / (result['dataset'] + '.json')).write_text(json.dumps(result, indent=1))
    print(json.dumps(result, indent=1))
