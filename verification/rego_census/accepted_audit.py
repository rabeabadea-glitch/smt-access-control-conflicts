"""Import the real Rego files that the mapper accepts, with a manifest inferred from their literals, and audit them."""
import json, re, sys
sys.path.insert(0, '/home/user/pkg/src')
from research.rego import Parser, import_rego
from pcproof.verify import audit
ROOT = '/home/user/realpol/'
out = []
for f in ['contrib/wasm/cloudflare-worker/example.rego', 'contrib/opa-aws-cloudformation-hook/examples/policy/authz.rego', 'contrib/opa-aws-cloudformation-hook/examples/policy/aws.rego']:
    text = open(ROOT + f).read()
    package, defs = Parser(text).module()
    attrs = {}
    for a, v in re.findall(r'input\.([A-Za-z_][A-Za-z0-9_]*)\s*==\s*"([^"]*)"', text):
        attrs.setdefault(a, set()).add(v)
    manifest = {'schema_version': 'cpm-1', 'package': package,
                'attributes': {a: {'type': 'enum', 'values': sorted(vs) + ['__OTHER__']} for a, vs in attrs.items()},
                'sources': {'S': {'kind': 'internal', 'citation': f, 'mapping_status': 'public example policy'}},
                'rules': [{'id': n, 'source': 'S', 'effect': 'Permit' if n == 'allow' else 'Deny', 'entry': n} for n in defs if n in ('allow', 'deny')]}
    if not manifest['rules']:
        out.append({'file': f, 'rules': 0, 'note': 'package without rules'}); print(f, 'no rules'); continue
    model = import_rego(text, manifest)
    res = audit(model)
    out.append({'file': f, 'rules': len(model['rules']), 'effects': sorted({r['effect'] for r in model['rules']}),
                'audit_label': res.get('label'), 'eligible_pairs': res.get('eligible_pairs')})
    print(out[-1])
json.dump(out, open('/home/user/realpol_scripts/accepted_audit.json', 'w'), indent=1)
