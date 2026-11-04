"""Strict CPM normalization and an independent, non-SMT reference interpreter."""
from __future__ import annotations
import copy
import hashlib
import itertools
import json
import math
import re

class InputError(ValueError):
    status='INVALID_INPUT'
class UnsupportedError(InputError):
    status='UNSUPPORTED_INPUT'

def fingerprint(value: object) -> str:
    return hashlib.sha256(json.dumps(value,sort_keys=True,separators=(',',':')).encode()).hexdigest()

def require(ok: bool, message: str):
    if not ok: raise InputError(message)

def fields(obj, required, optional=()):
    require(isinstance(obj,dict),'Expected JSON object')
    require(set(required)<=obj.keys(),'Missing fields: '+str(set(required)-obj.keys()))
    extra=set(obj)-set(required)-set(optional)
    if extra: raise UnsupportedError('Unsupported fields: '+', '.join(sorted(extra)))

def value_ok(domain: dict, value: object) -> bool:
    t=domain['type']
    if t == 'bool': return type(value) is bool
    if t == 'int': return type(value) is int and domain['min']<=value<=domain['max']
    return type(value) is str and value in domain['values']

def validate_expr(expr: object, attrs: dict, depth=0):
    require(depth<=40,'Expression nesting exceeds 40')
    if type(expr) is bool: return
    require(isinstance(expr,dict),'Expression must be Boolean or object')
    require('op' in expr,'Expression missing op')
    op=expr['op']
    if op in ('and','or'):
        fields(expr,['op','args']);require(isinstance(expr['args'],list),'args must be a list')
        require(1<=len(expr['args'])<=1000,'and/or require 1..1000 arguments')
        for child in expr['args']: validate_expr(child,attrs,depth+1)
    elif op=='not':
        fields(expr,['op','arg']);validate_expr(expr['arg'],attrs,depth+1)
    elif op in ('eq','ne','lt','le','gt','ge'):
        fields(expr,['op','attr','value']); name=expr['attr']
        require(isinstance(name,str) and name in attrs,'Unknown attribute')
        d=attrs[name];require(value_ok(d,expr['value']),'Constant outside typed domain: '+name)
        if op not in ('eq','ne') and d['type']!='int':
            raise UnsupportedError('Only integer attributes support order comparisons')
    else: raise UnsupportedError('Unsupported expression operator: '+str(op))

def normalize(raw: object) -> dict:
    fields(raw,['schema_version','attributes','sources','rules'],['validity','precedence','invariants','description'])
    if raw['schema_version']!='cpm-1': raise UnsupportedError('Unsupported schema version')
    if 'description' in raw: require(isinstance(raw['description'],str),'description must be a string')
    p=copy.deepcopy(raw);attrs=p['attributes'];require(isinstance(attrs,dict) and bool(attrs),'Nonempty attributes required')
    require(len(attrs)<=64,'At most 64 attributes supported')
    for name,d in attrs.items():
        require(bool(re.fullmatch(r'[A-Za-z][A-Za-z0-9_]{0,63}',name)),'Invalid attribute identifier')
        require(isinstance(d,dict) and 'type' in d,'Missing domain type')
        if d['type']=='bool': fields(d,['type'])
        elif d['type']=='int':
            fields(d,['type','min','max']);require(type(d['min']) is int and type(d['max']) is int,'Integer bounds required')
            require(d['min']<=d['max'],'Reversed bounds')
            require(abs(d['min'])<=2**53 and abs(d['max'])<=2**53,'Bounds exceed portable prototype limit')
        elif d['type']=='enum':
            fields(d,['type','values']);v=d['values'];require(isinstance(v,list) and bool(v),'Nonempty enum required')
            require(all(type(x) is str for x in v),'Enum values must be strings')
            require(len(v)==len(set(v)),'Duplicate enum values')
        else: raise UnsupportedError('Unsupported attribute type: '+str(d['type']))
    require(isinstance(p['sources'],dict) and bool(p['sources']),'Sources required')
    for name,s in p['sources'].items():
        require(isinstance(name,str) and bool(name),'Source id required')
        fields(s,['kind','citation','mapping_status'])
        require(s['kind'] in ('regulation','standard','internal','synthetic'),'Invalid source kind')
        require(all(isinstance(s[k],str) and s[k] for k in s),'Source metadata must be nonempty text')
    require(isinstance(p['rules'],list) and bool(p['rules']),'Nonempty rules required')
    require(len(p['rules'])<=10000,'At most 10000 rules supported')
    ids=set()
    for r in p['rules']:
        fields(r,['id','source','effect','condition'],['provenance'])
        require(isinstance(r['id'],str) and bool(r['id']) and r['id'] not in ids,'Duplicate/empty rule id')
        ids.add(r['id']);require(isinstance(r['source'],str) and r['source'] in p['sources'],'Unknown rule source')
        require(r['effect'] in ('Permit','Deny'),'Effect must be Permit or Deny')
        validate_expr(r['condition'],attrs)
    p.setdefault('validity',True);validate_expr(p['validity'],attrs)
    p.setdefault('precedence',[]);require(isinstance(p['precedence'],list),'precedence must be list')
    edges=set()
    for e in p['precedence']:
        fields(e,['higher','lower','approval_id'])
        require(isinstance(e['higher'],str) and isinstance(e['lower'],str) and e['higher'] in p['sources'] and e['lower'] in p['sources'],'Unknown precedence source')
        require(isinstance(e['approval_id'],str) and bool(e['approval_id']),'Precedence approval id missing')
        edges.add((e['higher'],e['lower']))
    closure=transitive(edges)
    require(not any(a==b for a,b in closure),'Cyclic precedence is invalid')
    p.setdefault('invariants',[]);require(isinstance(p['invariants'],list),'invariants must be list')
    inv_ids=set()
    for inv in p['invariants']:
        fields(inv,['id','when','required'])
        require(isinstance(inv['id'],str) and bool(inv['id']) and inv['id'] not in inv_ids,'Duplicate/empty invariant id')
        inv_ids.add(inv['id'])
        require(inv['required'] in ('Permit','Deny'),'Invariant requires Permit or Deny')
        validate_expr(inv['when'],attrs)
    return p

