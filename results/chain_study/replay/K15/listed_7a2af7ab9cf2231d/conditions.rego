package thesis

c0 if { true }
c1 if { input["x"] >= 4 }
c2 if { input["x"] <= 5 }
c3 if { input["y"] >= 5 }
c4 if { input["y"] <= 5 }
c5 if { input["f"] == true }
c6 if { c1; c2; c3; c4; c5 }
rule_0 if { c6 }
c7 if { input["x"] >= 4 }
c8 if { input["x"] <= 4 }
c9 if { input["y"] >= 4 }
c10 if { input["y"] <= 4 }
c11 if { c7; c8; c9; c10 }
rule_1 if { c11 }
c12 if { input["x"] >= 0 }
c13 if { input["x"] <= 1 }
c14 if { input["y"] >= 1 }
c15 if { input["y"] <= 4 }
c16 if { input["f"] == true }
c17 if { c12; c13; c14; c15; c16 }
rule_2 if { c17 }
c18 if { input["x"] >= 1 }
c19 if { input["x"] <= 5 }
c20 if { input["y"] >= 1 }
c21 if { input["y"] <= 3 }
c22 if { input["f"] == true }
c23 if { c18; c19; c20; c21; c22 }
c24 if { input["x"] >= 0 }
c25 if { input["x"] <= 1 }
c26 if { input["y"] >= 1 }
c27 if { input["y"] <= 4 }
c28 if { input["f"] == true }
c29 if { c24; c25; c26; c27; c28 }
c30 if { not c29 }
c31 if { c23; c30 }
rule_3 if { c31 }
c32 if { input["x"] >= 2 }
c33 if { input["x"] <= 4 }
c34 if { input["y"] >= 3 }
c35 if { input["y"] <= 3 }
c36 if { c32; c33; c34; c35 }
c37 if { input["x"] >= 1 }
c38 if { input["x"] <= 5 }
c39 if { input["y"] >= 1 }
c40 if { input["y"] <= 3 }
c41 if { input["f"] == true }
c42 if { c37; c38; c39; c40; c41 }
c43 if { input["x"] >= 0 }
c44 if { input["x"] <= 1 }
c45 if { input["y"] >= 1 }
c46 if { input["y"] <= 4 }
c47 if { input["f"] == true }
c48 if { c43; c44; c45; c46; c47 }
c49 if { not c48 }
c50 if { c42; c49 }
c51 if { not c50 }
c52 if { c36; c51 }
rule_4 if { c52 }
c53 if { input["x"] >= 1 }
c54 if { input["x"] <= 4 }
c55 if { input["y"] >= 4 }
c56 if { input["y"] <= 5 }
c57 if { input["f"] == false }
c58 if { c53; c54; c55; c56; c57 }
rule_5 if { c58 }
c59 if { input["x"] >= 0 }
c60 if { input["x"] <= 4 }
c61 if { input["y"] >= 2 }
c62 if { input["y"] <= 4 }
c63 if { c59; c60; c61; c62 }
c64 if { input["x"] >= 4 }
c65 if { input["x"] <= 4 }
c66 if { input["y"] >= 4 }
c67 if { input["y"] <= 4 }
c68 if { c64; c65; c66; c67 }
c69 if { not c68 }
c70 if { c63; c69 }
c71 if { input["x"] >= 0 }
c72 if { input["x"] <= 1 }
c73 if { input["y"] >= 1 }
c74 if { input["y"] <= 4 }
c75 if { input["f"] == true }
c76 if { c71; c72; c73; c74; c75 }
c77 if { not c76 }
c78 if { c70; c77 }
c79 if { input["x"] >= 2 }
c80 if { input["x"] <= 4 }
c81 if { input["y"] >= 3 }
c82 if { input["y"] <= 3 }
c83 if { c79; c80; c81; c82 }
c84 if { input["x"] >= 1 }
c85 if { input["x"] <= 5 }
c86 if { input["y"] >= 1 }
c87 if { input["y"] <= 3 }
c88 if { input["f"] == true }
c89 if { c84; c85; c86; c87; c88 }
c90 if { input["x"] >= 0 }
c91 if { input["x"] <= 1 }
c92 if { input["y"] >= 1 }
c93 if { input["y"] <= 4 }
c94 if { input["f"] == true }
c95 if { c90; c91; c92; c93; c94 }
c96 if { not c95 }
c97 if { c89; c96 }
c98 if { not c97 }
c99 if { c83; c98 }
c100 if { not c99 }
c101 if { c78; c100 }
c102 if { input["x"] >= 1 }
c103 if { input["x"] <= 4 }
c104 if { input["y"] >= 4 }
c105 if { input["y"] <= 5 }
c106 if { input["f"] == false }
c107 if { c102; c103; c104; c105; c106 }
c108 if { not c107 }
c109 if { c101; c108 }
rule_6 if { c109 }
c110 if { input["x"] == 0 }
c111 if { input["y"] == 1 }
c112 if { input["f"] == true }
c113 if { c110; c111; c112 }
c114 if { input["x"] == 0 }
c115 if { input["y"] == 2 }
c116 if { input["f"] == false }
c117 if { c114; c115; c116 }
c118 if { input["x"] == 0 }
c119 if { input["y"] == 2 }
c120 if { input["f"] == true }
c121 if { c118; c119; c120 }
c122 if { input["x"] == 0 }
c123 if { input["y"] == 3 }
c124 if { input["f"] == false }
c125 if { c122; c123; c124 }
c126 if { input["x"] == 0 }
c127 if { input["y"] == 3 }
c128 if { input["f"] == true }
c129 if { c126; c127; c128 }
c130 if { input["x"] == 0 }
c131 if { input["y"] == 4 }
c132 if { input["f"] == false }
c133 if { c130; c131; c132 }
c134 if { input["x"] == 0 }
c135 if { input["y"] == 4 }
c136 if { input["f"] == true }
c137 if { c134; c135; c136 }
c138 if { input["x"] == 1 }
c139 if { input["y"] == 1 }
c140 if { input["f"] == true }
c141 if { c138; c139; c140 }
c142 if { input["x"] == 1 }
c143 if { input["y"] == 2 }
c144 if { input["f"] == false }
c145 if { c142; c143; c144 }
c146 if { input["x"] == 1 }
c147 if { input["y"] == 2 }
c148 if { input["f"] == true }
c149 if { c146; c147; c148 }
c150 if { input["x"] == 1 }
c151 if { input["y"] == 3 }
c152 if { input["f"] == false }
c153 if { c150; c151; c152 }
c154 if { input["x"] == 1 }
c155 if { input["y"] == 3 }
c156 if { input["f"] == true }
c157 if { c154; c155; c156 }
c158 if { input["x"] == 1 }
c159 if { input["y"] == 4 }
c160 if { input["f"] == false }
c161 if { c158; c159; c160 }
c162 if { input["x"] == 1 }
c163 if { input["y"] == 4 }
c164 if { input["f"] == true }
c165 if { c162; c163; c164 }
c166 if { input["x"] == 1 }
c167 if { input["y"] == 5 }
c168 if { input["f"] == false }
c169 if { c166; c167; c168 }
c170 if { input["x"] == 2 }
c171 if { input["y"] == 1 }
c172 if { input["f"] == true }
c173 if { c170; c171; c172 }
c174 if { input["x"] == 2 }
c175 if { input["y"] == 2 }
c176 if { input["f"] == false }
c177 if { c174; c175; c176 }
c178 if { input["x"] == 2 }
c179 if { input["y"] == 2 }
c180 if { input["f"] == true }
c181 if { c178; c179; c180 }
c182 if { input["x"] == 2 }
c183 if { input["y"] == 3 }
c184 if { input["f"] == false }
c185 if { c182; c183; c184 }
c186 if { input["x"] == 2 }
c187 if { input["y"] == 3 }
c188 if { input["f"] == true }
c189 if { c186; c187; c188 }
c190 if { input["x"] == 2 }
c191 if { input["y"] == 4 }
c192 if { input["f"] == false }
c193 if { c190; c191; c192 }
c194 if { input["x"] == 2 }
c195 if { input["y"] == 4 }
c196 if { input["f"] == true }
c197 if { c194; c195; c196 }
c198 if { input["x"] == 2 }
c199 if { input["y"] == 5 }
c200 if { input["f"] == false }
c201 if { c198; c199; c200 }
c202 if { input["x"] == 3 }
c203 if { input["y"] == 1 }
c204 if { input["f"] == true }
c205 if { c202; c203; c204 }
c206 if { input["x"] == 3 }
c207 if { input["y"] == 2 }
c208 if { input["f"] == false }
c209 if { c206; c207; c208 }
c210 if { input["x"] == 3 }
c211 if { input["y"] == 2 }
c212 if { input["f"] == true }
c213 if { c210; c211; c212 }
c214 if { input["x"] == 3 }
c215 if { input["y"] == 3 }
c216 if { input["f"] == false }
c217 if { c214; c215; c216 }
c218 if { input["x"] == 3 }
c219 if { input["y"] == 3 }
c220 if { input["f"] == true }
c221 if { c218; c219; c220 }
c222 if { input["x"] == 3 }
c223 if { input["y"] == 4 }
c224 if { input["f"] == false }
c225 if { c222; c223; c224 }
c226 if { input["x"] == 3 }
c227 if { input["y"] == 4 }
c228 if { input["f"] == true }
c229 if { c226; c227; c228 }
c230 if { input["x"] == 3 }
c231 if { input["y"] == 5 }
c232 if { input["f"] == false }
c233 if { c230; c231; c232 }
c234 if { input["x"] == 4 }
c235 if { input["y"] == 1 }
c236 if { input["f"] == true }
c237 if { c234; c235; c236 }
c238 if { input["x"] == 4 }
c239 if { input["y"] == 2 }
c240 if { input["f"] == false }
c241 if { c238; c239; c240 }
c242 if { input["x"] == 4 }
c243 if { input["y"] == 2 }
c244 if { input["f"] == true }
c245 if { c242; c243; c244 }
c246 if { input["x"] == 4 }
c247 if { input["y"] == 3 }
c248 if { input["f"] == false }
c249 if { c246; c247; c248 }
c250 if { input["x"] == 4 }
c251 if { input["y"] == 3 }
c252 if { input["f"] == true }
c253 if { c250; c251; c252 }
c254 if { input["x"] == 4 }
c255 if { input["y"] == 4 }
c256 if { input["f"] == false }
c257 if { c254; c255; c256 }
c258 if { input["x"] == 4 }
c259 if { input["y"] == 4 }
c260 if { input["f"] == true }
c261 if { c258; c259; c260 }
c262 if { input["x"] == 4 }
c263 if { input["y"] == 5 }
c264 if { input["f"] == false }
c265 if { c262; c263; c264 }
c266 if { input["x"] == 4 }
c267 if { input["y"] == 5 }
c268 if { input["f"] == true }
c269 if { c266; c267; c268 }
c270 if { input["x"] == 5 }
c271 if { input["y"] == 1 }
c272 if { input["f"] == true }
c273 if { c270; c271; c272 }
c274 if { input["x"] == 5 }
c275 if { input["y"] == 2 }
c276 if { input["f"] == true }
c277 if { c274; c275; c276 }
c278 if { input["x"] == 5 }
c279 if { input["y"] == 3 }
c280 if { input["f"] == true }
c281 if { c278; c279; c280 }
c282 if { input["x"] == 5 }
c283 if { input["y"] == 5 }
c284 if { input["f"] == true }
c285 if { c282; c283; c284 }
