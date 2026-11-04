from pathlib import Path
import copy,datetime,hashlib,itertools,json,os,platform,random,sys,time
from unittest.mock import patch

WORK=Path(__file__).resolve().parents[1];DEV=WORK.parent
sys.dont_write_bytecode=True;sys.path.insert(0,str(WORK/'src'))
_dll=os.add_dll_directory(str(DEV/'Audit/runtime_z3'))
os.environ['Z3_LIBRARY']=str(DEV/'Audit/runtime_z3/libz3.dll')
from pcproof.model import normalize,fingerprint
from pcproof.native_z3 import NativeZ3
from research.workflow import refine_bounded,apply_precedence

OUT=WORK/'results/workflow';OUT.mkdir(exist_ok=True,parents=True)
RNG=random.Random(20261019)
RESUME='--resume' in sys.argv

def save(rel,obj):
    p=OUT/rel;p.parent.mkdir(exist_ok=True,parents=True)
    p.write_text(json.dumps(obj,ensure_ascii=False,indent=2),encoding='utf-8')

def atom(a,value,op='eq'):return {'op':op,'attr':a,'value':value}
def AND(*args):return {'op':'and','args':list(args)}
def OR(*args):return {'op':'or','args':list(args)} if args else False
def NOT(arg):return {'op':'not','arg':arg}
def source():return {'kind':'synthetic','citation':'Constructed formal experiment 2026-10-19','mapping_status':'Authored finite test, not a regulatory mapping'}
def rule(id,sourceid,effect,condition):return {'id':id,'source':sourceid,'effect':effect,'condition':condition}

def fixture(n,shuffle=False):
    vals=list(range(2*n+1))
    if shuffle:RNG.shuffle(vals)
    rules=[];choices=[];deny=[]
    for i in range(n):
        left,right=vals[2*i:2*i+2]
        rules.extend([rule(f'P{i}','permit','Permit',AND(atom('requested',True),OR(atom('item',left),atom('item',right)))),
                      rule(f'D{i}','deny','Deny',AND(atom('requested',True),atom('item',right)))])
        choices.append({'winner':f'D{i}','loser':f'P{i}'})
        deny.append(atom('item',right))
    safe=vals[-1];rules.append(rule('SAFE','permit','Permit',AND(atom('requested',True),atom('item',safe))))
    if shuffle:RNG.shuffle(rules)
    p=normalize({'schema_version':'cpm-1','attributes':{'item':{'type':'int','min':0,'max':2*n},'requested':{'type':'bool'}},
       'sources':{'permit':source(),'deny':source()},'rules':rules,
       'invariants':[{'id':'required-denials','when':AND(atom('requested',True),OR(*deny)),'required':'Deny'},
                     {'id':'required-access','when':AND(atom('requested',True),atom('item',safe)),'required':'Permit'}]})
    return p,choices,{'denied_items':vals[1:2*n:2],'safe_item':safe,'conflicts':n}

def approval(p,choices):return {'approval_id':'SYNTHETIC_TEST_ONLY_NO_ORGANIZATIONAL_AUTHORITY','policy_sha256':fingerprint(p),'operation':'bounded_refinement','choices':choices}

# A separate ordinary expression evaluator supplies finite expected behavior.
def ev(e,r):
    if type(e) is bool:return e
    op=e['op']
    if op=='not':return not ev(e['arg'],r)
    if op=='and':return all(ev(x,r) for x in e['args'])
    if op=='or':return any(ev(x,r) for x in e['args'])
    x,y=r[e['attr']],e['value']
    if op=='eq':return x==y
    if op=='ne':return x!=y
    if op=='lt':return x<y
    if op=='le':return x<=y
    if op=='gt':return x>y
    if op=='ge':return x>=y
    raise AssertionError(op)

def reqs(p):
    ds=[]
    for d in p['attributes'].values():
        ds.append([False,True] if d['type']=='bool' else range(d['min'],d['max']+1) if d['type']=='int' else d['values'])
    return [dict(zip(p['attributes'],vs)) for vs in itertools.product(*ds) if ev(p['validity'],dict(zip(p['attributes'],vs)))]

def outcome(p,r):
    matched=[x for x in p['rules'] if ev(x['condition'],r)]
    effects={x['effect'] for x in matched}
    return {'decision':'Conflict' if len(effects)>1 else next(iter(effects),'NotApplicable'),'matched':sorted(x['id'] for x in matched)}

def contracts_hold(p,r):
    actual=outcome(p,r)['decision']
    return all(not ev(inv['when'],r) or actual==inv['required'] for inv in p['invariants'])

