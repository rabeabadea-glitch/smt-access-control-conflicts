package thesis

c0 if { true }
c1 if { input["x"] >= 3 }
c2 if { input["x"] <= 5 }
c3 if { input["y"] >= 1 }
c4 if { input["y"] <= 2 }
c5 if { c1; c2; c3; c4 }
c6 if { input["x"] >= 5 }
c7 if { input["x"] <= 5 }
c8 if { input["y"] >= 2 }
c9 if { input["y"] <= 3 }
c10 if { c6; c7; c8; c9 }
c11 if { not c10 }
c12 if { c5; c11 }
c13 if { input["x"] >= 0 }
c14 if { input["x"] <= 4 }
c15 if { input["y"] >= 2 }
c16 if { input["y"] <= 5 }
c17 if { input["f"] == true }
c18 if { c13; c14; c15; c16; c17 }
c19 if { input["x"] >= 0 }
c20 if { input["x"] <= 3 }
c21 if { input["y"] >= 0 }
c22 if { input["y"] <= 3 }
c23 if { c19; c20; c21; c22 }
c24 if { not c23 }
c25 if { c18; c24 }
c26 if { input["x"] >= 3 }
c27 if { input["x"] <= 3 }
c28 if { input["y"] >= 2 }
c29 if { input["y"] <= 5 }
c30 if { input["f"] == true }
c31 if { c26; c27; c28; c29; c30 }
c32 if { input["x"] >= 2 }
c33 if { input["x"] <= 4 }
c34 if { input["y"] >= 3 }
c35 if { input["y"] <= 4 }
c36 if { c32; c33; c34; c35 }
c37 if { input["x"] >= 0 }
c38 if { input["x"] <= 3 }
c39 if { input["y"] >= 0 }
c40 if { input["y"] <= 3 }
c41 if { c37; c38; c39; c40 }
c42 if { not c41 }
c43 if { c36; c42 }
c44 if { not c43 }
c45 if { c31; c44 }
c46 if { not c45 }
c47 if { c25; c46 }
c48 if { not c47 }
c49 if { c12; c48 }
c50 if { input["x"] >= 2 }
c51 if { input["x"] <= 5 }
c52 if { input["y"] >= 1 }
c53 if { input["y"] <= 2 }
c54 if { c50; c51; c52; c53 }
c55 if { input["x"] >= 0 }
c56 if { input["x"] <= 3 }
c57 if { input["y"] >= 0 }
c58 if { input["y"] <= 3 }
c59 if { c55; c56; c57; c58 }
c60 if { not c59 }
c61 if { c54; c60 }
c62 if { not c61 }
c63 if { c49; c62 }
rule_0 if { c63 }
c64 if { input["x"] >= 0 }
c65 if { input["x"] <= 3 }
c66 if { input["y"] >= 0 }
c67 if { input["y"] <= 3 }
c68 if { c64; c65; c66; c67 }
rule_1 if { c68 }
c69 if { input["x"] >= 0 }
c70 if { input["x"] <= 4 }
c71 if { input["y"] >= 2 }
c72 if { input["y"] <= 5 }
c73 if { input["f"] == true }
c74 if { c69; c70; c71; c72; c73 }
c75 if { input["x"] >= 0 }
c76 if { input["x"] <= 3 }
c77 if { input["y"] >= 0 }
c78 if { input["y"] <= 3 }
c79 if { c75; c76; c77; c78 }
c80 if { not c79 }
c81 if { c74; c80 }
c82 if { input["x"] >= 3 }
c83 if { input["x"] <= 3 }
c84 if { input["y"] >= 2 }
c85 if { input["y"] <= 5 }
c86 if { input["f"] == true }
c87 if { c82; c83; c84; c85; c86 }
c88 if { input["x"] >= 2 }
c89 if { input["x"] <= 4 }
c90 if { input["y"] >= 3 }
c91 if { input["y"] <= 4 }
c92 if { c88; c89; c90; c91 }
c93 if { input["x"] >= 0 }
c94 if { input["x"] <= 3 }
c95 if { input["y"] >= 0 }
c96 if { input["y"] <= 3 }
c97 if { c93; c94; c95; c96 }
c98 if { not c97 }
c99 if { c92; c98 }
c100 if { not c99 }
c101 if { c87; c100 }
c102 if { not c101 }
c103 if { c81; c102 }
rule_2 if { c103 }
c104 if { input["x"] >= 0 }
c105 if { input["x"] <= 2 }
c106 if { input["y"] >= 0 }
c107 if { input["y"] <= 2 }
c108 if { c104; c105; c106; c107 }
rule_3 if { c108 }
c109 if { input["x"] >= 5 }
c110 if { input["x"] <= 5 }
c111 if { input["y"] >= 2 }
c112 if { input["y"] <= 3 }
c113 if { c109; c110; c111; c112 }
rule_4 if { c113 }
c114 if { input["x"] >= 2 }
c115 if { input["x"] <= 4 }
c116 if { input["y"] >= 3 }
c117 if { input["y"] <= 4 }
c118 if { c114; c115; c116; c117 }
c119 if { input["x"] >= 0 }
c120 if { input["x"] <= 3 }
c121 if { input["y"] >= 0 }
c122 if { input["y"] <= 3 }
c123 if { c119; c120; c121; c122 }
c124 if { not c123 }
c125 if { c118; c124 }
rule_5 if { c125 }
c126 if { input["x"] >= 0 }
c127 if { input["x"] <= 1 }
c128 if { input["y"] >= 3 }
c129 if { input["y"] <= 3 }
c130 if { c126; c127; c128; c129 }
rule_6 if { c130 }
c131 if { input["x"] >= 2 }
c132 if { input["x"] <= 5 }
c133 if { input["y"] >= 1 }
c134 if { input["y"] <= 2 }
c135 if { c131; c132; c133; c134 }
c136 if { input["x"] >= 0 }
c137 if { input["x"] <= 3 }
c138 if { input["y"] >= 0 }
c139 if { input["y"] <= 3 }
c140 if { c136; c137; c138; c139 }
c141 if { not c140 }
c142 if { c135; c141 }
rule_7 if { c142 }
c143 if { input["x"] >= 3 }
c144 if { input["x"] <= 3 }
c145 if { input["y"] >= 2 }
c146 if { input["y"] <= 5 }
c147 if { input["f"] == true }
c148 if { c143; c144; c145; c146; c147 }
c149 if { input["x"] >= 2 }
c150 if { input["x"] <= 4 }
c151 if { input["y"] >= 3 }
c152 if { input["y"] <= 4 }
c153 if { c149; c150; c151; c152 }
c154 if { input["x"] >= 0 }
c155 if { input["x"] <= 3 }
c156 if { input["y"] >= 0 }
c157 if { input["y"] <= 3 }
c158 if { c154; c155; c156; c157 }
c159 if { not c158 }
c160 if { c153; c159 }
c161 if { not c160 }
c162 if { c148; c161 }
rule_8 if { c162 }
c163 if { input["x"] == 0 }
c164 if { input["y"] == 0 }
c165 if { input["f"] == false }
c166 if { c163; c164; c165 }
c167 if { input["x"] == 0 }
c168 if { input["y"] == 0 }
c169 if { input["f"] == true }
c170 if { c167; c168; c169 }
c171 if { input["x"] == 0 }
c172 if { input["y"] == 1 }
c173 if { input["f"] == false }
c174 if { c171; c172; c173 }
c175 if { input["x"] == 0 }
c176 if { input["y"] == 1 }
c177 if { input["f"] == true }
c178 if { c175; c176; c177 }
c179 if { input["x"] == 0 }
c180 if { input["y"] == 2 }
c181 if { input["f"] == false }
c182 if { c179; c180; c181 }
c183 if { input["x"] == 0 }
c184 if { input["y"] == 2 }
c185 if { input["f"] == true }
c186 if { c183; c184; c185 }
c187 if { input["x"] == 0 }
c188 if { input["y"] == 3 }
c189 if { input["f"] == false }
c190 if { c187; c188; c189 }
c191 if { input["x"] == 0 }
c192 if { input["y"] == 3 }
c193 if { input["f"] == true }
c194 if { c191; c192; c193 }
c195 if { input["x"] == 0 }
c196 if { input["y"] == 4 }
c197 if { input["f"] == true }
c198 if { c195; c196; c197 }
c199 if { input["x"] == 0 }
c200 if { input["y"] == 5 }
c201 if { input["f"] == true }
c202 if { c199; c200; c201 }
c203 if { input["x"] == 1 }
c204 if { input["y"] == 0 }
c205 if { input["f"] == false }
c206 if { c203; c204; c205 }
c207 if { input["x"] == 1 }
c208 if { input["y"] == 0 }
c209 if { input["f"] == true }
c210 if { c207; c208; c209 }
c211 if { input["x"] == 1 }
c212 if { input["y"] == 1 }
c213 if { input["f"] == false }
c214 if { c211; c212; c213 }
c215 if { input["x"] == 1 }
c216 if { input["y"] == 1 }
c217 if { input["f"] == true }
c218 if { c215; c216; c217 }
c219 if { input["x"] == 1 }
c220 if { input["y"] == 2 }
c221 if { input["f"] == false }
c222 if { c219; c220; c221 }
c223 if { input["x"] == 1 }
c224 if { input["y"] == 2 }
c225 if { input["f"] == true }
c226 if { c223; c224; c225 }
c227 if { input["x"] == 1 }
c228 if { input["y"] == 3 }
c229 if { input["f"] == false }
c230 if { c227; c228; c229 }
c231 if { input["x"] == 1 }
c232 if { input["y"] == 3 }
c233 if { input["f"] == true }
c234 if { c231; c232; c233 }
c235 if { input["x"] == 1 }
c236 if { input["y"] == 4 }
c237 if { input["f"] == true }
c238 if { c235; c236; c237 }
c239 if { input["x"] == 1 }
c240 if { input["y"] == 5 }
c241 if { input["f"] == true }
c242 if { c239; c240; c241 }
c243 if { input["x"] == 2 }
c244 if { input["y"] == 0 }
c245 if { input["f"] == false }
c246 if { c243; c244; c245 }
c247 if { input["x"] == 2 }
c248 if { input["y"] == 0 }
c249 if { input["f"] == true }
c250 if { c247; c248; c249 }
c251 if { input["x"] == 2 }
c252 if { input["y"] == 1 }
c253 if { input["f"] == false }
c254 if { c251; c252; c253 }
c255 if { input["x"] == 2 }
c256 if { input["y"] == 1 }
c257 if { input["f"] == true }
c258 if { c255; c256; c257 }
c259 if { input["x"] == 2 }
c260 if { input["y"] == 2 }
c261 if { input["f"] == false }
c262 if { c259; c260; c261 }
c263 if { input["x"] == 2 }
c264 if { input["y"] == 2 }
c265 if { input["f"] == true }
c266 if { c263; c264; c265 }
c267 if { input["x"] == 2 }
c268 if { input["y"] == 3 }
c269 if { input["f"] == false }
c270 if { c267; c268; c269 }
c271 if { input["x"] == 2 }
c272 if { input["y"] == 3 }
c273 if { input["f"] == true }
c274 if { c271; c272; c273 }
c275 if { input["x"] == 2 }
c276 if { input["y"] == 4 }
c277 if { input["f"] == false }
c278 if { c275; c276; c277 }
c279 if { input["x"] == 2 }
c280 if { input["y"] == 4 }
c281 if { input["f"] == true }
c282 if { c279; c280; c281 }
c283 if { input["x"] == 2 }
c284 if { input["y"] == 5 }
c285 if { input["f"] == true }
c286 if { c283; c284; c285 }
c287 if { input["x"] == 3 }
c288 if { input["y"] == 0 }
c289 if { input["f"] == false }
c290 if { c287; c288; c289 }
c291 if { input["x"] == 3 }
c292 if { input["y"] == 0 }
c293 if { input["f"] == true }
c294 if { c291; c292; c293 }
c295 if { input["x"] == 3 }
c296 if { input["y"] == 1 }
c297 if { input["f"] == false }
c298 if { c295; c296; c297 }
c299 if { input["x"] == 3 }
c300 if { input["y"] == 1 }
c301 if { input["f"] == true }
c302 if { c299; c300; c301 }
c303 if { input["x"] == 3 }
c304 if { input["y"] == 2 }
c305 if { input["f"] == false }
c306 if { c303; c304; c305 }
c307 if { input["x"] == 3 }
c308 if { input["y"] == 2 }
c309 if { input["f"] == true }
c310 if { c307; c308; c309 }
c311 if { input["x"] == 3 }
c312 if { input["y"] == 3 }
c313 if { input["f"] == false }
c314 if { c311; c312; c313 }
c315 if { input["x"] == 3 }
c316 if { input["y"] == 3 }
c317 if { input["f"] == true }
c318 if { c315; c316; c317 }
c319 if { input["x"] == 3 }
c320 if { input["y"] == 4 }
c321 if { input["f"] == false }
c322 if { c319; c320; c321 }
c323 if { input["x"] == 3 }
c324 if { input["y"] == 4 }
c325 if { input["f"] == true }
c326 if { c323; c324; c325 }
c327 if { input["x"] == 3 }
c328 if { input["y"] == 5 }
c329 if { input["f"] == true }
c330 if { c327; c328; c329 }
c331 if { input["x"] == 4 }
c332 if { input["y"] == 1 }
c333 if { input["f"] == false }
c334 if { c331; c332; c333 }
c335 if { input["x"] == 4 }
c336 if { input["y"] == 1 }
c337 if { input["f"] == true }
c338 if { c335; c336; c337 }
c339 if { input["x"] == 4 }
c340 if { input["y"] == 2 }
c341 if { input["f"] == false }
c342 if { c339; c340; c341 }
c343 if { input["x"] == 4 }
c344 if { input["y"] == 2 }
c345 if { input["f"] == true }
c346 if { c343; c344; c345 }
c347 if { input["x"] == 4 }
c348 if { input["y"] == 3 }
c349 if { input["f"] == false }
c350 if { c347; c348; c349 }
c351 if { input["x"] == 4 }
c352 if { input["y"] == 3 }
c353 if { input["f"] == true }
c354 if { c351; c352; c353 }
c355 if { input["x"] == 4 }
c356 if { input["y"] == 4 }
c357 if { input["f"] == false }
c358 if { c355; c356; c357 }
c359 if { input["x"] == 4 }
c360 if { input["y"] == 4 }
c361 if { input["f"] == true }
c362 if { c359; c360; c361 }
c363 if { input["x"] == 4 }
c364 if { input["y"] == 5 }
c365 if { input["f"] == true }
c366 if { c363; c364; c365 }
c367 if { input["x"] == 5 }
c368 if { input["y"] == 1 }
c369 if { input["f"] == false }
c370 if { c367; c368; c369 }
c371 if { input["x"] == 5 }
c372 if { input["y"] == 1 }
c373 if { input["f"] == true }
c374 if { c371; c372; c373 }
c375 if { input["x"] == 5 }
c376 if { input["y"] == 2 }
c377 if { input["f"] == false }
c378 if { c375; c376; c377 }
c379 if { input["x"] == 5 }
c380 if { input["y"] == 2 }
c381 if { input["f"] == true }
c382 if { c379; c380; c381 }
c383 if { input["x"] == 5 }
c384 if { input["y"] == 3 }
c385 if { input["f"] == false }
c386 if { c383; c384; c385 }
c387 if { input["x"] == 5 }
c388 if { input["y"] == 3 }
c389 if { input["f"] == true }
c390 if { c387; c388; c389 }
