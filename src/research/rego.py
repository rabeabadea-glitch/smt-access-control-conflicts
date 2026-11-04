"""Deliberately partial Rego v1 mapping and standalone target compilation.

No policy is evaluated by Python in the generated target. The source mapper
accepts only Boolean comparisons and acyclic Boolean helper rules; everything
else is rejected. The sidecar carries domains and governance labels, never
conditions. Generated expressions are recovered from executable rule bodies.
"""
from __future__ import annotations
import copy
import json
import re
from pcproof.model import normalize, validate_expr, InputError, UnsupportedError

OPS={'==':'eq','!=':'ne','<':'lt','<=':'le','>':'gt','>=':'ge'}
REV={v:k for k,v in OPS.items()}
TOKEN=re.compile(r'\s+|\#[^\n]*|"(?:[^"\\]|\\.)*"|-?[0-9]+|:=|==|!=|<=|>=|[A-Za-z_][A-Za-z_0-9]*|[{}\[\];.<>]')

def compact(op,args):
    return args[0] if len(args)==1 else {'op':op,'args':args}

class Parser:
    def __init__(self,text):
        if len(text)>32*1024*1024:raise UnsupportedError('Rego module exceeds 32 MiB mapping bound')
        self.t=[];pos=0
        for m in TOKEN.finditer(text):
            if m.start()!=pos: raise UnsupportedError('Unsupported Rego syntax at '+str(pos))
            pos=m.end();s=m.group()
            if s.isspace():
                if '\n' in s:self.t.append('\n')
            elif not s.startswith('#'):self.t.append(s)
        if pos!=len(text):raise UnsupportedError('Unsupported trailing syntax')
        self.i=0
    def take(self,want=None):
        if self.i>=len(self.t):raise InputError('Unexpected end of Rego')
        t=self.t[self.i];self.i+=1
        if want is not None and t!=want:raise UnsupportedError('Expected '+want+', got '+t)
        return t
    def peek(self):return self.t[self.i] if self.i<len(self.t) else None
    def newlines(self):
        while self.peek()=='\n':self.take('\n')
    def line_end(self):
        if self.peek() not in ('\n',None):raise UnsupportedError('Rego declaration requires a line boundary')
        self.newlines()
    def ident(self):
        x=self.take()
        if not re.fullmatch('[A-Za-z_][A-Za-z_0-9]*',x):raise InputError('Identifier required')
        if x in ('input','data','not','true','false','default','import','package','if','some','every','contains','else','with','as','in'):
            raise UnsupportedError('Reserved identifier '+x)
        return x
    def term(self,depth=0):
        if depth>40:raise UnsupportedError('Negation nesting exceeds 40')
        x=self.take()
        if x=='not':
            if self.peek()=='not':raise UnsupportedError('Consecutive not tokens excluded; use a Boolean helper')
            return ('not',self.term(depth+1))
        if x in ('true','false'):return x=='true'
        if x=='input':
            t=self.take()
            if t=='.':a=self.ident()
            elif t=='[':
                try:a=json.loads(self.take())
                except ValueError as exc:raise InputError('String field required') from exc
                self.take(']')
                if not isinstance(a,str):raise InputError('String field required')
            else:raise UnsupportedError('Only direct input fields supported')
            op=self.take()
            if op not in OPS:raise UnsupportedError('Comparison required')
            lit=self.take()
            try:v=json.loads(lit)
            except ValueError as exc:raise UnsupportedError('Literal comparison required') from exc
            if type(v) not in (str,int,bool):raise UnsupportedError('Scalar literal required')
            return {'op':OPS[op],'attr':a,'value':v}
        if re.fullmatch('[A-Za-z_][A-Za-z_0-9]*',x):return ('ref',x)
        raise UnsupportedError('Unsupported body term '+x)
    def module(self):
        self.newlines()
        self.take('package');parts=[self.ident()]
        while self.peek()=='.':self.take('.');parts.append(self.ident())
        self.line_end()
        defs={};defaults=set()
        while self.peek()=='import':
            self.take('import');self.take('rego');self.take('.');self.take('v1');self.line_end()
        while self.peek() is not None:
            if self.peek()=='default':
                self.take('default');name=self.ident();self.take(':=');self.take('false')
                if name in defaults:raise InputError('Duplicate default')
                defaults.add(name);self.line_end();continue
            name=self.ident();self.take('if')
            if self.peek()!='{':defs.setdefault(name,[]).append([self.term()]);self.line_end();continue
            self.take('{');body=[]
            while self.peek()!='}':
                if self.peek() is None:raise InputError('Unclosed rule body')
                if self.peek() in (';','\n'):self.take();continue
                body.append(self.term())
                if self.peek()not in ('}',';','\n'):raise UnsupportedError('Body terms require a semicolon or line boundary')
            self.take('}')
            if not body:raise UnsupportedError('Empty bodies excluded; use true')
            defs.setdefault(name,[]).append(body)
            self.line_end()
        for name in defaults:
            if name not in defs:defs[name]=[[False]]
        return '.'.join(parts),defs

