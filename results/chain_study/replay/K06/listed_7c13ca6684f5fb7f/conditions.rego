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
c14 if { input["x"] >= 0 }
c15 if { input["x"] <= 4 }
c16 if { input["y"] >= 2 }
c17 if { input["y"] <= 5 }
c18 if { input["f"] == true }
c19 if { c14; c15; c16; c17; c18 }
c20 if { input["x"] >= 3 }
c21 if { input["x"] <= 3 }
c22 if { input["y"] >= 2 }
c23 if { input["y"] <= 5 }
c24 if { input["f"] == true }
c25 if { c20; c21; c22; c23; c24 }
c26 if { not c25 }
c27 if { c19; c26 }
c28 if { input["x"] >= 0 }
c29 if { input["x"] <= 1 }
c30 if { input["y"] >= 3 }
c31 if { input["y"] <= 3 }
c32 if { c28; c29; c30; c31 }
c33 if { not c32 }
c34 if { c27; c33 }
c35 if { input["x"] >= 0 }
c36 if { input["x"] <= 2 }
c37 if { input["y"] >= 0 }
c38 if { input["y"] <= 2 }
c39 if { c35; c36; c37; c38 }
c40 if { not c39 }
c41 if { c34; c40 }
c42 if { input["x"] >= 0 }
c43 if { input["x"] <= 3 }
c44 if { input["y"] >= 0 }
c45 if { input["y"] <= 3 }
c46 if { c42; c43; c44; c45 }
c47 if { not c46 }
c48 if { c41; c47 }
rule_1 if { c48 }
c49 if { input["x"] >= 0 }
c50 if { input["x"] <= 1 }
c51 if { input["y"] >= 3 }
c52 if { input["y"] <= 3 }
c53 if { c49; c50; c51; c52 }
rule_2 if { c53 }
c54 if { input["x"] >= 2 }
c55 if { input["x"] <= 4 }
c56 if { input["y"] >= 3 }
c57 if { input["y"] <= 4 }
c58 if { c54; c55; c56; c57 }
c59 if { input["x"] >= 0 }
c60 if { input["x"] <= 3 }
c61 if { input["y"] >= 0 }
c62 if { input["y"] <= 3 }
c63 if { c59; c60; c61; c62 }
c64 if { not c63 }
c65 if { c58; c64 }
rule_3 if { c65 }
c66 if { input["x"] >= 0 }
c67 if { input["x"] <= 2 }
c68 if { input["y"] >= 0 }
c69 if { input["y"] <= 2 }
c70 if { c66; c67; c68; c69 }
rule_4 if { c70 }
c71 if { input["x"] >= 0 }
c72 if { input["x"] <= 3 }
c73 if { input["y"] >= 0 }
c74 if { input["y"] <= 3 }
c75 if { c71; c72; c73; c74 }
rule_5 if { c75 }
c76 if { input["x"] >= 3 }
c77 if { input["x"] <= 5 }
c78 if { input["y"] >= 1 }
c79 if { input["y"] <= 2 }
c80 if { c76; c77; c78; c79 }
c81 if { input["x"] >= 0 }
c82 if { input["x"] <= 4 }
c83 if { input["y"] >= 2 }
c84 if { input["y"] <= 5 }
c85 if { input["f"] == true }
c86 if { c81; c82; c83; c84; c85 }
c87 if { input["x"] >= 3 }
c88 if { input["x"] <= 3 }
c89 if { input["y"] >= 2 }
c90 if { input["y"] <= 5 }
c91 if { input["f"] == true }
c92 if { c87; c88; c89; c90; c91 }
c93 if { not c92 }
c94 if { c86; c93 }
c95 if { input["x"] >= 0 }
c96 if { input["x"] <= 1 }
c97 if { input["y"] >= 3 }
c98 if { input["y"] <= 3 }
c99 if { c95; c96; c97; c98 }
c100 if { not c99 }
c101 if { c94; c100 }
c102 if { input["x"] >= 0 }
c103 if { input["x"] <= 2 }
c104 if { input["y"] >= 0 }
c105 if { input["y"] <= 2 }
c106 if { c102; c103; c104; c105 }
c107 if { not c106 }
c108 if { c101; c107 }
c109 if { input["x"] >= 0 }
c110 if { input["x"] <= 3 }
c111 if { input["y"] >= 0 }
c112 if { input["y"] <= 3 }
c113 if { c109; c110; c111; c112 }
c114 if { not c113 }
c115 if { c108; c114 }
c116 if { not c115 }
c117 if { c80; c116 }
c118 if { input["x"] >= 5 }
c119 if { input["x"] <= 5 }
c120 if { input["y"] >= 2 }
c121 if { input["y"] <= 3 }
c122 if { c118; c119; c120; c121 }
c123 if { not c122 }
c124 if { c117; c123 }
c125 if { input["x"] >= 2 }
c126 if { input["x"] <= 5 }
c127 if { input["y"] >= 1 }
c128 if { input["y"] <= 2 }
c129 if { c125; c126; c127; c128 }
c130 if { input["x"] >= 3 }
c131 if { input["x"] <= 3 }
c132 if { input["y"] >= 2 }
c133 if { input["y"] <= 5 }
c134 if { input["f"] == true }
c135 if { c130; c131; c132; c133; c134 }
c136 if { input["x"] >= 2 }
c137 if { input["x"] <= 4 }
c138 if { input["y"] >= 3 }
c139 if { input["y"] <= 4 }
c140 if { c136; c137; c138; c139 }
c141 if { not c140 }
c142 if { c135; c141 }
c143 if { not c142 }
c144 if { c129; c143 }
c145 if { input["x"] >= 0 }
c146 if { input["x"] <= 2 }
c147 if { input["y"] >= 0 }
c148 if { input["y"] <= 2 }
c149 if { c145; c146; c147; c148 }
c150 if { not c149 }
c151 if { c144; c150 }
c152 if { input["x"] >= 0 }
c153 if { input["x"] <= 3 }
c154 if { input["y"] >= 0 }
c155 if { input["y"] <= 3 }
c156 if { c152; c153; c154; c155 }
c157 if { not c156 }
c158 if { c151; c157 }
c159 if { not c158 }
c160 if { c124; c159 }
rule_6 if { c160 }
c161 if { input["x"] >= 5 }
c162 if { input["x"] <= 5 }
c163 if { input["y"] >= 2 }
c164 if { input["y"] <= 3 }
c165 if { c161; c162; c163; c164 }
rule_7 if { c165 }
c166 if { input["x"] >= 2 }
c167 if { input["x"] <= 5 }
c168 if { input["y"] >= 1 }
c169 if { input["y"] <= 2 }
c170 if { c166; c167; c168; c169 }
c171 if { input["x"] >= 3 }
c172 if { input["x"] <= 3 }
c173 if { input["y"] >= 2 }
c174 if { input["y"] <= 5 }
c175 if { input["f"] == true }
c176 if { c171; c172; c173; c174; c175 }
c177 if { input["x"] >= 2 }
c178 if { input["x"] <= 4 }
c179 if { input["y"] >= 3 }
c180 if { input["y"] <= 4 }
c181 if { c177; c178; c179; c180 }
c182 if { not c181 }
c183 if { c176; c182 }
c184 if { not c183 }
c185 if { c170; c184 }
c186 if { input["x"] >= 0 }
c187 if { input["x"] <= 2 }
c188 if { input["y"] >= 0 }
c189 if { input["y"] <= 2 }
c190 if { c186; c187; c188; c189 }
c191 if { not c190 }
c192 if { c185; c191 }
c193 if { input["x"] >= 0 }
c194 if { input["x"] <= 3 }
c195 if { input["y"] >= 0 }
c196 if { input["y"] <= 3 }
c197 if { c193; c194; c195; c196 }
c198 if { not c197 }
c199 if { c192; c198 }
rule_8 if { c199 }
c200 if { input["x"] == 0 }
c201 if { input["y"] == 0 }
c202 if { input["f"] == false }
c203 if { c200; c201; c202 }
c204 if { input["x"] == 0 }
c205 if { input["y"] == 0 }
c206 if { input["f"] == true }
c207 if { c204; c205; c206 }
c208 if { input["x"] == 0 }
c209 if { input["y"] == 1 }
c210 if { input["f"] == false }
c211 if { c208; c209; c210 }
c212 if { input["x"] == 0 }
c213 if { input["y"] == 1 }
c214 if { input["f"] == true }
c215 if { c212; c213; c214 }
c216 if { input["x"] == 0 }
c217 if { input["y"] == 2 }
c218 if { input["f"] == false }
c219 if { c216; c217; c218 }
c220 if { input["x"] == 0 }
c221 if { input["y"] == 2 }
c222 if { input["f"] == true }
c223 if { c220; c221; c222 }
c224 if { input["x"] == 0 }
c225 if { input["y"] == 3 }
c226 if { input["f"] == false }
c227 if { c224; c225; c226 }
c228 if { input["x"] == 0 }
c229 if { input["y"] == 3 }
c230 if { input["f"] == true }
c231 if { c228; c229; c230 }
c232 if { input["x"] == 0 }
c233 if { input["y"] == 4 }
c234 if { input["f"] == true }
c235 if { c232; c233; c234 }
c236 if { input["x"] == 0 }
c237 if { input["y"] == 5 }
c238 if { input["f"] == true }
c239 if { c236; c237; c238 }
c240 if { input["x"] == 1 }
c241 if { input["y"] == 0 }
c242 if { input["f"] == false }
c243 if { c240; c241; c242 }
c244 if { input["x"] == 1 }
c245 if { input["y"] == 0 }
c246 if { input["f"] == true }
c247 if { c244; c245; c246 }
c248 if { input["x"] == 1 }
c249 if { input["y"] == 1 }
c250 if { input["f"] == false }
c251 if { c248; c249; c250 }
c252 if { input["x"] == 1 }
c253 if { input["y"] == 1 }
c254 if { input["f"] == true }
c255 if { c252; c253; c254 }
c256 if { input["x"] == 1 }
c257 if { input["y"] == 2 }
c258 if { input["f"] == false }
c259 if { c256; c257; c258 }
c260 if { input["x"] == 1 }
c261 if { input["y"] == 2 }
c262 if { input["f"] == true }
c263 if { c260; c261; c262 }
c264 if { input["x"] == 1 }
c265 if { input["y"] == 3 }
c266 if { input["f"] == false }
c267 if { c264; c265; c266 }
c268 if { input["x"] == 1 }
c269 if { input["y"] == 3 }
c270 if { input["f"] == true }
c271 if { c268; c269; c270 }
c272 if { input["x"] == 1 }
c273 if { input["y"] == 4 }
c274 if { input["f"] == true }
c275 if { c272; c273; c274 }
c276 if { input["x"] == 1 }
c277 if { input["y"] == 5 }
c278 if { input["f"] == true }
c279 if { c276; c277; c278 }
c280 if { input["x"] == 2 }
c281 if { input["y"] == 0 }
c282 if { input["f"] == false }
c283 if { c280; c281; c282 }
c284 if { input["x"] == 2 }
c285 if { input["y"] == 0 }
c286 if { input["f"] == true }
c287 if { c284; c285; c286 }
c288 if { input["x"] == 2 }
c289 if { input["y"] == 1 }
c290 if { input["f"] == false }
c291 if { c288; c289; c290 }
c292 if { input["x"] == 2 }
c293 if { input["y"] == 1 }
c294 if { input["f"] == true }
c295 if { c292; c293; c294 }
c296 if { input["x"] == 2 }
c297 if { input["y"] == 2 }
c298 if { input["f"] == false }
c299 if { c296; c297; c298 }
c300 if { input["x"] == 2 }
c301 if { input["y"] == 2 }
c302 if { input["f"] == true }
c303 if { c300; c301; c302 }
c304 if { input["x"] == 2 }
c305 if { input["y"] == 3 }
c306 if { input["f"] == false }
c307 if { c304; c305; c306 }
c308 if { input["x"] == 2 }
c309 if { input["y"] == 3 }
c310 if { input["f"] == true }
c311 if { c308; c309; c310 }
c312 if { input["x"] == 2 }
c313 if { input["y"] == 4 }
c314 if { input["f"] == false }
c315 if { c312; c313; c314 }
c316 if { input["x"] == 2 }
c317 if { input["y"] == 4 }
c318 if { input["f"] == true }
c319 if { c316; c317; c318 }
c320 if { input["x"] == 2 }
c321 if { input["y"] == 5 }
c322 if { input["f"] == true }
c323 if { c320; c321; c322 }
c324 if { input["x"] == 3 }
c325 if { input["y"] == 0 }
c326 if { input["f"] == false }
c327 if { c324; c325; c326 }
c328 if { input["x"] == 3 }
c329 if { input["y"] == 0 }
c330 if { input["f"] == true }
c331 if { c328; c329; c330 }
c332 if { input["x"] == 3 }
c333 if { input["y"] == 1 }
c334 if { input["f"] == false }
c335 if { c332; c333; c334 }
c336 if { input["x"] == 3 }
c337 if { input["y"] == 1 }
c338 if { input["f"] == true }
c339 if { c336; c337; c338 }
c340 if { input["x"] == 3 }
c341 if { input["y"] == 2 }
c342 if { input["f"] == false }
c343 if { c340; c341; c342 }
c344 if { input["x"] == 3 }
c345 if { input["y"] == 2 }
c346 if { input["f"] == true }
c347 if { c344; c345; c346 }
c348 if { input["x"] == 3 }
c349 if { input["y"] == 3 }
c350 if { input["f"] == false }
c351 if { c348; c349; c350 }
c352 if { input["x"] == 3 }
c353 if { input["y"] == 3 }
c354 if { input["f"] == true }
c355 if { c352; c353; c354 }
c356 if { input["x"] == 3 }
c357 if { input["y"] == 4 }
c358 if { input["f"] == false }
c359 if { c356; c357; c358 }
c360 if { input["x"] == 3 }
c361 if { input["y"] == 4 }
c362 if { input["f"] == true }
c363 if { c360; c361; c362 }
c364 if { input["x"] == 3 }
c365 if { input["y"] == 5 }
c366 if { input["f"] == true }
c367 if { c364; c365; c366 }
c368 if { input["x"] == 4 }
c369 if { input["y"] == 1 }
c370 if { input["f"] == false }
c371 if { c368; c369; c370 }
c372 if { input["x"] == 4 }
c373 if { input["y"] == 1 }
c374 if { input["f"] == true }
c375 if { c372; c373; c374 }
c376 if { input["x"] == 4 }
c377 if { input["y"] == 2 }
c378 if { input["f"] == false }
c379 if { c376; c377; c378 }
c380 if { input["x"] == 4 }
c381 if { input["y"] == 2 }
c382 if { input["f"] == true }
c383 if { c380; c381; c382 }
c384 if { input["x"] == 4 }
c385 if { input["y"] == 3 }
c386 if { input["f"] == false }
c387 if { c384; c385; c386 }
c388 if { input["x"] == 4 }
c389 if { input["y"] == 3 }
c390 if { input["f"] == true }
c391 if { c388; c389; c390 }
c392 if { input["x"] == 4 }
c393 if { input["y"] == 4 }
c394 if { input["f"] == false }
c395 if { c392; c393; c394 }
c396 if { input["x"] == 4 }
c397 if { input["y"] == 4 }
c398 if { input["f"] == true }
c399 if { c396; c397; c398 }
c400 if { input["x"] == 4 }
c401 if { input["y"] == 5 }
c402 if { input["f"] == true }
c403 if { c400; c401; c402 }
c404 if { input["x"] == 5 }
c405 if { input["y"] == 1 }
c406 if { input["f"] == false }
c407 if { c404; c405; c406 }
c408 if { input["x"] == 5 }
c409 if { input["y"] == 1 }
c410 if { input["f"] == true }
c411 if { c408; c409; c410 }
c412 if { input["x"] == 5 }
c413 if { input["y"] == 2 }
c414 if { input["f"] == false }
c415 if { c412; c413; c414 }
c416 if { input["x"] == 5 }
c417 if { input["y"] == 2 }
c418 if { input["f"] == true }
c419 if { c416; c417; c418 }
c420 if { input["x"] == 5 }
c421 if { input["y"] == 3 }
c422 if { input["f"] == false }
c423 if { c420; c421; c422 }
c424 if { input["x"] == 5 }
c425 if { input["y"] == 3 }
c426 if { input["f"] == true }
c427 if { c424; c425; c426 }
