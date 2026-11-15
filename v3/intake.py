"""v3 per-rule XACML intake for the IEEE Software evaluation.

Why a second intake: src/research/xacml.py compiles a whole policy tree into one
Permit region and one Deny region and rejects anything outside its strict profile
(GEYSERS omits Category/MustBePresent, KMarket carries advice and obligations).
The article asks a different question: which two *rules* can fire on one request
with opposite effects. This module answers it without touching the frozen core:

  * it walks PolicySet -> Policy -> Rule and gives every Rule the conjunction of
    its ancestors' Targets, its own Target and its own Condition (AnyOf = OR of
    AllOf, AllOf = AND of Match), i.e. the rule's applicability;
  * combining algorithms are NOT applied: a pair is reported when both rules are
    applicable to one request, whatever the combiner later decides;
  * obligations, advice and Description are skipped and counted;
  * a designator without Category is given the category '' (documented loss);
  * a request carries one value per attribute. Under that reading the two bag
    forms of the Fedora policy are equalities: T-is-in(c, a) is a = c and
    T-at-least-one-member-of(T-bag(c1..cn), a) is a = c1 or ... or a = cn.
    Every other bag or higher-order function is rejected as Unsupported;
  * string attributes used only with equality become enums (literals + OTHER);
    integers keep their order; doubles and strings used with order comparisons
    are rank-coded (constant c_i -> 2i, domain 1..2n+1), which preserves every
    comparison against a policy constant.

The output is an ordinary cpm-1 model, validated by pcproof.model.normalize, with
one CPM rule per XACML Rule, plus the attribute mapping used for readable labels.
"""
from __future__ import annotations
import hashlib
import json
import sys
import xml.etree.ElementTree as ET
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / 'src'))
from pcproof.model import normalize  # noqa: E402
from research.xacml import AND, OR, NOT, local, child  # noqa: E402

FN = 'urn:oasis:names:tc:xacml:1.0:function:'
XS = 'http://www.w3.org/2001/XMLSchema#'
TAILS = {'equal': 'eq', 'less-than': 'lt', 'less-than-or-equal': 'le',
         'greater-than': 'gt', 'greater-than-or-equal': 'ge'}
FLIP = {'eq': 'eq', 'lt': 'gt', 'le': 'ge', 'gt': 'lt', 'ge': 'le'}
TYPES = ('string', 'integer', 'boolean', 'double')
SKIPPED = ('Description', 'ObligationExpressions', 'AdviceExpressions')


class Unsupported(ValueError):
    pass


def literal(text, datatype):
    kind = datatype.rsplit('#', 1)[-1]
    text = text or ''
    if kind == 'string':
        return text
    if kind == 'integer':
        return int(text.strip())
    if kind == 'double':
        return float(text.strip())
    if kind == 'boolean':
        if text.strip() not in ('true', 'false', '0', '1'):
            raise Unsupported('Invalid Boolean literal')
        return text.strip() in ('true', '1')
    raise Unsupported('Unsupported datatype ' + datatype)


def function(fid):
    for kind in TYPES:
        for tail, op in TAILS.items():
            if fid == FN + kind + '-' + tail:
                return kind, op
    raise Unsupported('Unsupported function ' + str(fid))


