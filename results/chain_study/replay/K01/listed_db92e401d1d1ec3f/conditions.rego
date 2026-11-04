package thesis

c0 if { true }
c1 if { input["x"] >= 0 }
c2 if { input["x"] <= 4 }
c3 if { input["y"] >= 2 }
c4 if { input["y"] <= 3 }
c5 if { input["f"] == false }
c6 if { c1; c2; c3; c4; c5 }
rule_0 if { c6 }
c7 if { input["x"] >= 3 }
c8 if { input["x"] <= 4 }
c9 if { input["y"] >= 2 }
c10 if { input["y"] <= 5 }
c11 if { c7; c8; c9; c10 }
c12 if { input["x"] >= 0 }
c13 if { input["x"] <= 4 }
c14 if { input["y"] >= 2 }
c15 if { input["y"] <= 3 }
c16 if { input["f"] == false }
c17 if { c12; c13; c14; c15; c16 }
c18 if { not c17 }
c19 if { c11; c18 }
rule_1 if { c19 }
c20 if { input["x"] >= 0 }
c21 if { input["x"] <= 3 }
c22 if { input["y"] >= 0 }
c23 if { input["y"] <= 1 }
c24 if { c20; c21; c22; c23 }
rule_2 if { c24 }
c25 if { input["x"] >= 2 }
c26 if { input["x"] <= 4 }
c27 if { input["y"] >= 5 }
c28 if { input["y"] <= 5 }
c29 if { c25; c26; c27; c28 }
c30 if { input["x"] >= 3 }
c31 if { input["x"] <= 4 }
c32 if { input["y"] >= 2 }
c33 if { input["y"] <= 5 }
c34 if { c30; c31; c32; c33 }
c35 if { input["x"] >= 0 }
c36 if { input["x"] <= 4 }
c37 if { input["y"] >= 2 }
c38 if { input["y"] <= 3 }
c39 if { input["f"] == false }
c40 if { c35; c36; c37; c38; c39 }
c41 if { not c40 }
c42 if { c34; c41 }
c43 if { not c42 }
c44 if { c29; c43 }
rule_3 if { c44 }
c45 if { input["x"] >= 4 }
c46 if { input["x"] <= 5 }
c47 if { input["y"] >= 3 }
c48 if { input["y"] <= 5 }
c49 if { input["f"] == false }
c50 if { c45; c46; c47; c48; c49 }
c51 if { input["x"] >= 0 }
c52 if { input["x"] <= 4 }
c53 if { input["y"] >= 2 }
c54 if { input["y"] <= 3 }
c55 if { input["f"] == false }
c56 if { c51; c52; c53; c54; c55 }
c57 if { not c56 }
c58 if { c50; c57 }
rule_4 if { c58 }
c59 if { input["x"] >= 3 }
c60 if { input["x"] <= 3 }
c61 if { input["y"] >= 3 }
c62 if { input["y"] <= 4 }
c63 if { input["f"] == true }
c64 if { c59; c60; c61; c62; c63 }
rule_5 if { c64 }
c65 if { input["x"] >= 2 }
c66 if { input["x"] <= 5 }
c67 if { input["y"] >= 0 }
c68 if { input["y"] <= 4 }
c69 if { input["f"] == false }
c70 if { c65; c66; c67; c68; c69 }
c71 if { input["x"] >= 3 }
c72 if { input["x"] <= 4 }
c73 if { input["y"] >= 2 }
c74 if { input["y"] <= 5 }
c75 if { c71; c72; c73; c74 }
c76 if { input["x"] >= 0 }
c77 if { input["x"] <= 4 }
c78 if { input["y"] >= 2 }
c79 if { input["y"] <= 3 }
c80 if { input["f"] == false }
c81 if { c76; c77; c78; c79; c80 }
c82 if { not c81 }
c83 if { c75; c82 }
c84 if { not c83 }
c85 if { c70; c84 }
c86 if { input["x"] >= 4 }
c87 if { input["x"] <= 5 }
c88 if { input["y"] >= 3 }
c89 if { input["y"] <= 5 }
c90 if { input["f"] == false }
c91 if { c86; c87; c88; c89; c90 }
c92 if { input["x"] >= 0 }
c93 if { input["x"] <= 4 }
c94 if { input["y"] >= 2 }
c95 if { input["y"] <= 3 }
c96 if { input["f"] == false }
c97 if { c92; c93; c94; c95; c96 }
c98 if { not c97 }
c99 if { c91; c98 }
c100 if { not c99 }
c101 if { c85; c100 }
rule_6 if { c101 }
c102 if { input["x"] == 0 }
c103 if { input["y"] == 0 }
c104 if { input["f"] == false }
c105 if { c102; c103; c104 }
c106 if { input["x"] == 0 }
c107 if { input["y"] == 0 }
c108 if { input["f"] == true }
c109 if { c106; c107; c108 }
c110 if { input["x"] == 0 }
c111 if { input["y"] == 1 }
c112 if { input["f"] == false }
c113 if { c110; c111; c112 }
c114 if { input["x"] == 0 }
c115 if { input["y"] == 1 }
c116 if { input["f"] == true }
c117 if { c114; c115; c116 }
c118 if { input["x"] == 0 }
c119 if { input["y"] == 2 }
c120 if { input["f"] == false }
c121 if { c118; c119; c120 }
c122 if { input["x"] == 0 }
c123 if { input["y"] == 3 }
c124 if { input["f"] == false }
c125 if { c122; c123; c124 }
c126 if { input["x"] == 1 }
c127 if { input["y"] == 0 }
c128 if { input["f"] == false }
c129 if { c126; c127; c128 }
c130 if { input["x"] == 1 }
c131 if { input["y"] == 0 }
c132 if { input["f"] == true }
c133 if { c130; c131; c132 }
c134 if { input["x"] == 1 }
c135 if { input["y"] == 1 }
c136 if { input["f"] == false }
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
c147 if { input["y"] == 3 }
c148 if { input["f"] == false }
c149 if { c146; c147; c148 }
c150 if { input["x"] == 2 }
c151 if { input["y"] == 0 }
c152 if { input["f"] == false }
c153 if { c150; c151; c152 }
c154 if { input["x"] == 2 }
c155 if { input["y"] == 0 }
c156 if { input["f"] == true }
c157 if { c154; c155; c156 }
c158 if { input["x"] == 2 }
c159 if { input["y"] == 1 }
c160 if { input["f"] == false }
c161 if { c158; c159; c160 }
c162 if { input["x"] == 2 }
c163 if { input["y"] == 1 }
c164 if { input["f"] == true }
c165 if { c162; c163; c164 }
c166 if { input["x"] == 2 }
c167 if { input["y"] == 2 }
c168 if { input["f"] == false }
c169 if { c166; c167; c168 }
c170 if { input["x"] == 2 }
c171 if { input["y"] == 3 }
c172 if { input["f"] == false }
c173 if { c170; c171; c172 }
c174 if { input["x"] == 2 }
c175 if { input["y"] == 4 }
c176 if { input["f"] == false }
c177 if { c174; c175; c176 }
c178 if { input["x"] == 2 }
c179 if { input["y"] == 5 }
c180 if { input["f"] == false }
c181 if { c178; c179; c180 }
c182 if { input["x"] == 2 }
c183 if { input["y"] == 5 }
c184 if { input["f"] == true }
c185 if { c182; c183; c184 }
c186 if { input["x"] == 3 }
c187 if { input["y"] == 0 }
c188 if { input["f"] == false }
c189 if { c186; c187; c188 }
c190 if { input["x"] == 3 }
c191 if { input["y"] == 0 }
c192 if { input["f"] == true }
c193 if { c190; c191; c192 }
c194 if { input["x"] == 3 }
c195 if { input["y"] == 1 }
c196 if { input["f"] == false }
c197 if { c194; c195; c196 }
c198 if { input["x"] == 3 }
c199 if { input["y"] == 1 }
c200 if { input["f"] == true }
c201 if { c198; c199; c200 }
c202 if { input["x"] == 3 }
c203 if { input["y"] == 2 }
c204 if { input["f"] == false }
c205 if { c202; c203; c204 }
c206 if { input["x"] == 3 }
c207 if { input["y"] == 2 }
c208 if { input["f"] == true }
c209 if { c206; c207; c208 }
c210 if { input["x"] == 3 }
c211 if { input["y"] == 3 }
c212 if { input["f"] == false }
c213 if { c210; c211; c212 }
c214 if { input["x"] == 3 }
c215 if { input["y"] == 3 }
c216 if { input["f"] == true }
c217 if { c214; c215; c216 }
c218 if { input["x"] == 3 }
c219 if { input["y"] == 4 }
c220 if { input["f"] == false }
c221 if { c218; c219; c220 }
c222 if { input["x"] == 3 }
c223 if { input["y"] == 4 }
c224 if { input["f"] == true }
c225 if { c222; c223; c224 }
c226 if { input["x"] == 3 }
c227 if { input["y"] == 5 }
c228 if { input["f"] == false }
c229 if { c226; c227; c228 }
c230 if { input["x"] == 3 }
c231 if { input["y"] == 5 }
c232 if { input["f"] == true }
c233 if { c230; c231; c232 }
c234 if { input["x"] == 4 }
c235 if { input["y"] == 0 }
c236 if { input["f"] == false }
c237 if { c234; c235; c236 }
c238 if { input["x"] == 4 }
c239 if { input["y"] == 1 }
c240 if { input["f"] == false }
c241 if { c238; c239; c240 }
c242 if { input["x"] == 4 }
c243 if { input["y"] == 2 }
c244 if { input["f"] == false }
c245 if { c242; c243; c244 }
c246 if { input["x"] == 4 }
c247 if { input["y"] == 2 }
c248 if { input["f"] == true }
c249 if { c246; c247; c248 }
c250 if { input["x"] == 4 }
c251 if { input["y"] == 3 }
c252 if { input["f"] == false }
c253 if { c250; c251; c252 }
c254 if { input["x"] == 4 }
c255 if { input["y"] == 3 }
c256 if { input["f"] == true }
c257 if { c254; c255; c256 }
c258 if { input["x"] == 4 }
c259 if { input["y"] == 4 }
c260 if { input["f"] == false }
c261 if { c258; c259; c260 }
c262 if { input["x"] == 4 }
c263 if { input["y"] == 4 }
c264 if { input["f"] == true }
c265 if { c262; c263; c264 }
c266 if { input["x"] == 4 }
c267 if { input["y"] == 5 }
c268 if { input["f"] == false }
c269 if { c266; c267; c268 }
c270 if { input["x"] == 4 }
c271 if { input["y"] == 5 }
c272 if { input["f"] == true }
c273 if { c270; c271; c272 }
c274 if { input["x"] == 5 }
c275 if { input["y"] == 0 }
c276 if { input["f"] == false }
c277 if { c274; c275; c276 }
c278 if { input["x"] == 5 }
c279 if { input["y"] == 1 }
c280 if { input["f"] == false }
c281 if { c278; c279; c280 }
c282 if { input["x"] == 5 }
c283 if { input["y"] == 2 }
c284 if { input["f"] == false }
c285 if { c282; c283; c284 }
c286 if { input["x"] == 5 }
c287 if { input["y"] == 3 }
c288 if { input["f"] == false }
c289 if { c286; c287; c288 }
c290 if { input["x"] == 5 }
c291 if { input["y"] == 4 }
c292 if { input["f"] == false }
c293 if { c290; c291; c292 }
c294 if { input["x"] == 5 }
c295 if { input["y"] == 5 }
c296 if { input["f"] == false }
c297 if { c294; c295; c296 }