def transitive(edges):
    closure=set(edges)
    while True:
        new=closure|{(a,d) for a,b in closure for c,d in closure if b==c}
        if new==closure:return new
        closure=new

def governed(p,r,s):
    g=transitive((e['higher'],e['lower']) for e in p['precedence'])
    return (r['source'],s['source']) in g or (s['source'],r['source']) in g

def evaluate(expr: object, request: dict) -> bool:
    """Direct typed interpretation. Does not call encoder, native Z3 or export."""
    if type(expr) is bool:return expr
    op=expr['op']
    if op=='and':return all(evaluate(x,request) for x in expr['args'])
    if op=='or':return any(evaluate(x,request) for x in expr['args'])
    if op=='not':return not evaluate(expr['arg'],request)
    a=request[expr['attr']];b=expr['value']
    if op=='eq':return a==b
    if op=='ne':return a!=b
    if op=='lt':return a<b
    if op=='le':return a<=b
    if op=='gt':return a>b
    if op=='ge':return a>=b
    raise UnsupportedError(op)

def valid_request(p, request):
    return (isinstance(request,dict) and request.keys()==p['attributes'].keys()
            and all(value_ok(d,request[a]) for a,d in p['attributes'].items())
            and evaluate(p['validity'],request))

def decision(p,request):
    if not valid_request(p,request):return {'decision':'InvalidRequest','matched':[],'allow':False}
    matched=[r for r in p['rules'] if evaluate(r['condition'],request)]
    effects={r['effect'] for r in matched}
    d='Conflict' if len(effects)==2 else next(iter(effects),'NotApplicable')
    return {'decision':d,'matched':sorted(r['id'] for r in matched),'allow':d=='Permit'}

def cardinality(p):
    return math.prod(len(domain_values(d)) for d in p['attributes'].values())

def domain_values(d):
    if d['type']=='bool':return [False,True]
    if d['type']=='int':return range(d['min'],d['max']+1)
    return d['values']

def requests(p,limit=200000):
    n=cardinality(p)
    if n>limit:raise ValueError(f'Enumeration bound exceeded: {n}>{limit}')
    keys=list(p['attributes'])
    for vals in itertools.product(*(domain_values(p['attributes'][k]) for k in keys)):
        r=dict(zip(keys,vals))
        if evaluate(p['validity'],r):yield r

def conj(*args):return {'op':'and','args':list(args)}
def neg(arg):return {'op':'not','arg':arg}
def disj(*args):return {'op':'or','args':list(args)} if args else False
def atom(attr,op,value):return {'op':op,'attr':attr,'value':value}
