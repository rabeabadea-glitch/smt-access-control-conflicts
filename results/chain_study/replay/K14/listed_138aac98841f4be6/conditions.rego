package thesis

c0 if { true }
c1 if { input["x"] >= 1 }
c2 if { input["x"] <= 3 }
c3 if { input["y"] >= 1 }
c4 if { input["y"] <= 3 }
c5 if { c1; c2; c3; c4 }
rule_0 if { c5 }
c6 if { input["x"] >= 4 }
c7 if { input["x"] <= 4 }
c8 if { input["y"] >= 1 }
c9 if { input["y"] <= 2 }
c10 if { c6; c7; c8; c9 }
rule_1 if { c10 }
c11 if { input["x"] >= 2 }
c12 if { input["x"] <= 4 }
c13 if { input["y"] >= 0 }
c14 if { input["y"] <= 2 }
c15 if { c11; c12; c13; c14 }
c16 if { input["x"] >= 1 }
c17 if { input["x"] <= 3 }
c18 if { input["y"] >= 1 }
c19 if { input["y"] <= 3 }
c20 if { c16; c17; c18; c19 }
c21 if { not c20 }
c22 if { c15; c21 }
c23 if { input["x"] >= 4 }
c24 if { input["x"] <= 4 }
c25 if { input["y"] >= 1 }
c26 if { input["y"] <= 2 }
c27 if { c23; c24; c25; c26 }
c28 if { not c27 }
c29 if { c22; c28 }
rule_2 if { c29 }
c30 if { input["x"] >= 4 }
c31 if { input["x"] <= 5 }
c32 if { input["y"] >= 3 }
c33 if { input["y"] <= 3 }
c34 if { input["f"] == true }
c35 if { c30; c31; c32; c33; c34 }
rule_3 if { c35 }
c36 if { input["x"] >= 2 }
c37 if { input["x"] <= 3 }
c38 if { input["y"] >= 0 }
c39 if { input["y"] <= 4 }
c40 if { c36; c37; c38; c39 }
c41 if { input["x"] >= 2 }
c42 if { input["x"] <= 4 }
c43 if { input["y"] >= 0 }
c44 if { input["y"] <= 2 }
c45 if { c41; c42; c43; c44 }
c46 if { input["x"] >= 1 }
c47 if { input["x"] <= 3 }
c48 if { input["y"] >= 1 }
c49 if { input["y"] <= 3 }
c50 if { c46; c47; c48; c49 }
c51 if { not c50 }
c52 if { c45; c51 }
c53 if { input["x"] >= 4 }
c54 if { input["x"] <= 4 }
c55 if { input["y"] >= 1 }
c56 if { input["y"] <= 2 }
c57 if { c53; c54; c55; c56 }
c58 if { not c57 }
c59 if { c52; c58 }
c60 if { not c59 }
c61 if { c40; c60 }
rule_4 if { c61 }
c62 if { input["x"] == 1 }
c63 if { input["y"] == 1 }
c64 if { input["f"] == false }
c65 if { c62; c63; c64 }
c66 if { input["x"] == 1 }
c67 if { input["y"] == 1 }
c68 if { input["f"] == true }
c69 if { c66; c67; c68 }
c70 if { input["x"] == 1 }
c71 if { input["y"] == 2 }
c72 if { input["f"] == false }
c73 if { c70; c71; c72 }
c74 if { input["x"] == 1 }
c75 if { input["y"] == 2 }
c76 if { input["f"] == true }
c77 if { c74; c75; c76 }
c78 if { input["x"] == 1 }
c79 if { input["y"] == 3 }
c80 if { input["f"] == false }
c81 if { c78; c79; c80 }
c82 if { input["x"] == 1 }
c83 if { input["y"] == 3 }
c84 if { input["f"] == true }
c85 if { c82; c83; c84 }
c86 if { input["x"] == 2 }
c87 if { input["y"] == 0 }
c88 if { input["f"] == false }
c89 if { c86; c87; c88 }
c90 if { input["x"] == 2 }
c91 if { input["y"] == 0 }
c92 if { input["f"] == true }
c93 if { c90; c91; c92 }
c94 if { input["x"] == 2 }
c95 if { input["y"] == 1 }
c96 if { input["f"] == false }
c97 if { c94; c95; c96 }
c98 if { input["x"] == 2 }
c99 if { input["y"] == 1 }
c100 if { input["f"] == true }
c101 if { c98; c99; c100 }
c102 if { input["x"] == 2 }
c103 if { input["y"] == 2 }
c104 if { input["f"] == false }
c105 if { c102; c103; c104 }
c106 if { input["x"] == 2 }
c107 if { input["y"] == 2 }
c108 if { input["f"] == true }
c109 if { c106; c107; c108 }
c110 if { input["x"] == 2 }
c111 if { input["y"] == 3 }
c112 if { input["f"] == false }
c113 if { c110; c111; c112 }
c114 if { input["x"] == 2 }
c115 if { input["y"] == 3 }
c116 if { input["f"] == true }
c117 if { c114; c115; c116 }
c118 if { input["x"] == 2 }
c119 if { input["y"] == 4 }
c120 if { input["f"] == false }
c121 if { c118; c119; c120 }
c122 if { input["x"] == 2 }
c123 if { input["y"] == 4 }
c124 if { input["f"] == true }
c125 if { c122; c123; c124 }
c126 if { input["x"] == 3 }
c127 if { input["y"] == 0 }
c128 if { input["f"] == false }
c129 if { c126; c127; c128 }
c130 if { input["x"] == 3 }
c131 if { input["y"] == 0 }
c132 if { input["f"] == true }
c133 if { c130; c131; c132 }
c134 if { input["x"] == 3 }
c135 if { input["y"] == 1 }
c136 if { input["f"] == false }
c137 if { c134; c135; c136 }
c138 if { input["x"] == 3 }
c139 if { input["y"] == 1 }
c140 if { input["f"] == true }
c141 if { c138; c139; c140 }
c142 if { input["x"] == 3 }
c143 if { input["y"] == 2 }
c144 if { input["f"] == false }
c145 if { c142; c143; c144 }
c146 if { input["x"] == 3 }
c147 if { input["y"] == 2 }
c148 if { input["f"] == true }
c149 if { c146; c147; c148 }
c150 if { input["x"] == 3 }
c151 if { input["y"] == 3 }
c152 if { input["f"] == false }
c153 if { c150; c151; c152 }
c154 if { input["x"] == 3 }
c155 if { input["y"] == 3 }
c156 if { input["f"] == true }
c157 if { c154; c155; c156 }
c158 if { input["x"] == 3 }
c159 if { input["y"] == 4 }
c160 if { input["f"] == false }
c161 if { c158; c159; c160 }
c162 if { input["x"] == 3 }
c163 if { input["y"] == 4 }
c164 if { input["f"] == true }
c165 if { c162; c163; c164 }
c166 if { input["x"] == 4 }
c167 if { input["y"] == 0 }
c168 if { input["f"] == false }
c169 if { c166; c167; c168 }
c170 if { input["x"] == 4 }
c171 if { input["y"] == 0 }
c172 if { input["f"] == true }
c173 if { c170; c171; c172 }
c174 if { input["x"] == 4 }
c175 if { input["y"] == 1 }
c176 if { input["f"] == false }
c177 if { c174; c175; c176 }
c178 if { input["x"] == 4 }
c179 if { input["y"] == 1 }
c180 if { input["f"] == true }
c181 if { c178; c179; c180 }
c182 if { input["x"] == 4 }
c183 if { input["y"] == 2 }
c184 if { input["f"] == false }
c185 if { c182; c183; c184 }
c186 if { input["x"] == 4 }
c187 if { input["y"] == 2 }
c188 if { input["f"] == true }
c189 if { c186; c187; c188 }
c190 if { input["x"] == 4 }
c191 if { input["y"] == 3 }
c192 if { input["f"] == true }
c193 if { c190; c191; c192 }
c194 if { input["x"] == 5 }
c195 if { input["y"] == 3 }
c196 if { input["f"] == true }
c197 if { c194; c195; c196 }
