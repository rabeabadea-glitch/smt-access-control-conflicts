(set-logic ALL)
(declare-sort Req 0)
(declare-datatypes ((Dec 0)) (((Permit) (Deny) (NotApplicable) (Conflict))))
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
(assert (forall ((x Req)) (= (dec x) (T x))))
(check-sat)
