"""Distinct-content view of the Rego census (28 October 2026).
Reads census.json (203 files), removes byte-identical copies (Gatekeeper vendors its library
files into many template folders), and adds: OPA 1.x default-mode (v1) parse, the
authorization-style subset, and the smaller constructs behind rejections that use none of the
features in Table C.5."""
import collections, hashlib, json, os, subprocess, sys
ROOT, CENSUS, OUT = sys.argv[1], sys.argv[2], sys.argv[3]
OPA = '/home/user/tools/opa_linux_amd64_static'
d = json.load(open(CENSUS))
rows = sorted(d['rows'], key=lambda r: r['file'])
groups = collections.OrderedDict()
for r in rows:
    h = hashlib.sha256(open(os.path.join(ROOT, r['file']), 'rb').read()).hexdigest()
    groups.setdefault(h, []).append(r)
uniq = [g[0] for g in groups.values()]
dups = {g[0]['file']: len(g) for g in groups.values() if len(g) > 1}

def ast(path, v0):
    p = subprocess.run([OPA, 'parse', '--format', 'json'] + (['--v0-compatible'] if v0 else []) + [path], capture_output=True, text=True)
    return json.loads(p.stdout) if p.returncode == 0 else None

def small(a):
    """Constructs outside the profile that Table C.5 does not list."""
    acc = set()
    def w(x):
        if isinstance(x, dict):
            if x.get('type') in ('array', 'object', 'set'): acc.add('list, set or object constant')
            if x.get('type') == 'ref':
                v = x.get('value', [])
                if v and isinstance(v[0], dict) and v[0].get('type') == 'var':
                    op = v[0].get('value')
                    if op == 'eq': acc.add('unification (=) instead of comparison (==)')
                    if op == 'internal' and len(v) > 1 and str(v[1].get('value', '')).startswith('member'): acc.add('membership test (in)')
            for v in x.values(): w(v)
        elif isinstance(x, list):
            for v in x: w(v)
    for rule in a.get('rules', []):
        w(rule.get('body', [])); w(rule.get('head', {}).get('value'))
        for e in rule.get('body', []):
            t = e.get('terms')
            if isinstance(t, dict) and t.get('type') == 'ref' and not e.get('negated'):
                acc.add('bare attribute used as a condition')
    if any('future' in json.dumps(i.get('path', {})) for i in a.get('imports', [])):
        acc.add('import of future keywords')
    return sorted(acc)

AUTHZ = ('authz', 'authoriz', 'rbac', 'access')
out = []
for r in uniq:
    path = os.path.join(ROOT, r['file'])
    v1 = ast(path, False) is not None
    listed = {k for k in r['features'] if k != 'negation'}
    row = dict(r, copies=dups.get(r['file'], 1), parses_v1=v1, authz_style=any(k in r['file'].lower() for k in AUTHZ))
    if r['mapper'] == 'rejected' and not listed:
        row['smaller_constructs'] = small(ast(path, True))
    out.append(row)

C = collections.Counter
summary = {
    'files': len(rows), 'distinct_modules': len(uniq), 'duplicate_copies_removed': len(rows) - len(uniq),
    'largest_duplicate_groups': sorted(dups.items(), key=lambda kv: -kv[1])[:4],
    'distinct_by_repo': C(r['repo'] for r in out),
    'accepted_by_mapper': sum(r['mapper'] == 'accepted' for r in out),
    'parse_in_opa_v1_default_mode': sum(r['parses_v1'] for r in out),
    'need_v0_compatible_mode': sum(not r['parses_v1'] for r in out),
    'need_v0_by_repo': C(r['repo'] for r in out if not r['parses_v1']),
    'accepted_among_v1_parsable': sum(r['mapper'] == 'accepted' and r['parses_v1'] for r in out),
    'files_using_feature': C(f for r in out for f in r['features']),
    'rejected_without_listed_feature': sum('smaller_constructs' in r for r in out),
    'smaller_constructs': C(c for r in out for c in r.get('smaller_constructs', [])),
    'authz_style_modules': sum(r['authz_style'] for r in out),
    'authz_style_accepted': sum(r['authz_style'] and r['mapper'] == 'accepted' for r in out),
}
json.dump({'summary': summary, 'rows': out}, open(OUT, 'w'), indent=1, default=dict)
print(json.dumps(summary, indent=1, default=dict))
for r in out:
    if 'smaller_constructs' in r: print(r['file'], '|', r['reason'], '|', r['smaller_constructs'])
