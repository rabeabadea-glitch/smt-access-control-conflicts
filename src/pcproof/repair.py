"""Transactional, hash-bound condition refinement. Approval is externally trusted.
DEMO approvals are fixtures, not real organizational or legal authorization.
"""
from __future__ import annotations
import copy
import time
from .model import normalize, fingerprint, conj, neg, disj, decision, requests, require, InputError
from .verify import Verifier, audit

def invariant_checks(p,timeout_ms=2000):
    v=Verifier(p,timeout_ms);out=[]
    for inv in p['invariants']:
        yes=disj(*(r['condition'] for r in p['rules'] if r['effect']==inv['required']))
        no=disj(*(r['condition'] for r in p['rules'] if r['effect']!=inv['required']))
        nonvacuous=v.check(inv['when'])
        violation=v.check(conj(inv['when'],disj(neg(yes),no)))
        out.append({'id':inv['id'],'nonvacuous':nonvacuous,'violation':violation,
                    'passed':nonvacuous['status']=='SAT' and violation['status']=='UNSAT'})
    return out

def refine(p,approval,timeout_ms=2000):
    started=time.perf_counter(); result={'status':'REJECTED','committed':False,'checks':{}}
    def finish(reason,policy=None):
        result['reason']=reason;result['elapsed_ms']=(time.perf_counter()-started)*1000
        if policy is not None:result['policy']=policy
        return result
    expected={'approval_id','policy_sha256','loser','winner','operation'}
    if not isinstance(approval,dict) or set(approval)!=expected:return finish('INVALID_AUTHORIZATION_RECORD')
    if not all(isinstance(v,str) and v for v in approval.values()) or approval['operation']!='exclude_winner_region':return finish('UNAUTHORIZED_OPERATION')
    if approval['policy_sha256']!=fingerprint(p):return finish('STALE_OR_WRONG_POLICY_HASH')
    ids={r['id']:r for r in p['rules']}
    if approval['loser'] not in ids or approval['winner'] not in ids:return finish('UNKNOWN_RULE')
    loser=ids[approval['loser']];winner=ids[approval['winner']]
    v=Verifier(p,timeout_ms); pre=v.pair(loser,winner);result['checks']['pre']=pre
    if pre['status']!='SAT':return finish('NO_CONFIRMED_CROSS_SOURCE_CONFLICT')
    if not p['invariants']:return finish('SAFETY_CONTRACT_REQUIRED')
    required={x['required'] for x in p['invariants']}
    if required!={'Permit','Deny'}:return finish('BOTH_RESTRICTION_AND_ACCESS_CONTRACTS_REQUIRED')
    candidate=copy.deepcopy(p); edited=next(r for r in candidate['rules'] if r['id']==loser['id'])
    edited['condition']=conj(loser['condition'],neg(winner['condition']))
    try:
        candidate=normalize(candidate)
    except InputError as exc:
        result['candidate_error']=str(exc)
        return finish('CANDIDATE_OUTSIDE_SUPPORTED_FRAGMENT')
    postv=Verifier(candidate,timeout_ms)
    alive=postv.check(edited['condition']);result['checks']['loser_nonempty']=alive
    if alive['status']!='SAT':return finish('REPAIR_REMOVES_ALL_LOSER_BEHAVIOR_OR_UNRESOLVED')
    local=v.check(conj(loser['condition'],neg(edited['condition']),neg(winner['condition'])))
    result['checks']['outside_overlap_removed']=local
    if local['status']!='UNSAT':return finish('NONLOCAL_OR_UNRESOLVED_REPAIR')
    after=postv.pair(edited,winner);result['checks']['pair_after']=after
    if after['status']!='UNSAT':return finish('PAIR_NOT_RESOLVED')
    invariants=invariant_checks(candidate,timeout_ms);result['checks']['invariants']=invariants
    if not all(x['passed'] for x in invariants):return finish('INVARIANT_VIOLATION_OR_UNRESOLVED')
    final=audit(candidate,'exhaustive',timeout_ms);result['checks']['final']=final
    if final['label']!='CROSS_SOURCE_CONFLICT_FREE_WITHIN_SCOPE':return finish('FINAL_CERTIFICATION_FAILED')
    # Only a fully checked result is emitted; the original input is not mutated.
    result.update(status='ACCEPTED',committed=True,approval_id=approval['approval_id'],
                  before_sha256=fingerprint(p),after_sha256=fingerprint(candidate))
    return finish('SAFETY_CONTRACTS_AND_EXHAUSTIVE_CHECK_PASSED',candidate)