class Intake:
    def __init__(self):
        self.attrs = {}        # name -> descriptor
        self.literals = {}     # name -> set of raw literals
        self.ordered = set()   # names used with an order comparison
        self.skipped = {k: 0 for k in SKIPPED}
        self.defaulted_category = 0
        self.rules = []

    def designator(self, e):
        category = e.get('Category')
        if category is None:
            category = ''
            self.defaulted_category += 1
        datatype = e.get('DataType', '')
        if datatype.rsplit('#', 1)[-1] not in TYPES or not datatype.startswith(XS):
            raise Unsupported('Unsupported datatype ' + datatype)
        key = [category, e.get('AttributeId'), datatype]
        name = 'a_' + hashlib.sha256(json.dumps(key).encode()).hexdigest()[:16]
        self.attrs.setdefault(name, {'Category': category or 'unknown', 'AttributeId': e.get('AttributeId'), 'DataType': datatype})
        self.literals.setdefault(name, set())
        return name, datatype

    def operand(self, e):
        tag = local(e)
        if tag == 'AttributeValue':
            return ('lit', e.get('DataType'), e.text)
        if tag == 'AttributeDesignator':
            return ('attr',) + self.designator(e)
        if tag == 'Apply' and e.get('FunctionId', '').endswith('-one-and-only') and len(e) == 1:
            return self.operand(e[0])
        raise Unsupported('Unsupported operand ' + tag)

    def compare(self, fid, first, second):
        kind, op = function(fid)
        if first[0] == 'lit' and second[0] == 'attr':
            lit, att, op = first, second, FLIP[op]       # f(constant, attribute)
        elif first[0] == 'attr' and second[0] == 'lit':
            lit, att = second, first                     # f(attribute, constant)
        else:
            raise Unsupported('Comparison must relate one attribute to one constant')
        if lit[1] != att[2] or att[2] != XS + kind:
            raise Unsupported('Comparison datatype mismatch')
        value = literal(lit[2], lit[1])
        self.literals[att[1]].add(value)
        if op != 'eq':
            if kind == 'boolean':
                raise Unsupported('Order comparison on Boolean')
            self.ordered.add(att[1])
        return {'op': op, 'attr': att[1], 'value': value}

    def membership(self, e):
        """The two bag forms of the Fedora policy, read under one value per attribute:
        T-is-in(c, a) is a = c; T-at-least-one-member-of(T-bag(c1..cn), a) is a = c1 or ... or a = cn."""
        fid = e.get('FunctionId', '')
        if len(e) != 2:
            return None
        for kind in TYPES:
            equal = FN + kind + '-equal'
            if fid == FN + kind + '-is-in' and local(e[0]) == 'AttributeValue' and local(e[1]) == 'AttributeDesignator':
                return self.compare(equal, self.operand(e[0]), self.operand(e[1]))
            if fid == FN + kind + '-at-least-one-member-of':
                bag, des = (e[0], e[1]) if local(e[0]) == 'Apply' else (e[1], e[0])
                if (local(bag) == 'Apply' and bag.get('FunctionId') == FN + kind + '-bag' and len(bag)
                        and all(local(v) == 'AttributeValue' for v in bag) and local(des) == 'AttributeDesignator'):
                    att = self.operand(des)
                    return OR(*[self.compare(equal, self.operand(v), att) for v in bag])
        return None

    def target(self, e):
        if e is None:
            return True
        groups = []
        for anyof in e:
            if local(anyof) != 'AnyOf':
                raise Unsupported('Target expects AnyOf')
            alternatives = []
            for allof in anyof:
                if local(allof) != 'AllOf':
                    raise Unsupported('AnyOf expects AllOf')
                atoms = []
                for m in allof:
                    if local(m) != 'Match' or len(m) != 2:
                        raise Unsupported('AllOf expects Match')
                    atoms.append(self.compare(m.get('MatchId', ''), self.operand(m[0]), self.operand(m[1])))
                alternatives.append(AND(*atoms))
            groups.append(OR(*alternatives))
        return AND(*groups)

    def condition(self, e):
        if local(e) == 'AttributeValue':
            value = literal(e.text, e.get('DataType'))
            if type(value) is not bool:
                raise Unsupported('Non-Boolean condition')
            return value
        if local(e) != 'Apply':
            raise Unsupported('Unsupported condition ' + local(e))
        fid = e.get('FunctionId', '')
        if fid in (FN + 'and', FN + 'or'):
            parts = [self.condition(x) for x in e]
            return AND(*parts) if fid == FN + 'and' else OR(*parts)
        if fid == FN + 'not':
            if len(e) != 1:
                raise Unsupported('not arity')
            return NOT(self.condition(e[0]))
        member = self.membership(e)
        if member is not None:
            return member
        if len(e) != 2:
            raise Unsupported('Comparison arity')
        return self.compare(fid, self.operand(e[0]), self.operand(e[1]))

    def walk(self, e, inherited, path, top):
        tag = local(e)
        for c in e:
            if local(c) in SKIPPED:
                self.skipped[local(c)] += 1
            elif local(c) not in ('Target', 'Condition', 'Policy', 'PolicySet', 'Rule'):
                raise Unsupported('Unsupported ' + local(c) + ' in ' + tag)
        scope = AND(inherited, self.target(child(e, 'Target')))
        if tag == 'Rule':
            if e.get('Effect') not in ('Permit', 'Deny'):
                raise Unsupported('Invalid effect')
            cond = child(e, 'Condition')
            if cond is not None:
                if len(cond) != 1:
                    raise Unsupported('Condition arity')
                scope = AND(scope, self.condition(cond[0]))
            self.rules.append({'rule_id': e.get('RuleId'), 'path': path, 'top': top,
                               'effect': e.get('Effect'), 'condition': scope})
            return
        ident = e.get('PolicyId') or e.get('PolicySetId')
        for c in e:
            if local(c) in ('Policy', 'PolicySet', 'Rule'):
                self.walk(c, scope, path + '/' + str(ident), top or (ident if path else None))


