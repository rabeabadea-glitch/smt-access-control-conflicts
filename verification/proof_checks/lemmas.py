"""SMT-LIB lemmas behind the proofs of Chapter 4, checked for arbitrary request universes and regions.
Every lemma asserts the negation of a claim; the claim holds when the solver answers unsat.
Regions are uninterpreted predicates over an uninterpreted sort Req, so no bound on the number
of requests, attributes or values is assumed."""

HDR = "(set-logic ALL)\n(declare-sort Req 0)\n"

def preds(*names):
    return ''.join(f"(declare-fun {n} (Req) Bool)\n" for n in names)

L = {}

# ---------- Encoding: Proposition 4.1 (cases of the structural induction), 4.2, Theorem 4.1 ----------
L['P4.1 equality atom over an injective coding'] = HDR + """(declare-sort Val 0)
(declare-fun a (Req) Val)
(declare-const k Val)
(declare-fun code (Val) Int)
(assert (forall ((u Val) (v Val)) (=> (= (code u) (code v)) (= u v))))
(assert (exists ((x Req)) (not (= (= (a x) k) (= (code (a x)) (code k))))))
(check-sat)
"""
L['P4.1 inequality atom over an injective coding'] = HDR + """(declare-sort Val 0)
(declare-fun a (Req) Val)
(declare-const k Val)
(declare-fun code (Val) Int)
(assert (forall ((u Val) (v Val)) (=> (= (code u) (code v)) (= u v))))
(assert (exists ((x Req)) (not (= (not (= (a x) k)) (not (= (code (a x)) (code k)))))))
(check-sat)
"""
L['P4.1 Boolean coding false=0, true=1 is injective'] = """(set-logic ALL)
(declare-const b1 Bool)
(declare-const b2 Bool)
(assert (= (ite b1 1 0) (ite b2 1 0)))
(assert (not (= b1 b2)))
(check-sat)
"""
for op in ['<', '<=', '>', '>=']:
    L[f'P4.1 integer order atom {op} (identity coding)'] = HDR + f"""(declare-fun a (Req) Int)
(declare-const k Int)
(define-fun enc ((n Int)) Int n)
(assert (exists ((x Req)) (not (= ({op} (a x) k) ({op} (enc (a x)) (enc k))))))
(check-sat)
"""
L['P4.1 negation, conjunction and disjunction preserve equivalence'] = """(set-logic ALL)
(declare-const f1 Bool) (declare-const g1 Bool) (declare-const f2 Bool) (declare-const g2 Bool)
(assert (= f1 g1)) (assert (= f2 g2))
(assert (or (not (= (not f1) (not g1))) (not (= (and f1 f2) (and g1 g2))) (not (= (or f1 f2) (or g1 g2)))))
(check-sat)
"""
for n in (1, 2, 3, 5, 8, 13, 21):
    cons = ' '.join(f'(v{i})' for i in range(n))
    code = 'x'
    body = '0'
    for i in reversed(range(n)):
        body = f'(ite (= x v{i}) {i} {body})'
    L[f'P4.2 consecutive coding of a {n}-value enumeration can be decoded'] = f"""(set-logic ALL)
(declare-datatypes ((E 0)) (({cons})))
(define-fun code ((x E)) Int {body})
(declare-const z Int)
(assert (and (<= 0 z) (<= z {n - 1})))
(assert (forall ((v E)) (not (= (code v) z))))
(check-sat)
"""
THM = HDR + """(declare-sort M 0)
(declare-fun adm (Req) Bool) (declare-fun phi1 (Req) Bool) (declare-fun phi2 (Req) Bool)
(declare-fun VR (M) Bool) (declare-fun Phi1 (M) Bool) (declare-fun Phi2 (M) Bool)
(declare-fun enc (Req) M) (declare-fun dec (M) Req)
; Proposition 4.1: translation preserves every condition at every admissible request
(assert (forall ((x Req)) (=> (adm x) (and (= (phi1 x) (Phi1 (enc x))) (= (phi2 x) (Phi2 (enc x)))))))
; encodings of admissible requests satisfy V_R
(assert (forall ((x Req)) (=> (adm x) (VR (enc x)))))
; Proposition 4.2: every model of V_R decodes into an admissible request whose encoding is the model
(assert (forall ((m M)) (=> (VR m) (and (adm (dec m)) (= (enc (dec m)) m)))))
"""
L['Theorem 4.1 overlap implies the query is satisfiable'] = THM + """(assert (exists ((x Req)) (and (adm x) (phi1 x) (phi2 x))))
(assert (forall ((m M)) (not (and (VR m) (Phi1 m) (Phi2 m)))))
(check-sat)
"""
L['Theorem 4.1 a satisfying model is a real overlap'] = THM + """(assert (exists ((m M)) (and (VR m) (Phi1 m) (Phi2 m))))
(assert (forall ((x Req)) (not (and (adm x) (phi1 x) (phi2 x)))))
(check-sat)
"""

# ---------- Proposition 4.3 ----------
L['P4.3 a collected equality holds whenever its conjunction holds'] = HDR + preds('A', 'B') + """(assert (exists ((x Req)) (and (A x) (B x) (not (A x)))))
(check-sat)
"""
L['P4.3 contradictory necessary equalities rule out an overlap'] = HDR + preds('phi1', 'phi2') + """(declare-sort Val 0)
(declare-fun a (Req) Val)
(declare-const c1 Val) (declare-const c2 Val)
(assert (not (= c1 c2)))
(assert (forall ((x Req)) (=> (phi1 x) (= (a x) c1))))
(assert (forall ((x Req)) (=> (phi2 x) (= (a x) c2))))
(assert (exists ((x Req)) (and (phi1 x) (phi2 x))))
(check-sat)
"""

