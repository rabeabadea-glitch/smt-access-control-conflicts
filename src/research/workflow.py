"""Explicitly authorized research transactions; approval records are not identities.

This extension does not change the preserved one-step PCProof repair operator.
Intermediate loop candidates are tentative. Only a fully checked final state is
returned as committed. The caller remains responsible for the completeness and
real authority of its source interpretations, approvals, and requirements.
"""
from __future__ import annotations
import copy
from pcproof.model import normalize, fingerprint, conj, neg, disj, transitive, InputError
from pcproof.verify import Verifier, audit
from pcproof.repair import invariant_checks


def _approval_ok(record, p, operation, extras=()):
    fields={'approval_id','policy_sha256','operation',*extras}
    if not isinstance(record,dict) or set(record)!=fields:return 'INVALID_AUTHORIZATION_RECORD'
    if not all(type(record[k]) is str and record[k] for k in ['approval_id','policy_sha256','operation']):return 'INVALID_AUTHORIZATION_RECORD'
    if record['operation']!=operation:return 'UNAUTHORIZED_OPERATION'
    if record['policy_sha256']!=fingerprint(p):return 'STALE_OR_WRONG_POLICY_HASH'
    return None


def _violation(p, inv):
    yes=disj(*(r['condition'] for r in p['rules'] if r['effect']==inv['required']))
    no=disj(*(r['condition'] for r in p['rules'] if r['effect']!=inv['required']))
    return conj(inv['when'],disj(neg(yes),no))


def _diagnostic_overlap(p, timeout_ms):
    permit=disj(*(r['condition'] for r in p['rules'] if r['effect']=='Permit'))
    deny=disj(*(r['condition'] for r in p['rules'] if r['effect']=='Deny'))
    return Verifier(p,timeout_ms).check(conj(permit,deny))


def apply_precedence(raw, approval, timeout_ms=2000):
    """Compile maximal-active-source semantics for an approved acyclic order.

    A rule is suppressed whenever any original rule in a higher source applies.
    Comparability is determined by the transitive closure. Incomparable sources
    remain jointly active. This is a declared CPM priority profile; no claim of
    arbitrary XACML combining semantics or legally inferred priority is made.
    """
    p=normalize(raw)
    result={'status':'REJECTED','committed':False,'operation':'apply_precedence',
            'before_sha256':fingerprint(p),'checks':{}}
    def stop(reason):result['reason']=reason;return result
    error=_approval_ok(approval,p,'apply_precedence',('edges',))
    if error:return stop(error)
    if not isinstance(approval['edges'],list) or approval['edges']!=p['precedence']:return stop('ORDER_NOT_EXPLICITLY_AUTHORIZED')
    if not p['precedence']:return stop('EMPTY_SOURCE_ORDER')
    closure=transitive((e['higher'],e['lower']) for e in p['precedence'])
    candidate=copy.deepcopy(p)
    for r in candidate['rules']:
        higher=[s['condition'] for s in p['rules'] if (s['source'],r['source']) in closure]
        if higher:r['condition']=conj(r['condition'],neg(disj(*higher)))
    try:candidate=normalize(candidate)
    except InputError as exc:
        result['candidate_error']=str(exc);return stop('CANDIDATE_OUTSIDE_SUPPORTED_FRAGMENT')
    # Every transformed rule is a narrowing; explicit SMT checks guard compilation.
    locality=[]
    for old,new in zip(p['rules'],candidate['rules']):
        check=Verifier(p,timeout_ms).check(conj(new['condition'],neg(old['condition'])))
        locality.append({'rule':old['id'],'new_applicability_outside_original':check})
        if check['status']!='UNSAT':
            result['checks']['narrowing']=locality;return stop('NON_NARROWING_OR_UNRESOLVED_COMPILATION')
    result['checks']['narrowing']=locality
    final=audit(candidate,'exhaustive',timeout_ms)
    result['checks']['final']=final
    # A partial order can legitimately leave incomparable-source conflicts.
    # Commit the authorized priority transformation, but do not certify them away.
    if final['label'] in ('INVALID_OR_UNRESOLVED_REQUEST_SPACE','UNRESOLVED'):return stop('UNRESOLVED_FINAL_CHECK')
    result.update(status='APPLIED',committed=True,reason='AUTHORIZED_ORDER_COMPILED',
                  approval_id=approval['approval_id'],after_sha256=fingerprint(candidate),policy=candidate,
                  final_scoped_label=final['label'],diagnostic_overlap=_diagnostic_overlap(candidate,timeout_ms))
    return result


