import copy,json,pathlib,tempfile,unittest
from pcproof.model import *
from pcproof.verify import *
from pcproof.repair import refine,invariant_checks
from pcproof.export import generate,replay,load_generated
from pcproof.native_z3 import NativeZ3
ROOT=pathlib.Path(__file__).resolve().parents[1]

def fixture(name='conflict.json'):return normalize(json.loads((ROOT/'examples'/name).read_text()))
def approval(name='approval_safe.json'):return json.loads((ROOT/'examples'/name).read_text())

class ModelTests(unittest.TestCase):
    def test_normalization_idempotent(self):self.assertEqual(fixture(),normalize(fixture()))
    def test_unknown_attr(self):
        p=fixture();p['rules'][0]['condition']=atom('no','eq',True)
        with self.assertRaises(InputError):normalize(p)
    def test_bool_not_integer(self):
        p=fixture();p['rules'][0]['condition']=atom('grounds','eq',1)
        with self.assertRaises(InputError):normalize(p)
    def test_enum_order_unsupported(self):
        p=fixture();p['rules'][0]['condition']=atom('role','lt','other')
        with self.assertRaises(UnsupportedError):normalize(p)
    def test_unsupported_operator(self):
        p=json.loads((ROOT/'examples/unsupported.json').read_text())
        with self.assertRaises(UnsupportedError):normalize(p)
    def test_duplicate_rules(self):
        p=fixture();p['rules'][1]['id']=p['rules'][0]['id']
        with self.assertRaises(InputError):normalize(p)
    def test_obligations_not_silently_ignored(self):
        p=fixture();p['rules'][0]['obligation']='retain'
        with self.assertRaises(UnsupportedError):normalize(p)
    def test_missing_request(self):self.assertEqual(decision(fixture(),{})['decision'],'InvalidRequest')
    def test_multivalue_request(self):
        p=fixture();r=next(requests(p));r['role']=['subject']
        self.assertEqual(decision(p,r)['decision'],'InvalidRequest')
    def test_not_applicable(self):
        p=fixture();r=next(requests(p));r['role']='other'
        self.assertEqual(decision(p,r)['decision'],'NotApplicable')
    def test_cyclic_governance(self):
        p=fixture('governed.json');p['precedence'].append({'higher':'GDPR','lower':'AMLD','approval_id':'DEMO'})
        with self.assertRaises(InputError):normalize(p)
    def test_empty_domain(self):
        p=fixture();p['attributes']['role']['values']=[]
        with self.assertRaises(InputError):normalize(p)
    def test_empty_valid_request_space(self):
        p=fixture();p['validity']=False
        self.assertEqual(audit(p)['label'],'INVALID_OR_UNRESOLVED_REQUEST_SPACE')

class VerificationTests(unittest.TestCase):
    def test_sat_valid_witness(self):
        p=fixture();r=Verifier(p).pair(*p['rules']);self.assertEqual(r['status'],'SAT')
        self.assertTrue(valid_request(p,r['witness']));self.assertEqual(decision(p,r['witness'])['decision'],'Conflict')
    def test_unsat(self):
        p=fixture('nonoverlap.json');self.assertEqual(Verifier(p).pair(*p['rules'])['status'],'UNSAT')
    def test_governance_does_not_remove_overlap(self):
        p=fixture('governed.json');a=Verifier(p).pair(*p['rules']);self.assertTrue(a['governed']);self.assertEqual(a['status'],'SAT')
    def test_same_source_ineligible(self):
        p=fixture();p['rules'][1]['source']='GDPR';self.assertEqual(Verifier(p).pair(*p['rules'])['status'],'NOT_ELIGIBLE')
    def test_same_effect_ineligible(self):
        p=fixture();p['rules'][1]['effect']='Permit';self.assertEqual(Verifier(p).pair(*p['rules'])['status'],'NOT_ELIGIBLE')
    def test_actual_resource_limit_unknown(self):
        p=fixture();self.assertEqual(Verifier(p,resource_limit=1).pair(*p['rules'])['status'],'UNKNOWN')
    def test_unknown_not_conflict_free(self):
        self.assertNotEqual(audit(fixture(),resource_limit=1)['label'],'CROSS_SOURCE_CONFLICT_FREE_WITHIN_SCOPE')
    def test_timeout_reason_classifier(self):self.assertEqual(NativeZ3.unknown_status('timeout'),'TIMEOUT')
    def test_integer_negative_and_order(self):
        p=fixture();p['attributes']['age']={'type':'int','min':-3,'max':3}
        p['rules'][0]['condition']=atom('age','lt',0);p['rules'][1]['condition']=atom('age','ge',0)
        p=normalize(p);self.assertEqual(Verifier(p).pair(*p['rules'])['status'],'UNSAT')
    def test_exact_filter_sound_trivial(self):
        p=fixture();p['rules'][0]['condition']=atom('role','eq','subject');p['rules'][1]['condition']=atom('role','eq','other')
        self.assertTrue(can_skip_exact(*p['rules']));self.assertEqual(Verifier(p).pair(*p['rules'])['status'],'UNSAT')
    def test_lossy_screen_misses_true_conflict(self):
        p=fixture();p['rules'][0]['condition']=atom('grounds','eq',True);p['rules'][1]['condition']=atom('retention_active','eq',True)
        self.assertEqual(audit(p,'heuristic')['checked_pairs'],0)
        self.assertEqual(audit(p,'heuristic')['label'],'NO_CONFLICT_DETECTED_BY_SCREENING')
        self.assertEqual(audit(p)['results'][0]['status'],'SAT')

