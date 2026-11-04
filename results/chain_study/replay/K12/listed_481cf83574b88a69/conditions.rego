package thesis

c0 if { true }
c1 if { input["x"] >= 4 }
c2 if { input["x"] <= 5 }
c3 if { input["y"] >= 2 }
c4 if { input["y"] <= 5 }
c5 if { input["f"] == true }
c6 if { c1; c2; c3; c4; c5 }
c7 if { input["x"] >= 0 }
c8 if { input["x"] <= 5 }
c9 if { input["y"] >= 3 }
c10 if { input["y"] <= 5 }
c11 if { c7; c8; c9; c10 }
c12 if { not c11 }
c13 if { c6; c12 }
rule_0 if { c13 }
c14 if { input["x"] >= 0 }
c15 if { input["x"] <= 5 }
c16 if { input["y"] >= 3 }
c17 if { input["y"] <= 5 }
c18 if { c14; c15; c16; c17 }
c19 if { input["x"] >= 2 }
c20 if { input["x"] <= 5 }
c21 if { input["y"] >= 2 }
c22 if { input["y"] <= 3 }
c23 if { c19; c20; c21; c22 }
c24 if { not c23 }
c25 if { c18; c24 }
rule_1 if { c25 }
c26 if { input["x"] >= 2 }
c27 if { input["x"] <= 5 }
c28 if { input["y"] >= 2 }
c29 if { input["y"] <= 3 }
c30 if { c26; c27; c28; c29 }
rule_2 if { c30 }
c31 if { input["x"] >= 4 }
c32 if { input["x"] <= 5 }
c33 if { input["y"] >= 2 }
c34 if { input["y"] <= 4 }
c35 if { c31; c32; c33; c34 }
c36 if { input["x"] >= 4 }
c37 if { input["x"] <= 5 }
c38 if { input["y"] >= 2 }
c39 if { input["y"] <= 5 }
c40 if { input["f"] == true }
c41 if { c36; c37; c38; c39; c40 }
c42 if { input["x"] >= 0 }
c43 if { input["x"] <= 5 }
c44 if { input["y"] >= 3 }
c45 if { input["y"] <= 5 }
c46 if { c42; c43; c44; c45 }
c47 if { not c46 }
c48 if { c41; c47 }
c49 if { not c48 }
c50 if { c35; c49 }
c51 if { input["x"] >= 2 }
c52 if { input["x"] <= 5 }
c53 if { input["y"] >= 2 }
c54 if { input["y"] <= 3 }
c55 if { c51; c52; c53; c54 }
c56 if { not c55 }
c57 if { c50; c56 }
rule_3 if { c57 }
c58 if { input["x"] >= 0 }
c59 if { input["x"] <= 1 }
c60 if { input["y"] >= 0 }
c61 if { input["y"] <= 1 }
c62 if { c58; c59; c60; c61 }
rule_4 if { c62 }
c63 if { input["x"] >= 2 }
c64 if { input["x"] <= 4 }
c65 if { input["y"] >= 1 }
c66 if { input["y"] <= 2 }
c67 if { c63; c64; c65; c66 }
rule_5 if { c67 }
c68 if { input["x"] >= 2 }
c69 if { input["x"] <= 2 }
c70 if { input["y"] >= 2 }
c71 if { input["y"] <= 4 }
c72 if { input["f"] == false }
c73 if { c68; c69; c70; c71; c72 }
c74 if { input["x"] >= 0 }
c75 if { input["x"] <= 5 }
c76 if { input["y"] >= 3 }
c77 if { input["y"] <= 5 }
c78 if { c74; c75; c76; c77 }
c79 if { input["x"] >= 2 }
c80 if { input["x"] <= 5 }
c81 if { input["y"] >= 2 }
c82 if { input["y"] <= 3 }
c83 if { c79; c80; c81; c82 }
c84 if { not c83 }
c85 if { c78; c84 }
c86 if { not c85 }
c87 if { c73; c86 }
rule_6 if { c87 }
c88 if { input["x"] == 0 }
c89 if { input["y"] == 0 }
c90 if { input["f"] == false }
c91 if { c88; c89; c90 }
c92 if { input["x"] == 0 }
c93 if { input["y"] == 0 }
c94 if { input["f"] == true }
c95 if { c92; c93; c94 }
c96 if { input["x"] == 0 }
c97 if { input["y"] == 1 }
c98 if { input["f"] == false }
c99 if { c96; c97; c98 }
c100 if { input["x"] == 0 }
c101 if { input["y"] == 1 }
c102 if { input["f"] == true }
c103 if { c100; c101; c102 }
c104 if { input["x"] == 0 }
c105 if { input["y"] == 3 }
c106 if { input["f"] == false }
c107 if { c104; c105; c106 }
c108 if { input["x"] == 0 }
c109 if { input["y"] == 3 }
c110 if { input["f"] == true }
c111 if { c108; c109; c110 }
c112 if { input["x"] == 0 }
c113 if { input["y"] == 4 }
c114 if { input["f"] == false }
c115 if { c112; c113; c114 }
c116 if { input["x"] == 0 }
c117 if { input["y"] == 4 }
c118 if { input["f"] == true }
c119 if { c116; c117; c118 }
c120 if { input["x"] == 0 }
c121 if { input["y"] == 5 }
c122 if { input["f"] == false }
c123 if { c120; c121; c122 }
c124 if { input["x"] == 0 }
c125 if { input["y"] == 5 }
c126 if { input["f"] == true }
c127 if { c124; c125; c126 }
c128 if { input["x"] == 1 }
c129 if { input["y"] == 0 }
c130 if { input["f"] == false }
c131 if { c128; c129; c130 }
c132 if { input["x"] == 1 }
c133 if { input["y"] == 0 }
c134 if { input["f"] == true }
c135 if { c132; c133; c134 }
c136 if { input["x"] == 1 }
c137 if { input["y"] == 1 }
c138 if { input["f"] == false }
c139 if { c136; c137; c138 }
c140 if { input["x"] == 1 }
c141 if { input["y"] == 1 }
c142 if { input["f"] == true }
c143 if { c140; c141; c142 }
c144 if { input["x"] == 1 }
c145 if { input["y"] == 3 }
c146 if { input["f"] == false }
c147 if { c144; c145; c146 }
c148 if { input["x"] == 1 }
c149 if { input["y"] == 3 }
c150 if { input["f"] == true }
c151 if { c148; c149; c150 }
c152 if { input["x"] == 1 }
c153 if { input["y"] == 4 }
c154 if { input["f"] == false }
c155 if { c152; c153; c154 }
c156 if { input["x"] == 1 }
c157 if { input["y"] == 4 }
c158 if { input["f"] == true }
c159 if { c156; c157; c158 }
c160 if { input["x"] == 1 }
c161 if { input["y"] == 5 }
c162 if { input["f"] == false }
c163 if { c160; c161; c162 }
c164 if { input["x"] == 1 }
c165 if { input["y"] == 5 }
c166 if { input["f"] == true }
c167 if { c164; c165; c166 }
c168 if { input["x"] == 2 }
c169 if { input["y"] == 1 }
c170 if { input["f"] == false }
c171 if { c168; c169; c170 }
c172 if { input["x"] == 2 }
c173 if { input["y"] == 1 }
c174 if { input["f"] == true }
c175 if { c172; c173; c174 }
c176 if { input["x"] == 2 }
c177 if { input["y"] == 2 }
c178 if { input["f"] == false }
c179 if { c176; c177; c178 }
c180 if { input["x"] == 2 }
c181 if { input["y"] == 2 }
c182 if { input["f"] == true }
c183 if { c180; c181; c182 }
c184 if { input["x"] == 2 }
c185 if { input["y"] == 3 }
c186 if { input["f"] == false }
c187 if { c184; c185; c186 }
c188 if { input["x"] == 2 }
c189 if { input["y"] == 3 }
c190 if { input["f"] == true }
c191 if { c188; c189; c190 }
c192 if { input["x"] == 2 }
c193 if { input["y"] == 4 }
c194 if { input["f"] == false }
c195 if { c192; c193; c194 }
c196 if { input["x"] == 2 }
c197 if { input["y"] == 4 }
c198 if { input["f"] == true }
c199 if { c196; c197; c198 }
c200 if { input["x"] == 2 }
c201 if { input["y"] == 5 }
c202 if { input["f"] == false }
c203 if { c200; c201; c202 }
c204 if { input["x"] == 2 }
c205 if { input["y"] == 5 }
c206 if { input["f"] == true }
c207 if { c204; c205; c206 }
c208 if { input["x"] == 3 }
c209 if { input["y"] == 1 }
c210 if { input["f"] == false }
c211 if { c208; c209; c210 }
c212 if { input["x"] == 3 }
c213 if { input["y"] == 1 }
c214 if { input["f"] == true }
c215 if { c212; c213; c214 }
c216 if { input["x"] == 3 }
c217 if { input["y"] == 2 }
c218 if { input["f"] == false }
c219 if { c216; c217; c218 }
c220 if { input["x"] == 3 }
c221 if { input["y"] == 2 }
c222 if { input["f"] == true }
c223 if { c220; c221; c222 }
c224 if { input["x"] == 3 }
c225 if { input["y"] == 3 }
c226 if { input["f"] == false }
c227 if { c224; c225; c226 }
c228 if { input["x"] == 3 }
c229 if { input["y"] == 3 }
c230 if { input["f"] == true }
c231 if { c228; c229; c230 }
c232 if { input["x"] == 3 }
c233 if { input["y"] == 4 }
c234 if { input["f"] == false }
c235 if { c232; c233; c234 }
c236 if { input["x"] == 3 }
c237 if { input["y"] == 4 }
c238 if { input["f"] == true }
c239 if { c236; c237; c238 }
c240 if { input["x"] == 3 }
c241 if { input["y"] == 5 }
c242 if { input["f"] == false }
c243 if { c240; c241; c242 }
c244 if { input["x"] == 3 }
c245 if { input["y"] == 5 }
c246 if { input["f"] == true }
c247 if { c244; c245; c246 }
c248 if { input["x"] == 4 }
c249 if { input["y"] == 1 }
c250 if { input["f"] == false }
c251 if { c248; c249; c250 }
c252 if { input["x"] == 4 }
c253 if { input["y"] == 1 }
c254 if { input["f"] == true }
c255 if { c252; c253; c254 }
c256 if { input["x"] == 4 }
c257 if { input["y"] == 2 }
c258 if { input["f"] == false }
c259 if { c256; c257; c258 }
c260 if { input["x"] == 4 }
c261 if { input["y"] == 2 }
c262 if { input["f"] == true }
c263 if { c260; c261; c262 }
c264 if { input["x"] == 4 }
c265 if { input["y"] == 3 }
c266 if { input["f"] == false }
c267 if { c264; c265; c266 }
c268 if { input["x"] == 4 }
c269 if { input["y"] == 3 }
c270 if { input["f"] == true }
c271 if { c268; c269; c270 }
c272 if { input["x"] == 4 }
c273 if { input["y"] == 4 }
c274 if { input["f"] == false }
c275 if { c272; c273; c274 }
c276 if { input["x"] == 4 }
c277 if { input["y"] == 4 }
c278 if { input["f"] == true }
c279 if { c276; c277; c278 }
c280 if { input["x"] == 4 }
c281 if { input["y"] == 5 }
c282 if { input["f"] == false }
c283 if { c280; c281; c282 }
c284 if { input["x"] == 4 }
c285 if { input["y"] == 5 }
c286 if { input["f"] == true }
c287 if { c284; c285; c286 }
c288 if { input["x"] == 5 }
c289 if { input["y"] == 2 }
c290 if { input["f"] == false }
c291 if { c288; c289; c290 }
c292 if { input["x"] == 5 }
c293 if { input["y"] == 2 }
c294 if { input["f"] == true }
c295 if { c292; c293; c294 }
c296 if { input["x"] == 5 }
c297 if { input["y"] == 3 }
c298 if { input["f"] == false }
c299 if { c296; c297; c298 }
c300 if { input["x"] == 5 }
c301 if { input["y"] == 3 }
c302 if { input["f"] == true }
c303 if { c300; c301; c302 }
c304 if { input["x"] == 5 }
c305 if { input["y"] == 4 }
c306 if { input["f"] == false }
c307 if { c304; c305; c306 }
c308 if { input["x"] == 5 }
c309 if { input["y"] == 4 }
c310 if { input["f"] == true }
c311 if { c308; c309; c310 }
c312 if { input["x"] == 5 }
c313 if { input["y"] == 5 }
c314 if { input["f"] == false }
c315 if { c312; c313; c314 }
c316 if { input["x"] == 5 }
c317 if { input["y"] == 5 }
c318 if { input["f"] == true }
c319 if { c316; c317; c318 }
