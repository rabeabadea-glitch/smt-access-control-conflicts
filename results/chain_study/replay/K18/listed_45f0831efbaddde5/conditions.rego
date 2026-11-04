package thesis

c0 if { true }
c1 if { input["x"] >= 1 }
c2 if { input["x"] <= 5 }
c3 if { input["y"] >= 0 }
c4 if { input["y"] <= 4 }
c5 if { c1; c2; c3; c4 }
c6 if { input["x"] >= 5 }
c7 if { input["x"] <= 5 }
c8 if { input["y"] >= 4 }
c9 if { input["y"] <= 5 }
c10 if { c6; c7; c8; c9 }
c11 if { not c10 }
c12 if { c5; c11 }
c13 if { input["x"] >= 1 }
c14 if { input["x"] <= 3 }
c15 if { input["y"] >= 1 }
c16 if { input["y"] <= 2 }
c17 if { c13; c14; c15; c16 }
c18 if { not c17 }
c19 if { c12; c18 }
c20 if { input["x"] >= 0 }
c21 if { input["x"] <= 1 }
c22 if { input["y"] >= 3 }
c23 if { input["y"] <= 4 }
c24 if { c20; c21; c22; c23 }
c25 if { not c24 }
c26 if { c19; c25 }
c27 if { input["x"] >= 2 }
c28 if { input["x"] <= 2 }
c29 if { input["y"] >= 0 }
c30 if { input["y"] <= 1 }
c31 if { input["f"] == true }
c32 if { c27; c28; c29; c30; c31 }
c33 if { not c32 }
c34 if { c26; c33 }
rule_0 if { c34 }
c35 if { input["x"] >= 5 }
c36 if { input["x"] <= 5 }
c37 if { input["y"] >= 4 }
c38 if { input["y"] <= 5 }
c39 if { c35; c36; c37; c38 }
rule_1 if { c39 }
c40 if { input["x"] >= 1 }
c41 if { input["x"] <= 1 }
c42 if { input["y"] >= 1 }
c43 if { input["y"] <= 5 }
c44 if { c40; c41; c42; c43 }
c45 if { input["x"] >= 0 }
c46 if { input["x"] <= 1 }
c47 if { input["y"] >= 3 }
c48 if { input["y"] <= 4 }
c49 if { c45; c46; c47; c48 }
c50 if { not c49 }
c51 if { c44; c50 }
rule_2 if { c51 }
c52 if { input["x"] >= 1 }
c53 if { input["x"] <= 3 }
c54 if { input["y"] >= 2 }
c55 if { input["y"] <= 5 }
c56 if { input["f"] == true }
c57 if { c52; c53; c54; c55; c56 }
c58 if { input["x"] >= 1 }
c59 if { input["x"] <= 3 }
c60 if { input["y"] >= 1 }
c61 if { input["y"] <= 2 }
c62 if { c58; c59; c60; c61 }
c63 if { input["x"] >= 1 }
c64 if { input["x"] <= 1 }
c65 if { input["y"] >= 1 }
c66 if { input["y"] <= 5 }
c67 if { c63; c64; c65; c66 }
c68 if { not c67 }
c69 if { c62; c68 }
c70 if { not c69 }
c71 if { c57; c70 }
c72 if { input["x"] >= 0 }
c73 if { input["x"] <= 1 }
c74 if { input["y"] >= 3 }
c75 if { input["y"] <= 4 }
c76 if { c72; c73; c74; c75 }
c77 if { not c76 }
c78 if { c71; c77 }
rule_3 if { c78 }
c79 if { input["x"] >= 1 }
c80 if { input["x"] <= 3 }
c81 if { input["y"] >= 1 }
c82 if { input["y"] <= 2 }
c83 if { c79; c80; c81; c82 }
c84 if { input["x"] >= 1 }
c85 if { input["x"] <= 1 }
c86 if { input["y"] >= 1 }
c87 if { input["y"] <= 5 }
c88 if { c84; c85; c86; c87 }
c89 if { not c88 }
c90 if { c83; c89 }
rule_4 if { c90 }
c91 if { input["x"] >= 0 }
c92 if { input["x"] <= 1 }
c93 if { input["y"] >= 3 }
c94 if { input["y"] <= 4 }
c95 if { c91; c92; c93; c94 }
rule_5 if { c95 }
c96 if { input["x"] >= 2 }
c97 if { input["x"] <= 2 }
c98 if { input["y"] >= 0 }
c99 if { input["y"] <= 1 }
c100 if { input["f"] == true }
c101 if { c96; c97; c98; c99; c100 }
rule_6 if { c101 }
c102 if { input["x"] == 0 }
c103 if { input["y"] == 3 }
c104 if { input["f"] == false }
c105 if { c102; c103; c104 }
c106 if { input["x"] == 0 }
c107 if { input["y"] == 3 }
c108 if { input["f"] == true }
c109 if { c106; c107; c108 }
c110 if { input["x"] == 0 }
c111 if { input["y"] == 4 }
c112 if { input["f"] == false }
c113 if { c110; c111; c112 }
c114 if { input["x"] == 0 }
c115 if { input["y"] == 4 }
c116 if { input["f"] == true }
c117 if { c114; c115; c116 }
c118 if { input["x"] == 1 }
c119 if { input["y"] == 0 }
c120 if { input["f"] == false }
c121 if { c118; c119; c120 }
c122 if { input["x"] == 1 }
c123 if { input["y"] == 0 }
c124 if { input["f"] == true }
c125 if { c122; c123; c124 }
c126 if { input["x"] == 1 }
c127 if { input["y"] == 1 }
c128 if { input["f"] == false }
c129 if { c126; c127; c128 }
c130 if { input["x"] == 1 }
c131 if { input["y"] == 1 }
c132 if { input["f"] == true }
c133 if { c130; c131; c132 }
c134 if { input["x"] == 1 }
c135 if { input["y"] == 2 }
c136 if { input["f"] == false }
c137 if { c134; c135; c136 }
c138 if { input["x"] == 1 }
c139 if { input["y"] == 2 }
c140 if { input["f"] == true }
c141 if { c138; c139; c140 }
c142 if { input["x"] == 1 }
c143 if { input["y"] == 3 }
c144 if { input["f"] == false }
c145 if { c142; c143; c144 }
c146 if { input["x"] == 1 }
c147 if { input["y"] == 3 }
c148 if { input["f"] == true }
c149 if { c146; c147; c148 }
c150 if { input["x"] == 1 }
c151 if { input["y"] == 4 }
c152 if { input["f"] == false }
c153 if { c150; c151; c152 }
c154 if { input["x"] == 1 }
c155 if { input["y"] == 4 }
c156 if { input["f"] == true }
c157 if { c154; c155; c156 }
c158 if { input["x"] == 1 }
c159 if { input["y"] == 5 }
c160 if { input["f"] == false }
c161 if { c158; c159; c160 }
c162 if { input["x"] == 1 }
c163 if { input["y"] == 5 }
c164 if { input["f"] == true }
c165 if { c162; c163; c164 }
c166 if { input["x"] == 2 }
c167 if { input["y"] == 0 }
c168 if { input["f"] == false }
c169 if { c166; c167; c168 }
c170 if { input["x"] == 2 }
c171 if { input["y"] == 0 }
c172 if { input["f"] == true }
c173 if { c170; c171; c172 }
c174 if { input["x"] == 2 }
c175 if { input["y"] == 1 }
c176 if { input["f"] == false }
c177 if { c174; c175; c176 }
c178 if { input["x"] == 2 }
c179 if { input["y"] == 1 }
c180 if { input["f"] == true }
c181 if { c178; c179; c180 }
c182 if { input["x"] == 2 }
c183 if { input["y"] == 2 }
c184 if { input["f"] == false }
c185 if { c182; c183; c184 }
c186 if { input["x"] == 2 }
c187 if { input["y"] == 2 }
c188 if { input["f"] == true }
c189 if { c186; c187; c188 }
c190 if { input["x"] == 2 }
c191 if { input["y"] == 3 }
c192 if { input["f"] == false }
c193 if { c190; c191; c192 }
c194 if { input["x"] == 2 }
c195 if { input["y"] == 3 }
c196 if { input["f"] == true }
c197 if { c194; c195; c196 }
c198 if { input["x"] == 2 }
c199 if { input["y"] == 4 }
c200 if { input["f"] == false }
c201 if { c198; c199; c200 }
c202 if { input["x"] == 2 }
c203 if { input["y"] == 4 }
c204 if { input["f"] == true }
c205 if { c202; c203; c204 }
c206 if { input["x"] == 2 }
c207 if { input["y"] == 5 }
c208 if { input["f"] == true }
c209 if { c206; c207; c208 }
c210 if { input["x"] == 3 }
c211 if { input["y"] == 0 }
c212 if { input["f"] == false }
c213 if { c210; c211; c212 }
c214 if { input["x"] == 3 }
c215 if { input["y"] == 0 }
c216 if { input["f"] == true }
c217 if { c214; c215; c216 }
c218 if { input["x"] == 3 }
c219 if { input["y"] == 1 }
c220 if { input["f"] == false }
c221 if { c218; c219; c220 }
c222 if { input["x"] == 3 }
c223 if { input["y"] == 1 }
c224 if { input["f"] == true }
c225 if { c222; c223; c224 }
c226 if { input["x"] == 3 }
c227 if { input["y"] == 2 }
c228 if { input["f"] == false }
c229 if { c226; c227; c228 }
c230 if { input["x"] == 3 }
c231 if { input["y"] == 2 }
c232 if { input["f"] == true }
c233 if { c230; c231; c232 }
c234 if { input["x"] == 3 }
c235 if { input["y"] == 3 }
c236 if { input["f"] == false }
c237 if { c234; c235; c236 }
c238 if { input["x"] == 3 }
c239 if { input["y"] == 3 }
c240 if { input["f"] == true }
c241 if { c238; c239; c240 }
c242 if { input["x"] == 3 }
c243 if { input["y"] == 4 }
c244 if { input["f"] == false }
c245 if { c242; c243; c244 }
c246 if { input["x"] == 3 }
c247 if { input["y"] == 4 }
c248 if { input["f"] == true }
c249 if { c246; c247; c248 }
c250 if { input["x"] == 3 }
c251 if { input["y"] == 5 }
c252 if { input["f"] == true }
c253 if { c250; c251; c252 }
c254 if { input["x"] == 4 }
c255 if { input["y"] == 0 }
c256 if { input["f"] == false }
c257 if { c254; c255; c256 }
c258 if { input["x"] == 4 }
c259 if { input["y"] == 0 }
c260 if { input["f"] == true }
c261 if { c258; c259; c260 }
c262 if { input["x"] == 4 }
c263 if { input["y"] == 1 }
c264 if { input["f"] == false }
c265 if { c262; c263; c264 }
c266 if { input["x"] == 4 }
c267 if { input["y"] == 1 }
c268 if { input["f"] == true }
c269 if { c266; c267; c268 }
c270 if { input["x"] == 4 }
c271 if { input["y"] == 2 }
c272 if { input["f"] == false }
c273 if { c270; c271; c272 }
c274 if { input["x"] == 4 }
c275 if { input["y"] == 2 }
c276 if { input["f"] == true }
c277 if { c274; c275; c276 }
c278 if { input["x"] == 4 }
c279 if { input["y"] == 3 }
c280 if { input["f"] == false }
c281 if { c278; c279; c280 }
c282 if { input["x"] == 4 }
c283 if { input["y"] == 3 }
c284 if { input["f"] == true }
c285 if { c282; c283; c284 }
c286 if { input["x"] == 4 }
c287 if { input["y"] == 4 }
c288 if { input["f"] == false }
c289 if { c286; c287; c288 }
c290 if { input["x"] == 4 }
c291 if { input["y"] == 4 }
c292 if { input["f"] == true }
c293 if { c290; c291; c292 }
c294 if { input["x"] == 5 }
c295 if { input["y"] == 0 }
c296 if { input["f"] == false }
c297 if { c294; c295; c296 }
c298 if { input["x"] == 5 }
c299 if { input["y"] == 0 }
c300 if { input["f"] == true }
c301 if { c298; c299; c300 }
c302 if { input["x"] == 5 }
c303 if { input["y"] == 1 }
c304 if { input["f"] == false }
c305 if { c302; c303; c304 }
c306 if { input["x"] == 5 }
c307 if { input["y"] == 1 }
c308 if { input["f"] == true }
c309 if { c306; c307; c308 }
c310 if { input["x"] == 5 }
c311 if { input["y"] == 2 }
c312 if { input["f"] == false }
c313 if { c310; c311; c312 }
c314 if { input["x"] == 5 }
c315 if { input["y"] == 2 }
c316 if { input["f"] == true }
c317 if { c314; c315; c316 }
c318 if { input["x"] == 5 }
c319 if { input["y"] == 3 }
c320 if { input["f"] == false }
c321 if { c318; c319; c320 }
c322 if { input["x"] == 5 }
c323 if { input["y"] == 3 }
c324 if { input["f"] == true }
c325 if { c322; c323; c324 }
c326 if { input["x"] == 5 }
c327 if { input["y"] == 4 }
c328 if { input["f"] == false }
c329 if { c326; c327; c328 }
c330 if { input["x"] == 5 }
c331 if { input["y"] == 4 }
c332 if { input["f"] == true }
c333 if { c330; c331; c332 }
c334 if { input["x"] == 5 }
c335 if { input["y"] == 5 }
c336 if { input["f"] == false }
c337 if { c334; c335; c336 }
c338 if { input["x"] == 5 }
c339 if { input["y"] == 5 }
c340 if { input["f"] == true }
c341 if { c338; c339; c340 }