def run_case(name,p,a,expected,max_iterations=20,expected_reason=None,injection=None):
    cached=OUT/f'cases/{name}.json'
    if RESUME and cached.exists():
        record=json.loads(cached.read_text(encoding='utf-8'));res=record['result']
        assert record['input']==p and record['approval']==a,(name,'resume input changed')
        assert res['status']==expected and (not expected_reason or res['reason']==expected_reason)
        assert record['input_unchanged']
        return {'name':name,'status':res['status'],'reason':res['reason'],'steps':res['tentative_steps'],
                'independent_request_checks':len(record['independent_requests']),'injection':injection,'input_unchanged':True}
    before=copy.deepcopy(p);started=time.perf_counter()
    if injection=='identity-proposal':
        with patch('research.workflow.conj',side_effect=lambda *xs:xs[0]):res=refine_bounded(p,a,max_iterations)
    elif injection=='unresolved-scan':
        with patch('research.workflow.audit',return_value={'label':'UNRESOLVED','results':[{'status':'UNKNOWN'}]}):res=refine_bounded(p,a,max_iterations)
    else:res=refine_bounded(p,a,max_iterations)
    assert p==before,(name,'input mutated')
    assert res['status']==expected,(name,res['status'],res.get('reason'))
    if expected_reason:assert res['reason']==expected_reason,(name,res['reason'])
    checks=[]
    if res['committed']:
        for r in reqs(p):
            assert contracts_hold(res['policy'],r),(name,'contract',r)
            checks.append({'request':r,'before':outcome(p,r),'after':outcome(res['policy'],r),'contracts_hold':True})
        save(f'accepted_models/{name}.json',res['policy'])
    record={'name':name,'expected':expected,'expectation_origin':'Authored case before execution',
            'injection':injection,'elapsed_ms':(time.perf_counter()-started)*1000,'input_unchanged':p==before,
            'input':p,'approval':a,'result':res,'independent_requests':checks}
    save(f'cases/{name}.json',record)
    return {'name':name,'status':res['status'],'reason':res['reason'],'steps':res['tentative_steps'],
            'independent_request_checks':len(checks),'injection':injection,'input_unchanged':True}

environment={'date_local':'2026-10-19','timestamp_utc':datetime.datetime.now(datetime.timezone.utc).isoformat(),
     'python':sys.version,'platform':platform.platform(),'z3':NativeZ3().version,'timeout_ms':2000,'resource_limit':0,
     'seed':20261019,'protocol_sha256':hashlib.sha256((WORK/'protocols/workflow_protocol.json').read_bytes()).hexdigest(),
     'workflow_sha256':hashlib.sha256((WORK/'src/research/workflow.py').read_bytes()).hexdigest()}
if RESUME and (OUT/'environment.json').exists():
    old=json.loads((OUT/'environment.json').read_text())
    for key in ['z3','seed','protocol_sha256','workflow_sha256']:assert environment[key]==old[key],('Cannot resume changed experiment',key)
    save('resume_environment.json',environment)
else:save('environment.json',environment)

summaries=[]
p,choices,_=fixture(2);a=approval(p,choices)
summaries.append(run_case('two-conflicts',p,a,'ACCEPTED'))
summaries.append(run_case('one-step-limit',p,a,'REJECTED',1,'ITERATION_LIMIT_REACHED'))
stale=copy.deepcopy(a);stale['policy_sha256']='not-the-input-hash'
summaries.append(run_case('stale-approval',p,stale,'REJECTED',expected_reason='STALE_OR_WRONG_POLICY_HASH'))
missing=approval(p,choices[:1])
summaries.append(run_case('missing-direction',p,missing,'REJECTED',expected_reason='NO_AUTHORIZED_DIRECTION_FOR_REMAINING_CONFLICTS'))
summaries.append(run_case('repeated-state-injected-identity',p,a,'REJECTED',expected_reason='REPEATED_STATE',injection='identity-proposal'))
summaries.append(run_case('unresolved-scan-injected-control',p,a,'REJECTED',expected_reason='UNRESOLVED_OR_INVALID_REQUEST_SPACE',injection='unresolved-scan'))

# A wrong winner leaves a real denial-only region, so nonempty-loser alone cannot reject it.
p,choices,_=fixture(1)
p['attributes']['item']['max']=3
p['rules'][1]['condition']=AND(atom('requested',True),OR(atom('item',1),atom('item',2)))
p['rules'][2]['condition']=AND(atom('requested',True),atom('item',3))
p['invariants'][0]['when']=AND(atom('requested',True),OR(atom('item',1),atom('item',2)))
p['invariants'][1]['when']=AND(atom('requested',True),OR(atom('item',0),atom('item',3)))
p=normalize(p)
summaries.append(run_case('protected-wrong-winner',p,approval(p,[{'winner':'P0','loser':'D0'}]),'REJECTED',expected_reason='FINAL_CONTRACT_VIOLATION_OR_UNRESOLVED'))
summaries.append(run_case('protected-right-winner',p,approval(p,choices),'ACCEPTED'))
incompatible=copy.deepcopy(p);incompatible['invariants'].append({'id':'incompatible-deny','when':AND(atom('requested',True),atom('item',0)),'required':'Deny'})
summaries.append(run_case('incompatible-contracts',incompatible,approval(incompatible,choices),'REJECTED',expected_reason='FINAL_CONTRACT_VIOLATION_OR_UNRESOLVED'))