def refine_bounded(raw, approval, max_iterations=20, timeout_ms=2000):
    """Tentative bounded sequence of local refinements followed by atomic commit.

    The approval fixes the initial normalized policy and the allowed winner/loser
    directions. Every candidate narrows one loser. The contract-violation region
    must not expand at any step; all declared contracts must hold at final commit.
    A version-bound fixture approval is not evidence of real governance authority.
    """
    p=normalize(raw)
    result={'status':'REJECTED','committed':False,'operation':'bounded_refinement',
            'before_sha256':fingerprint(p),'iterations':[],'checks':{}}
    def stop(reason):
        result['reason']=reason;result['tentative_steps']=len(result['iterations']);return result
    if type(max_iterations) is not int or not 1<=max_iterations<=1000:return stop('INVALID_ITERATION_LIMIT')
    error=_approval_ok(approval,p,'bounded_refinement',('choices',))
    if error:return stop(error)
    if not isinstance(approval['choices'],list):return stop('INVALID_AUTHORIZED_CHOICES')
    ids={r['id']:r for r in p['rules']};choices={}
    for choice in approval['choices']:
        if not isinstance(choice,dict) or set(choice)!={'winner','loser'}:return stop('INVALID_AUTHORIZED_CHOICES')
        if not all(type(v) is str and v in ids for v in choice.values()):return stop('UNKNOWN_RULE')
        w,l=ids[choice['winner']],ids[choice['loser']]
        if w['effect']==l['effect'] or w['source']==l['source']:return stop('INELIGIBLE_AUTHORIZED_PAIR')
        key=frozenset(choice.values())
        if key in choices:return stop('DUPLICATE_AUTHORIZED_PAIR')
        choices[key]=choice
    if not p['invariants'] or {i['required'] for i in p['invariants']}!={'Permit','Deny'}:return stop('BOTH_RESTRICTION_AND_ACCESS_CONTRACTS_REQUIRED')
    v=Verifier(p,timeout_ms)
    reachable=[{'id':i['id'],'query':v.check(i['when'])} for i in p['invariants']]
    result['checks']['contract_antecedents']=reachable
    if any(x['query']['status']!='SAT' for x in reachable):return stop('UNREACHABLE_OR_UNRESOLVED_CONTRACT')
    current=copy.deepcopy(p);seen={fingerprint(current)}
    for step_no in range(max_iterations+1):
        scan=audit(current,'exhaustive',timeout_ms)
        if scan['label'] in ('INVALID_OR_UNRESOLVED_REQUEST_SPACE','UNRESOLVED'):
            result['checks']['last_scan']=scan;return stop('UNRESOLVED_OR_INVALID_REQUEST_SPACE')
        positive=[r for r in scan['results'] if r['status']=='SAT']
        if not positive:
            contracts=invariant_checks(current,timeout_ms)
            result['checks'].update(final=scan,contracts=contracts,diagnostic_overlap=_diagnostic_overlap(current,timeout_ms))
            if not all(c['passed'] for c in contracts):return stop('FINAL_CONTRACT_VIOLATION_OR_UNRESOLVED')
            if scan['label']!='CROSS_SOURCE_CONFLICT_FREE_WITHIN_SCOPE':return stop('FINAL_CERTIFICATION_FAILED')
            result.update(status='ACCEPTED',committed=True,reason='BOUNDED_TRANSACTION_AND_EXHAUSTIVE_CHECK_PASSED',
                          approval_id=approval['approval_id'],after_sha256=fingerprint(current),policy=current,
                          tentative_steps=len(result['iterations']))
            return result
        if step_no==max_iterations:
            result['checks']['last_scan']=scan;return stop('ITERATION_LIMIT_REACHED')
        found=next((r for r in positive if frozenset(r['pair']) in choices),None)
        if found is None:
            result['checks']['last_scan']=scan;return stop('NO_AUTHORIZED_DIRECTION_FOR_REMAINING_CONFLICTS')
        choice=choices[frozenset(found['pair'])]
        curr_ids={r['id']:r for r in current['rules']}
        winner,loser=curr_ids[choice['winner']],curr_ids[choice['loser']]
        candidate=copy.deepcopy(current)
        edited=next(r for r in candidate['rules'] if r['id']==loser['id'])
        edited['condition']=conj(loser['condition'],neg(winner['condition']))
        entry={'iteration':step_no+1,'choice':choice,'before_sha256':fingerprint(current),
               'overlap_before':found,'checks':{}}
        try:candidate=normalize(candidate)
        except InputError as exc:
            entry['candidate_error']=str(exc);result['iterations'].append(entry)
            return stop('CANDIDATE_OUTSIDE_SUPPORTED_FRAGMENT')
        after_hash=fingerprint(candidate);entry['after_sha256']=after_hash
        if after_hash in seen:
            result['iterations'].append(entry);return stop('REPEATED_STATE')
        seen.add(after_hash)
        post=Verifier(candidate,timeout_ms);pre=Verifier(current,timeout_ms)
        new_rule=next(r for r in candidate['rules'] if r['id']==loser['id'])
        alive=post.check(new_rule['condition'])
        local=pre.check(conj(loser['condition'],neg(new_rule['condition']),neg(winner['condition'])))
        pair_after=post.pair(new_rule,next(r for r in candidate['rules'] if r['id']==winner['id']))
        entry['checks'].update(loser_nonempty=alive,outside_overlap_removed=local,pair_after=pair_after)
        if alive['status']!='SAT':
            result['iterations'].append(entry);return stop('REPAIR_REMOVES_ALL_LOSER_BEHAVIOR_OR_UNRESOLVED')
        if local['status']!='UNSAT' or pair_after['status']!='UNSAT':
            result['iterations'].append(entry);return stop('PAIR_NOT_RESOLVED_OR_NONLOCAL_OR_UNRESOLVED')
        no_new=[]
        for inv in current['invariants']:
            query=post.check(conj(_violation(candidate,inv),neg(_violation(current,inv))))
            no_new.append({'id':inv['id'],'new_violation_region':query})
        entry['checks']['contract_violation_nonexpansion']=no_new
        result['iterations'].append(entry)
        if any(x['new_violation_region']['status']!='UNSAT' for x in no_new):return stop('NEW_CONTRACT_VIOLATION_OR_UNRESOLVED')
        current=candidate
    raise AssertionError('Bounded loop should always return at or before its limit')
