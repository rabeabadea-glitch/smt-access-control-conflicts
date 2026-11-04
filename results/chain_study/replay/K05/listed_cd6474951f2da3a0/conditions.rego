package thesis

c0 if { true }
c1 if { input["x"] >= 2 }
c2 if { input["x"] <= 5 }
c3 if { input["y"] >= 0 }
c4 if { input["y"] <= 5 }
c5 if { c1; c2; c3; c4 }
c6 if { input["x"] >= 3 }
c7 if { input["x"] <= 4 }
c8 if { input["y"] >= 0 }
c9 if { input["y"] <= 3 }
c10 if { c6; c7; c8; c9 }
c11 if { not c10 }
c12 if { c5; c11 }
c13 if { input["x"] >= 3 }
c14 if { input["x"] <= 4 }
c15 if { input["y"] >= 1 }
c16 if { input["y"] <= 4 }
c17 if { c13; c14; c15; c16 }
c18 if { not c17 }
c19 if { c12; c18 }
rule_0 if { c19 }
c20 if { input["x"] >= 3 }
c21 if { input["x"] <= 4 }
c22 if { input["y"] >= 0 }
c23 if { input["y"] <= 3 }
c24 if { c20; c21; c22; c23 }
c25 if { input["x"] >= 2 }
c26 if { input["x"] <= 5 }
c27 if { input["y"] >= 3 }
c28 if { input["y"] <= 3 }
c29 if { input["f"] == false }
c30 if { c25; c26; c27; c28; c29 }
c31 if { not c30 }
c32 if { c24; c31 }
rule_1 if { c32 }
c33 if { input["x"] >= 2 }
c34 if { input["x"] <= 5 }
c35 if { input["y"] >= 3 }
c36 if { input["y"] <= 5 }
c37 if { c33; c34; c35; c36 }
c38 if { input["x"] >= 3 }
c39 if { input["x"] <= 4 }
c40 if { input["y"] >= 0 }
c41 if { input["y"] <= 3 }
c42 if { c38; c39; c40; c41 }
c43 if { not c42 }
c44 if { c37; c43 }
c45 if { input["x"] >= 3 }
c46 if { input["x"] <= 4 }
c47 if { input["y"] >= 1 }
c48 if { input["y"] <= 4 }
c49 if { c45; c46; c47; c48 }
c50 if { not c49 }
c51 if { c44; c50 }
rule_2 if { c51 }
c52 if { input["x"] >= 1 }
c53 if { input["x"] <= 3 }
c54 if { input["y"] >= 0 }
c55 if { input["y"] <= 5 }
c56 if { c52; c53; c54; c55 }
c57 if { input["x"] >= 2 }
c58 if { input["x"] <= 5 }
c59 if { input["y"] >= 0 }
c60 if { input["y"] <= 5 }
c61 if { c57; c58; c59; c60 }
c62 if { input["x"] >= 3 }
c63 if { input["x"] <= 4 }
c64 if { input["y"] >= 0 }
c65 if { input["y"] <= 3 }
c66 if { c62; c63; c64; c65 }
c67 if { not c66 }
c68 if { c61; c67 }
c69 if { not c68 }
c70 if { c56; c69 }
c71 if { input["x"] >= 2 }
c72 if { input["x"] <= 5 }
c73 if { input["y"] >= 3 }
c74 if { input["y"] <= 3 }
c75 if { input["f"] == false }
c76 if { c71; c72; c73; c74; c75 }
c77 if { not c76 }
c78 if { c70; c77 }
rule_3 if { c78 }
c79 if { input["x"] >= 2 }
c80 if { input["x"] <= 5 }
c81 if { input["y"] >= 3 }
c82 if { input["y"] <= 3 }
c83 if { input["f"] == false }
c84 if { c79; c80; c81; c82; c83 }
rule_4 if { c84 }
c85 if { input["x"] >= 0 }
c86 if { input["x"] <= 2 }
c87 if { input["y"] >= 2 }
c88 if { input["y"] <= 4 }
c89 if { input["f"] == true }
c90 if { c85; c86; c87; c88; c89 }
c91 if { input["x"] >= 2 }
c92 if { input["x"] <= 5 }
c93 if { input["y"] >= 0 }
c94 if { input["y"] <= 5 }
c95 if { c91; c92; c93; c94 }
c96 if { input["x"] >= 3 }
c97 if { input["x"] <= 4 }
c98 if { input["y"] >= 0 }
c99 if { input["y"] <= 3 }
c100 if { c96; c97; c98; c99 }
c101 if { not c100 }
c102 if { c95; c101 }
c103 if { not c102 }
c104 if { c90; c103 }
rule_5 if { c104 }
c105 if { input["x"] >= 3 }
c106 if { input["x"] <= 3 }
c107 if { input["y"] >= 1 }
c108 if { input["y"] <= 4 }
c109 if { c105; c106; c107; c108 }
c110 if { input["x"] >= 3 }
c111 if { input["x"] <= 4 }
c112 if { input["y"] >= 0 }
c113 if { input["y"] <= 3 }
c114 if { c110; c111; c112; c113 }
c115 if { input["x"] >= 2 }
c116 if { input["x"] <= 5 }
c117 if { input["y"] >= 3 }
c118 if { input["y"] <= 3 }
c119 if { input["f"] == false }
c120 if { c115; c116; c117; c118; c119 }
c121 if { not c120 }
c122 if { c114; c121 }
c123 if { not c122 }
c124 if { c109; c123 }
c125 if { input["x"] >= 3 }
c126 if { input["x"] <= 4 }
c127 if { input["y"] >= 1 }
c128 if { input["y"] <= 4 }
c129 if { c125; c126; c127; c128 }
c130 if { input["x"] >= 2 }
c131 if { input["x"] <= 5 }
c132 if { input["y"] >= 3 }
c133 if { input["y"] <= 3 }
c134 if { input["f"] == false }
c135 if { c130; c131; c132; c133; c134 }
c136 if { not c135 }
c137 if { c129; c136 }
c138 if { not c137 }
c139 if { c124; c138 }
rule_6 if { c139 }
c140 if { input["x"] >= 3 }
c141 if { input["x"] <= 4 }
c142 if { input["y"] >= 1 }
c143 if { input["y"] <= 4 }
c144 if { c140; c141; c142; c143 }
c145 if { input["x"] >= 2 }
c146 if { input["x"] <= 5 }
c147 if { input["y"] >= 3 }
c148 if { input["y"] <= 3 }
c149 if { input["f"] == false }
c150 if { c145; c146; c147; c148; c149 }
c151 if { not c150 }
c152 if { c144; c151 }
rule_7 if { c152 }
c153 if { input["x"] == 0 }
c154 if { input["y"] == 2 }
c155 if { input["f"] == true }
c156 if { c153; c154; c155 }
c157 if { input["x"] == 0 }
c158 if { input["y"] == 3 }
c159 if { input["f"] == true }
c160 if { c157; c158; c159 }
c161 if { input["x"] == 0 }
c162 if { input["y"] == 4 }
c163 if { input["f"] == true }
c164 if { c161; c162; c163 }
c165 if { input["x"] == 1 }
c166 if { input["y"] == 0 }
c167 if { input["f"] == false }
c168 if { c165; c166; c167 }
c169 if { input["x"] == 1 }
c170 if { input["y"] == 0 }
c171 if { input["f"] == true }
c172 if { c169; c170; c171 }
c173 if { input["x"] == 1 }
c174 if { input["y"] == 1 }
c175 if { input["f"] == false }
c176 if { c173; c174; c175 }
c177 if { input["x"] == 1 }
c178 if { input["y"] == 1 }
c179 if { input["f"] == true }
c180 if { c177; c178; c179 }
c181 if { input["x"] == 1 }
c182 if { input["y"] == 2 }
c183 if { input["f"] == false }
c184 if { c181; c182; c183 }
c185 if { input["x"] == 1 }
c186 if { input["y"] == 2 }
c187 if { input["f"] == true }
c188 if { c185; c186; c187 }
c189 if { input["x"] == 1 }
c190 if { input["y"] == 3 }
c191 if { input["f"] == false }
c192 if { c189; c190; c191 }
c193 if { input["x"] == 1 }
c194 if { input["y"] == 3 }
c195 if { input["f"] == true }
c196 if { c193; c194; c195 }
c197 if { input["x"] == 1 }
c198 if { input["y"] == 4 }
c199 if { input["f"] == false }
c200 if { c197; c198; c199 }
c201 if { input["x"] == 1 }
c202 if { input["y"] == 4 }
c203 if { input["f"] == true }
c204 if { c201; c202; c203 }
c205 if { input["x"] == 1 }
c206 if { input["y"] == 5 }
c207 if { input["f"] == false }
c208 if { c205; c206; c207 }
c209 if { input["x"] == 1 }
c210 if { input["y"] == 5 }
c211 if { input["f"] == true }
c212 if { c209; c210; c211 }
c213 if { input["x"] == 2 }
c214 if { input["y"] == 0 }
c215 if { input["f"] == false }
c216 if { c213; c214; c215 }
c217 if { input["x"] == 2 }
c218 if { input["y"] == 0 }
c219 if { input["f"] == true }
c220 if { c217; c218; c219 }
c221 if { input["x"] == 2 }
c222 if { input["y"] == 1 }
c223 if { input["f"] == false }
c224 if { c221; c222; c223 }
c225 if { input["x"] == 2 }
c226 if { input["y"] == 1 }
c227 if { input["f"] == true }
c228 if { c225; c226; c227 }
c229 if { input["x"] == 2 }
c230 if { input["y"] == 2 }
c231 if { input["f"] == false }
c232 if { c229; c230; c231 }
c233 if { input["x"] == 2 }
c234 if { input["y"] == 2 }
c235 if { input["f"] == true }
c236 if { c233; c234; c235 }
c237 if { input["x"] == 2 }
c238 if { input["y"] == 3 }
c239 if { input["f"] == false }
c240 if { c237; c238; c239 }
c241 if { input["x"] == 2 }
c242 if { input["y"] == 3 }
c243 if { input["f"] == true }
c244 if { c241; c242; c243 }
c245 if { input["x"] == 2 }
c246 if { input["y"] == 4 }
c247 if { input["f"] == false }
c248 if { c245; c246; c247 }
c249 if { input["x"] == 2 }
c250 if { input["y"] == 4 }
c251 if { input["f"] == true }
c252 if { c249; c250; c251 }
c253 if { input["x"] == 2 }
c254 if { input["y"] == 5 }
c255 if { input["f"] == false }
c256 if { c253; c254; c255 }
c257 if { input["x"] == 2 }
c258 if { input["y"] == 5 }
c259 if { input["f"] == true }
c260 if { c257; c258; c259 }
c261 if { input["x"] == 3 }
c262 if { input["y"] == 0 }
c263 if { input["f"] == false }
c264 if { c261; c262; c263 }
c265 if { input["x"] == 3 }
c266 if { input["y"] == 0 }
c267 if { input["f"] == true }
c268 if { c265; c266; c267 }
c269 if { input["x"] == 3 }
c270 if { input["y"] == 1 }
c271 if { input["f"] == false }
c272 if { c269; c270; c271 }
c273 if { input["x"] == 3 }
c274 if { input["y"] == 1 }
c275 if { input["f"] == true }
c276 if { c273; c274; c275 }
c277 if { input["x"] == 3 }
c278 if { input["y"] == 2 }
c279 if { input["f"] == false }
c280 if { c277; c278; c279 }
c281 if { input["x"] == 3 }
c282 if { input["y"] == 2 }
c283 if { input["f"] == true }
c284 if { c281; c282; c283 }
c285 if { input["x"] == 3 }
c286 if { input["y"] == 3 }
c287 if { input["f"] == false }
c288 if { c285; c286; c287 }
c289 if { input["x"] == 3 }
c290 if { input["y"] == 3 }
c291 if { input["f"] == true }
c292 if { c289; c290; c291 }
c293 if { input["x"] == 3 }
c294 if { input["y"] == 4 }
c295 if { input["f"] == false }
c296 if { c293; c294; c295 }
c297 if { input["x"] == 3 }
c298 if { input["y"] == 4 }
c299 if { input["f"] == true }
c300 if { c297; c298; c299 }
c301 if { input["x"] == 3 }
c302 if { input["y"] == 5 }
c303 if { input["f"] == false }
c304 if { c301; c302; c303 }
c305 if { input["x"] == 3 }
c306 if { input["y"] == 5 }
c307 if { input["f"] == true }
c308 if { c305; c306; c307 }
c309 if { input["x"] == 4 }
c310 if { input["y"] == 0 }
c311 if { input["f"] == false }
c312 if { c309; c310; c311 }
c313 if { input["x"] == 4 }
c314 if { input["y"] == 0 }
c315 if { input["f"] == true }
c316 if { c313; c314; c315 }
c317 if { input["x"] == 4 }
c318 if { input["y"] == 1 }
c319 if { input["f"] == false }
c320 if { c317; c318; c319 }
c321 if { input["x"] == 4 }
c322 if { input["y"] == 1 }
c323 if { input["f"] == true }
c324 if { c321; c322; c323 }
c325 if { input["x"] == 4 }
c326 if { input["y"] == 2 }
c327 if { input["f"] == false }
c328 if { c325; c326; c327 }
c329 if { input["x"] == 4 }
c330 if { input["y"] == 2 }
c331 if { input["f"] == true }
c332 if { c329; c330; c331 }
c333 if { input["x"] == 4 }
c334 if { input["y"] == 3 }
c335 if { input["f"] == false }
c336 if { c333; c334; c335 }
c337 if { input["x"] == 4 }
c338 if { input["y"] == 3 }
c339 if { input["f"] == true }
c340 if { c337; c338; c339 }
c341 if { input["x"] == 4 }
c342 if { input["y"] == 4 }
c343 if { input["f"] == false }
c344 if { c341; c342; c343 }
c345 if { input["x"] == 4 }
c346 if { input["y"] == 4 }
c347 if { input["f"] == true }
c348 if { c345; c346; c347 }
c349 if { input["x"] == 4 }
c350 if { input["y"] == 5 }
c351 if { input["f"] == false }
c352 if { c349; c350; c351 }
c353 if { input["x"] == 4 }
c354 if { input["y"] == 5 }
c355 if { input["f"] == true }
c356 if { c353; c354; c355 }
c357 if { input["x"] == 5 }
c358 if { input["y"] == 0 }
c359 if { input["f"] == false }
c360 if { c357; c358; c359 }
c361 if { input["x"] == 5 }
c362 if { input["y"] == 0 }
c363 if { input["f"] == true }
c364 if { c361; c362; c363 }
c365 if { input["x"] == 5 }
c366 if { input["y"] == 1 }
c367 if { input["f"] == false }
c368 if { c365; c366; c367 }
c369 if { input["x"] == 5 }
c370 if { input["y"] == 1 }
c371 if { input["f"] == true }
c372 if { c369; c370; c371 }
c373 if { input["x"] == 5 }
c374 if { input["y"] == 2 }
c375 if { input["f"] == false }
c376 if { c373; c374; c375 }
c377 if { input["x"] == 5 }
c378 if { input["y"] == 2 }
c379 if { input["f"] == true }
c380 if { c377; c378; c379 }
c381 if { input["x"] == 5 }
c382 if { input["y"] == 3 }
c383 if { input["f"] == false }
c384 if { c381; c382; c383 }
c385 if { input["x"] == 5 }
c386 if { input["y"] == 3 }
c387 if { input["f"] == true }
c388 if { c385; c386; c387 }
c389 if { input["x"] == 5 }
c390 if { input["y"] == 4 }
c391 if { input["f"] == false }
c392 if { c389; c390; c391 }
c393 if { input["x"] == 5 }
c394 if { input["y"] == 4 }
c395 if { input["f"] == true }
c396 if { c393; c394; c395 }
c397 if { input["x"] == 5 }
c398 if { input["y"] == 5 }
c399 if { input["f"] == false }
c400 if { c397; c398; c399 }
c401 if { input["x"] == 5 }
c402 if { input["y"] == 5 }
c403 if { input["f"] == true }
c404 if { c401; c402; c403 }
