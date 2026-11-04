package thesis

c0 if { true }
c1 if { input["x"] >= 2 }
c2 if { input["x"] <= 5 }
c3 if { input["y"] >= 3 }
c4 if { input["y"] <= 3 }
c5 if { input["f"] == false }
c6 if { c1; c2; c3; c4; c5 }
rule_0 if { c6 }
c7 if { input["x"] >= 3 }
c8 if { input["x"] <= 4 }
c9 if { input["y"] >= 1 }
c10 if { input["y"] <= 4 }
c11 if { c7; c8; c9; c10 }
c12 if { input["x"] >= 2 }
c13 if { input["x"] <= 5 }
c14 if { input["y"] >= 3 }
c15 if { input["y"] <= 3 }
c16 if { input["f"] == false }
c17 if { c12; c13; c14; c15; c16 }
c18 if { not c17 }
c19 if { c11; c18 }
rule_1 if { c19 }
c20 if { input["x"] >= 2 }
c21 if { input["x"] <= 5 }
c22 if { input["y"] >= 0 }
c23 if { input["y"] <= 5 }
c24 if { c20; c21; c22; c23 }
c25 if { input["x"] >= 3 }
c26 if { input["x"] <= 4 }
c27 if { input["y"] >= 1 }
c28 if { input["y"] <= 4 }
c29 if { c25; c26; c27; c28 }
c30 if { input["x"] >= 2 }
c31 if { input["x"] <= 5 }
c32 if { input["y"] >= 3 }
c33 if { input["y"] <= 3 }
c34 if { input["f"] == false }
c35 if { c30; c31; c32; c33; c34 }
c36 if { not c35 }
c37 if { c29; c36 }
c38 if { not c37 }
c39 if { c24; c38 }
c40 if { input["x"] >= 3 }
c41 if { input["x"] <= 4 }
c42 if { input["y"] >= 0 }
c43 if { input["y"] <= 3 }
c44 if { c40; c41; c42; c43 }
c45 if { input["x"] >= 2 }
c46 if { input["x"] <= 5 }
c47 if { input["y"] >= 3 }
c48 if { input["y"] <= 3 }
c49 if { input["f"] == false }
c50 if { c45; c46; c47; c48; c49 }
c51 if { not c50 }
c52 if { c44; c51 }
c53 if { not c52 }
c54 if { c39; c53 }
rule_2 if { c54 }
c55 if { input["x"] >= 3 }
c56 if { input["x"] <= 4 }
c57 if { input["y"] >= 0 }
c58 if { input["y"] <= 3 }
c59 if { c55; c56; c57; c58 }
c60 if { input["x"] >= 2 }
c61 if { input["x"] <= 5 }
c62 if { input["y"] >= 3 }
c63 if { input["y"] <= 3 }
c64 if { input["f"] == false }
c65 if { c60; c61; c62; c63; c64 }
c66 if { not c65 }
c67 if { c59; c66 }
rule_3 if { c67 }
c68 if { input["x"] >= 0 }
c69 if { input["x"] <= 2 }
c70 if { input["y"] >= 2 }
c71 if { input["y"] <= 4 }
c72 if { input["f"] == true }
c73 if { c68; c69; c70; c71; c72 }
c74 if { input["x"] >= 2 }
c75 if { input["x"] <= 5 }
c76 if { input["y"] >= 0 }
c77 if { input["y"] <= 5 }
c78 if { c74; c75; c76; c77 }
c79 if { input["x"] >= 3 }
c80 if { input["x"] <= 4 }
c81 if { input["y"] >= 1 }
c82 if { input["y"] <= 4 }
c83 if { c79; c80; c81; c82 }
c84 if { input["x"] >= 2 }
c85 if { input["x"] <= 5 }
c86 if { input["y"] >= 3 }
c87 if { input["y"] <= 3 }
c88 if { input["f"] == false }
c89 if { c84; c85; c86; c87; c88 }
c90 if { not c89 }
c91 if { c83; c90 }
c92 if { not c91 }
c93 if { c78; c92 }
c94 if { input["x"] >= 3 }
c95 if { input["x"] <= 4 }
c96 if { input["y"] >= 0 }
c97 if { input["y"] <= 3 }
c98 if { c94; c95; c96; c97 }
c99 if { input["x"] >= 2 }
c100 if { input["x"] <= 5 }
c101 if { input["y"] >= 3 }
c102 if { input["y"] <= 3 }
c103 if { input["f"] == false }
c104 if { c99; c100; c101; c102; c103 }
c105 if { not c104 }
c106 if { c98; c105 }
c107 if { not c106 }
c108 if { c93; c107 }
c109 if { not c108 }
c110 if { c73; c109 }
rule_4 if { c110 }
c111 if { input["x"] >= 1 }
c112 if { input["x"] <= 3 }
c113 if { input["y"] >= 0 }
c114 if { input["y"] <= 5 }
c115 if { c111; c112; c113; c114 }
c116 if { input["x"] >= 2 }
c117 if { input["x"] <= 5 }
c118 if { input["y"] >= 3 }
c119 if { input["y"] <= 3 }
c120 if { input["f"] == false }
c121 if { c116; c117; c118; c119; c120 }
c122 if { not c121 }
c123 if { c115; c122 }
c124 if { input["x"] >= 2 }
c125 if { input["x"] <= 5 }
c126 if { input["y"] >= 0 }
c127 if { input["y"] <= 5 }
c128 if { c124; c125; c126; c127 }
c129 if { input["x"] >= 3 }
c130 if { input["x"] <= 4 }
c131 if { input["y"] >= 1 }
c132 if { input["y"] <= 4 }
c133 if { c129; c130; c131; c132 }
c134 if { input["x"] >= 2 }
c135 if { input["x"] <= 5 }
c136 if { input["y"] >= 3 }
c137 if { input["y"] <= 3 }
c138 if { input["f"] == false }
c139 if { c134; c135; c136; c137; c138 }
c140 if { not c139 }
c141 if { c133; c140 }
c142 if { not c141 }
c143 if { c128; c142 }
c144 if { input["x"] >= 3 }
c145 if { input["x"] <= 4 }
c146 if { input["y"] >= 0 }
c147 if { input["y"] <= 3 }
c148 if { c144; c145; c146; c147 }
c149 if { input["x"] >= 2 }
c150 if { input["x"] <= 5 }
c151 if { input["y"] >= 3 }
c152 if { input["y"] <= 3 }
c153 if { input["f"] == false }
c154 if { c149; c150; c151; c152; c153 }
c155 if { not c154 }
c156 if { c148; c155 }
c157 if { not c156 }
c158 if { c143; c157 }
c159 if { not c158 }
c160 if { c123; c159 }
rule_5 if { c160 }
c161 if { input["x"] >= 3 }
c162 if { input["x"] <= 3 }
c163 if { input["y"] >= 1 }
c164 if { input["y"] <= 4 }
c165 if { c161; c162; c163; c164 }
c166 if { input["x"] >= 3 }
c167 if { input["x"] <= 4 }
c168 if { input["y"] >= 1 }
c169 if { input["y"] <= 4 }
c170 if { c166; c167; c168; c169 }
c171 if { input["x"] >= 2 }
c172 if { input["x"] <= 5 }
c173 if { input["y"] >= 3 }
c174 if { input["y"] <= 3 }
c175 if { input["f"] == false }
c176 if { c171; c172; c173; c174; c175 }
c177 if { not c176 }
c178 if { c170; c177 }
c179 if { not c178 }
c180 if { c165; c179 }
rule_6 if { c180 }
c181 if { input["x"] >= 2 }
c182 if { input["x"] <= 5 }
c183 if { input["y"] >= 3 }
c184 if { input["y"] <= 5 }
c185 if { c181; c182; c183; c184 }
c186 if { input["x"] >= 3 }
c187 if { input["x"] <= 4 }
c188 if { input["y"] >= 1 }
c189 if { input["y"] <= 4 }
c190 if { c186; c187; c188; c189 }
c191 if { input["x"] >= 2 }
c192 if { input["x"] <= 5 }
c193 if { input["y"] >= 3 }
c194 if { input["y"] <= 3 }
c195 if { input["f"] == false }
c196 if { c191; c192; c193; c194; c195 }
c197 if { not c196 }
c198 if { c190; c197 }
c199 if { not c198 }
c200 if { c185; c199 }
rule_7 if { c200 }
c201 if { input["x"] == 0 }
c202 if { input["y"] == 2 }
c203 if { input["f"] == true }
c204 if { c201; c202; c203 }
c205 if { input["x"] == 0 }
c206 if { input["y"] == 3 }
c207 if { input["f"] == true }
c208 if { c205; c206; c207 }
c209 if { input["x"] == 0 }
c210 if { input["y"] == 4 }
c211 if { input["f"] == true }
c212 if { c209; c210; c211 }
c213 if { input["x"] == 1 }
c214 if { input["y"] == 0 }
c215 if { input["f"] == false }
c216 if { c213; c214; c215 }
c217 if { input["x"] == 1 }
c218 if { input["y"] == 0 }
c219 if { input["f"] == true }
c220 if { c217; c218; c219 }
c221 if { input["x"] == 1 }
c222 if { input["y"] == 1 }
c223 if { input["f"] == false }
c224 if { c221; c222; c223 }
c225 if { input["x"] == 1 }
c226 if { input["y"] == 1 }
c227 if { input["f"] == true }
c228 if { c225; c226; c227 }
c229 if { input["x"] == 1 }
c230 if { input["y"] == 2 }
c231 if { input["f"] == false }
c232 if { c229; c230; c231 }
c233 if { input["x"] == 1 }
c234 if { input["y"] == 2 }
c235 if { input["f"] == true }
c236 if { c233; c234; c235 }
c237 if { input["x"] == 1 }
c238 if { input["y"] == 3 }
c239 if { input["f"] == false }
c240 if { c237; c238; c239 }
c241 if { input["x"] == 1 }
c242 if { input["y"] == 3 }
c243 if { input["f"] == true }
c244 if { c241; c242; c243 }
c245 if { input["x"] == 1 }
c246 if { input["y"] == 4 }
c247 if { input["f"] == false }
c248 if { c245; c246; c247 }
c249 if { input["x"] == 1 }
c250 if { input["y"] == 4 }
c251 if { input["f"] == true }
c252 if { c249; c250; c251 }
c253 if { input["x"] == 1 }
c254 if { input["y"] == 5 }
c255 if { input["f"] == false }
c256 if { c253; c254; c255 }
c257 if { input["x"] == 1 }
c258 if { input["y"] == 5 }
c259 if { input["f"] == true }
c260 if { c257; c258; c259 }
c261 if { input["x"] == 2 }
c262 if { input["y"] == 0 }
c263 if { input["f"] == false }
c264 if { c261; c262; c263 }
c265 if { input["x"] == 2 }
c266 if { input["y"] == 0 }
c267 if { input["f"] == true }
c268 if { c265; c266; c267 }
c269 if { input["x"] == 2 }
c270 if { input["y"] == 1 }
c271 if { input["f"] == false }
c272 if { c269; c270; c271 }
c273 if { input["x"] == 2 }
c274 if { input["y"] == 1 }
c275 if { input["f"] == true }
c276 if { c273; c274; c275 }
c277 if { input["x"] == 2 }
c278 if { input["y"] == 2 }
c279 if { input["f"] == false }
c280 if { c277; c278; c279 }
c281 if { input["x"] == 2 }
c282 if { input["y"] == 2 }
c283 if { input["f"] == true }
c284 if { c281; c282; c283 }
c285 if { input["x"] == 2 }
c286 if { input["y"] == 3 }
c287 if { input["f"] == false }
c288 if { c285; c286; c287 }
c289 if { input["x"] == 2 }
c290 if { input["y"] == 3 }
c291 if { input["f"] == true }
c292 if { c289; c290; c291 }
c293 if { input["x"] == 2 }
c294 if { input["y"] == 4 }
c295 if { input["f"] == false }
c296 if { c293; c294; c295 }
c297 if { input["x"] == 2 }
c298 if { input["y"] == 4 }
c299 if { input["f"] == true }
c300 if { c297; c298; c299 }
c301 if { input["x"] == 2 }
c302 if { input["y"] == 5 }
c303 if { input["f"] == false }
c304 if { c301; c302; c303 }
c305 if { input["x"] == 2 }
c306 if { input["y"] == 5 }
c307 if { input["f"] == true }
c308 if { c305; c306; c307 }
c309 if { input["x"] == 3 }
c310 if { input["y"] == 0 }
c311 if { input["f"] == false }
c312 if { c309; c310; c311 }
c313 if { input["x"] == 3 }
c314 if { input["y"] == 0 }
c315 if { input["f"] == true }
c316 if { c313; c314; c315 }
c317 if { input["x"] == 3 }
c318 if { input["y"] == 1 }
c319 if { input["f"] == false }
c320 if { c317; c318; c319 }
c321 if { input["x"] == 3 }
c322 if { input["y"] == 1 }
c323 if { input["f"] == true }
c324 if { c321; c322; c323 }
c325 if { input["x"] == 3 }
c326 if { input["y"] == 2 }
c327 if { input["f"] == false }
c328 if { c325; c326; c327 }
c329 if { input["x"] == 3 }
c330 if { input["y"] == 2 }
c331 if { input["f"] == true }
c332 if { c329; c330; c331 }
c333 if { input["x"] == 3 }
c334 if { input["y"] == 3 }
c335 if { input["f"] == false }
c336 if { c333; c334; c335 }
c337 if { input["x"] == 3 }
c338 if { input["y"] == 3 }
c339 if { input["f"] == true }
c340 if { c337; c338; c339 }
c341 if { input["x"] == 3 }
c342 if { input["y"] == 4 }
c343 if { input["f"] == false }
c344 if { c341; c342; c343 }
c345 if { input["x"] == 3 }
c346 if { input["y"] == 4 }
c347 if { input["f"] == true }
c348 if { c345; c346; c347 }
c349 if { input["x"] == 3 }
c350 if { input["y"] == 5 }
c351 if { input["f"] == false }
c352 if { c349; c350; c351 }
c353 if { input["x"] == 3 }
c354 if { input["y"] == 5 }
c355 if { input["f"] == true }
c356 if { c353; c354; c355 }
c357 if { input["x"] == 4 }
c358 if { input["y"] == 0 }
c359 if { input["f"] == false }
c360 if { c357; c358; c359 }
c361 if { input["x"] == 4 }
c362 if { input["y"] == 0 }
c363 if { input["f"] == true }
c364 if { c361; c362; c363 }
c365 if { input["x"] == 4 }
c366 if { input["y"] == 1 }
c367 if { input["f"] == false }
c368 if { c365; c366; c367 }
c369 if { input["x"] == 4 }
c370 if { input["y"] == 1 }
c371 if { input["f"] == true }
c372 if { c369; c370; c371 }
c373 if { input["x"] == 4 }
c374 if { input["y"] == 2 }
c375 if { input["f"] == false }
c376 if { c373; c374; c375 }
c377 if { input["x"] == 4 }
c378 if { input["y"] == 2 }
c379 if { input["f"] == true }
c380 if { c377; c378; c379 }
c381 if { input["x"] == 4 }
c382 if { input["y"] == 3 }
c383 if { input["f"] == false }
c384 if { c381; c382; c383 }
c385 if { input["x"] == 4 }
c386 if { input["y"] == 3 }
c387 if { input["f"] == true }
c388 if { c385; c386; c387 }
c389 if { input["x"] == 4 }
c390 if { input["y"] == 4 }
c391 if { input["f"] == false }
c392 if { c389; c390; c391 }
c393 if { input["x"] == 4 }
c394 if { input["y"] == 4 }
c395 if { input["f"] == true }
c396 if { c393; c394; c395 }
c397 if { input["x"] == 4 }
c398 if { input["y"] == 5 }
c399 if { input["f"] == false }
c400 if { c397; c398; c399 }
c401 if { input["x"] == 4 }
c402 if { input["y"] == 5 }
c403 if { input["f"] == true }
c404 if { c401; c402; c403 }
c405 if { input["x"] == 5 }
c406 if { input["y"] == 0 }
c407 if { input["f"] == false }
c408 if { c405; c406; c407 }
c409 if { input["x"] == 5 }
c410 if { input["y"] == 0 }
c411 if { input["f"] == true }
c412 if { c409; c410; c411 }
c413 if { input["x"] == 5 }
c414 if { input["y"] == 1 }
c415 if { input["f"] == false }
c416 if { c413; c414; c415 }
c417 if { input["x"] == 5 }
c418 if { input["y"] == 1 }
c419 if { input["f"] == true }
c420 if { c417; c418; c419 }
c421 if { input["x"] == 5 }
c422 if { input["y"] == 2 }
c423 if { input["f"] == false }
c424 if { c421; c422; c423 }
c425 if { input["x"] == 5 }
c426 if { input["y"] == 2 }
c427 if { input["f"] == true }
c428 if { c425; c426; c427 }
c429 if { input["x"] == 5 }
c430 if { input["y"] == 3 }
c431 if { input["f"] == false }
c432 if { c429; c430; c431 }
c433 if { input["x"] == 5 }
c434 if { input["y"] == 3 }
c435 if { input["f"] == true }
c436 if { c433; c434; c435 }
c437 if { input["x"] == 5 }
c438 if { input["y"] == 4 }
c439 if { input["f"] == false }
c440 if { c437; c438; c439 }
c441 if { input["x"] == 5 }
c442 if { input["y"] == 4 }
c443 if { input["f"] == true }
c444 if { c441; c442; c443 }
c445 if { input["x"] == 5 }
c446 if { input["y"] == 5 }
c447 if { input["f"] == false }
c448 if { c445; c446; c447 }
c449 if { input["x"] == 5 }
c450 if { input["y"] == 5 }
c451 if { input["f"] == true }
c452 if { c449; c450; c451 }
