from pathlib import Path
import copy,hashlib,itertools,json,os,random,sys
W=Path(__file__).resolve().parents[1];D=W.parent;sys.path.insert(0,str(W/'src'));sys.dont_write_bytecode=True
handle=os.add_dll_directory(str(D/'Audit/runtime_z3'));os.environ['Z3_LIBRARY']=str(D/'Audit/runtime_z3/libz3.dll')
from pcproof.model import normalize,fingerprint
from research.workflow import refine_bounded
O=W/'results/workflow_second_family';O.mkdir(exist_ok=True,parents=True)
rng=random.Random(20261020)
def save(name,x):(O/name).write_text(json.dumps(x,indent=2),encoding='utf-8')
def a(v,op='eq'):return {'op':op,'attr':'item','value':v}
def A(*xs):return {'op':'and','args':list(xs)}
def B(*xs):return {'op':'or','args':list(xs)}
def req(e):return A({'op':'eq','attr':'requested','value':True},e)
def src():return {'kind':'synthetic','citation':'Second-family constructed experiment','mapping_status':'Not independently human reviewed'}
def rule(id,s,e,c):return {'id':id,'source':s,'effect':e,'condition':c}
def auth(p,ch):return {'approval_id':'SYNTHETIC_ONLY_NO_REAL_AUTHORITY','policy_sha256':fingerprint(p),'operation':'bounded_refinement','choices':ch}
def ev(e,r):
 if type(e) is bool:return e
 op=e['op']
 if op=='and':return all(ev(v,r) for v in e['args'])
 if op=='or':return any(ev(v,r) for v in e['args'])
 if op=='not':return not ev(e['arg'],r)
 x,y=r[e['attr']],e['value']
 if op=='eq':return x==y
 if op=='ne':return x!=y
 if op=='ge':return x>=y
 if op=='le':return x<=y
 raise AssertionError(op)
def out(p,r):
 es={x['effect'] for x in p['rules'] if ev(x['condition'],r)}
 return 'Conflict' if len(es)>1 else next(iter(es),'NotApplicable')
def run(name,p,ch,expected):
 p=normalize(p);before=copy.deepcopy(p);result=refine_bounded(p,auth(p,ch),max_iterations=6)
 assert result['status']=='ACCEPTED',(name,result['reason']);assert p==before
 rows=[]
 for i in range(p['attributes']['item']['max']+1):
  for requested in [False,True]:
   r={'item':i,'requested':requested};actual=out(result['policy'],r);assert actual==expected(r),(name,r,actual,expected(r))
   for inv in p['invariants']:assert not ev(inv['when'],r) or actual==inv['required']
   rows.append({'request':r,'before':out(p,r),'after':actual})
 save(name+'.json',{'input':p,'approval':auth(p,ch),'result':result,'independent_requests':rows,'input_unchanged':True})
 return {'case':name,'steps':result['tentative_steps'],'requests':len(rows),'mismatches':0}
records=[]
for index in range(60):
 n=index%6+1;values=list(range(2*n+1));rng.shuffle(values);rules=[];choices=[];permit=[]
 for i in range(n):
  left,right=values[2*i:2*i+2]
  rules.extend([rule(f'D{i}','denials','Deny',req(B(a(left),a(right)))),rule(f'P{i}','permissions','Permit',req(a(right)))])
  choices.append({'winner':f'P{i}','loser':f'D{i}'});permit.append(right)
 safe=values[-1];rules.append(rule('SAFE_DENY','denials','Deny',req(a(safe))));rng.shuffle(rules)
 p={'schema_version':'cpm-1','attributes':{'item':{'type':'int','min':0,'max':2*n},'requested':{'type':'bool'}},'sources':{'denials':src(),'permissions':src()},'rules':rules,
  'invariants':[{'id':'must-permit','required':'Permit','when':req(B(*(a(v) for v in permit)))},{'id':'must-deny','required':'Deny','when':req(a(safe))}]}
 records.append(run(f'deny-loser-{index:03}',p,choices,lambda r,permit=permit:'NotApplicable' if not r['requested'] else 'Permit' if r['item'] in permit else 'Deny'))
 print('losing-Deny cases',index+1,flush=True)
p={'schema_version':'cpm-1','attributes':{'item':{'type':'int','min':0,'max':4},'requested':{'type':'bool'}},'sources':{s:src() for s in ['P','D1','D2']},
 'rules':[rule('P','P','Permit',req(A(a(0,'ge'),a(3,'le')))),rule('D1','D1','Deny',req(A(a(1,'ge'),a(2,'le')))),rule('D2','D2','Deny',req(A(a(2,'ge'),a(3,'le'))))],
 'invariants':[{'id':'access','required':'Permit','when':req(a(0))},{'id':'restriction','required':'Deny','when':req(A(a(1,'ge'),a(3,'le')))}]}
interacting=run('interacting-overlaps',p,[{'winner':'D1','loser':'P'},{'winner':'D2','loser':'P'}],lambda r:'NotApplicable' if not r['requested'] or r['item']==4 else 'Permit' if r['item']==0 else 'Deny')
assert interacting['steps']==2

# The supplied contracts protect items0 and3 only. The overlap at1 is unprotected.
# Acceptance is expected but must not be described as preservation of every restriction.
p={'schema_version':'cpm-1','attributes':{'item':{'type':'int','min':0,'max':3},'requested':{'type':'bool'}},'sources':{s:src() for s in ['P','D']},
 'rules':[rule('P','P','Permit',req(B(a(0),a(1)))),rule('D','D','Deny',req(B(a(1),a(2),a(3))))],
 'invariants':[{'id':'access-0','required':'Permit','when':req(a(0))},{'id':'restriction-3','required':'Deny','when':req(a(3))}]}
incomplete=run('incomplete-contract-access-expansion',p,[{'winner':'P','loser':'D'}],lambda r:'NotApplicable' if not r['requested'] else 'Permit' if r['item'] in [0,1] else 'Deny')
summary={'date':'2026-10-19','seed':20261020,'losing_deny_policies':60,'losing_deny_steps':sum(r['steps'] for r in records),'losing_deny_request_checks':sum(r['requests'] for r in records),
 'interacting_case':interacting,'incomplete_contract_counterexample':incomplete,'human_approvals':0,'disagreements_with_declared_expected_behavior':0,
 'limitation':'The counterexample changes Conflict (allow=false) to Permit (allow=true) at an unprotected request while all supplied contracts pass. Do not call contract acceptance general safety.',
 'protocol_sha256':hashlib.sha256((W/'protocols/workflow_second_family_addendum.json').read_bytes()).hexdigest()}
save('summary.json',summary);print(json.dumps(summary,indent=2),flush=True)
