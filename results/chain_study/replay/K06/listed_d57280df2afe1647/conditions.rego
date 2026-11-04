package thesis

c0 if { true }
c1 if { input["x"] >= 0 }
c2 if { input["x"] <= 4 }
c3 if { input["y"] >= 2 }
c4 if { input["y"] <= 5 }
c5 if { input["f"] == true }
c6 if { c1; c2; c3; c4; c5 }
c7 if { input["x"] >= 0 }
c8 if { input["x"] <= 2 }
c9 if { input["y"] >= 0 }
c10 if { input["y"] <= 2 }
c11 if { c7; c8; c9; c10 }
c12 if { not c11 }
c13 if { c6; c12 }
c14 if { input["x"] >= 3 }
c15 if { input["x"] <= 3 }
c16 if { input["y"] >= 2 }
c17 if { input["y"] <= 5 }
c18 if { input["f"] == true }
c19 if { c14; c15; c16; c17; c18 }
c20 if { not c19 }
c21 if { c13; c20 }
c22 if { input["x"] >= 0 }
c23 if { input["x"] <= 3 }
c24 if { input["y"] >= 0 }
c25 if { input["y"] <= 3 }
c26 if { c22; c23; c24; c25 }
c27 if { not c26 }
c28 if { c21; c27 }
rule_0 if { c28 }
c29 if { input["x"] >= 0 }
c30 if { input["x"] <= 2 }
c31 if { input["y"] >= 0 }
c32 if { input["y"] <= 2 }
c33 if { c29; c30; c31; c32 }
rule_1 if { c33 }
c34 if { input["x"] >= 2 }
c35 if { input["x"] <= 4 }
c36 if { input["y"] >= 3 }
c37 if { input["y"] <= 4 }
c38 if { c34; c35; c36; c37 }
c39 if { input["x"] >= 0 }
c40 if { input["x"] <= 3 }
c41 if { input["y"] >= 0 }
c42 if { input["y"] <= 3 }
c43 if { c39; c40; c41; c42 }
c44 if { not c43 }
c45 if { c38; c44 }
rule_2 if { c45 }
c46 if { input["x"] >= 5 }
c47 if { input["x"] <= 5 }
c48 if { input["y"] >= 2 }
c49 if { input["y"] <= 3 }
c50 if { c46; c47; c48; c49 }
rule_3 if { c50 }
c51 if { input["x"] >= 3 }
c52 if { input["x"] <= 3 }
c53 if { input["y"] >= 2 }
c54 if { input["y"] <= 5 }
c55 if { input["f"] == true }
c56 if { c51; c52; c53; c54; c55 }
c57 if { input["x"] >= 2 }
c58 if { input["x"] <= 4 }
c59 if { input["y"] >= 3 }
c60 if { input["y"] <= 4 }
c61 if { c57; c58; c59; c60 }
c62 if { not c61 }
c63 if { c56; c62 }
rule_4 if { c63 }
c64 if { input["x"] >= 0 }
c65 if { input["x"] <= 3 }
c66 if { input["y"] >= 0 }
c67 if { input["y"] <= 3 }
c68 if { c64; c65; c66; c67 }
rule_5 if { c68 }
c69 if { input["x"] >= 3 }
c70 if { input["x"] <= 5 }
c71 if { input["y"] >= 1 }
c72 if { input["y"] <= 2 }
c73 if { c69; c70; c71; c72 }
c74 if { input["x"] >= 0 }
c75 if { input["x"] <= 4 }
c76 if { input["y"] >= 2 }
c77 if { input["y"] <= 5 }
c78 if { input["f"] == true }
c79 if { c74; c75; c76; c77; c78 }
c80 if { input["x"] >= 0 }
c81 if { input["x"] <= 2 }
c82 if { input["y"] >= 0 }
c83 if { input["y"] <= 2 }
c84 if { c80; c81; c82; c83 }
c85 if { not c84 }
c86 if { c79; c85 }
c87 if { input["x"] >= 3 }
c88 if { input["x"] <= 3 }
c89 if { input["y"] >= 2 }
c90 if { input["y"] <= 5 }
c91 if { input["f"] == true }
c92 if { c87; c88; c89; c90; c91 }
c93 if { not c92 }
c94 if { c86; c93 }
c95 if { input["x"] >= 0 }
c96 if { input["x"] <= 3 }
c97 if { input["y"] >= 0 }
c98 if { input["y"] <= 3 }
c99 if { c95; c96; c97; c98 }
c100 if { not c99 }
c101 if { c94; c100 }
c102 if { not c101 }
c103 if { c73; c102 }
c104 if { input["x"] >= 5 }
c105 if { input["x"] <= 5 }
c106 if { input["y"] >= 2 }
c107 if { input["y"] <= 3 }
c108 if { c104; c105; c106; c107 }
c109 if { not c108 }
c110 if { c103; c109 }
c111 if { input["x"] >= 2 }
c112 if { input["x"] <= 5 }
c113 if { input["y"] >= 1 }
c114 if { input["y"] <= 2 }
c115 if { c111; c112; c113; c114 }
c116 if { input["x"] >= 0 }
c117 if { input["x"] <= 2 }
c118 if { input["y"] >= 0 }
c119 if { input["y"] <= 2 }
c120 if { c116; c117; c118; c119 }
c121 if { not c120 }
c122 if { c115; c121 }
c123 if { input["x"] >= 3 }
c124 if { input["x"] <= 3 }
c125 if { input["y"] >= 2 }
c126 if { input["y"] <= 5 }
c127 if { input["f"] == true }
c128 if { c123; c124; c125; c126; c127 }
c129 if { input["x"] >= 2 }
c130 if { input["x"] <= 4 }
c131 if { input["y"] >= 3 }
c132 if { input["y"] <= 4 }
c133 if { c129; c130; c131; c132 }
c134 if { not c133 }
c135 if { c128; c134 }
c136 if { not c135 }
c137 if { c122; c136 }
c138 if { input["x"] >= 0 }
c139 if { input["x"] <= 3 }
c140 if { input["y"] >= 0 }
c141 if { input["y"] <= 3 }
c142 if { c138; c139; c140; c141 }
c143 if { not c142 }
c144 if { c137; c143 }
c145 if { not c144 }
c146 if { c110; c145 }
rule_6 if { c146 }
c147 if { input["x"] >= 0 }
c148 if { input["x"] <= 1 }
c149 if { input["y"] >= 3 }
c150 if { input["y"] <= 3 }
c151 if { c147; c148; c149; c150 }
rule_7 if { c151 }
c152 if { input["x"] >= 2 }
c153 if { input["x"] <= 5 }
c154 if { input["y"] >= 1 }
c155 if { input["y"] <= 2 }
c156 if { c152; c153; c154; c155 }
c157 if { input["x"] >= 0 }
c158 if { input["x"] <= 2 }
c159 if { input["y"] >= 0 }
c160 if { input["y"] <= 2 }
c161 if { c157; c158; c159; c160 }
c162 if { not c161 }
c163 if { c156; c162 }
c164 if { input["x"] >= 3 }
c165 if { input["x"] <= 3 }
c166 if { input["y"] >= 2 }
c167 if { input["y"] <= 5 }
c168 if { input["f"] == true }
c169 if { c164; c165; c166; c167; c168 }
c170 if { input["x"] >= 2 }
c171 if { input["x"] <= 4 }
c172 if { input["y"] >= 3 }
c173 if { input["y"] <= 4 }
c174 if { c170; c171; c172; c173 }
c175 if { not c174 }
c176 if { c169; c175 }
c177 if { not c176 }
c178 if { c163; c177 }
c179 if { input["x"] >= 0 }
c180 if { input["x"] <= 3 }
c181 if { input["y"] >= 0 }
c182 if { input["y"] <= 3 }
c183 if { c179; c180; c181; c182 }
c184 if { not c183 }
c185 if { c178; c184 }
rule_8 if { c185 }
c186 if { input["x"] == 0 }
c187 if { input["y"] == 0 }
c188 if { input["f"] == false }
c189 if { c186; c187; c188 }
c190 if { input["x"] == 0 }
c191 if { input["y"] == 0 }
c192 if { input["f"] == true }
c193 if { c190; c191; c192 }
c194 if { input["x"] == 0 }
c195 if { input["y"] == 1 }
c196 if { input["f"] == false }
c197 if { c194; c195; c196 }
c198 if { input["x"] == 0 }
c199 if { input["y"] == 1 }
c200 if { input["f"] == true }
c201 if { c198; c199; c200 }
c202 if { input["x"] == 0 }
c203 if { input["y"] == 2 }
c204 if { input["f"] == false }
c205 if { c202; c203; c204 }
c206 if { input["x"] == 0 }
c207 if { input["y"] == 2 }
c208 if { input["f"] == true }
c209 if { c206; c207; c208 }
c210 if { input["x"] == 0 }
c211 if { input["y"] == 3 }
c212 if { input["f"] == false }
c213 if { c210; c211; c212 }
c214 if { input["x"] == 0 }
c215 if { input["y"] == 3 }
c216 if { input["f"] == true }
c217 if { c214; c215; c216 }
c218 if { input["x"] == 0 }
c219 if { input["y"] == 4 }
c220 if { input["f"] == true }
c221 if { c218; c219; c220 }
c222 if { input["x"] == 0 }
c223 if { input["y"] == 5 }
c224 if { input["f"] == true }
c225 if { c222; c223; c224 }
c226 if { input["x"] == 1 }
c227 if { input["y"] == 0 }
c228 if { input["f"] == false }
c229 if { c226; c227; c228 }
c230 if { input["x"] == 1 }
c231 if { input["y"] == 0 }
c232 if { input["f"] == true }
c233 if { c230; c231; c232 }
c234 if { input["x"] == 1 }
c235 if { input["y"] == 1 }
c236 if { input["f"] == false }
c237 if { c234; c235; c236 }
c238 if { input["x"] == 1 }
c239 if { input["y"] == 1 }
c240 if { input["f"] == true }
c241 if { c238; c239; c240 }
c242 if { input["x"] == 1 }
c243 if { input["y"] == 2 }
c244 if { input["f"] == false }
c245 if { c242; c243; c244 }
c246 if { input["x"] == 1 }
c247 if { input["y"] == 2 }
c248 if { input["f"] == true }
c249 if { c246; c247; c248 }
c250 if { input["x"] == 1 }
c251 if { input["y"] == 3 }
c252 if { input["f"] == false }
c253 if { c250; c251; c252 }
c254 if { input["x"] == 1 }
c255 if { input["y"] == 3 }
c256 if { input["f"] == true }
c257 if { c254; c255; c256 }
c258 if { input["x"] == 1 }
c259 if { input["y"] == 4 }
c260 if { input["f"] == true }
c261 if { c258; c259; c260 }
c262 if { input["x"] == 1 }
c263 if { input["y"] == 5 }
c264 if { input["f"] == true }
c265 if { c262; c263; c264 }
c266 if { input["x"] == 2 }
c267 if { input["y"] == 0 }
c268 if { input["f"] == false }
c269 if { c266; c267; c268 }
c270 if { input["x"] == 2 }
c271 if { input["y"] == 0 }
c272 if { input["f"] == true }
c273 if { c270; c271; c272 }
c274 if { input["x"] == 2 }
c275 if { input["y"] == 1 }
c276 if { input["f"] == false }
c277 if { c274; c275; c276 }
c278 if { input["x"] == 2 }
c279 if { input["y"] == 1 }
c280 if { input["f"] == true }
c281 if { c278; c279; c280 }
c282 if { input["x"] == 2 }
c283 if { input["y"] == 2 }
c284 if { input["f"] == false }
c285 if { c282; c283; c284 }
c286 if { input["x"] == 2 }
c287 if { input["y"] == 2 }
c288 if { input["f"] == true }
c289 if { c286; c287; c288 }
c290 if { input["x"] == 2 }
c291 if { input["y"] == 3 }
c292 if { input["f"] == false }
c293 if { c290; c291; c292 }
c294 if { input["x"] == 2 }
c295 if { input["y"] == 3 }
c296 if { input["f"] == true }
c297 if { c294; c295; c296 }
c298 if { input["x"] == 2 }
c299 if { input["y"] == 4 }
c300 if { input["f"] == false }
c301 if { c298; c299; c300 }
c302 if { input["x"] == 2 }
c303 if { input["y"] == 4 }
c304 if { input["f"] == true }
c305 if { c302; c303; c304 }
c306 if { input["x"] == 2 }
c307 if { input["y"] == 5 }
c308 if { input["f"] == true }
c309 if { c306; c307; c308 }
c310 if { input["x"] == 3 }
c311 if { input["y"] == 0 }
c312 if { input["f"] == false }
c313 if { c310; c311; c312 }
c314 if { input["x"] == 3 }
c315 if { input["y"] == 0 }
c316 if { input["f"] == true }
c317 if { c314; c315; c316 }
c318 if { input["x"] == 3 }
c319 if { input["y"] == 1 }
c320 if { input["f"] == false }
c321 if { c318; c319; c320 }
c322 if { input["x"] == 3 }
c323 if { input["y"] == 1 }
c324 if { input["f"] == true }
c325 if { c322; c323; c324 }
c326 if { input["x"] == 3 }
c327 if { input["y"] == 2 }
c328 if { input["f"] == false }
c329 if { c326; c327; c328 }
c330 if { input["x"] == 3 }
c331 if { input["y"] == 2 }
c332 if { input["f"] == true }
c333 if { c330; c331; c332 }
c334 if { input["x"] == 3 }
c335 if { input["y"] == 3 }
c336 if { input["f"] == false }
c337 if { c334; c335; c336 }
c338 if { input["x"] == 3 }
c339 if { input["y"] == 3 }
c340 if { input["f"] == true }
c341 if { c338; c339; c340 }
c342 if { input["x"] == 3 }
c343 if { input["y"] == 4 }
c344 if { input["f"] == false }
c345 if { c342; c343; c344 }
c346 if { input["x"] == 3 }
c347 if { input["y"] == 4 }
c348 if { input["f"] == true }
c349 if { c346; c347; c348 }
c350 if { input["x"] == 3 }
c351 if { input["y"] == 5 }
c352 if { input["f"] == true }
c353 if { c350; c351; c352 }
c354 if { input["x"] == 4 }
c355 if { input["y"] == 1 }
c356 if { input["f"] == false }
c357 if { c354; c355; c356 }
c358 if { input["x"] == 4 }
c359 if { input["y"] == 1 }
c360 if { input["f"] == true }
c361 if { c358; c359; c360 }
c362 if { input["x"] == 4 }
c363 if { input["y"] == 2 }
c364 if { input["f"] == false }
c365 if { c362; c363; c364 }
c366 if { input["x"] == 4 }
c367 if { input["y"] == 2 }
c368 if { input["f"] == true }
c369 if { c366; c367; c368 }
c370 if { input["x"] == 4 }
c371 if { input["y"] == 3 }
c372 if { input["f"] == false }
c373 if { c370; c371; c372 }
c374 if { input["x"] == 4 }
c375 if { input["y"] == 3 }
c376 if { input["f"] == true }
c377 if { c374; c375; c376 }
c378 if { input["x"] == 4 }
c379 if { input["y"] == 4 }
c380 if { input["f"] == false }
c381 if { c378; c379; c380 }
c382 if { input["x"] == 4 }
c383 if { input["y"] == 4 }
c384 if { input["f"] == true }
c385 if { c382; c383; c384 }
c386 if { input["x"] == 4 }
c387 if { input["y"] == 5 }
c388 if { input["f"] == true }
c389 if { c386; c387; c388 }
c390 if { input["x"] == 5 }
c391 if { input["y"] == 1 }
c392 if { input["f"] == false }
c393 if { c390; c391; c392 }
c394 if { input["x"] == 5 }
c395 if { input["y"] == 1 }
c396 if { input["f"] == true }
c397 if { c394; c395; c396 }
c398 if { input["x"] == 5 }
c399 if { input["y"] == 2 }
c400 if { input["f"] == false }
c401 if { c398; c399; c400 }
c402 if { input["x"] == 5 }
c403 if { input["y"] == 2 }
c404 if { input["f"] == true }
c405 if { c402; c403; c404 }
c406 if { input["x"] == 5 }
c407 if { input["y"] == 3 }
c408 if { input["f"] == false }
c409 if { c406; c407; c408 }
c410 if { input["x"] == 5 }
c411 if { input["y"] == 3 }
c412 if { input["f"] == true }
c413 if { c410; c411; c412 }
