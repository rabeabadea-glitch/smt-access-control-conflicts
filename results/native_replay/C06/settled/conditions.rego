package thesis

c0 if { true }
c1 if { input["p"] == true }
rule_0 if { c1 }
c2 if { input["p"] == true }
c3 if { input["q"] == true }
c4 if { not c3 }
c5 if { c2 }
c5 if { c4 }
rule_1 if { c5 }
c6 if { input["p"] == true }
c7 if { not c6 }
c8 if { input["q"] == true }
c9 if { c7; c8 }
rule_2 if { c9 }
c10 if { input["p"] == false }
c11 if { input["q"] == false }
c12 if { input["r"] == false }
c13 if { c10; c11; c12 }
c14 if { input["p"] == false }
c15 if { input["q"] == false }
c16 if { input["r"] == true }
c17 if { c14; c15; c16 }
c18 if { input["p"] == false }
c19 if { input["q"] == true }
c20 if { input["r"] == false }
c21 if { c18; c19; c20 }
c22 if { input["p"] == false }
c23 if { input["q"] == true }
c24 if { input["r"] == true }
c25 if { c22; c23; c24 }
c26 if { input["p"] == true }
c27 if { input["q"] == false }
c28 if { input["r"] == false }
c29 if { c26; c27; c28 }
c30 if { input["p"] == true }
c31 if { input["q"] == false }
c32 if { input["r"] == true }
c33 if { c30; c31; c32 }
c34 if { input["p"] == true }
c35 if { input["q"] == true }
c36 if { input["r"] == false }
c37 if { c34; c35; c36 }
c38 if { input["p"] == true }
c39 if { input["q"] == true }
c40 if { input["r"] == true }
c41 if { c38; c39; c40 }
