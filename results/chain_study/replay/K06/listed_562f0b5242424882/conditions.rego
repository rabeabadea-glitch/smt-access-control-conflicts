package thesis

c0 if { true }
c1 if { input["x"] >= 3 }
c2 if { input["x"] <= 3 }
c3 if { input["y"] >= 2 }
c4 if { input["y"] <= 5 }
c5 if { input["f"] == true }
c6 if { c1; c2; c3; c4; c5 }
c7 if { input["x"] >= 2 }
c8 if { input["x"] <= 4 }
c9 if { input["y"] >= 3 }
c10 if { input["y"] <= 4 }
c11 if { c7; c8; c9; c10 }
c12 if { not c11 }
c13 if { c6; c12 }
rule_0 if { c13 }
c14 if { input["x"] >= 5 }
c15 if { input["x"] <= 5 }
c16 if { input["y"] >= 2 }
c17 if { input["y"] <= 3 }
c18 if { c14; c15; c16; c17 }
rule_1 if { c18 }
c19 if { input["x"] >= 0 }
c20 if { input["x"] <= 2 }
c21 if { input["y"] >= 0 }
c22 if { input["y"] <= 2 }
c23 if { c19; c20; c21; c22 }
rule_2 if { c23 }
c24 if { input["x"] >= 0 }
c25 if { input["x"] <= 4 }
c26 if { input["y"] >= 2 }
c27 if { input["y"] <= 5 }
c28 if { input["f"] == true }
c29 if { c24; c25; c26; c27; c28 }
c30 if { input["x"] >= 3 }
c31 if { input["x"] <= 3 }
c32 if { input["y"] >= 2 }
c33 if { input["y"] <= 5 }
c34 if { input["f"] == true }
c35 if { c30; c31; c32; c33; c34 }
c36 if { not c35 }
c37 if { c29; c36 }
c38 if { input["x"] >= 0 }
c39 if { input["x"] <= 2 }
c40 if { input["y"] >= 0 }
c41 if { input["y"] <= 2 }
c42 if { c38; c39; c40; c41 }
c43 if { not c42 }
c44 if { c37; c43 }
c45 if { input["x"] >= 0 }
c46 if { input["x"] <= 1 }
c47 if { input["y"] >= 3 }
c48 if { input["y"] <= 3 }
c49 if { c45; c46; c47; c48 }
c50 if { not c49 }
c51 if { c44; c50 }
c52 if { input["x"] >= 0 }
c53 if { input["x"] <= 3 }
c54 if { input["y"] >= 0 }
c55 if { input["y"] <= 3 }
c56 if { c52; c53; c54; c55 }
c57 if { not c56 }
c58 if { c51; c57 }
rule_3 if { c58 }
c59 if { input["x"] >= 2 }
c60 if { input["x"] <= 5 }
c61 if { input["y"] >= 1 }
c62 if { input["y"] <= 2 }
c63 if { c59; c60; c61; c62 }
c64 if { input["x"] >= 3 }
c65 if { input["x"] <= 3 }
c66 if { input["y"] >= 2 }
c67 if { input["y"] <= 5 }
c68 if { input["f"] == true }
c69 if { c64; c65; c66; c67; c68 }
c70 if { not c69 }
c71 if { c63; c70 }
c72 if { input["x"] >= 0 }
c73 if { input["x"] <= 2 }
c74 if { input["y"] >= 0 }
c75 if { input["y"] <= 2 }
c76 if { c72; c73; c74; c75 }
c77 if { not c76 }
c78 if { c71; c77 }
c79 if { input["x"] >= 0 }
c80 if { input["x"] <= 3 }
c81 if { input["y"] >= 0 }
c82 if { input["y"] <= 3 }
c83 if { c79; c80; c81; c82 }
c84 if { not c83 }
c85 if { c78; c84 }
rule_4 if { c85 }
c86 if { input["x"] >= 2 }
c87 if { input["x"] <= 4 }
c88 if { input["y"] >= 3 }
c89 if { input["y"] <= 4 }
c90 if { c86; c87; c88; c89 }
c91 if { input["x"] >= 0 }
c92 if { input["x"] <= 3 }
c93 if { input["y"] >= 0 }
c94 if { input["y"] <= 3 }
c95 if { c91; c92; c93; c94 }
c96 if { not c95 }
c97 if { c90; c96 }
rule_5 if { c97 }
c98 if { input["x"] >= 0 }
c99 if { input["x"] <= 1 }
c100 if { input["y"] >= 3 }
c101 if { input["y"] <= 3 }
c102 if { c98; c99; c100; c101 }
rule_6 if { c102 }
c103 if { input["x"] >= 0 }
c104 if { input["x"] <= 3 }
c105 if { input["y"] >= 0 }
c106 if { input["y"] <= 3 }
c107 if { c103; c104; c105; c106 }
rule_7 if { c107 }
c108 if { input["x"] >= 3 }
c109 if { input["x"] <= 5 }
c110 if { input["y"] >= 1 }
c111 if { input["y"] <= 2 }
c112 if { c108; c109; c110; c111 }
c113 if { input["x"] >= 5 }
c114 if { input["x"] <= 5 }
c115 if { input["y"] >= 2 }
c116 if { input["y"] <= 3 }
c117 if { c113; c114; c115; c116 }
c118 if { not c117 }
c119 if { c112; c118 }
c120 if { input["x"] >= 0 }
c121 if { input["x"] <= 4 }
c122 if { input["y"] >= 2 }
c123 if { input["y"] <= 5 }
c124 if { input["f"] == true }
c125 if { c120; c121; c122; c123; c124 }
c126 if { input["x"] >= 3 }
c127 if { input["x"] <= 3 }
c128 if { input["y"] >= 2 }
c129 if { input["y"] <= 5 }
c130 if { input["f"] == true }
c131 if { c126; c127; c128; c129; c130 }
c132 if { not c131 }
c133 if { c125; c132 }
c134 if { input["x"] >= 0 }
c135 if { input["x"] <= 2 }
c136 if { input["y"] >= 0 }
c137 if { input["y"] <= 2 }
c138 if { c134; c135; c136; c137 }
c139 if { not c138 }
c140 if { c133; c139 }
c141 if { input["x"] >= 0 }
c142 if { input["x"] <= 1 }
c143 if { input["y"] >= 3 }
c144 if { input["y"] <= 3 }
c145 if { c141; c142; c143; c144 }
c146 if { not c145 }
c147 if { c140; c146 }
c148 if { input["x"] >= 0 }
c149 if { input["x"] <= 3 }
c150 if { input["y"] >= 0 }
c151 if { input["y"] <= 3 }
c152 if { c148; c149; c150; c151 }
c153 if { not c152 }
c154 if { c147; c153 }
c155 if { not c154 }
c156 if { c119; c155 }
c157 if { input["x"] >= 2 }
c158 if { input["x"] <= 5 }
c159 if { input["y"] >= 1 }
c160 if { input["y"] <= 2 }
c161 if { c157; c158; c159; c160 }
c162 if { input["x"] >= 3 }
c163 if { input["x"] <= 3 }
c164 if { input["y"] >= 2 }
c165 if { input["y"] <= 5 }
c166 if { input["f"] == true }
c167 if { c162; c163; c164; c165; c166 }
c168 if { not c167 }
c169 if { c161; c168 }
c170 if { input["x"] >= 0 }
c171 if { input["x"] <= 2 }
c172 if { input["y"] >= 0 }
c173 if { input["y"] <= 2 }
c174 if { c170; c171; c172; c173 }
c175 if { not c174 }
c176 if { c169; c175 }
c177 if { input["x"] >= 0 }
c178 if { input["x"] <= 3 }
c179 if { input["y"] >= 0 }
c180 if { input["y"] <= 3 }
c181 if { c177; c178; c179; c180 }
c182 if { not c181 }
c183 if { c176; c182 }
c184 if { not c183 }
c185 if { c156; c184 }
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
