package thesis

c0 if { true }
c1 if { input["x"] >= 0 }
c2 if { input["x"] <= 1 }
c3 if { input["y"] >= 3 }
c4 if { input["y"] <= 4 }
c5 if { c1; c2; c3; c4 }
rule_0 if { c5 }
c6 if { input["x"] >= 5 }
c7 if { input["x"] <= 5 }
c8 if { input["y"] >= 4 }
c9 if { input["y"] <= 5 }
c10 if { c6; c7; c8; c9 }
rule_1 if { c10 }
c11 if { input["x"] >= 1 }
c12 if { input["x"] <= 1 }
c13 if { input["y"] >= 1 }
c14 if { input["y"] <= 5 }
c15 if { c11; c12; c13; c14 }
c16 if { input["x"] >= 0 }
c17 if { input["x"] <= 1 }
c18 if { input["y"] >= 3 }
c19 if { input["y"] <= 4 }
c20 if { c16; c17; c18; c19 }
c21 if { not c20 }
c22 if { c15; c21 }
rule_2 if { c22 }
c23 if { input["x"] >= 1 }
c24 if { input["x"] <= 3 }
c25 if { input["y"] >= 2 }
c26 if { input["y"] <= 5 }
c27 if { input["f"] == true }
c28 if { c23; c24; c25; c26; c27 }
c29 if { input["x"] >= 0 }
c30 if { input["x"] <= 1 }
c31 if { input["y"] >= 3 }
c32 if { input["y"] <= 4 }
c33 if { c29; c30; c31; c32 }
c34 if { not c33 }
c35 if { c28; c34 }
c36 if { input["x"] >= 1 }
c37 if { input["x"] <= 3 }
c38 if { input["y"] >= 1 }
c39 if { input["y"] <= 2 }
c40 if { c36; c37; c38; c39 }
c41 if { input["x"] >= 1 }
c42 if { input["x"] <= 1 }
c43 if { input["y"] >= 1 }
c44 if { input["y"] <= 5 }
c45 if { c41; c42; c43; c44 }
c46 if { input["x"] >= 0 }
c47 if { input["x"] <= 1 }
c48 if { input["y"] >= 3 }
c49 if { input["y"] <= 4 }
c50 if { c46; c47; c48; c49 }
c51 if { not c50 }
c52 if { c45; c51 }
c53 if { not c52 }
c54 if { c40; c53 }
c55 if { not c54 }
c56 if { c35; c55 }
rule_3 if { c56 }
c57 if { input["x"] >= 1 }
c58 if { input["x"] <= 5 }
c59 if { input["y"] >= 0 }
c60 if { input["y"] <= 4 }
c61 if { c57; c58; c59; c60 }
c62 if { input["x"] >= 0 }
c63 if { input["x"] <= 1 }
c64 if { input["y"] >= 3 }
c65 if { input["y"] <= 4 }
c66 if { c62; c63; c64; c65 }
c67 if { not c66 }
c68 if { c61; c67 }
c69 if { input["x"] >= 5 }
c70 if { input["x"] <= 5 }
c71 if { input["y"] >= 4 }
c72 if { input["y"] <= 5 }
c73 if { c69; c70; c71; c72 }
c74 if { not c73 }
c75 if { c68; c74 }
c76 if { input["x"] >= 2 }
c77 if { input["x"] <= 2 }
c78 if { input["y"] >= 0 }
c79 if { input["y"] <= 1 }
c80 if { input["f"] == true }
c81 if { c76; c77; c78; c79; c80 }
c82 if { not c81 }
c83 if { c75; c82 }
c84 if { input["x"] >= 1 }
c85 if { input["x"] <= 3 }
c86 if { input["y"] >= 1 }
c87 if { input["y"] <= 2 }
c88 if { c84; c85; c86; c87 }
c89 if { input["x"] >= 1 }
c90 if { input["x"] <= 1 }
c91 if { input["y"] >= 1 }
c92 if { input["y"] <= 5 }
c93 if { c89; c90; c91; c92 }
c94 if { input["x"] >= 0 }
c95 if { input["x"] <= 1 }
c96 if { input["y"] >= 3 }
c97 if { input["y"] <= 4 }
c98 if { c94; c95; c96; c97 }
c99 if { not c98 }
c100 if { c93; c99 }
c101 if { not c100 }
c102 if { c88; c101 }
c103 if { not c102 }
c104 if { c83; c103 }
rule_4 if { c104 }
c105 if { input["x"] >= 2 }
c106 if { input["x"] <= 2 }
c107 if { input["y"] >= 0 }
c108 if { input["y"] <= 1 }
c109 if { input["f"] == true }
c110 if { c105; c106; c107; c108; c109 }
rule_5 if { c110 }
c111 if { input["x"] >= 1 }
c112 if { input["x"] <= 3 }
c113 if { input["y"] >= 1 }
c114 if { input["y"] <= 2 }
c115 if { c111; c112; c113; c114 }
c116 if { input["x"] >= 1 }
c117 if { input["x"] <= 1 }
c118 if { input["y"] >= 1 }
c119 if { input["y"] <= 5 }
c120 if { c116; c117; c118; c119 }
c121 if { input["x"] >= 0 }
c122 if { input["x"] <= 1 }
c123 if { input["y"] >= 3 }
c124 if { input["y"] <= 4 }
c125 if { c121; c122; c123; c124 }
c126 if { not c125 }
c127 if { c120; c126 }
c128 if { not c127 }
c129 if { c115; c128 }
rule_6 if { c129 }
c130 if { input["x"] == 0 }
c131 if { input["y"] == 3 }
c132 if { input["f"] == false }
c133 if { c130; c131; c132 }
c134 if { input["x"] == 0 }
c135 if { input["y"] == 3 }
c136 if { input["f"] == true }
c137 if { c134; c135; c136 }
c138 if { input["x"] == 0 }
c139 if { input["y"] == 4 }
c140 if { input["f"] == false }
c141 if { c138; c139; c140 }
c142 if { input["x"] == 0 }
c143 if { input["y"] == 4 }
c144 if { input["f"] == true }
c145 if { c142; c143; c144 }
c146 if { input["x"] == 1 }
c147 if { input["y"] == 0 }
c148 if { input["f"] == false }
c149 if { c146; c147; c148 }
c150 if { input["x"] == 1 }
c151 if { input["y"] == 0 }
c152 if { input["f"] == true }
c153 if { c150; c151; c152 }
c154 if { input["x"] == 1 }
c155 if { input["y"] == 1 }
c156 if { input["f"] == false }
c157 if { c154; c155; c156 }
c158 if { input["x"] == 1 }
c159 if { input["y"] == 1 }
c160 if { input["f"] == true }
c161 if { c158; c159; c160 }
c162 if { input["x"] == 1 }
c163 if { input["y"] == 2 }
c164 if { input["f"] == false }
c165 if { c162; c163; c164 }
c166 if { input["x"] == 1 }
c167 if { input["y"] == 2 }
c168 if { input["f"] == true }
c169 if { c166; c167; c168 }
c170 if { input["x"] == 1 }
c171 if { input["y"] == 3 }
c172 if { input["f"] == false }
c173 if { c170; c171; c172 }
c174 if { input["x"] == 1 }
c175 if { input["y"] == 3 }
c176 if { input["f"] == true }
c177 if { c174; c175; c176 }
c178 if { input["x"] == 1 }
c179 if { input["y"] == 4 }
c180 if { input["f"] == false }
c181 if { c178; c179; c180 }
c182 if { input["x"] == 1 }
c183 if { input["y"] == 4 }
c184 if { input["f"] == true }
c185 if { c182; c183; c184 }
c186 if { input["x"] == 1 }
c187 if { input["y"] == 5 }
c188 if { input["f"] == false }
c189 if { c186; c187; c188 }
c190 if { input["x"] == 1 }
c191 if { input["y"] == 5 }
c192 if { input["f"] == true }
c193 if { c190; c191; c192 }
c194 if { input["x"] == 2 }
c195 if { input["y"] == 0 }
c196 if { input["f"] == false }
c197 if { c194; c195; c196 }
c198 if { input["x"] == 2 }
c199 if { input["y"] == 0 }
c200 if { input["f"] == true }
c201 if { c198; c199; c200 }
c202 if { input["x"] == 2 }
c203 if { input["y"] == 1 }
c204 if { input["f"] == false }
c205 if { c202; c203; c204 }
c206 if { input["x"] == 2 }
c207 if { input["y"] == 1 }
c208 if { input["f"] == true }
c209 if { c206; c207; c208 }
c210 if { input["x"] == 2 }
c211 if { input["y"] == 2 }
c212 if { input["f"] == false }
c213 if { c210; c211; c212 }
c214 if { input["x"] == 2 }
c215 if { input["y"] == 2 }
c216 if { input["f"] == true }
c217 if { c214; c215; c216 }
c218 if { input["x"] == 2 }
c219 if { input["y"] == 3 }
c220 if { input["f"] == false }
c221 if { c218; c219; c220 }
c222 if { input["x"] == 2 }
c223 if { input["y"] == 3 }
c224 if { input["f"] == true }
c225 if { c222; c223; c224 }
c226 if { input["x"] == 2 }
c227 if { input["y"] == 4 }
c228 if { input["f"] == false }
c229 if { c226; c227; c228 }
c230 if { input["x"] == 2 }
c231 if { input["y"] == 4 }
c232 if { input["f"] == true }
c233 if { c230; c231; c232 }
c234 if { input["x"] == 2 }
c235 if { input["y"] == 5 }
c236 if { input["f"] == true }
c237 if { c234; c235; c236 }
c238 if { input["x"] == 3 }
c239 if { input["y"] == 0 }
c240 if { input["f"] == false }
c241 if { c238; c239; c240 }
c242 if { input["x"] == 3 }
c243 if { input["y"] == 0 }
c244 if { input["f"] == true }
c245 if { c242; c243; c244 }
c246 if { input["x"] == 3 }
c247 if { input["y"] == 1 }
c248 if { input["f"] == false }
c249 if { c246; c247; c248 }
c250 if { input["x"] == 3 }
c251 if { input["y"] == 1 }
c252 if { input["f"] == true }
c253 if { c250; c251; c252 }
c254 if { input["x"] == 3 }
c255 if { input["y"] == 2 }
c256 if { input["f"] == false }
c257 if { c254; c255; c256 }
c258 if { input["x"] == 3 }
c259 if { input["y"] == 2 }
c260 if { input["f"] == true }
c261 if { c258; c259; c260 }
c262 if { input["x"] == 3 }
c263 if { input["y"] == 3 }
c264 if { input["f"] == false }
c265 if { c262; c263; c264 }
c266 if { input["x"] == 3 }
c267 if { input["y"] == 3 }
c268 if { input["f"] == true }
c269 if { c266; c267; c268 }
c270 if { input["x"] == 3 }
c271 if { input["y"] == 4 }
c272 if { input["f"] == false }
c273 if { c270; c271; c272 }
c274 if { input["x"] == 3 }
c275 if { input["y"] == 4 }
c276 if { input["f"] == true }
c277 if { c274; c275; c276 }
c278 if { input["x"] == 3 }
c279 if { input["y"] == 5 }
c280 if { input["f"] == true }
c281 if { c278; c279; c280 }
c282 if { input["x"] == 4 }
c283 if { input["y"] == 0 }
c284 if { input["f"] == false }
c285 if { c282; c283; c284 }
c286 if { input["x"] == 4 }
c287 if { input["y"] == 0 }
c288 if { input["f"] == true }
c289 if { c286; c287; c288 }
c290 if { input["x"] == 4 }
c291 if { input["y"] == 1 }
c292 if { input["f"] == false }
c293 if { c290; c291; c292 }
c294 if { input["x"] == 4 }
c295 if { input["y"] == 1 }
c296 if { input["f"] == true }
c297 if { c294; c295; c296 }
c298 if { input["x"] == 4 }
c299 if { input["y"] == 2 }
c300 if { input["f"] == false }
c301 if { c298; c299; c300 }
c302 if { input["x"] == 4 }
c303 if { input["y"] == 2 }
c304 if { input["f"] == true }
c305 if { c302; c303; c304 }
c306 if { input["x"] == 4 }
c307 if { input["y"] == 3 }
c308 if { input["f"] == false }
c309 if { c306; c307; c308 }
c310 if { input["x"] == 4 }
c311 if { input["y"] == 3 }
c312 if { input["f"] == true }
c313 if { c310; c311; c312 }
c314 if { input["x"] == 4 }
c315 if { input["y"] == 4 }
c316 if { input["f"] == false }
c317 if { c314; c315; c316 }
c318 if { input["x"] == 4 }
c319 if { input["y"] == 4 }
c320 if { input["f"] == true }
c321 if { c318; c319; c320 }
c322 if { input["x"] == 5 }
c323 if { input["y"] == 0 }
c324 if { input["f"] == false }
c325 if { c322; c323; c324 }
c326 if { input["x"] == 5 }
c327 if { input["y"] == 0 }
c328 if { input["f"] == true }
c329 if { c326; c327; c328 }
c330 if { input["x"] == 5 }
c331 if { input["y"] == 1 }
c332 if { input["f"] == false }
c333 if { c330; c331; c332 }
c334 if { input["x"] == 5 }
c335 if { input["y"] == 1 }
c336 if { input["f"] == true }
c337 if { c334; c335; c336 }
c338 if { input["x"] == 5 }
c339 if { input["y"] == 2 }
c340 if { input["f"] == false }
c341 if { c338; c339; c340 }
c342 if { input["x"] == 5 }
c343 if { input["y"] == 2 }
c344 if { input["f"] == true }
c345 if { c342; c343; c344 }
c346 if { input["x"] == 5 }
c347 if { input["y"] == 3 }
c348 if { input["f"] == false }
c349 if { c346; c347; c348 }
c350 if { input["x"] == 5 }
c351 if { input["y"] == 3 }
c352 if { input["f"] == true }
c353 if { c350; c351; c352 }
c354 if { input["x"] == 5 }
c355 if { input["y"] == 4 }
c356 if { input["f"] == false }
c357 if { c354; c355; c356 }
c358 if { input["x"] == 5 }
c359 if { input["y"] == 4 }
c360 if { input["f"] == true }
c361 if { c358; c359; c360 }
c362 if { input["x"] == 5 }
c363 if { input["y"] == 5 }
c364 if { input["f"] == false }
c365 if { c362; c363; c364 }
c366 if { input["x"] == 5 }
c367 if { input["y"] == 5 }
c368 if { input["f"] == true }
c369 if { c366; c367; c368 }
