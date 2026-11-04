package thesis

c0 if { true }
c1 if { input["x"] >= 1 }
c2 if { input["x"] <= 3 }
c3 if { input["y"] >= 2 }
c4 if { input["y"] <= 3 }
c5 if { input["f"] == false }
c6 if { c1; c2; c3; c4; c5 }
rule_0 if { c6 }
c7 if { input["x"] >= 2 }
c8 if { input["x"] <= 5 }
c9 if { input["y"] >= 1 }
c10 if { input["y"] <= 2 }
c11 if { c7; c8; c9; c10 }
c12 if { input["x"] >= 1 }
c13 if { input["x"] <= 3 }
c14 if { input["y"] >= 2 }
c15 if { input["y"] <= 3 }
c16 if { input["f"] == false }
c17 if { c12; c13; c14; c15; c16 }
c18 if { not c17 }
c19 if { c11; c18 }
c20 if { input["x"] >= 2 }
c21 if { input["x"] <= 5 }
c22 if { input["y"] >= 1 }
c23 if { input["y"] <= 5 }
c24 if { input["f"] == true }
c25 if { c20; c21; c22; c23; c24 }
c26 if { not c25 }
c27 if { c19; c26 }
c28 if { input["x"] >= 4 }
c29 if { input["x"] <= 5 }
c30 if { input["y"] >= 1 }
c31 if { input["y"] <= 5 }
c32 if { c28; c29; c30; c31 }
c33 if { not c32 }
c34 if { c27; c33 }
rule_1 if { c34 }
c35 if { input["x"] >= 2 }
c36 if { input["x"] <= 5 }
c37 if { input["y"] >= 1 }
c38 if { input["y"] <= 5 }
c39 if { input["f"] == true }
c40 if { c35; c36; c37; c38; c39 }
rule_2 if { c40 }
c41 if { input["x"] >= 3 }
c42 if { input["x"] <= 5 }
c43 if { input["y"] >= 1 }
c44 if { input["y"] <= 5 }
c45 if { input["f"] == true }
c46 if { c41; c42; c43; c44; c45 }
rule_3 if { c46 }
c47 if { input["x"] >= 0 }
c48 if { input["x"] <= 0 }
c49 if { input["y"] >= 1 }
c50 if { input["y"] <= 1 }
c51 if { input["f"] == false }
c52 if { c47; c48; c49; c50; c51 }
rule_4 if { c52 }
c53 if { input["x"] >= 4 }
c54 if { input["x"] <= 4 }
c55 if { input["y"] >= 2 }
c56 if { input["y"] <= 5 }
c57 if { c53; c54; c55; c56 }
c58 if { input["x"] >= 2 }
c59 if { input["x"] <= 5 }
c60 if { input["y"] >= 1 }
c61 if { input["y"] <= 2 }
c62 if { c58; c59; c60; c61 }
c63 if { input["x"] >= 1 }
c64 if { input["x"] <= 3 }
c65 if { input["y"] >= 2 }
c66 if { input["y"] <= 3 }
c67 if { input["f"] == false }
c68 if { c63; c64; c65; c66; c67 }
c69 if { not c68 }
c70 if { c62; c69 }
c71 if { input["x"] >= 2 }
c72 if { input["x"] <= 5 }
c73 if { input["y"] >= 1 }
c74 if { input["y"] <= 5 }
c75 if { input["f"] == true }
c76 if { c71; c72; c73; c74; c75 }
c77 if { not c76 }
c78 if { c70; c77 }
c79 if { not c78 }
c80 if { c57; c79 }
rule_5 if { c80 }
c81 if { input["x"] >= 4 }
c82 if { input["x"] <= 5 }
c83 if { input["y"] >= 1 }
c84 if { input["y"] <= 5 }
c85 if { c81; c82; c83; c84 }
rule_6 if { c85 }
c86 if { input["x"] == 0 }
c87 if { input["y"] == 1 }
c88 if { input["f"] == false }
c89 if { c86; c87; c88 }
c90 if { input["x"] == 1 }
c91 if { input["y"] == 2 }
c92 if { input["f"] == false }
c93 if { c90; c91; c92 }
c94 if { input["x"] == 1 }
c95 if { input["y"] == 3 }
c96 if { input["f"] == false }
c97 if { c94; c95; c96 }
c98 if { input["x"] == 2 }
c99 if { input["y"] == 1 }
c100 if { input["f"] == false }
c101 if { c98; c99; c100 }
c102 if { input["x"] == 2 }
c103 if { input["y"] == 1 }
c104 if { input["f"] == true }
c105 if { c102; c103; c104 }
c106 if { input["x"] == 2 }
c107 if { input["y"] == 2 }
c108 if { input["f"] == false }
c109 if { c106; c107; c108 }
c110 if { input["x"] == 2 }
c111 if { input["y"] == 2 }
c112 if { input["f"] == true }
c113 if { c110; c111; c112 }
c114 if { input["x"] == 2 }
c115 if { input["y"] == 3 }
c116 if { input["f"] == false }
c117 if { c114; c115; c116 }
c118 if { input["x"] == 2 }
c119 if { input["y"] == 3 }
c120 if { input["f"] == true }
c121 if { c118; c119; c120 }
c122 if { input["x"] == 2 }
c123 if { input["y"] == 4 }
c124 if { input["f"] == true }
c125 if { c122; c123; c124 }
c126 if { input["x"] == 2 }
c127 if { input["y"] == 5 }
c128 if { input["f"] == true }
c129 if { c126; c127; c128 }
c130 if { input["x"] == 3 }
c131 if { input["y"] == 1 }
c132 if { input["f"] == false }
c133 if { c130; c131; c132 }
c134 if { input["x"] == 3 }
c135 if { input["y"] == 1 }
c136 if { input["f"] == true }
c137 if { c134; c135; c136 }
c138 if { input["x"] == 3 }
c139 if { input["y"] == 2 }
c140 if { input["f"] == false }
c141 if { c138; c139; c140 }
c142 if { input["x"] == 3 }
c143 if { input["y"] == 2 }
c144 if { input["f"] == true }
c145 if { c142; c143; c144 }
c146 if { input["x"] == 3 }
c147 if { input["y"] == 3 }
c148 if { input["f"] == false }
c149 if { c146; c147; c148 }
c150 if { input["x"] == 3 }
c151 if { input["y"] == 3 }
c152 if { input["f"] == true }
c153 if { c150; c151; c152 }
c154 if { input["x"] == 3 }
c155 if { input["y"] == 4 }
c156 if { input["f"] == true }
c157 if { c154; c155; c156 }
c158 if { input["x"] == 3 }
c159 if { input["y"] == 5 }
c160 if { input["f"] == true }
c161 if { c158; c159; c160 }
c162 if { input["x"] == 4 }
c163 if { input["y"] == 1 }
c164 if { input["f"] == false }
c165 if { c162; c163; c164 }
c166 if { input["x"] == 4 }
c167 if { input["y"] == 1 }
c168 if { input["f"] == true }
c169 if { c166; c167; c168 }
c170 if { input["x"] == 4 }
c171 if { input["y"] == 2 }
c172 if { input["f"] == false }
c173 if { c170; c171; c172 }
c174 if { input["x"] == 4 }
c175 if { input["y"] == 2 }
c176 if { input["f"] == true }
c177 if { c174; c175; c176 }
c178 if { input["x"] == 4 }
c179 if { input["y"] == 3 }
c180 if { input["f"] == false }
c181 if { c178; c179; c180 }
c182 if { input["x"] == 4 }
c183 if { input["y"] == 3 }
c184 if { input["f"] == true }
c185 if { c182; c183; c184 }
c186 if { input["x"] == 4 }
c187 if { input["y"] == 4 }
c188 if { input["f"] == false }
c189 if { c186; c187; c188 }
c190 if { input["x"] == 4 }
c191 if { input["y"] == 4 }
c192 if { input["f"] == true }
c193 if { c190; c191; c192 }
c194 if { input["x"] == 4 }
c195 if { input["y"] == 5 }
c196 if { input["f"] == false }
c197 if { c194; c195; c196 }
c198 if { input["x"] == 4 }
c199 if { input["y"] == 5 }
c200 if { input["f"] == true }
c201 if { c198; c199; c200 }
c202 if { input["x"] == 5 }
c203 if { input["y"] == 1 }
c204 if { input["f"] == false }
c205 if { c202; c203; c204 }
c206 if { input["x"] == 5 }
c207 if { input["y"] == 1 }
c208 if { input["f"] == true }
c209 if { c206; c207; c208 }
c210 if { input["x"] == 5 }
c211 if { input["y"] == 2 }
c212 if { input["f"] == false }
c213 if { c210; c211; c212 }
c214 if { input["x"] == 5 }
c215 if { input["y"] == 2 }
c216 if { input["f"] == true }
c217 if { c214; c215; c216 }
c218 if { input["x"] == 5 }
c219 if { input["y"] == 3 }
c220 if { input["f"] == false }
c221 if { c218; c219; c220 }
c222 if { input["x"] == 5 }
c223 if { input["y"] == 3 }
c224 if { input["f"] == true }
c225 if { c222; c223; c224 }
c226 if { input["x"] == 5 }
c227 if { input["y"] == 4 }
c228 if { input["f"] == false }
c229 if { c226; c227; c228 }
c230 if { input["x"] == 5 }
c231 if { input["y"] == 4 }
c232 if { input["f"] == true }
c233 if { c230; c231; c232 }
c234 if { input["x"] == 5 }
c235 if { input["y"] == 5 }
c236 if { input["f"] == false }
c237 if { c234; c235; c236 }
c238 if { input["x"] == 5 }
c239 if { input["y"] == 5 }
c240 if { input["f"] == true }
c241 if { c238; c239; c240 }
