"""Coverage census of real, public Rego policies against the thesis's Rego mapping profile.
For every non-test .rego file: (1) run the thesis's Rego mapper (research/rego.py, unchanged),
(2) parse it with OPA 1.21.2 and record which language features it uses."""
import collections, json, os, re, subprocess, sys
sys.path.insert(0, '/home/user/pkg/src')
from research.rego import Parser
from pcproof.model import InputError, UnsupportedError

OPA = '/home/user/tools/opa_linux_amd64_static'
ROOT = sys.argv[1]
REPOS = {'gatekeeper-library': 'src', 'conftest': 'examples', 'contrib': ''}

def files():
    for repo, sub in REPOS.items():
        base = os.path.join(ROOT, repo, sub)
        for d, _, fs in os.walk(base):
            for f in sorted(fs):
                if f.endswith('.rego') and not f.endswith('_test.rego'):
                    yield repo, os.path.join(d, f)

def opa_ast(path):
    for flags in (['--v0-compatible'], []):
        r = subprocess.run([OPA, 'parse', '--format', 'json'] + flags + [path], capture_output=True, text=True, timeout=60)
        if r.returncode == 0:
            return json.loads(r.stdout), ('v0' if flags else 'v1')
    return None, None

def walk(x, acc, in_head=False):
    if isinstance(x, dict):
        t = x.get('type')
        if t == 'call': acc['function or built-in call'] += 1
        if t in ('arraycomprehension', 'setcomprehension', 'objectcomprehension'): acc['comprehension'] += 1
        if t == 'every': acc['every quantifier'] += 1
        if t == 'ref':
            v = x.get('value', [])
            if v and isinstance(v[0], dict) and v[0].get('value') == 'data': acc['reference to external data'] += 1
            if any(isinstance(e, dict) and e.get('type') == 'var' and i > 0 for i, e in enumerate(v)): acc['iteration over collections'] += 1
        if 'with' in x and x['with']: acc['with modifier'] += 1
        if 'negated' in x and x['negated']: acc['negation'] += 1
        for k, v in x.items():
            walk(v, acc, in_head)
    elif isinstance(x, list):
        for v in x: walk(v, acc, in_head)

rows = []
for repo, path in files():
    text = open(path, encoding='utf-8', errors='replace').read()
    try:
        Parser(text).module(); mapper = 'accepted'; reason = ''
    except (InputError, UnsupportedError, ValueError, IndexError) as e:
        mapper = 'rejected'; reason = str(e)
    ast, syntax = opa_ast(path)
    feats = collections.Counter()
    if ast:
        for rule in ast.get('rules', []):
            head = rule.get('head', {})
            if head.get('args'): feats['user-defined function'] += 1
            if head.get('key') is not None or (len(head.get('ref', [])) > 1): feats['partial set or object rule'] += 1
            if rule.get('else'): feats['else branch'] += 1
            walk(rule.get('body', []), feats)
        if ast.get('imports'):
            if any('data' in json.dumps(i.get('path', {})) for i in ast['imports']): feats['import of external data or libraries'] += 1
    rows.append({'repo': repo, 'file': os.path.relpath(path, ROOT), 'mapper': mapper, 'reason': reason, 'opa_syntax': syntax, 'features': dict(feats)})

def reason_class(r):
    r = r.lower()
    if r.startswith('expected if'): return 'pre-1.0 rule syntax (no "if")'
    if 'reserved identifier' in r or 'expected rego' in r: return 'imports or reserved keywords'
    if 'unsupported body term' in r or 'only direct input fields' in r: return 'body terms outside Boolean comparisons of input fields'
    if 'literal' in r or 'comparison required' in r: return 'comparison that is not attribute against literal'
    if 'syntax' in r: return 'syntax outside the profile (e.g., brackets, strings, operators)'
    return 'other: ' + r[:60]

summary = {'files': len(rows), 'by_repo': collections.Counter(r['repo'] for r in rows),
           'accepted_by_mapper': sum(r['mapper'] == 'accepted' for r in rows),
           'opa_parsed': sum(r['opa_syntax'] is not None for r in rows),
           'rejection_classes': collections.Counter(reason_class(r['reason']) for r in rows if r['mapper'] == 'rejected'),
           'files_using_feature': collections.Counter(f for r in rows for f in r['features'])}
json.dump({'summary': summary, 'rows': rows}, open(sys.argv[2], 'w'), indent=1, default=dict)
print(json.dumps(summary, indent=1, default=dict))
