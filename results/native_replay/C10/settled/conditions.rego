package thesis

c0 if { true }
c1 if { input["p"] == true }
c2 if { input["q"] == true }
c3 if { c1; c2 }
rule_0 if { c3 }
c4 if { input["p"] == true }
c5 if { input["q"] == true }
c6 if { not c5 }
c7 if { c4; c6 }
rule_1 if { c7 }
c8 if { input["p"] == true }
c9 if { not c8 }
c10 if { input["r"] == true }
c11 if { c9; c10 }
rule_2 if { c11 }
c12 if { input["p"] == true }
c13 if { not c12 }
c14 if { input["r"] == true }
c15 if { not c14 }
c16 if { c13; c15 }
rule_3 if { c16 }
c17 if { input["p"] == false }
c18 if { input["q"] == false }
c19 if { input["r"] == false }
c20 if { c17; c18; c19 }
c21 if { input["p"] == false }
c22 if { input["q"] == false }
c23 if { input["r"] == true }
c24 if { c21; c22; c23 }
c25 if { input["p"] == false }
c26 if { input["q"] == true }
c27 if { input["r"] == false }
c28 if { c25; c26; c27 }
c29 if { input["p"] == false }
c30 if { input["q"] == true }
c31 if { input["r"] == true }
c32 if { c29; c30; c31 }
c33 if { input["p"] == true }
c34 if { input["q"] == false }
c35 if { input["r"] == false }
c36 if { c33; c34; c35 }
c37 if { input["p"] == true }
c38 if { input["q"] == false }
c39 if { input["r"] == true }
c40 if { c37; c38; c39 }
c41 if { input["p"] == true }
c42 if { input["q"] == true }
c43 if { input["r"] == false }
c44 if { c41; c42; c43 }
c45 if { input["p"] == true }
c46 if { input["q"] == true }
c47 if { input["r"] == true }
c48 if { c45; c46; c47 }
