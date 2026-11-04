(set-logic ALL)
(declare-sort Req 0)
(declare-sort M 0)
(declare-fun adm (Req) Bool) (declare-fun phi1 (Req) Bool) (declare-fun phi2 (Req) Bool)
(declare-fun VR (M) Bool) (declare-fun Phi1 (M) Bool) (declare-fun Phi2 (M) Bool)
(declare-fun enc (Req) M) (declare-fun dec (M) Req)
; Proposition 4.1: translation preserves every condition at every admissible request
(assert (forall ((x Req)) (=> (adm x) (and (= (phi1 x) (Phi1 (enc x))) (= (phi2 x) (Phi2 (enc x)))))))
; encodings of admissible requests satisfy V_R
(assert (forall ((x Req)) (=> (adm x) (VR (enc x)))))
; Proposition 4.2: every model of V_R decodes into an admissible request whose encoding is the model
(assert (forall ((m M)) (=> (VR m) (and (adm (dec m)) (= (enc (dec m)) m)))))
(assert (exists ((m M)) (and (VR m) (Phi1 m) (Phi2 m))))
(assert (forall ((x Req)) (not (and (adm x) (phi1 x) (phi2 x)))))
(check-sat)
