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
c9 if { input["r"] == true }
c10 if { c8; c9 }
rule_2 if { c10 }
c11 if { input["p"] == true }
c12 if { not c11 }
c13 if { input["r"] == true }
c14 if { c12; c13 }
rule_3 if { c14 }
c15 if { input["p"] == true }
c16 if { not c15 }
c17 if { input["q"] == true }
c18 if { c16; c17 }
rule_4 if { c18 }
c19 if { input["p"] == true }
c20 if { not c19 }
c21 if { input["q"] == true }
c22 if { not c21 }
c23 if { c20; c22 }
rule_5 if { c23 }
c24 if { input["p"] == false }
c25 if { input["q"] == false }
c26 if { input["r"] == false }
c27 if { c24; c25; c26 }
c28 if { input["p"] == false }
c29 if { input["q"] == false }
c30 if { input["r"] == false }
c31 if { c28; c29; c30 }
c32 if { input["p"] == false }
c33 if { input["q"] == false }
c34 if { input["r"] == true }
c35 if { c32; c33; c34 }
c36 if { input["p"] == false }
c37 if { input["q"] == true }
c38 if { input["r"] == false }
c39 if { c36; c37; c38 }
c40 if { input["p"] == false }
c41 if { input["q"] == true }
c42 if { input["r"] == true }
c43 if { c40; c41; c42 }
c44 if { input["p"] == true }
c45 if { input["q"] == false }
c46 if { input["r"] == false }
c47 if { c44; c45; c46 }
c48 if { input["p"] == true }
c49 if { input["q"] == false }
c50 if { input["r"] == true }
c51 if { c48; c49; c50 }
c52 if { input["p"] == true }
c53 if { input["q"] == true }
c54 if { input["r"] == false }
c55 if { c52; c53; c54 }
c56 if { input["p"] == true }
c57 if { input["q"] == true }
c58 if { input["r"] == true }
c59 if { c56; c57; c58 }
