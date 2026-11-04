"""Non-vacuity check: with the negated claim removed, every lemma's assumptions must be satisfiable."""
import json, os, re, subprocess, sys
import cvc5
sys.path.insert(0, os.path.dirname(__file__))
from lemmas import L
from dags import script
Z3 = '/home/user/venv312/bin/z3'
def drop_last_assert(text):
    i = text.rfind('(assert')
    j = text.index('(check-sat)', i)
    return text[:i] + text[j:]
def z3(text):
    return subprocess.run([Z3, '-smt2', '-in'], input=text, capture_output=True, text=True, timeout=120).stdout.split()
def cv(text):
    tm = cvc5.TermManager(); s = cvc5.Solver(tm); s.setOption('incremental', 'true'); s.setOption('tlimit-per', '30000')
    s.setOption('finite-model-find', 'true')
    p = cvc5.InputParser(s); p.setStringInput(cvc5.InputLanguage.SMT_LIB_2_6, text, 'x'); sm = p.getSymbolManager(); o = []
    while True:
        c = p.nextCommand()
        if c.isNull(): break
        r = c.invoke(s, sm).strip()
        if r: o.append(r)
    return o
out = []
for name, text in L.items():
    t = drop_last_assert(text)
    a, b = z3(t), cv(t)
    ok = a == ['sat'] and b == ['sat']
    out.append({'lemma': name, 'z3': a, 'cvc5': b, 'assumptions_satisfiable': ok})
    print('OK  ' if ok else 'CHECK', name, a, b)
# uniqueness: drop the final exists in every block for n = 3
text, count = script(3)
blocks = text.replace('(assert (exists', '(assert (and true (exists').split('\n')
t2 = '\n'.join(l for l in text.split('\n') if not l.startswith('(assert (exists'))
a, b = z3(t2), cv(t2)
ok = a.count('sat') == count and b.count('sat') == count
out.append({'lemma': 'closed form: both families definable (n = 3, all relations)', 'z3_sat': a.count('sat'), 'cvc5_sat': b.count('sat'), 'assumptions_satisfiable': ok})
print('OK  ' if ok else 'CHECK', 'uniqueness assumptions n=3', a.count('sat'), b.count('sat'), count)
json.dump(out, open('vacuity.json', 'w'), indent=1)
print('ALL NON-VACUOUS' if all(x['assumptions_satisfiable'] for x in out) else 'SOME NEED A LOOK')