# ---------- Section 4.7 and Proposition 4.4 ----------
NARROW = HDR + preds('L', 'W', 'Lp', 'T') + "(assert (forall ((x Req)) (= (Lp x) (and (L x) (not (W x))))))\n"
L['Eq. 4.7 the narrowed pair no longer overlaps'] = NARROW + "(assert (exists ((x Req)) (and (Lp x) (W x))))\n(check-sat)\n"
L['Eq. 4.7 the loser gains no request'] = NARROW + "(assert (exists ((x Req)) (and (Lp x) (not (L x)))))\n(check-sat)\n"
L['Eq. 4.7 everything removed lies in the winner region'] = NARROW + "(assert (exists ((x Req)) (and (L x) (not (Lp x)) (not (W x)))))\n(check-sat)\n"
L['Eq. 4.7 no new overlap with a third rule'] = NARROW + "(assert (exists ((x Req)) (and (Lp x) (T x) (not (and (L x) (T x))))))\n(check-sat)\n"
L['P4.4 every disjoint subregion lies inside D(l) minus D(w)'] = HDR + preds('L', 'W', 'X') + """(assert (forall ((x Req)) (=> (X x) (L x))))
(assert (forall ((x Req)) (=> (X x) (not (W x)))))
(assert (exists ((x Req)) (and (X x) (not (and (L x) (not (W x)))))))
(check-sat)
"""
L['P4.4 D(l) minus D(w) is itself admissible (inside D(l), disjoint from D(w))'] = HDR + preds('L', 'W') + """(assert (exists ((x Req)) (or (and (L x) (not (W x)) (not (L x))) (and (L x) (not (W x)) (W x)))))
(check-sat)
"""

# ---------- Proposition 4.5 ----------
L['P4.5 an accepted step check gives containment'] = HDR + preds('Bold', 'Bnew') + """; the step check: Bnew and not Bold is unsatisfiable
(assert (forall ((x Req)) (not (and (Bnew x) (not (Bold x))))))
(assert (exists ((x Req)) (and (Bnew x) (not (Bold x)))))
(check-sat)
"""
L['P4.5 induction step: containment in the input is preserved'] = HDR + preds('B0', 'Bk', 'Bk1') + """(assert (forall ((x Req)) (=> (Bk x) (B0 x))))
(assert (forall ((x Req)) (=> (Bk1 x) (Bk x))))
(assert (exists ((x Req)) (and (Bk1 x) (not (B0 x)))))
(check-sat)
"""

# ---------- Proposition 4.6 (set lemmas) ----------
L['P4.6(a) narrowing never makes an unsatisfiable pair satisfiable'] = HDR + preds('A', 'B', 'Ap', 'Bp') + """(assert (forall ((x Req)) (not (and (A x) (B x)))))
(assert (forall ((x Req)) (=> (Ap x) (A x))))
(assert (forall ((x Req)) (=> (Bp x) (B x))))
(assert (exists ((x Req)) (and (Ap x) (Bp x))))
(check-sat)
"""
L['P4.6(b) subtracting a disjoint winner changes nothing'] = HDR + preds('L', 'W') + """(assert (forall ((x Req)) (not (and (L x) (W x)))))
(assert (exists ((x Req)) (not (= (and (L x) (not (W x))) (L x)))))
(check-sat)
"""
for k in (2, 3, 4, 5, 6):
    ws = [f'W{i}' for i in range(k)]
    seq = 'L'
    stepdefs = ''
    prev = 'L'
    for i, w in enumerate(ws):
        stepdefs += f"(define-fun S{i} ((x Req)) Bool (and ({prev} x) (not ({w} x))))\n"
        prev = f'S{i}'
    union = '(or ' + ' '.join(f'({w} x)' for w in ws) + ')'
    L[f'P4.6(b) {k} successive subtractions equal one subtraction of the union'] = HDR + preds('L', *ws) + stepdefs + f"""(assert (exists ((x Req)) (not (= ({prev} x) (and (L x) (not {union}))))))
(check-sat)
"""

# ---------- Proposition 4.7 ----------
DEC = HDR + """(declare-datatypes ((Dec 0)) (((Permit) (Deny) (NotApplicable) (Conflict))))
(declare-fun P (Req) Bool) (declare-fun N (Req) Bool) (declare-fun T (Req) Dec)
(declare-fun D (Req) Bool) (declare-fun Dstar (Req) Bool)
(declare-const e Dec)
(define-fun dec ((x Req)) Dec (ite (and (P x) (not (N x))) Permit (ite (and (N x) (not (P x))) Deny (ite (and (P x) (N x)) Conflict NotApplicable))))
(assert (or (= e Permit) (= e Deny)))
; the final rule contributes its effect wherever it applies
(assert (forall ((x Req)) (=> (Dstar x) (and (=> (= e Permit) (P x)) (=> (= e Deny) (N x))))))
; forced to retire: the original region is nonempty and the target never asks for the rule's effect there
(assert (exists ((x Req)) (D x)))
(assert (forall ((x Req)) (=> (D x) (not (= (T x) e)))))
; the target never asks for Conflict
(assert (forall ((x Req)) (not (= (T x) Conflict))))
; the checked transaction only narrows and never empties the rule
(assert (forall ((x Req)) (=> (Dstar x) (D x))))
(assert (exists ((x Req)) (Dstar x)))
"""
L['P4.7 a forced-to-retire rule that is kept nonempty misses the target'] = DEC + """(assert (forall ((x Req)) (= (dec x) (T x))))
(check-sat)
"""
