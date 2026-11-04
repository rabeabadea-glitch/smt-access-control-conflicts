"""Behavioral regressions for reproduced failures; original tests unmodified."""
import copy,json,os,pathlib,subprocess,sys,tempfile,unittest
from pcproof.model import normalize,InputError,fingerprint
from pcproof.repair import refine
from pcproof.native_z3 import NativeZ3
from pcproof.export import generate,replay
H=pathlib.Path(__file__).resolve().parents[2]
E=pathlib.Path(os.environ.get('PCPROOF_AUDIT_FIXTURES',pathlib.Path(__file__).resolve().parent/'fixtures'/'inputs'))
def fixture(name):return normalize(json.loads((E/name).read_text()))
class AuditRegressions(unittest.TestCase):
 def test_empty_space_has_structured_nonpassing_replay(self):
  p=fixture('empty_validity.json')
  with tempfile.TemporaryDirectory() as d:
   f=pathlib.Path(d)/'p.py';f.write_text(generate(p));r=replay(p,f)
   self.assertEqual(r['status'],'EMPTY_VALID_REQUEST_SPACE');self.assertFalse(r['passed']);self.assertEqual(r['valid_requests_checked'],0)
 def test_empty_space_cli_writes_json_report(self):
  p=fixture('empty_validity.json')
  with tempfile.TemporaryDirectory() as d:
   d=pathlib.Path(d);(d/'p.py').write_text(generate(p));(d/'p.json').write_text(json.dumps(p))
   env=dict(os.environ,PYTHONPATH=str(H/'src'),PYTHONDONTWRITEBYTECODE='1')
   r=subprocess.run([sys.executable,'-m','pcproof','replay',str(d/'p.json'),'--out',str(d/'report.json'),'--generated',str(d/'p.py')],capture_output=True,text=True,env=env)
   self.assertEqual(r.returncode,0,r.stderr);self.assertEqual(json.loads((d/'report.json').read_text())['status'],'EMPTY_VALID_REQUEST_SPACE')
 def test_max_depth_transaction_rejected_without_mutation(self):
  p=fixture('depth_boundary.json');h=fingerprint(p)
  r=refine(p,json.loads((E/'depth_boundary_approval.json').read_text()))
  self.assertEqual(r['status'],'REJECTED');self.assertFalse(r['committed']);self.assertEqual(r['reason'],'CANDIDATE_OUTSIDE_SUPPORTED_FRAGMENT');self.assertEqual(h,fingerprint(p))
 def test_description_obeys_schema_string_type(self):
  p=fixture('empty_validity.json')
  for value in [None,True,0,[],{}]:
   with self.subTest(value=value):
    p['description']=value
    with self.assertRaises(InputError):normalize(p)
  p['description']='';self.assertEqual(normalize(p)['description'],'')
 def test_both_native_limits_reject_overflow_and_noninteger(self):
  z=NativeZ3()
  for key in ['timeout_ms','resource_limit']:
   for value in [-1,True,1.5,'10',2**32,2**32+1]:
    with self.subTest(key=key,value=value):
     with self.assertRaises(ValueError):z.solve('(declare-const x Int)\n(assert (= x 0))',['x'],**{key:value})
 def test_native_limits_accept_unsigned32_boundary(self):
  z=NativeZ3()
  self.assertEqual(z.solve('(declare-const x Int)\n(assert (= x 0))',['x'],timeout_ms=2**32-1,resource_limit=2**32-1).status,'SAT')
