package thesis

c0 if { true }
c1 if { input["x"] >= 2 }
c2 if { input["x"] <= 3 }
c3 if { input["y"] >= 2 }
c4 if { input["y"] <= 3 }
c5 if { c1; c2; c3; c4 }
rule_0 if { c5 }
c6 if { input["x"] >= 1 }
c7 if { input["x"] <= 2 }
c8 if { input["y"] >= 3 }
c9 if { input["y"] <= 4 }
c10 if { c6; c7; c8; c9 }
c11 if { input["x"] >= 2 }
c12 if { input["x"] <= 3 }
c13 if { input["y"] >= 2 }
c14 if { input["y"] <= 3 }
c15 if { c11; c12; c13; c14 }
c16 if { not c15 }
c17 if { c10; c16 }
rule_1 if { c17 }
c18 if { input["x"] >= 1 }
c19 if { input["x"] <= 2 }
c20 if { input["y"] >= 1 }
c21 if { input["y"] <= 4 }
c22 if { c18; c19; c20; c21 }
c23 if { input["x"] >= 1 }
c24 if { input["x"] <= 2 }
c25 if { input["y"] >= 3 }
c26 if { input["y"] <= 4 }
c27 if { c23; c24; c25; c26 }
c28 if { input["x"] >= 2 }
c29 if { input["x"] <= 3 }
c30 if { input["y"] >= 2 }
c31 if { input["y"] <= 3 }
c32 if { c28; c29; c30; c31 }
c33 if { not c32 }
c34 if { c27; c33 }
c35 if { not c34 }
c36 if { c22; c35 }
rule_2 if { c36 }
c37 if { input["x"] >= 0 }
c38 if { input["x"] <= 3 }
c39 if { input["y"] >= 0 }
c40 if { input["y"] <= 2 }
c41 if { c37; c38; c39; c40 }
c42 if { input["x"] >= 2 }
c43 if { input["x"] <= 3 }
c44 if { input["y"] >= 2 }
c45 if { input["y"] <= 3 }
c46 if { c42; c43; c44; c45 }
c47 if { not c46 }
c48 if { c41; c47 }
c49 if { input["x"] >= 1 }
c50 if { input["x"] <= 2 }
c51 if { input["y"] >= 1 }
c52 if { input["y"] <= 4 }
c53 if { c49; c50; c51; c52 }
c54 if { input["x"] >= 1 }
c55 if { input["x"] <= 2 }
c56 if { input["y"] >= 3 }
c57 if { input["y"] <= 4 }
c58 if { c54; c55; c56; c57 }
c59 if { input["x"] >= 2 }
c60 if { input["x"] <= 3 }
c61 if { input["y"] >= 2 }
c62 if { input["y"] <= 3 }
c63 if { c59; c60; c61; c62 }
c64 if { not c63 }
c65 if { c58; c64 }
c66 if { not c65 }
c67 if { c53; c66 }
c68 if { not c67 }
c69 if { c48; c68 }
rule_3 if { c69 }
c70 if { input["x"] >= 2 }
c71 if { input["x"] <= 3 }
c72 if { input["y"] >= 5 }
c73 if { input["y"] <= 5 }
c74 if { c70; c71; c72; c73 }
rule_4 if { c74 }
c75 if { input["x"] >= 3 }
c76 if { input["x"] <= 5 }
c77 if { input["y"] >= 0 }
c78 if { input["y"] <= 5 }
c79 if { input["f"] == true }
c80 if { c75; c76; c77; c78; c79 }
c81 if { input["x"] >= 0 }
c82 if { input["x"] <= 3 }
c83 if { input["y"] >= 0 }
c84 if { input["y"] <= 2 }
c85 if { c81; c82; c83; c84 }
c86 if { input["x"] >= 2 }
c87 if { input["x"] <= 3 }
c88 if { input["y"] >= 2 }
c89 if { input["y"] <= 3 }
c90 if { c86; c87; c88; c89 }
c91 if { not c90 }
c92 if { c85; c91 }
c93 if { input["x"] >= 1 }
c94 if { input["x"] <= 2 }
c95 if { input["y"] >= 1 }
c96 if { input["y"] <= 4 }
c97 if { c93; c94; c95; c96 }
c98 if { input["x"] >= 1 }
c99 if { input["x"] <= 2 }
c100 if { input["y"] >= 3 }
c101 if { input["y"] <= 4 }
c102 if { c98; c99; c100; c101 }
c103 if { input["x"] >= 2 }
c104 if { input["x"] <= 3 }
c105 if { input["y"] >= 2 }
c106 if { input["y"] <= 3 }
c107 if { c103; c104; c105; c106 }
c108 if { not c107 }
c109 if { c102; c108 }
c110 if { not c109 }
c111 if { c97; c110 }
c112 if { not c111 }
c113 if { c92; c112 }
c114 if { not c113 }
c115 if { c80; c114 }
rule_5 if { c115 }
c116 if { input["x"] == 0 }
c117 if { input["y"] == 0 }
c118 if { input["f"] == false }
c119 if { c116; c117; c118 }
c120 if { input["x"] == 0 }
c121 if { input["y"] == 0 }
c122 if { input["f"] == true }
c123 if { c120; c121; c122 }
c124 if { input["x"] == 0 }
c125 if { input["y"] == 1 }
c126 if { input["f"] == false }
c127 if { c124; c125; c126 }
c128 if { input["x"] == 0 }
c129 if { input["y"] == 1 }
c130 if { input["f"] == true }
c131 if { c128; c129; c130 }
c132 if { input["x"] == 0 }
c133 if { input["y"] == 2 }
c134 if { input["f"] == false }
c135 if { c132; c133; c134 }
c136 if { input["x"] == 0 }
c137 if { input["y"] == 2 }
c138 if { input["f"] == true }
c139 if { c136; c137; c138 }
c140 if { input["x"] == 1 }
c141 if { input["y"] == 0 }
c142 if { input["f"] == false }
c143 if { c140; c141; c142 }
c144 if { input["x"] == 1 }
c145 if { input["y"] == 0 }
c146 if { input["f"] == true }
c147 if { c144; c145; c146 }
c148 if { input["x"] == 1 }
c149 if { input["y"] == 1 }
c150 if { input["f"] == false }
c151 if { c148; c149; c150 }
c152 if { input["x"] == 1 }
c153 if { input["y"] == 1 }
c154 if { input["f"] == true }
c155 if { c152; c153; c154 }
c156 if { input["x"] == 1 }
c157 if { input["y"] == 2 }
c158 if { input["f"] == false }
c159 if { c156; c157; c158 }
c160 if { input["x"] == 1 }
c161 if { input["y"] == 2 }
c162 if { input["f"] == true }
c163 if { c160; c161; c162 }
c164 if { input["x"] == 1 }
c165 if { input["y"] == 3 }
c166 if { input["f"] == false }
c167 if { c164; c165; c166 }
c168 if { input["x"] == 1 }
c169 if { input["y"] == 3 }
c170 if { input["f"] == true }
c171 if { c168; c169; c170 }
c172 if { input["x"] == 1 }
c173 if { input["y"] == 4 }
c174 if { input["f"] == false }
c175 if { c172; c173; c174 }
c176 if { input["x"] == 1 }
c177 if { input["y"] == 4 }
c178 if { input["f"] == true }
c179 if { c176; c177; c178 }
c180 if { input["x"] == 2 }
c181 if { input["y"] == 0 }
c182 if { input["f"] == false }
c183 if { c180; c181; c182 }
c184 if { input["x"] == 2 }
c185 if { input["y"] == 0 }
c186 if { input["f"] == true }
c187 if { c184; c185; c186 }
c188 if { input["x"] == 2 }
c189 if { input["y"] == 1 }
c190 if { input["f"] == false }
c191 if { c188; c189; c190 }
c192 if { input["x"] == 2 }
c193 if { input["y"] == 1 }
c194 if { input["f"] == true }
c195 if { c192; c193; c194 }
c196 if { input["x"] == 2 }
c197 if { input["y"] == 2 }
c198 if { input["f"] == false }
c199 if { c196; c197; c198 }
c200 if { input["x"] == 2 }
c201 if { input["y"] == 2 }
c202 if { input["f"] == true }
c203 if { c200; c201; c202 }
c204 if { input["x"] == 2 }
c205 if { input["y"] == 3 }
c206 if { input["f"] == false }
c207 if { c204; c205; c206 }
c208 if { input["x"] == 2 }
c209 if { input["y"] == 3 }
c210 if { input["f"] == true }
c211 if { c208; c209; c210 }
c212 if { input["x"] == 2 }
c213 if { input["y"] == 4 }
c214 if { input["f"] == false }
c215 if { c212; c213; c214 }
c216 if { input["x"] == 2 }
c217 if { input["y"] == 4 }
c218 if { input["f"] == true }
c219 if { c216; c217; c218 }
c220 if { input["x"] == 2 }
c221 if { input["y"] == 5 }
c222 if { input["f"] == false }
c223 if { c220; c221; c222 }
c224 if { input["x"] == 2 }
c225 if { input["y"] == 5 }
c226 if { input["f"] == true }
c227 if { c224; c225; c226 }
c228 if { input["x"] == 3 }
c229 if { input["y"] == 0 }
c230 if { input["f"] == false }
c231 if { c228; c229; c230 }
c232 if { input["x"] == 3 }
c233 if { input["y"] == 0 }
c234 if { input["f"] == true }
c235 if { c232; c233; c234 }
c236 if { input["x"] == 3 }
c237 if { input["y"] == 1 }
c238 if { input["f"] == false }
c239 if { c236; c237; c238 }
c240 if { input["x"] == 3 }
c241 if { input["y"] == 1 }
c242 if { input["f"] == true }
c243 if { c240; c241; c242 }
c244 if { input["x"] == 3 }
c245 if { input["y"] == 2 }
c246 if { input["f"] == false }
c247 if { c244; c245; c246 }
c248 if { input["x"] == 3 }
c249 if { input["y"] == 2 }
c250 if { input["f"] == true }
c251 if { c248; c249; c250 }
c252 if { input["x"] == 3 }
c253 if { input["y"] == 3 }
c254 if { input["f"] == false }
c255 if { c252; c253; c254 }
c256 if { input["x"] == 3 }
c257 if { input["y"] == 3 }
c258 if { input["f"] == true }
c259 if { c256; c257; c258 }
c260 if { input["x"] == 3 }
c261 if { input["y"] == 4 }
c262 if { input["f"] == true }
c263 if { c260; c261; c262 }
c264 if { input["x"] == 3 }
c265 if { input["y"] == 5 }
c266 if { input["f"] == false }
c267 if { c264; c265; c266 }
c268 if { input["x"] == 3 }
c269 if { input["y"] == 5 }
c270 if { input["f"] == true }
c271 if { c268; c269; c270 }
c272 if { input["x"] == 4 }
c273 if { input["y"] == 0 }
c274 if { input["f"] == true }
c275 if { c272; c273; c274 }
c276 if { input["x"] == 4 }
c277 if { input["y"] == 1 }
c278 if { input["f"] == true }
c279 if { c276; c277; c278 }
c280 if { input["x"] == 4 }
c281 if { input["y"] == 2 }
c282 if { input["f"] == true }
c283 if { c280; c281; c282 }
c284 if { input["x"] == 4 }
c285 if { input["y"] == 3 }
c286 if { input["f"] == true }
c287 if { c284; c285; c286 }
c288 if { input["x"] == 4 }
c289 if { input["y"] == 4 }
c290 if { input["f"] == true }
c291 if { c288; c289; c290 }
c292 if { input["x"] == 4 }
c293 if { input["y"] == 5 }
c294 if { input["f"] == true }
c295 if { c292; c293; c294 }
c296 if { input["x"] == 5 }
c297 if { input["y"] == 0 }
c298 if { input["f"] == true }
c299 if { c296; c297; c298 }
c300 if { input["x"] == 5 }
c301 if { input["y"] == 1 }
c302 if { input["f"] == true }
c303 if { c300; c301; c302 }
c304 if { input["x"] == 5 }
c305 if { input["y"] == 2 }
c306 if { input["f"] == true }
c307 if { c304; c305; c306 }
c308 if { input["x"] == 5 }
c309 if { input["y"] == 3 }
c310 if { input["f"] == true }
c311 if { c308; c309; c310 }
c312 if { input["x"] == 5 }
c313 if { input["y"] == 4 }
c314 if { input["f"] == true }
c315 if { c312; c313; c314 }
c316 if { input["x"] == 5 }
c317 if { input["y"] == 5 }
c318 if { input["f"] == true }
c319 if { c316; c317; c318 }
