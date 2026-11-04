"""Compile validated CPM into a standalone Python policy, not an AST interpreter.
This target is a research execution format, not XACML, Rego, or a production PDP.
"""
from __future__ import annotations
import importlib.util
import json
import pathlib
from .model import fingerprint, requests, decision

def expression(e):
    if type(e) is bool:return repr(e)
    if e['op'] in ('and','or'):
        return '('+(' '+e['op']+' ').join(expression(x) for x in e['args'])+')'
    if e['op']=='not':return '(not '+expression(e['arg'])+')'
    op={'eq':'==','ne':'!=','lt':'<','le':'<=','gt':'>','ge':'>='}[e['op']]
    return f"(r[{e['attr']!r}] {op} {e['value']!r})"

def generate(p):
    lines=['"""Generated research policy. Do not edit; regenerate from the CPM input."""',
           'import json','import sys',f"POLICY_SHA256 = {fingerprint(p)!r}",'',
           'def decide(r):',f"    if not isinstance(r, dict) or set(r) != set({list(p['attributes'])!r}):",
           "        return {'decision': 'InvalidRequest', 'matched': [], 'allow': False}"]
    for a,d in p['attributes'].items():
        x=f'r[{a!r}]'
        if d['type']=='bool':check=f'type({x}) is bool'
        elif d['type']=='int':check=f'type({x}) is int and {d["min"]} <= {x} <= {d["max"]}'
        else:check=f'type({x}) is str and {x} in {d["values"]!r}'
        lines += [f'    if not ({check}):',"        return {'decision': 'InvalidRequest', 'matched': [], 'allow': False}"]
    lines += [f'    if not {expression(p["validity"])}:',
              "        return {'decision': 'InvalidRequest', 'matched': [], 'allow': False}",
              '    matched = []','    effects = set()']
    for r in p['rules']:
        lines += [f'    if {expression(r["condition"])}:',f'        matched.append({r["id"]!r})',f'        effects.add({r["effect"]!r})']
    lines += ["    d = 'Conflict' if len(effects) == 2 else next(iter(effects), 'NotApplicable')",
              "    return {'decision': d, 'matched': sorted(matched), 'allow': d == 'Permit'}",'',
              "if __name__ == '__main__':",
              "    try:","        print(json.dumps(decide(json.load(sys.stdin)), sort_keys=True))",
              "    except (ValueError, TypeError) as exc:",
              "        print(json.dumps({'error': str(exc)})); sys.exit(2)"]
    return '\n'.join(lines)+'\n'

def load_generated(path):
    spec=importlib.util.spec_from_file_location('generated_policy',path)
    module=importlib.util.module_from_spec(spec);spec.loader.exec_module(module)
    return module

def replay(p,path,limit=200000):
    m=load_generated(path);count=0;mismatches=[]
    for r in requests(p,limit):
        a=decision(p,r);b=m.decide(r);count+=1
        if a!=b:mismatches.append({'request':r,'reference':a,'generated':b})
    first=next(requests(p,limit),None)
    invalid=[{},None]
    if first is not None: invalid.append({**first,'extra':'invalid'})
    for r in invalid:
        a=decision(p,r);b=m.decide(r)
        if a!=b:mismatches.append({'request':r,'reference':a,'generated':b})
    return {'status':'EMPTY_VALID_REQUEST_SPACE' if count==0 else 'COMPLETED',
            'valid_requests_checked':count,'invalid_requests_checked':len(invalid),
            'mismatches':mismatches,'passed':count>0 and not mismatches}
