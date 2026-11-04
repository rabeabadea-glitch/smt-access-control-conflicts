package thesis

c0 if { true }
c1 if { input["p"] == true }
rule_0 if { c1 }
c2 if { input["q"] == true }
rule_1 if { c2 }
c3 if { input["p"] == true }
c4 if { not c3 }
c5 if { input["q"] == true }
c6 if { not c5 }
c7 if { c4; c6 }
rule_2 if { c7 }
c8 if { input["p"] == false }
c9 if { input["q"] == false }
c10 if { input["r"] == false }
c11 if { c8; c9; c10 }
c12 if { input["p"] == false }
c13 if { input["q"] == false }
c14 if { input["r"] == true }
c15 if { c12; c13; c14 }
c16 if { input["p"] == false }
c17 if { input["q"] == true }
c18 if { input["r"] == false }
c19 if { c16; c17; c18 }
c20 if { input["p"] == false }
c21 if { input["q"] == true }
c22 if { input["r"] == true }
c23 if { c20; c21; c22 }
c24 if { input["p"] == true }
c25 if { input["q"] == false }
c26 if { input["r"] == false }
c27 if { c24; c25; c26 }
c28 if { input["p"] == true }
c29 if { input["q"] == false }
c30 if { input["r"] == true }
c31 if { c28; c29; c30 }
c32 if { input["p"] == true }
c33 if { input["q"] == true }
c34 if { input["r"] == false }
c35 if { c32; c33; c34 }
c36 if { input["p"] == true }
c37 if { input["q"] == true }
c38 if { input["r"] == true }
c39 if { c36; c37; c38 }
