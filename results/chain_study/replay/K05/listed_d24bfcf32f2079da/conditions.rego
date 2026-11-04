package thesis

c0 if { true }
c1 if { input["x"] >= 3 }
c2 if { input["x"] <= 4 }
c3 if { input["y"] >= 1 }
c4 if { input["y"] <= 4 }
c5 if { c1; c2; c3; c4 }
c6 if { input["x"] >= 2 }
c7 if { input["x"] <= 5 }
c8 if { input["y"] >= 3 }
c9 if { input["y"] <= 3 }
c10 if { input["f"] == false }
c11 if { c6; c7; c8; c9; c10 }
c12 if { not c11 }
c13 if { c5; c12 }
rule_0 if { c13 }
c14 if { input["x"] >= 2 }
c15 if { input["x"] <= 5 }
c16 if { input["y"] >= 3 }
c17 if { input["y"] <= 3 }
c18 if { input["f"] == false }
c19 if { c14; c15; c16; c17; c18 }
rule_1 if { c19 }
c20 if { input["x"] >= 0 }
c21 if { input["x"] <= 2 }
c22 if { input["y"] >= 2 }
c23 if { input["y"] <= 4 }
c24 if { input["f"] == true }
c25 if { c20; c21; c22; c23; c24 }
c26 if { input["x"] >= 2 }
c27 if { input["x"] <= 5 }
c28 if { input["y"] >= 0 }
c29 if { input["y"] <= 5 }
c30 if { c26; c27; c28; c29 }
c31 if { input["x"] >= 3 }
c32 if { input["x"] <= 4 }
c33 if { input["y"] >= 1 }
c34 if { input["y"] <= 4 }
c35 if { c31; c32; c33; c34 }
c36 if { input["x"] >= 2 }
c37 if { input["x"] <= 5 }
c38 if { input["y"] >= 3 }
c39 if { input["y"] <= 3 }
c40 if { input["f"] == false }
c41 if { c36; c37; c38; c39; c40 }
c42 if { not c41 }
c43 if { c35; c42 }
c44 if { not c43 }
c45 if { c30; c44 }
c46 if { not c45 }
c47 if { c25; c46 }
rule_2 if { c47 }
c48 if { input["x"] >= 2 }
c49 if { input["x"] <= 5 }
c50 if { input["y"] >= 3 }
c51 if { input["y"] <= 5 }
c52 if { c48; c49; c50; c51 }
c53 if { input["x"] >= 3 }
c54 if { input["x"] <= 4 }
c55 if { input["y"] >= 1 }
c56 if { input["y"] <= 4 }
c57 if { c53; c54; c55; c56 }
c58 if { input["x"] >= 2 }
c59 if { input["x"] <= 5 }
c60 if { input["y"] >= 3 }
c61 if { input["y"] <= 3 }
c62 if { input["f"] == false }
c63 if { c58; c59; c60; c61; c62 }
c64 if { not c63 }
c65 if { c57; c64 }
c66 if { not c65 }
c67 if { c52; c66 }
c68 if { input["x"] >= 0 }
c69 if { input["x"] <= 2 }
c70 if { input["y"] >= 2 }
c71 if { input["y"] <= 4 }
c72 if { input["f"] == true }
c73 if { c68; c69; c70; c71; c72 }
c74 if { not c73 }
c75 if { c67; c74 }
c76 if { input["x"] >= 1 }
c77 if { input["x"] <= 3 }
c78 if { input["y"] >= 0 }
c79 if { input["y"] <= 5 }
c80 if { c76; c77; c78; c79 }
c81 if { input["x"] >= 2 }
c82 if { input["x"] <= 5 }
c83 if { input["y"] >= 3 }
c84 if { input["y"] <= 3 }
c85 if { input["f"] == false }
c86 if { c81; c82; c83; c84; c85 }
c87 if { not c86 }
c88 if { c80; c87 }
c89 if { not c88 }
c90 if { c75; c89 }
rule_3 if { c90 }
c91 if { input["x"] >= 3 }
c92 if { input["x"] <= 3 }
c93 if { input["y"] >= 1 }
c94 if { input["y"] <= 4 }
c95 if { c91; c92; c93; c94 }
c96 if { input["x"] >= 3 }
c97 if { input["x"] <= 4 }
c98 if { input["y"] >= 1 }
c99 if { input["y"] <= 4 }
c100 if { c96; c97; c98; c99 }
c101 if { input["x"] >= 2 }
c102 if { input["x"] <= 5 }
c103 if { input["y"] >= 3 }
c104 if { input["y"] <= 3 }
c105 if { input["f"] == false }
c106 if { c101; c102; c103; c104; c105 }
c107 if { not c106 }
c108 if { c100; c107 }
c109 if { not c108 }
c110 if { c95; c109 }
rule_4 if { c110 }
c111 if { input["x"] >= 3 }
c112 if { input["x"] <= 4 }
c113 if { input["y"] >= 0 }
c114 if { input["y"] <= 3 }
c115 if { c111; c112; c113; c114 }
c116 if { input["x"] >= 2 }
c117 if { input["x"] <= 5 }
c118 if { input["y"] >= 3 }
c119 if { input["y"] <= 3 }
c120 if { input["f"] == false }
c121 if { c116; c117; c118; c119; c120 }
c122 if { not c121 }
c123 if { c115; c122 }
rule_5 if { c123 }
c124 if { input["x"] >= 1 }
c125 if { input["x"] <= 3 }
c126 if { input["y"] >= 0 }
c127 if { input["y"] <= 5 }
c128 if { c124; c125; c126; c127 }
c129 if { input["x"] >= 2 }
c130 if { input["x"] <= 5 }
c131 if { input["y"] >= 3 }
c132 if { input["y"] <= 3 }
c133 if { input["f"] == false }
c134 if { c129; c130; c131; c132; c133 }
c135 if { not c134 }
c136 if { c128; c135 }
c137 if { input["x"] >= 2 }
c138 if { input["x"] <= 5 }
c139 if { input["y"] >= 0 }
c140 if { input["y"] <= 5 }
c141 if { c137; c138; c139; c140 }
c142 if { input["x"] >= 3 }
c143 if { input["x"] <= 4 }
c144 if { input["y"] >= 1 }
c145 if { input["y"] <= 4 }
c146 if { c142; c143; c144; c145 }
c147 if { input["x"] >= 2 }
c148 if { input["x"] <= 5 }
c149 if { input["y"] >= 3 }
c150 if { input["y"] <= 3 }
c151 if { input["f"] == false }
c152 if { c147; c148; c149; c150; c151 }
c153 if { not c152 }
c154 if { c146; c153 }
c155 if { not c154 }
c156 if { c141; c155 }
c157 if { input["x"] >= 3 }
c158 if { input["x"] <= 4 }
c159 if { input["y"] >= 0 }
c160 if { input["y"] <= 3 }
c161 if { c157; c158; c159; c160 }
c162 if { input["x"] >= 2 }
c163 if { input["x"] <= 5 }
c164 if { input["y"] >= 3 }
c165 if { input["y"] <= 3 }
c166 if { input["f"] == false }
c167 if { c162; c163; c164; c165; c166 }
c168 if { not c167 }
c169 if { c161; c168 }
c170 if { not c169 }
c171 if { c156; c170 }
c172 if { not c171 }
c173 if { c136; c172 }
rule_6 if { c173 }
c174 if { input["x"] >= 2 }
c175 if { input["x"] <= 5 }
c176 if { input["y"] >= 0 }
c177 if { input["y"] <= 5 }
c178 if { c174; c175; c176; c177 }
c179 if { input["x"] >= 3 }
c180 if { input["x"] <= 4 }
c181 if { input["y"] >= 1 }
c182 if { input["y"] <= 4 }
c183 if { c179; c180; c181; c182 }
c184 if { input["x"] >= 2 }
c185 if { input["x"] <= 5 }
c186 if { input["y"] >= 3 }
c187 if { input["y"] <= 3 }
c188 if { input["f"] == false }
c189 if { c184; c185; c186; c187; c188 }
c190 if { not c189 }
c191 if { c183; c190 }
c192 if { not c191 }
c193 if { c178; c192 }
c194 if { input["x"] >= 3 }
c195 if { input["x"] <= 4 }
c196 if { input["y"] >= 0 }
c197 if { input["y"] <= 3 }
c198 if { c194; c195; c196; c197 }
c199 if { input["x"] >= 2 }
c200 if { input["x"] <= 5 }
c201 if { input["y"] >= 3 }
c202 if { input["y"] <= 3 }
c203 if { input["f"] == false }
c204 if { c199; c200; c201; c202; c203 }
c205 if { not c204 }
c206 if { c198; c205 }
c207 if { not c206 }
c208 if { c193; c207 }
rule_7 if { c208 }
c209 if { input["x"] == 0 }
c210 if { input["y"] == 2 }
c211 if { input["f"] == true }
c212 if { c209; c210; c211 }
c213 if { input["x"] == 0 }
c214 if { input["y"] == 3 }
c215 if { input["f"] == true }
c216 if { c213; c214; c215 }
c217 if { input["x"] == 0 }
c218 if { input["y"] == 4 }
c219 if { input["f"] == true }
c220 if { c217; c218; c219 }
c221 if { input["x"] == 1 }
c222 if { input["y"] == 0 }
c223 if { input["f"] == false }
c224 if { c221; c222; c223 }
c225 if { input["x"] == 1 }
c226 if { input["y"] == 0 }
c227 if { input["f"] == true }
c228 if { c225; c226; c227 }
c229 if { input["x"] == 1 }
c230 if { input["y"] == 1 }
c231 if { input["f"] == false }
c232 if { c229; c230; c231 }
c233 if { input["x"] == 1 }
c234 if { input["y"] == 1 }
c235 if { input["f"] == true }
c236 if { c233; c234; c235 }
c237 if { input["x"] == 1 }
c238 if { input["y"] == 2 }
c239 if { input["f"] == false }
c240 if { c237; c238; c239 }
c241 if { input["x"] == 1 }
c242 if { input["y"] == 2 }
c243 if { input["f"] == true }
c244 if { c241; c242; c243 }
c245 if { input["x"] == 1 }
c246 if { input["y"] == 3 }
c247 if { input["f"] == false }
c248 if { c245; c246; c247 }
c249 if { input["x"] == 1 }
c250 if { input["y"] == 3 }
c251 if { input["f"] == true }
c252 if { c249; c250; c251 }
c253 if { input["x"] == 1 }
c254 if { input["y"] == 4 }
c255 if { input["f"] == false }
c256 if { c253; c254; c255 }
c257 if { input["x"] == 1 }
c258 if { input["y"] == 4 }
c259 if { input["f"] == true }
c260 if { c257; c258; c259 }
c261 if { input["x"] == 1 }
c262 if { input["y"] == 5 }
c263 if { input["f"] == false }
c264 if { c261; c262; c263 }
c265 if { input["x"] == 1 }
c266 if { input["y"] == 5 }
c267 if { input["f"] == true }
c268 if { c265; c266; c267 }
c269 if { input["x"] == 2 }
c270 if { input["y"] == 0 }
c271 if { input["f"] == false }
c272 if { c269; c270; c271 }
c273 if { input["x"] == 2 }
c274 if { input["y"] == 0 }
c275 if { input["f"] == true }
c276 if { c273; c274; c275 }
c277 if { input["x"] == 2 }
c278 if { input["y"] == 1 }
c279 if { input["f"] == false }
c280 if { c277; c278; c279 }
c281 if { input["x"] == 2 }
c282 if { input["y"] == 1 }
c283 if { input["f"] == true }
c284 if { c281; c282; c283 }
c285 if { input["x"] == 2 }
c286 if { input["y"] == 2 }
c287 if { input["f"] == false }
c288 if { c285; c286; c287 }
c289 if { input["x"] == 2 }
c290 if { input["y"] == 2 }
c291 if { input["f"] == true }
c292 if { c289; c290; c291 }
c293 if { input["x"] == 2 }
c294 if { input["y"] == 3 }
c295 if { input["f"] == false }
c296 if { c293; c294; c295 }
c297 if { input["x"] == 2 }
c298 if { input["y"] == 3 }
c299 if { input["f"] == true }
c300 if { c297; c298; c299 }
c301 if { input["x"] == 2 }
c302 if { input["y"] == 4 }
c303 if { input["f"] == false }
c304 if { c301; c302; c303 }
c305 if { input["x"] == 2 }
c306 if { input["y"] == 4 }
c307 if { input["f"] == true }
c308 if { c305; c306; c307 }
c309 if { input["x"] == 2 }
c310 if { input["y"] == 5 }
c311 if { input["f"] == false }
c312 if { c309; c310; c311 }
c313 if { input["x"] == 2 }
c314 if { input["y"] == 5 }
c315 if { input["f"] == true }
c316 if { c313; c314; c315 }
c317 if { input["x"] == 3 }
c318 if { input["y"] == 0 }
c319 if { input["f"] == false }
c320 if { c317; c318; c319 }
c321 if { input["x"] == 3 }
c322 if { input["y"] == 0 }
c323 if { input["f"] == true }
c324 if { c321; c322; c323 }
c325 if { input["x"] == 3 }
c326 if { input["y"] == 1 }
c327 if { input["f"] == false }
c328 if { c325; c326; c327 }
c329 if { input["x"] == 3 }
c330 if { input["y"] == 1 }
c331 if { input["f"] == true }
c332 if { c329; c330; c331 }
c333 if { input["x"] == 3 }
c334 if { input["y"] == 2 }
c335 if { input["f"] == false }
c336 if { c333; c334; c335 }
c337 if { input["x"] == 3 }
c338 if { input["y"] == 2 }
c339 if { input["f"] == true }
c340 if { c337; c338; c339 }
c341 if { input["x"] == 3 }
c342 if { input["y"] == 3 }
c343 if { input["f"] == false }
c344 if { c341; c342; c343 }
c345 if { input["x"] == 3 }
c346 if { input["y"] == 3 }
c347 if { input["f"] == true }
c348 if { c345; c346; c347 }
c349 if { input["x"] == 3 }
c350 if { input["y"] == 4 }
c351 if { input["f"] == false }
c352 if { c349; c350; c351 }
c353 if { input["x"] == 3 }
c354 if { input["y"] == 4 }
c355 if { input["f"] == true }
c356 if { c353; c354; c355 }
c357 if { input["x"] == 3 }
c358 if { input["y"] == 5 }
c359 if { input["f"] == false }
c360 if { c357; c358; c359 }
c361 if { input["x"] == 3 }
c362 if { input["y"] == 5 }
c363 if { input["f"] == true }
c364 if { c361; c362; c363 }
c365 if { input["x"] == 4 }
c366 if { input["y"] == 0 }
c367 if { input["f"] == false }
c368 if { c365; c366; c367 }
c369 if { input["x"] == 4 }
c370 if { input["y"] == 0 }
c371 if { input["f"] == true }
c372 if { c369; c370; c371 }
c373 if { input["x"] == 4 }
c374 if { input["y"] == 1 }
c375 if { input["f"] == false }
c376 if { c373; c374; c375 }
c377 if { input["x"] == 4 }
c378 if { input["y"] == 1 }
c379 if { input["f"] == true }
c380 if { c377; c378; c379 }
c381 if { input["x"] == 4 }
c382 if { input["y"] == 2 }
c383 if { input["f"] == false }
c384 if { c381; c382; c383 }
c385 if { input["x"] == 4 }
c386 if { input["y"] == 2 }
c387 if { input["f"] == true }
c388 if { c385; c386; c387 }
c389 if { input["x"] == 4 }
c390 if { input["y"] == 3 }
c391 if { input["f"] == false }
c392 if { c389; c390; c391 }
c393 if { input["x"] == 4 }
c394 if { input["y"] == 3 }
c395 if { input["f"] == true }
c396 if { c393; c394; c395 }
c397 if { input["x"] == 4 }
c398 if { input["y"] == 4 }
c399 if { input["f"] == false }
c400 if { c397; c398; c399 }
c401 if { input["x"] == 4 }
c402 if { input["y"] == 4 }
c403 if { input["f"] == true }
c404 if { c401; c402; c403 }
c405 if { input["x"] == 4 }
c406 if { input["y"] == 5 }
c407 if { input["f"] == false }
c408 if { c405; c406; c407 }
c409 if { input["x"] == 4 }
c410 if { input["y"] == 5 }
c411 if { input["f"] == true }
c412 if { c409; c410; c411 }
c413 if { input["x"] == 5 }
c414 if { input["y"] == 0 }
c415 if { input["f"] == false }
c416 if { c413; c414; c415 }
c417 if { input["x"] == 5 }
c418 if { input["y"] == 0 }
c419 if { input["f"] == true }
c420 if { c417; c418; c419 }
c421 if { input["x"] == 5 }
c422 if { input["y"] == 1 }
c423 if { input["f"] == false }
c424 if { c421; c422; c423 }
c425 if { input["x"] == 5 }
c426 if { input["y"] == 1 }
c427 if { input["f"] == true }
c428 if { c425; c426; c427 }
c429 if { input["x"] == 5 }
c430 if { input["y"] == 2 }
c431 if { input["f"] == false }
c432 if { c429; c430; c431 }
c433 if { input["x"] == 5 }
c434 if { input["y"] == 2 }
c435 if { input["f"] == true }
c436 if { c433; c434; c435 }
c437 if { input["x"] == 5 }
c438 if { input["y"] == 3 }
c439 if { input["f"] == false }
c440 if { c437; c438; c439 }
c441 if { input["x"] == 5 }
c442 if { input["y"] == 3 }
c443 if { input["f"] == true }
c444 if { c441; c442; c443 }
c445 if { input["x"] == 5 }
c446 if { input["y"] == 4 }
c447 if { input["f"] == false }
c448 if { c445; c446; c447 }
c449 if { input["x"] == 5 }
c450 if { input["y"] == 4 }
c451 if { input["f"] == true }
c452 if { c449; c450; c451 }
c453 if { input["x"] == 5 }
c454 if { input["y"] == 5 }
c455 if { input["f"] == false }
c456 if { c453; c454; c455 }
c457 if { input["x"] == 5 }
c458 if { input["y"] == 5 }
c459 if { input["f"] == true }
c460 if { c457; c458; c459 }
