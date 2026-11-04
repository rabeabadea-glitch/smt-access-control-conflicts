"""Run every lemma and the closed-form uniqueness scripts with Z3 (binary) and cvc5 (Python API)."""
import json, os, re, subprocess, sys, time
import cvc5
sys.path.insert(0, os.path.dirname(__file__))
from lemmas import L
from dags import script

HERE = os.path.dirname(os.path.abspath(__file__))
Z3 = '/home/user/venv312/bin/z3'
SMT = os.path.join(HERE, 'smt'); os.makedirs(SMT, exist_ok=True)

def slug(s):
    for a, b in (('<=', ' le '), ('>=', ' ge '), ('<', ' lt '), ('>', ' gt ')):
        s = s.replace(a, b)
    return re.sub(r'[^A-Za-z0-9]+', '_', s).strip('_')[:90]

assert len({slug(n) for n in L}) == len(L), 'two lemmas would share one file name'

def run_z3(path, timeout=600):
    t = time.time()
    r = subprocess.run([Z3, '-smt2', path], capture_output=True, text=True, timeout=timeout)
    return [l.strip() for l in r.stdout.splitlines() if l.strip()], round(time.time() - t, 2)

def run_cvc5(path):
    t = time.time()
    tm = cvc5.TermManager(); s = cvc5.Solver(tm)
    s.setOption('tlimit-per', '60000'); s.setOption('incremental', 'true')
    p = cvc5.InputParser(s); p.setFileInput(cvc5.InputLanguage.SMT_LIB_2_6, path)
    sm = p.getSymbolManager(); outs = []
    while True:
        cmd = p.nextCommand()
        if cmd.isNull(): break
        o = cmd.invoke(s, sm).strip()
        if o: outs.append(o)
    return outs, round(time.time() - t, 2)

res = {'solvers': {'z3': subprocess.run([Z3, '--version'], capture_output=True, text=True).stdout.strip(), 'cvc5': cvc5.__version__}, 'lemmas': [], 'closed_form_uniqueness': []}
for name, text in L.items():
    path = os.path.join(SMT, slug(name) + '.smt2'); open(path, 'w').write(text)
    z, tz = run_z3(path); c, tc = run_cvc5(path)
    ok = z == ['unsat'] and c == ['unsat']
    res['lemmas'].append({'lemma': name, 'file': os.path.relpath(path, HERE), 'z3': z, 'cvc5': c, 'z3_s': tz, 'cvc5_s': tc, 'holds': ok})
    print(('OK  ' if ok else 'FAIL'), name, z, c, flush=True)
maxn = int(sys.argv[1]) if len(sys.argv) > 1 else 5
for n in range(1, maxn + 1):
    text, count = script(n)
    path = os.path.join(SMT, f'closed_form_uniqueness_n{n}.smt2'); open(path, 'w').write(text)
    z, tz = run_z3(path, timeout=3600); c, tc = run_cvc5(path)
    ok = len(z) == count and all(x == 'unsat' for x in z) and len(c) == count and all(x == 'unsat' for x in c)
    res['closed_form_uniqueness'].append({'rules': n, 'acyclic_relations': count, 'z3_unsat': z.count('unsat'), 'cvc5_unsat': c.count('unsat'), 'z3_s': tz, 'cvc5_s': tc, 'holds': ok})
    print(('OK  ' if ok else 'FAIL'), f'closed form unique for all {count} acyclic relations on {n} rules', tz, tc, flush=True)
res['all_hold'] = all(x['holds'] for x in res['lemmas']) and all(x['holds'] for x in res['closed_form_uniqueness'])
json.dump(res, open(os.path.join(HERE, 'results.json'), 'w'), indent=1)
print('ALL HOLD' if res['all_hold'] else 'SOME FAILED')
