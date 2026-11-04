(set-logic ALL)
(declare-sort Req 0)
(declare-fun Bold (Req) Bool)
(declare-fun Bnew (Req) Bool)
; the step check: Bnew and not Bold is unsatisfiable
(assert (forall ((x Req)) (not (and (Bnew x) (not (Bold x))))))
(assert (exists ((x Req)) (and (Bnew x) (not (Bold x)))))
(check-sat)
