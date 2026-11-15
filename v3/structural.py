"""v3 structural stage: one SPARQL query over an RDF view of the rules.

Each rule becomes a node typed ex:PermitRule or ex:DenyRule. For every equality
that the rule's applicability makes necessary (a positive `attribute = constant`
reachable through AND only, never through OR or NOT) the node gets a requirement:

    <rule> ex:requires [ ex:attribute <attribute> ; ex:value "constant" ] .

SCOPE_QUERY returns the Permit/Deny pairs that require two different constants
for the same attribute. No request can fire both rules of such a pair, so dropping
it cannot lose a conflict: the stage is sound by construction. SELF_QUERY returns
rules that contradict themselves in the same way. Every other pair goes on.

kept_pairs() also checks the query answers against pcproof.verify.can_skip_exact,
the plain-Python statement of the same rule, and raises if they ever differ.
"""
from __future__ import annotations
import hashlib
import json
import sys
from pathlib import Path

from rdflib import RDF, Graph, Literal, Namespace, URIRef

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / 'src'))
from pcproof.verify import can_skip_exact, equalities  # noqa: E402

EX = Namespace('urn:v3:')
SCOPE_QUERY = '''PREFIX ex: <urn:v3:>
SELECT DISTINCT ?p ?d WHERE {
  ?p  a ex:PermitRule ; ex:requires ?rp .
  ?rp ex:attribute ?attr ; ex:value ?vp .
  ?rd ex:attribute ?attr ; ex:value ?vd .
  FILTER(?vp != ?vd)
  ?d  ex:requires ?rd ; a ex:DenyRule .
}'''
SELF_QUERY = '''PREFIX ex: <urn:v3:>
SELECT DISTINCT ?r WHERE {
  ?r  ex:requires ?r1 , ?r2 .
  ?r1 ex:attribute ?attr ; ex:value ?v1 .
  ?r2 ex:attribute ?attr ; ex:value ?v2 .
  FILTER(?v1 != ?v2)
}'''


def node(rule_id):
    return URIRef(EX + 'rule/' + hashlib.sha256(rule_id.encode()).hexdigest()[:24])


def rdf_view(rules):
    g = Graph()
    g.bind('ex', EX)
    back, n_req = {}, 0
    for r in rules:
        n = node(r['id'])
        back[str(n)] = r['id']
        g.add((n, RDF.type, EX[r['effect'] + 'Rule']))
        for attr, values in equalities(r['condition']).items():
            for value in values:
                n_req += 1
                req = URIRef(EX + f'requirement/{n_req}')
                g.add((n, EX.requires, req))
                g.add((req, EX.attribute, URIRef(EX + 'attribute/' + attr)))
                g.add((req, EX.value, Literal(json.dumps(value))))
    return g, back


def kept_pairs(rules, pairs):
    """Return the pairs the structural stage keeps, as a set of sorted id tuples."""
    g, back = rdf_view(rules)
    dropped = {tuple(sorted((back[str(row.p)], back[str(row.d)]))) for row in g.query(SCOPE_QUERY)}
    contradictory = {back[str(row.r)] for row in g.query(SELF_QUERY)}
    kept = set()
    for a, b in pairs:
        key = tuple(sorted((a['id'], b['id'])))
        keep = key not in dropped and a['id'] not in contradictory and b['id'] not in contradictory
        if keep == can_skip_exact(a, b):
            raise AssertionError('SPARQL scope query and can_skip_exact disagree on ' + str(key))
        if keep:
            kept.add(key)
    return kept