def expand(defs,name,attrs,active=(),seen=None):
    if seen is None:seen=[250000]
    seen[0]-=1
    if seen[0]<0:raise UnsupportedError('Expanded expression exceeds mapping budget')
    # Generated aliases plus a permitted CPM depth-40 expression need >40
    # helper levels even though the recovered Boolean AST stays within depth40.
    if len(active)>82:raise UnsupportedError('Helper nesting exceeds 82')
    if name in active:raise UnsupportedError('Recursive Rego is outside the supported fragment')
    if name not in defs:raise UnsupportedError('Undefined/external helper '+name)
    def one(t):
        if isinstance(t,tuple):
            if t[0]=='ref':return expand(defs,t[1],attrs,active+(name,),seen)
            return {'op':'not','arg':one(t[1])}
        return copy.deepcopy(t)
    expr=compact('or',[compact('and',[one(t) for t in body]) for body in defs[name]])
    validate_expr(expr,attrs)
    return expr

def import_rego(text,manifest):
    """Map Boolean source rules; domain and authority labels must be explicit."""
    package,defs=Parser(text).module()
    if package!=manifest['package']:raise InputError('Package mismatch')
    # Validate all definitions, including unused ones. Never silently skip code.
    for n in defs:expand(defs,n,manifest['attributes'])
    raw={k:copy.deepcopy(manifest[k]) for k in ('schema_version','attributes','sources')}
    raw['rules']=[]
    for r in manifest['rules']:
        raw['rules'].append({k:copy.deepcopy(r[k]) for k in ('id','source','effect')})
        if 'provenance'in r:raw['rules'][-1]['provenance']=copy.deepcopy(r['provenance'])
        raw['rules'][-1]['condition']=expand(defs,r['entry'],manifest['attributes'])
    raw['validity']=expand(defs,manifest['validity_entry'],manifest['attributes']) if manifest.get('validity_entry') else True
    raw['precedence']=copy.deepcopy(manifest.get('precedence',[]))
    raw['invariants']=[{'id':v['id'],'required':v['required'],'when':expand(defs,v['entry'],manifest['attributes'])} for v in manifest.get('invariants',[])]
    if 'description'in manifest:raw['description']=manifest['description']
    return normalize(raw)

def generate(p):
    """Return two standalone Rego modules and a condition-free mapping manifest."""
    p=normalize(p);defs=[];serial=0
    def emit(e):
        nonlocal serial
        kids=[]
        if isinstance(e,dict):
            if e['op'] in ('and','or'):kids=[emit(x) for x in e['args']]
            elif e['op']=='not':kids=[emit(e['arg'])]
        name='c'+str(serial);serial+=1
        if type(e) is bool:bodies=[str(e).lower()]
        elif e['op']=='and':bodies=['; '.join(kids)]
        elif e['op']=='or':bodies=kids
        elif e['op']=='not':bodies=['not '+kids[0]]
        else:bodies=[f'input[{json.dumps(e["attr"])}] {REV[e["op"]]} {json.dumps(e["value"],ensure_ascii=True)}']
        defs.extend(f'{name} if {{ {b} }}' for b in bodies)
        return name
    validity=emit(p['validity']);entries=[]
    for i,r in enumerate(p['rules']):
        child=emit(r['condition']);name='rule_'+str(i)
        defs.append(f'{name} if {{ {child} }}')
        entries.append({k:copy.deepcopy(r[k]) for k in ('id','source','effect')})
        if 'provenance'in r:entries[-1]['provenance']=copy.deepcopy(r['provenance'])
        entries[-1]['entry']=name
    invariants=[]
    for inv in p['invariants']:
        child=emit(inv['when']);invariants.append({'id':inv['id'],'required':inv['required'],'entry':child})
    manifest={'schema_version':'cpm-1','package':'thesis','attributes':copy.deepcopy(p['attributes']),
              'sources':copy.deepcopy(p['sources']),'rules':entries,'validity_entry':validity,
              'precedence':copy.deepcopy(p['precedence']),'invariants':invariants}
    if 'description'in p:manifest['description']=p['description']
    conditions='package thesis\n\n'+'\n'.join(defs)+'\n'
    return conditions,wrapper(manifest),manifest

