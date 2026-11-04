package thesis

c0 if { true }
c1 if { input["x"] >= 3 }
c2 if { input["x"] <= 5 }
c3 if { input["y"] >= 0 }
c4 if { input["y"] <= 2 }
c5 if { c1; c2; c3; c4 }
rule_0 if { c5 }
c6 if { input["x"] >= 2 }
c7 if { input["x"] <= 3 }
c8 if { input["y"] >= 3 }
c9 if { input["y"] <= 4 }
c10 if { input["f"] == false }
c11 if { c6; c7; c8; c9; c10 }
c12 if { input["x"] >= 2 }
c13 if { input["x"] <= 2 }
c14 if { input["y"] >= 2 }
c15 if { input["y"] <= 3 }
c16 if { c12; c13; c14; c15 }
c17 if { not c16 }
c18 if { c11; c17 }
rule_1 if { c18 }
c19 if { input["x"] >= 2 }
c20 if { input["x"] <= 5 }
c21 if { input["y"] >= 3 }
c22 if { input["y"] <= 3 }
c23 if { input["f"] == false }
c24 if { c19; c20; c21; c22; c23 }
rule_2 if { c24 }
c25 if { input["x"] >= 0 }
c26 if { input["x"] <= 4 }
c27 if { input["y"] >= 0 }
c28 if { input["y"] <= 0 }
c29 if { c25; c26; c27; c28 }
rule_3 if { c29 }
c30 if { input["x"] >= 2 }
c31 if { input["x"] <= 2 }
c32 if { input["y"] >= 2 }
c33 if { input["y"] <= 3 }
c34 if { c30; c31; c32; c33 }
c35 if { input["x"] >= 2 }
c36 if { input["x"] <= 5 }
c37 if { input["y"] >= 3 }
c38 if { input["y"] <= 3 }
c39 if { input["f"] == false }
c40 if { c35; c36; c37; c38; c39 }
c41 if { not c40 }
c42 if { c34; c41 }
rule_4 if { c42 }
c43 if { input["x"] == 0 }
c44 if { input["y"] == 0 }
c45 if { input["f"] == false }
c46 if { c43; c44; c45 }
c47 if { input["x"] == 0 }
c48 if { input["y"] == 0 }
c49 if { input["f"] == true }
c50 if { c47; c48; c49 }
c51 if { input["x"] == 1 }
c52 if { input["y"] == 0 }
c53 if { input["f"] == false }
c54 if { c51; c52; c53 }
c55 if { input["x"] == 1 }
c56 if { input["y"] == 0 }
c57 if { input["f"] == true }
c58 if { c55; c56; c57 }
c59 if { input["x"] == 2 }
c60 if { input["y"] == 0 }
c61 if { input["f"] == false }
c62 if { c59; c60; c61 }
c63 if { input["x"] == 2 }
c64 if { input["y"] == 0 }
c65 if { input["f"] == true }
c66 if { c63; c64; c65 }
c67 if { input["x"] == 2 }
c68 if { input["y"] == 2 }
c69 if { input["f"] == false }
c70 if { c67; c68; c69 }
c71 if { input["x"] == 2 }
c72 if { input["y"] == 2 }
c73 if { input["f"] == true }
c74 if { c71; c72; c73 }
c75 if { input["x"] == 2 }
c76 if { input["y"] == 3 }
c77 if { input["f"] == false }
c78 if { c75; c76; c77 }
c79 if { input["x"] == 2 }
c80 if { input["y"] == 3 }
c81 if { input["f"] == true }
c82 if { c79; c80; c81 }
c83 if { input["x"] == 2 }
c84 if { input["y"] == 4 }
c85 if { input["f"] == false }
c86 if { c83; c84; c85 }
c87 if { input["x"] == 3 }
c88 if { input["y"] == 0 }
c89 if { input["f"] == false }
c90 if { c87; c88; c89 }
c91 if { input["x"] == 3 }
c92 if { input["y"] == 0 }
c93 if { input["f"] == true }
c94 if { c91; c92; c93 }
c95 if { input["x"] == 3 }
c96 if { input["y"] == 1 }
c97 if { input["f"] == false }
c98 if { c95; c96; c97 }
c99 if { input["x"] == 3 }
c100 if { input["y"] == 1 }
c101 if { input["f"] == true }
c102 if { c99; c100; c101 }
c103 if { input["x"] == 3 }
c104 if { input["y"] == 2 }
c105 if { input["f"] == false }
c106 if { c103; c104; c105 }
c107 if { input["x"] == 3 }
c108 if { input["y"] == 2 }
c109 if { input["f"] == true }
c110 if { c107; c108; c109 }
c111 if { input["x"] == 3 }
c112 if { input["y"] == 3 }
c113 if { input["f"] == false }
c114 if { c111; c112; c113 }
c115 if { input["x"] == 3 }
c116 if { input["y"] == 4 }
c117 if { input["f"] == false }
c118 if { c115; c116; c117 }
c119 if { input["x"] == 4 }
c120 if { input["y"] == 0 }
c121 if { input["f"] == false }
c122 if { c119; c120; c121 }
c123 if { input["x"] == 4 }
c124 if { input["y"] == 0 }
c125 if { input["f"] == true }
c126 if { c123; c124; c125 }
c127 if { input["x"] == 4 }
c128 if { input["y"] == 1 }
c129 if { input["f"] == false }
c130 if { c127; c128; c129 }
c131 if { input["x"] == 4 }
c132 if { input["y"] == 1 }
c133 if { input["f"] == true }
c134 if { c131; c132; c133 }
c135 if { input["x"] == 4 }
c136 if { input["y"] == 2 }
c137 if { input["f"] == false }
c138 if { c135; c136; c137 }
c139 if { input["x"] == 4 }
c140 if { input["y"] == 2 }
c141 if { input["f"] == true }
c142 if { c139; c140; c141 }
c143 if { input["x"] == 4 }
c144 if { input["y"] == 3 }
c145 if { input["f"] == false }
c146 if { c143; c144; c145 }
c147 if { input["x"] == 5 }
c148 if { input["y"] == 0 }
c149 if { input["f"] == false }
c150 if { c147; c148; c149 }
c151 if { input["x"] == 5 }
c152 if { input["y"] == 0 }
c153 if { input["f"] == true }
c154 if { c151; c152; c153 }
c155 if { input["x"] == 5 }
c156 if { input["y"] == 1 }
c157 if { input["f"] == false }
c158 if { c155; c156; c157 }
c159 if { input["x"] == 5 }
c160 if { input["y"] == 1 }
c161 if { input["f"] == true }
c162 if { c159; c160; c161 }
c163 if { input["x"] == 5 }
c164 if { input["y"] == 2 }
c165 if { input["f"] == false }
c166 if { c163; c164; c165 }
c167 if { input["x"] == 5 }
c168 if { input["y"] == 2 }
c169 if { input["f"] == true }
c170 if { c167; c168; c169 }
c171 if { input["x"] == 5 }
c172 if { input["y"] == 3 }
c173 if { input["f"] == false }
c174 if { c171; c172; c173 }