class RepairTests(unittest.TestCase):
    def test_authorized_safe_repair(self):self.assertEqual(refine(fixture(),approval())['status'],'ACCEPTED')
    def test_unsafe_repair_rejected(self):
        a=refine(fixture(),approval('approval_unsafe.json'));self.assertEqual(a['status'],'REJECTED');self.assertEqual(a['reason'],'INVARIANT_VIOLATION_OR_UNRESOLVED')
    def test_original_unmodified(self):
        p=fixture();before=fingerprint(p);refine(p,approval());self.assertEqual(before,fingerprint(p))
    def test_stale_approval(self):
        a=approval();a['policy_sha256']='wrong';self.assertEqual(refine(fixture(),a)['reason'],'STALE_OR_WRONG_POLICY_HASH')
    def test_no_invariants_block(self):
        p=fixture();p['invariants']=[];a=approval();a['policy_sha256']=fingerprint(p)
        self.assertEqual(refine(p,a)['reason'],'SAFETY_CONTRACT_REQUIRED')
    def test_degenerate_repair_block(self):
        p=fixture();p['rules'][1]['condition']=True;a=approval();a['policy_sha256']=fingerprint(p)
        self.assertEqual(refine(p,a)['reason'],'REPAIR_REMOVES_ALL_LOSER_BEHAVIOR_OR_UNRESOLVED')
    def test_contract_nonavacuity(self):
        p=fixture('nonoverlap.json');p['invariants'][0]['when']=False
        self.assertFalse(invariant_checks(p)[0]['passed'])
    def test_behavior_after_repair(self):
        p=refine(fixture(),approval())['policy'];d=[decision(p,r)['decision'] for r in requests(p)]
        self.assertIn('Deny',d);self.assertIn('Permit',d);self.assertNotIn('Conflict',d)

class ExecutionTests(unittest.TestCase):
    def test_generated_matches_all_requests(self):
        for p in [fixture(),fixture('nonoverlap.json')]:
            with tempfile.TemporaryDirectory() as d:
                f=pathlib.Path(d)/'policy.py';f.write_text(generate(p));self.assertTrue(replay(p,f)['passed'])
    def test_generated_type_check(self):
        p=fixture()
        with tempfile.TemporaryDirectory() as d:
            f=pathlib.Path(d)/'policy.py';f.write_text(generate(p));m=load_generated(f)
            r=next(requests(p));r['grounds']=1;self.assertEqual(m.decide(r)['decision'],'InvalidRequest')
    def test_generated_rejects_invalid_correlation(self):
        p=fixture();p['validity']=atom('grounds','eq',True)
        with tempfile.TemporaryDirectory() as d:
            f=pathlib.Path(d)/'policy.py';f.write_text(generate(p));m=load_generated(f)
            r={'role':'subject','action':'erase','grounds':False,'retention_active':False}
            self.assertEqual(m.decide(r)['decision'],'InvalidRequest')
    def test_enumeration_cap(self):
        p=fixture()
        with self.assertRaises(ValueError):list(requests(p,limit=1))

class BoundaryTests(unittest.TestCase):
    def test_nonstring_source_rejected(self):
        p=fixture();p['rules'][0]['source']=[]
        with self.assertRaises(InputError):normalize(p)
    def test_nonstring_precedence_rejected(self):
        p=fixture();p['precedence']=[{'higher':[],'lower':'GDPR','approval_id':'test'}]
        with self.assertRaises(InputError):normalize(p)
    def test_nonstring_authorization_rejected(self):
        a=approval();a['loser']=[]
        self.assertEqual(refine(fixture(),a)['status'],'REJECTED')
    def test_nonempty_authorization_text_required(self):
        a=approval();a['approval_id']=1
        self.assertEqual(refine(fixture(),a)['reason'],'UNAUTHORIZED_OPERATION')

if __name__=='__main__':unittest.main()
