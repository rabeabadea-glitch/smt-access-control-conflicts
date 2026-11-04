"""QF_LIA compilation, total witness decoding and exhaustive pair verification."""
from __future__ import annotations
import itertools
import time
from .model import evaluate, governed, valid_request, conj, neg, atom
from .native_z3 import NativeZ3

class Verifier:
    def __init__(self,policy,timeout_ms=2000,resource_limit=0):
        self.p=policy; self.z=NativeZ3();self.timeout=timeout_ms;self.rlimit=resource_limit
        self.names={a:f'v{i}' for i,a in enumerate(policy['attributes'])}
    @staticmethod
    def numeral(x): return f'(- {-x})' if x<0 else str(x)
    def code(self,a,value):
        d=self.p['attributes'][a]
        if d['type']=='enum':return d['values'].index(value)
        return int(value)
    def expr(self,e):
        if type(e) is bool:return str(e).lower()
        op=e['op']
        if op in ('and','or'):return '('+op+' '+' '.join(self.expr(x) for x in e['args'])+')'
        if op=='not':return '(not '+self.expr(e['arg'])+')'
        ops={'eq':'=','ne':'distinct','lt':'<','le':'<=','gt':'>','ge':'>='}
        return f"({ops[op]} {self.names[e['attr']]} {self.numeral(self.code(e['attr'],e['value']))})"
    def smt(self,e):
        lines=['(set-logic QF_LIA)']
        for a,d in self.p['attributes'].items():
            v=self.names[a];lines.append(f'(declare-const {v} Int)')
            lo,hi=(d['min'],d['max']) if d['type']=='int' else (0,1 if d['type']=='bool' else len(d['values'])-1)
            lines.append(f'(assert (and (<= {self.numeral(lo)} {v}) (<= {v} {self.numeral(hi)})))')
        lines += [f"(assert {self.expr(self.p['validity'])})",f'(assert {self.expr(e)})']
        return '\n'.join(lines)
    def check(self,e):
        result=self.z.solve(self.smt(e),list(self.names.values()),timeout_ms=self.timeout,resource_limit=self.rlimit).to_dict()
        vals=result.pop('values');result['witness']=None
        if result['status']=='SAT':
            w={}
            for a,d in self.p['attributes'].items():
                v=vals[self.names[a]]
                w[a]=d['values'][v] if d['type']=='enum' else (bool(v) if d['type']=='bool' else v)
            if not valid_request(self.p,w) or not evaluate(e,w):
                result.update(status='ENCODING_ERROR',reason='Witness failed independent replay')
            else:result['witness']=w
        return result
    def pair(self,r,s):
        if r['effect']==s['effect'] or r['source']==s['source']:
            return {'status':'NOT_ELIGIBLE','pair':[r['id'],s['id']],'governed':False}
        ans=self.check(conj(r['condition'],s['condition']))
        ans.update(pair=[r['id'],s['id']],governed=governed(self.p,r,s))
        return ans

def eligible(p):
    return [(a,b) for a,b in itertools.combinations(p['rules'],2) if a['effect']!=b['effect'] and a['source']!=b['source']]

def equalities(e):
    # Necessary positive equalities only. Never infer through OR or NOT.
    if type(e) is bool:return {}
    if e['op']=='eq':return {e['attr']:{e['value']}}
    if e['op']=='and':
        out={}
        for child in e['args']:
            for a,vals in equalities(child).items():out.setdefault(a,set()).update(vals)
        return out
    return {}

def can_skip_exact(a,b):
    x=equalities(a['condition']);y=equalities(b['condition'])
    return any(len(v)>1 for v in list(x.values())+list(y.values())) or any(x[k]!=y[k] for k in x.keys()&y.keys())

def attr_mentions(e):
    if type(e) is bool:return set()
    if e['op'] in ('and','or'):return set().union(*(attr_mentions(x) for x in e['args']))
    if e['op']=='not':return attr_mentions(e['arg'])
    return {e['attr']}

def screen(p,mode='exhaustive'):
    if mode not in ('exhaustive','exact','heuristic'):raise ValueError('Unknown screening mode')
    kept=[];dropped=[]
    for a,b in eligible(p):
        drop=mode=='exact' and can_skip_exact(a,b)
        if mode=='heuristic':
            x=attr_mentions(a['condition']);y=attr_mentions(b['condition'])
            score=len(x&y)/max(1,len(x|y));drop=score<0.5
        (dropped if drop else kept).append((a,b))
    return kept,dropped

def audit(p,mode='exhaustive',timeout_ms=2000,resource_limit=0):
    t=time.perf_counter(); v=Verifier(p,timeout_ms,resource_limit)
    validity=v.check(True)
    kept,dropped=screen(p,mode)
    rows=[v.pair(a,b) for a,b in kept]
    statuses=[r['status'] for r in rows]
    if validity['status']!='SAT':label='INVALID_OR_UNRESOLVED_REQUEST_SPACE'
    elif any(s not in ('SAT','UNSAT') for s in statuses):label='UNRESOLVED'
    elif 'SAT' in statuses:label='CONFLICTS_PRESENT'
    elif mode=='exhaustive':label='CROSS_SOURCE_CONFLICT_FREE_WITHIN_SCOPE'
    else:label='NO_CONFLICT_DETECTED_BY_SCREENING'
    return {'label':label,'screening':mode,'validity':validity,'eligible_pairs':len(kept)+len(dropped),
            'checked_pairs':len(kept),'discarded_pairs':[[a['id'],b['id']] for a,b in dropped],
            'results':rows,'elapsed_ms':(time.perf_counter()-t)*1000}