depth,dc,_=fixture(1);expr=atom('item',0,'ge')
for _ in range(40):expr=NOT(expr)
depth['rules'][0]['condition']=expr;depth=normalize(depth)
summaries.append(run_case('unsupported-deep-candidate',depth,approval(depth,dc),'REJECTED',expected_reason='CANDIDATE_OUTSIDE_SUPPORTED_FRAGMENT'))

# Certification deliberately concerns cross-source pairs, not same-source ambiguity.
same,sc,_=fixture(1)
same['rules'].extend([rule('same-P','permit','Permit',AND(atom('requested',False),atom('item',0))),
                     rule('same-D','permit','Deny',AND(atom('requested',False),atom('item',0)))])
same=normalize(same)
summaries.append(run_case('same-source-residual',same,approval(same,sc),'ACCEPTED'))

generated=[]
for index in range(120):
    n=index%6+1;p,ch,expect=fixture(n,True)
    s=run_case(f'generated-{index:03}',p,approval(p,ch),'ACCEPTED',max_iterations=6)
    assert s['steps']==n
    output=json.loads((OUT/f'accepted_models/generated-{index:03}.json').read_text())
    for r in reqs(p):
        expected='NotApplicable' if not r['requested'] else 'Deny' if r['item'] in expect['denied_items'] else 'Permit'
        assert outcome(output,r)['decision']==expected,(index,r,expected)
    generated.append({**s,'design':expect})
    if index%20==0:print('repair cases',index+1,flush=True)

# Independent source-priority evaluator does not call the compilation algorithm.
def priority_expected(p,r):
    active=[x for x in p['rules'] if ev(x['condition'],r)]
    direct={(e['higher'],e['lower']) for e in p['precedence']}
    def higher(a,b):
        seen=set();todo=[a]
        while todo:
            x=todo.pop()
            for left,right in direct:
                if left==x:
                    if right==b:return True
                    if right not in seen:seen.add(right);todo.append(right)
        return False
    keep=[x for x in active if not any(higher(y['source'],x['source']) for y in active)]
    effects={x['effect'] for x in keep}
    return {'decision':'Conflict' if len(effects)>1 else next(iter(effects),'NotApplicable'),'matched':sorted(x['id'] for x in keep)}

priority=[]
for index in range(120):
    count=3+index%4;srcs=[f'S{i}' for i in range(count)]
    edges=[{'higher':srcs[i],'lower':srcs[j],'approval_id':'SYNTHETIC_TEST_ONLY'} for i in range(count) for j in range(i+1,count) if RNG.random()<.45]
    if not edges:edges=[{'higher':srcs[0],'lower':srcs[-1],'approval_id':'SYNTHETIC_TEST_ONLY'}]
    rules=[]
    for i,s in enumerate(srcs):
        for j in range(2):
            lo=RNG.randrange(0,5);hi=RNG.randrange(lo,6)
            rules.append(rule(f'{s}r{j}',s,RNG.choice(['Permit','Deny']),AND(atom('requested',True),atom('item',lo,'ge'),atom('item',hi,'le'))))
    p=normalize({'schema_version':'cpm-1','attributes':{'item':{'type':'int','min':0,'max':5},'requested':{'type':'bool'}},'sources':{s:source() for s in srcs},'rules':rules,'precedence':edges})
    ap={'approval_id':'SYNTHETIC_TEST_ONLY_NO_ORGANIZATIONAL_AUTHORITY','policy_sha256':fingerprint(p),'operation':'apply_precedence','edges':edges}
    before=copy.deepcopy(p);res=apply_precedence(p,ap);assert p==before;assert res['committed']
    rows=[]
    for r in reqs(p):
        expected=priority_expected(p,r);actual=outcome(res['policy'],r)
        assert actual==expected,(index,r,actual,expected)
        rows.append({'request':r,'expected':expected,'actual':actual})
    save(f'precedence/priority-{index:03}.json',{'input':p,'approval':ap,'result':res,'independent_checks':rows})
    if index<6:save(f'accepted_models/priority-{index:03}.json',res['policy'])
    priority.append({'case':index,'requests':len(rows),'disagreements':0,'final_scoped_label':res['final_scoped_label']})

summary={'primary_cases':summaries,'generated_repair_cases':len(generated),'generated_repair_accepted':sum(s['status']=='ACCEPTED' for s in generated),
         'generated_repair_steps':sum(s['steps'] for s in generated),'generated_repair_independent_requests':sum(s['independent_request_checks'] for s in generated),
         'generated_precedence_cases':len(priority),'precedence_independent_requests':sum(s['requests'] for s in priority),'precedence_disagreements':0,
         'precedence_remaining_conflicts':sum(s['final_scoped_label']=='CONFLICTS_PRESENT' for s in priority),
         'human_approvals':0,'scope':'Synthetic formal mechanisms only; not natural/regulatory repair effectiveness',
         'branch_injections':'Two primary cases deliberately inject a no-op proposal or unresolved scan; these are control tests, not naturally observed solver results',
         'generated_rows':generated,'precedence_rows':priority}
save('summary.json',summary)
print(json.dumps({k:v for k,v in summary.items() if k not in ['generated_rows','precedence_rows']},indent=2),flush=True)
