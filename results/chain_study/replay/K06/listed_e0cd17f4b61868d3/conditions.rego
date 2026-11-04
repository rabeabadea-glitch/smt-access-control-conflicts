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
c14 if { input["x"] >= 3 }
c15 if { input["x"] <= 5 }
c16 if { input["y"] >= 1 }
c17 if { input["y"] <= 2 }
c18 if { c14; c15; c16; c17 }
c19 if { input["x"] >= 0 }
c20 if { input["x"] <= 4 }
c21 if { input["y"] >= 2 }
c22 if { input["y"] <= 5 }
c23 if { input["f"] == true }
c24 if { c19; c20; c21; c22; c23 }
c25 if { input["x"] >= 3 }
c26 if { input["x"] <= 3 }
c27 if { input["y"] >= 2 }
c28 if { input["y"] <= 5 }
c29 if { input["f"] == true }
c30 if { c25; c26; c27; c28; c29 }
c31 if { not c30 }
c32 if { c24; c31 }
c33 if { not c32 }
c34 if { c18; c33 }
c35 if { input["x"] >= 5 }
c36 if { input["x"] <= 5 }
c37 if { input["y"] >= 2 }
c38 if { input["y"] <= 3 }
c39 if { c35; c36; c37; c38 }
c40 if { not c39 }
c41 if { c34; c40 }
c42 if { input["x"] >= 2 }
c43 if { input["x"] <= 5 }
c44 if { input["y"] >= 1 }
c45 if { input["y"] <= 2 }
c46 if { c42; c43; c44; c45 }
c47 if { input["x"] >= 3 }
c48 if { input["x"] <= 3 }
c49 if { input["y"] >= 2 }
c50 if { input["y"] <= 5 }
c51 if { input["f"] == true }
c52 if { c47; c48; c49; c50; c51 }
c53 if { input["x"] >= 2 }
c54 if { input["x"] <= 4 }
c55 if { input["y"] >= 3 }
c56 if { input["y"] <= 4 }
c57 if { c53; c54; c55; c56 }
c58 if { not c57 }
c59 if { c52; c58 }
c60 if { not c59 }
c61 if { c46; c60 }
c62 if { not c61 }
c63 if { c41; c62 }
rule_1 if { c63 }
c64 if { input["x"] >= 0 }
c65 if { input["x"] <= 4 }
c66 if { input["y"] >= 2 }
c67 if { input["y"] <= 5 }
c68 if { input["f"] == true }
c69 if { c64; c65; c66; c67; c68 }
c70 if { input["x"] >= 3 }
c71 if { input["x"] <= 3 }
c72 if { input["y"] >= 2 }
c73 if { input["y"] <= 5 }
c74 if { input["f"] == true }
c75 if { c70; c71; c72; c73; c74 }
c76 if { not c75 }
c77 if { c69; c76 }
c78 if { input["x"] >= 0 }
c79 if { input["x"] <= 3 }
c80 if { input["y"] >= 0 }
c81 if { input["y"] <= 3 }
c82 if { c78; c79; c80; c81 }
c83 if { not c82 }
c84 if { c77; c83 }
rule_2 if { c84 }
c85 if { input["x"] >= 0 }
c86 if { input["x"] <= 3 }
c87 if { input["y"] >= 0 }
c88 if { input["y"] <= 3 }
c89 if { c85; c86; c87; c88 }
rule_3 if { c89 }
c90 if { input["x"] >= 2 }
c91 if { input["x"] <= 4 }
c92 if { input["y"] >= 3 }
c93 if { input["y"] <= 4 }
c94 if { c90; c91; c92; c93 }
c95 if { input["x"] >= 0 }
c96 if { input["x"] <= 3 }
c97 if { input["y"] >= 0 }
c98 if { input["y"] <= 3 }
c99 if { c95; c96; c97; c98 }
c100 if { not c99 }
c101 if { c94; c100 }
rule_4 if { c101 }
c102 if { input["x"] >= 0 }
c103 if { input["x"] <= 1 }
c104 if { input["y"] >= 3 }
c105 if { input["y"] <= 3 }
c106 if { c102; c103; c104; c105 }
rule_5 if { c106 }
c107 if { input["x"] >= 5 }
c108 if { input["x"] <= 5 }
c109 if { input["y"] >= 2 }
c110 if { input["y"] <= 3 }
c111 if { c107; c108; c109; c110 }
rule_6 if { c111 }
c112 if { input["x"] >= 0 }
c113 if { input["x"] <= 2 }
c114 if { input["y"] >= 0 }
c115 if { input["y"] <= 2 }
c116 if { c112; c113; c114; c115 }
rule_7 if { c116 }
c117 if { input["x"] >= 2 }
c118 if { input["x"] <= 5 }
c119 if { input["y"] >= 1 }
c120 if { input["y"] <= 2 }
c121 if { c117; c118; c119; c120 }
c122 if { input["x"] >= 3 }
c123 if { input["x"] <= 3 }
c124 if { input["y"] >= 2 }
c125 if { input["y"] <= 5 }
c126 if { input["f"] == true }
c127 if { c122; c123; c124; c125; c126 }
c128 if { input["x"] >= 2 }
c129 if { input["x"] <= 4 }
c130 if { input["y"] >= 3 }
c131 if { input["y"] <= 4 }
c132 if { c128; c129; c130; c131 }
c133 if { not c132 }
c134 if { c127; c133 }
c135 if { not c134 }
c136 if { c121; c135 }
c137 if { input["x"] >= 0 }
c138 if { input["x"] <= 3 }
c139 if { input["y"] >= 0 }
c140 if { input["y"] <= 3 }
c141 if { c137; c138; c139; c140 }
c142 if { not c141 }
c143 if { c136; c142 }
rule_8 if { c143 }
c144 if { input["x"] == 0 }
c145 if { input["y"] == 0 }
c146 if { input["f"] == false }
c147 if { c144; c145; c146 }
c148 if { input["x"] == 0 }
c149 if { input["y"] == 0 }
c150 if { input["f"] == true }
c151 if { c148; c149; c150 }
c152 if { input["x"] == 0 }
c153 if { input["y"] == 1 }
c154 if { input["f"] == false }
c155 if { c152; c153; c154 }
c156 if { input["x"] == 0 }
c157 if { input["y"] == 1 }
c158 if { input["f"] == true }
c159 if { c156; c157; c158 }
c160 if { input["x"] == 0 }
c161 if { input["y"] == 2 }
c162 if { input["f"] == false }
c163 if { c160; c161; c162 }
c164 if { input["x"] == 0 }
c165 if { input["y"] == 2 }
c166 if { input["f"] == true }
c167 if { c164; c165; c166 }
c168 if { input["x"] == 0 }
c169 if { input["y"] == 3 }
c170 if { input["f"] == false }
c171 if { c168; c169; c170 }
c172 if { input["x"] == 0 }
c173 if { input["y"] == 3 }
c174 if { input["f"] == true }
c175 if { c172; c173; c174 }
c176 if { input["x"] == 0 }
c177 if { input["y"] == 4 }
c178 if { input["f"] == true }
c179 if { c176; c177; c178 }
c180 if { input["x"] == 0 }
c181 if { input["y"] == 5 }
c182 if { input["f"] == true }
c183 if { c180; c181; c182 }
c184 if { input["x"] == 1 }
c185 if { input["y"] == 0 }
c186 if { input["f"] == false }
c187 if { c184; c185; c186 }
c188 if { input["x"] == 1 }
c189 if { input["y"] == 0 }
c190 if { input["f"] == true }
c191 if { c188; c189; c190 }
c192 if { input["x"] == 1 }
c193 if { input["y"] == 1 }
c194 if { input["f"] == false }
c195 if { c192; c193; c194 }
c196 if { input["x"] == 1 }
c197 if { input["y"] == 1 }
c198 if { input["f"] == true }
c199 if { c196; c197; c198 }
c200 if { input["x"] == 1 }
c201 if { input["y"] == 2 }
c202 if { input["f"] == false }
c203 if { c200; c201; c202 }
c204 if { input["x"] == 1 }
c205 if { input["y"] == 2 }
c206 if { input["f"] == true }
c207 if { c204; c205; c206 }
c208 if { input["x"] == 1 }
c209 if { input["y"] == 3 }
c210 if { input["f"] == false }
c211 if { c208; c209; c210 }
c212 if { input["x"] == 1 }
c213 if { input["y"] == 3 }
c214 if { input["f"] == true }
c215 if { c212; c213; c214 }
c216 if { input["x"] == 1 }
c217 if { input["y"] == 4 }
c218 if { input["f"] == true }
c219 if { c216; c217; c218 }
c220 if { input["x"] == 1 }
c221 if { input["y"] == 5 }
c222 if { input["f"] == true }
c223 if { c220; c221; c222 }
c224 if { input["x"] == 2 }
c225 if { input["y"] == 0 }
c226 if { input["f"] == false }
c227 if { c224; c225; c226 }
c228 if { input["x"] == 2 }
c229 if { input["y"] == 0 }
c230 if { input["f"] == true }
c231 if { c228; c229; c230 }
c232 if { input["x"] == 2 }
c233 if { input["y"] == 1 }
c234 if { input["f"] == false }
c235 if { c232; c233; c234 }
c236 if { input["x"] == 2 }
c237 if { input["y"] == 1 }
c238 if { input["f"] == true }
c239 if { c236; c237; c238 }
c240 if { input["x"] == 2 }
c241 if { input["y"] == 2 }
c242 if { input["f"] == false }
c243 if { c240; c241; c242 }
c244 if { input["x"] == 2 }
c245 if { input["y"] == 2 }
c246 if { input["f"] == true }
c247 if { c244; c245; c246 }
c248 if { input["x"] == 2 }
c249 if { input["y"] == 3 }
c250 if { input["f"] == false }
c251 if { c248; c249; c250 }
c252 if { input["x"] == 2 }
c253 if { input["y"] == 3 }
c254 if { input["f"] == true }
c255 if { c252; c253; c254 }
c256 if { input["x"] == 2 }
c257 if { input["y"] == 4 }
c258 if { input["f"] == false }
c259 if { c256; c257; c258 }
c260 if { input["x"] == 2 }
c261 if { input["y"] == 4 }
c262 if { input["f"] == true }
c263 if { c260; c261; c262 }
c264 if { input["x"] == 2 }
c265 if { input["y"] == 5 }
c266 if { input["f"] == true }
c267 if { c264; c265; c266 }
c268 if { input["x"] == 3 }
c269 if { input["y"] == 0 }
c270 if { input["f"] == false }
c271 if { c268; c269; c270 }
c272 if { input["x"] == 3 }
c273 if { input["y"] == 0 }
c274 if { input["f"] == true }
c275 if { c272; c273; c274 }
c276 if { input["x"] == 3 }
c277 if { input["y"] == 1 }
c278 if { input["f"] == false }
c279 if { c276; c277; c278 }
c280 if { input["x"] == 3 }
c281 if { input["y"] == 1 }
c282 if { input["f"] == true }
c283 if { c280; c281; c282 }
c284 if { input["x"] == 3 }
c285 if { input["y"] == 2 }
c286 if { input["f"] == false }
c287 if { c284; c285; c286 }
c288 if { input["x"] == 3 }
c289 if { input["y"] == 2 }
c290 if { input["f"] == true }
c291 if { c288; c289; c290 }
c292 if { input["x"] == 3 }
c293 if { input["y"] == 3 }
c294 if { input["f"] == false }
c295 if { c292; c293; c294 }
c296 if { input["x"] == 3 }
c297 if { input["y"] == 3 }
c298 if { input["f"] == true }
c299 if { c296; c297; c298 }
c300 if { input["x"] == 3 }
c301 if { input["y"] == 4 }
c302 if { input["f"] == false }
c303 if { c300; c301; c302 }
c304 if { input["x"] == 3 }
c305 if { input["y"] == 4 }
c306 if { input["f"] == true }
c307 if { c304; c305; c306 }
c308 if { input["x"] == 3 }
c309 if { input["y"] == 5 }
c310 if { input["f"] == true }
c311 if { c308; c309; c310 }
c312 if { input["x"] == 4 }
c313 if { input["y"] == 1 }
c314 if { input["f"] == false }
c315 if { c312; c313; c314 }
c316 if { input["x"] == 4 }
c317 if { input["y"] == 1 }
c318 if { input["f"] == true }
c319 if { c316; c317; c318 }
c320 if { input["x"] == 4 }
c321 if { input["y"] == 2 }
c322 if { input["f"] == false }
c323 if { c320; c321; c322 }
c324 if { input["x"] == 4 }
c325 if { input["y"] == 2 }
c326 if { input["f"] == true }
c327 if { c324; c325; c326 }
c328 if { input["x"] == 4 }
c329 if { input["y"] == 3 }
c330 if { input["f"] == false }
c331 if { c328; c329; c330 }
c332 if { input["x"] == 4 }
c333 if { input["y"] == 3 }
c334 if { input["f"] == true }
c335 if { c332; c333; c334 }
c336 if { input["x"] == 4 }
c337 if { input["y"] == 4 }
c338 if { input["f"] == false }
c339 if { c336; c337; c338 }
c340 if { input["x"] == 4 }
c341 if { input["y"] == 4 }
c342 if { input["f"] == true }
c343 if { c340; c341; c342 }
c344 if { input["x"] == 4 }
c345 if { input["y"] == 5 }
c346 if { input["f"] == true }
c347 if { c344; c345; c346 }
c348 if { input["x"] == 5 }
c349 if { input["y"] == 1 }
c350 if { input["f"] == false }
c351 if { c348; c349; c350 }
c352 if { input["x"] == 5 }
c353 if { input["y"] == 1 }
c354 if { input["f"] == true }
c355 if { c352; c353; c354 }
c356 if { input["x"] == 5 }
c357 if { input["y"] == 2 }
c358 if { input["f"] == false }
c359 if { c356; c357; c358 }
c360 if { input["x"] == 5 }
c361 if { input["y"] == 2 }
c362 if { input["f"] == true }
c363 if { c360; c361; c362 }
c364 if { input["x"] == 5 }
c365 if { input["y"] == 3 }
c366 if { input["f"] == false }
c367 if { c364; c365; c366 }
c368 if { input["x"] == 5 }
c369 if { input["y"] == 3 }
c370 if { input["f"] == true }
c371 if { c368; c369; c370 }
