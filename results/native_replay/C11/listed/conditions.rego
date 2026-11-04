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
c22 if { input["s"] == true }
c23 if { c21; c22 }
c24 if { input["p"] == true }
c25 if { input["q"] == true }
c26 if { not c25 }
c27 if { c24; c26 }
c28 if { not c27 }
c29 if { c23; c28 }
rule_4 if { c29 }
c30 if { input["p"] == true }
c31 if { not c30 }
c32 if { input["s"] == true }
c33 if { c31; c32 }
rule_5 if { c33 }
c34 if { input["p"] == true }
c35 if { input["r"] == true }
c36 if { not c35 }
c37 if { input["s"] == true }
c38 if { not c37 }
c39 if { c34; c36; c38 }
c40 if { input["p"] == true }
c41 if { input["q"] == true }
c42 if { not c41 }
c43 if { c40; c42 }
c44 if { not c43 }
c45 if { c39; c44 }
rule_6 if { c45 }
c46 if { input["p"] == true }
c47 if { not c46 }
c48 if { input["r"] == true }
c49 if { not c48 }
c50 if { input["s"] == true }
c51 if { not c50 }
c52 if { c47; c49; c51 }
rule_7 if { c52 }
c53 if { input["p"] == false }
c54 if { input["q"] == false }
c55 if { input["r"] == false }
c56 if { input["s"] == false }
c57 if { c53; c54; c55; c56 }
c58 if { input["p"] == false }
c59 if { input["q"] == false }
c60 if { input["r"] == false }
c61 if { input["s"] == true }
c62 if { c58; c59; c60; c61 }
c63 if { input["p"] == false }
c64 if { input["q"] == false }
c65 if { input["r"] == true }
c66 if { input["s"] == false }
c67 if { c63; c64; c65; c66 }
c68 if { input["p"] == false }
c69 if { input["q"] == false }
c70 if { input["r"] == true }
c71 if { input["s"] == true }
c72 if { c68; c69; c70; c71 }
c73 if { input["p"] == false }
c74 if { input["q"] == true }
c75 if { input["r"] == false }
c76 if { input["s"] == false }
c77 if { c73; c74; c75; c76 }
c78 if { input["p"] == false }
c79 if { input["q"] == true }
c80 if { input["r"] == false }
c81 if { input["s"] == true }
c82 if { c78; c79; c80; c81 }
c83 if { input["p"] == false }
c84 if { input["q"] == true }
c85 if { input["r"] == true }
c86 if { input["s"] == false }
c87 if { c83; c84; c85; c86 }
c88 if { input["p"] == false }
c89 if { input["q"] == true }
c90 if { input["r"] == true }
c91 if { input["s"] == true }
c92 if { c88; c89; c90; c91 }
c93 if { input["p"] == true }
c94 if { input["q"] == false }
c95 if { input["r"] == false }
c96 if { input["s"] == false }
c97 if { c93; c94; c95; c96 }
c98 if { input["p"] == true }
c99 if { input["q"] == false }
c100 if { input["r"] == false }
c101 if { input["s"] == true }
c102 if { c98; c99; c100; c101 }
c103 if { input["p"] == true }
c104 if { input["q"] == false }
c105 if { input["r"] == true }
c106 if { input["s"] == false }
c107 if { c103; c104; c105; c106 }
c108 if { input["p"] == true }
c109 if { input["q"] == false }
c110 if { input["r"] == true }
c111 if { input["s"] == true }
c112 if { c108; c109; c110; c111 }
c113 if { input["p"] == true }
c114 if { input["q"] == true }
c115 if { input["r"] == false }
c116 if { input["s"] == false }
c117 if { c113; c114; c115; c116 }
c118 if { input["p"] == true }
c119 if { input["q"] == true }
c120 if { input["r"] == false }
c121 if { input["s"] == true }
c122 if { c118; c119; c120; c121 }
c123 if { input["p"] == true }
c124 if { input["q"] == true }
c125 if { input["r"] == true }
c126 if { input["s"] == false }
c127 if { c123; c124; c125; c126 }
c128 if { input["p"] == true }
c129 if { input["q"] == true }
c130 if { input["r"] == true }
c131 if { input["s"] == true }
c132 if { c128; c129; c130; c131 }
