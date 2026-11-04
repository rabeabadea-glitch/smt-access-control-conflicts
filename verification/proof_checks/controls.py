"""Negative controls: deliberately false variants must be refuted (sat) by both solvers."""
import json, subprocess, sys, os
import cvc5
sys.path.insert(0, os.path.dirname(__file__))
from lemmas import L, DEC, HDR, preds
Z3 = '/home/user/venv312/bin/z3'
def z3(text): return subprocess.run([Z3, '-smt2', '-in'], input=text, capture_output=True, text=True, timeout=120).stdout.split()
def cv(text):
    tm = cvc5.TermManager(); s = cvc5.Solver(tm); s.setOption('tlimit-per', '30000'); s.setOption('finite-model-find', 'true')
    p = cvc5.InputParser(s); p.setStringInput(cvc5.InputLanguage.SMT_LIB_2_6, text, 'x'); sm = p.getSymbolManager(); o = []
    while True:
        c = p.nextCommand()
        if c.isNull(): break
        r = c.invoke(s, sm).strip()
        if r: o.append(r)
    return o
C = {}
C['P4.7 without "the target never asks for Conflict" (the version corrected on 27 October)'] = DEC.replace('(assert (forall ((x Req)) (not (= (T x) Conflict))))', '') + "(assert (forall ((x Req)) (= (dec x) (T x))))\n(check-sat)\n"
C['P4.4 reversed: D(l) minus D(w) inside every disjoint subregion'] = HDR + preds('L', 'W', 'X') + """(assert (forall ((x Req)) (=> (X x) (L x))))
(assert (forall ((x Req)) (=> (X x) (not (W x)))))
(assert (exists ((x Req)) (and (L x) (not (W x)) (not (X x)))))
(check-sat)
"""
C['P4.3 without the two values being different'] = L['P4.3 contradictory necessary equalities rule out an overlap'].replace('(assert (not (= c1 c2)))', '')
C['P4.1 equality atom without an injective coding'] = L['P4.1 equality atom over an injective coding'].replace('(assert (forall ((u Val) (v Val)) (=> (= (code u) (code v)) (= u v))))', '')
out = []
for name, t in C.items():
    a, b = z3(t), cv(t)
    ok = a == ['sat'] and b == ['sat']
    out.append({'control': name, 'z3': a, 'cvc5': b, 'refuted': ok}); print('OK  ' if ok else 'CHECK', name, a, b)
json.dump(out, open('controls.json', 'w'), indent=1)
