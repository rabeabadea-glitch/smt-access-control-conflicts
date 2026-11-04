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
c11 if { input["p"] == true }
c12 if { input["q"] == true }
c13 if { not c12 }
c14 if { c11; c13 }
c15 if { not c14 }
c16 if { c10; c15 }
rule_2 if { c16 }
c17 if { input["p"] == true }
c18 if { not c17 }
c19 if { input["r"] == true }
c20 if { c18; c19 }
rule_3 if { c20 }
c21 if { input["p"] == true }
c22 if { not c21 }
c23 if { input["q"] == true }
c24 if { c22; c23 }
c25 if { input["p"] == true }
c26 if { not c25 }
c27 if { input["r"] == true }
c28 if { c26; c27 }
c29 if { not c28 }
c30 if { c24; c29 }
rule_4 if { c30 }
c31 if { input["p"] == true }
c32 if { not c31 }
c33 if { input["q"] == true }
c34 if { not c33 }
c35 if { c32; c34 }
rule_5 if { c35 }
c36 if { input["p"] == false }
c37 if { input["q"] == false }
c38 if { input["r"] == false }
c39 if { c36; c37; c38 }
c40 if { input["p"] == false }
c41 if { input["q"] == false }
c42 if { input["r"] == true }
c43 if { c40; c41; c42 }
c44 if { input["p"] == false }
c45 if { input["q"] == true }
c46 if { input["r"] == false }
c47 if { c44; c45; c46 }
c48 if { input["p"] == false }
c49 if { input["q"] == true }
c50 if { input["r"] == true }
c51 if { c48; c49; c50 }
c52 if { input["p"] == true }
c53 if { input["q"] == false }
c54 if { input["r"] == false }
c55 if { c52; c53; c54 }
c56 if { input["p"] == true }
c57 if { input["q"] == false }
c58 if { input["r"] == true }
c59 if { c56; c57; c58 }
c60 if { input["p"] == true }
c61 if { input["q"] == true }
c62 if { input["r"] == false }
c63 if { c60; c61; c62 }
c64 if { input["p"] == true }
c65 if { input["q"] == true }
c66 if { input["r"] == true }
c67 if { c64; c65; c66 }