def wrapper(m):
    lines=['package thesis','','valid if {','    is_object(input)',f'    count(input) == {len(m["attributes"])}']
    for a,d in m['attributes'].items():
        ref='input['+json.dumps(a)+']'
        if d['type']=='bool':lines.append(f'    is_boolean({ref})')
        elif d['type']=='int':
            lines.extend([f'    is_number({ref})',f'    {ref} == floor({ref})',f'    {ref} >= {d["min"]}',f'    {ref} <= {d["max"]}'])
        else:lines.extend([f'    is_string({ref})',f'    {ref} in {{'+', '.join(json.dumps(v,ensure_ascii=True) for v in d['values'])+'}'])
    lines += ['    '+m['validity_entry'],'}','','matched := set() if { not valid }']
    # Partial-set rules naturally produce the empty set when none applies.
    lines[-1:]=[]
    for r in m['rules']:
        lines += [f'matched contains {json.dumps(r["id"],ensure_ascii=True)} if {{ valid; {r["entry"]} }}']
    for effect in ('Permit','Deny'):
        for r in m['rules']:
            if r['effect']==effect:lines.append(f'{effect.lower()} if {{ valid; {r["entry"]} }}')
        # default false makes both predicates total and avoids negated undefined issues.
        lines.append('default '+effect.lower()+' := false')
    lines += ['','decision := "InvalidRequest" if { not valid }',
              'decision := "Conflict" if { valid; permit; deny }',
              'decision := "Permit" if { valid; permit; not deny }',
              'decision := "Deny" if { valid; deny; not permit }',
              'decision := "NotApplicable" if { valid; not permit; not deny }',
              'allow := decision == "Permit"',
              'result := {"decision": decision, "matched": sort(matched), "allow": allow}']
    return '\n'.join(lines)+'\n'

def recover_attributes(wrapper_text):
    """Recover actual executable type/domain guard values, not manifest values."""
    body=wrapper_text.split('valid if {\n',1)[1].split('\n}',1)[0].splitlines()
    if body[0]!='    is_object(input)':raise InputError('Missing object guard')
    count=int(re.fullmatch(r'    count\(input\) == (\d+)',body[1]).group(1))
    attrs={};i=2
    while i<len(body)-1:
        line=body[i];match=re.fullmatch(r'    is_(boolean|number|string)\(input\[("(?:[^"\\]|\\.)*")\]\)',line)
        if not match:raise InputError('Unsupported type guard')
        typ,a=match.groups();a=json.loads(a);ref='input['+json.dumps(a)+']'
        if a in attrs:raise InputError('Duplicate attribute guard')
        if typ=='boolean':d={'type':'bool'};i+=1
        elif typ=='number':
            if body[i+1]!=f'    {ref} == floor({ref})':raise InputError('Missing integral guard')
            lo=int(body[i+2].removeprefix(f'    {ref} >= '));hi=int(body[i+3].removeprefix(f'    {ref} <= '))
            d={'type':'int','min':lo,'max':hi};i+=4
        else:
            prefix=f'    {ref} in {{'
            if not body[i+1].startswith(prefix) or not body[i+1].endswith('}'):raise InputError('Missing enum guard')
            values=json.loads('['+body[i+1][len(prefix):-1]+']');d={'type':'enum','values':values};i+=2
        attrs[a]=d
    if count!=len(attrs):raise InputError('Wrong exact-key-count guard')
    return attrs

def roundtrip(conditions,generated_wrapper,manifest):
    recovered=copy.deepcopy(manifest)
    try:recovered['attributes']=recover_attributes(generated_wrapper)
    except (IndexError,AttributeError,ValueError) as exc:raise InputError('Malformed generated validity guard') from exc
    # All other wrapper statements must match the reviewed scaffold. This checks
    # matched IDs/effects, decision combination, invalid behavior and allow.
    if generated_wrapper!=wrapper(recovered):raise InputError('Generated decision wrapper was changed')
    if recovered['attributes']!=manifest['attributes']:raise InputError('Executable domains differ from sidecar')
    return import_rego(conditions,recovered)

def semantic_projection(p):
    """All normalized supported fields, including resolution-contract metadata."""
    return normalize(copy.deepcopy(p))