def recode(expr, coding):
    if type(expr) is bool:
        return expr
    if expr['op'] in ('and', 'or'):
        return {'op': expr['op'], 'args': [recode(x, coding) for x in expr['args']]}
    if expr['op'] == 'not':
        return {'op': 'not', 'arg': recode(expr['arg'], coding)}
    table = coding.get(expr['attr'])
    return {**expr, 'value': table[expr['value']]} if table else expr


def load(path, sources='file'):
    """Return {'cpm', 'display', 'mapping', 'stats'} for one XACML 3.0 file.

    sources='file'   : every rule belongs to one source (single-framework benchmark);
    sources='policy' : each top-level Policy/PolicySet under the root is a source.
    'display' has the same rules with the original literals, for verbalisation.
    """
    path = Path(path)
    root = ET.parse(path).getroot()
    it = Intake()
    it.walk(root, True, '', None)
    domains, coding = {}, {}
    for name, d in it.attrs.items():
        kind = d['DataType'].rsplit('#', 1)[-1]
        values = it.literals[name]
        if kind == 'boolean':
            domains[name] = {'type': 'bool'}
        elif kind == 'integer':
            domains[name] = {'type': 'int', 'min': min(values) - 1, 'max': max(values) + 1}
        elif kind == 'string' and name not in it.ordered:
            other = '__OTHER__'
            while other in values:
                other += 'X'
            domains[name] = {'type': 'enum', 'values': sorted(values) + [other]}
        else:  # double, or string compared by order: rank coding
            ranked = sorted(values)
            coding[name] = {v: 2 * (i + 1) for i, v in enumerate(ranked)}
            domains[name] = {'type': 'int', 'min': 1, 'max': 2 * len(ranked) + 1}
    counts = {}
    for r in it.rules:
        counts[r['rule_id']] = counts.get(r['rule_id'], 0) + 1
    file_source = 'file:' + path.name
    srcs, rules, display = {}, [], []
    used = set()
    for r in it.rules:
        rid = r['rule_id'] if counts[r['rule_id']] == 1 else r['path'].strip('/') + '/' + str(r['rule_id'])
        base, n = rid, 1
        while rid in used:      # same RuleId twice inside one Policy: number the repeats
            n += 1
            rid = f'{base}#{n}'
        used.add(rid)
        src = file_source if sources == 'file' else (r['top'] or file_source)
        srcs.setdefault(src, {'kind': 'internal', 'citation': path.name + (' ' + src if sources != 'file' else ''),
                              'mapping_status': 'v3 per-rule applicability; combiners, obligations and advice not modelled'})
        rules.append({'id': rid, 'source': src, 'effect': r['effect'], 'condition': recode(r['condition'], coding)})
        display.append({'id': rid, 'source': src, 'effect': r['effect'], 'condition': r['condition']})
    cpm = normalize({'schema_version': 'cpm-1', 'attributes': domains, 'sources': srcs, 'rules': rules})
    stats = {'file': path.name, 'sha256': hashlib.sha256(path.read_bytes()).hexdigest(), 'rules': len(rules),
             'permit': sum(r['effect'] == 'Permit' for r in rules), 'deny': sum(r['effect'] == 'Deny' for r in rules),
             'attributes': len(domains), 'rank_coded_attributes': len(coding), 'sources': len(srcs),
             'skipped_elements': it.skipped, 'designators_without_category': it.defaulted_category}
    return {'cpm': cpm, 'display': {'rules': display}, 'mapping': it.attrs, 'stats': stats, 'coding': coding}


if __name__ == '__main__':
    for arg in sys.argv[1:]:
        try:
            print(json.dumps(load(arg)['stats']))
        except Exception as exc:  # report, never hide
            print(json.dumps({'file': arg, 'error': type(exc).__name__ + ': ' + str(exc)}))
