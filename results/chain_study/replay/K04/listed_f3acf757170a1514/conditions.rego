package thesis

c0 if { true }
c1 if { input["x"] >= 0 }
c2 if { input["x"] <= 1 }
c3 if { input["y"] >= 1 }
c4 if { input["y"] <= 2 }
c5 if { c1; c2; c3; c4 }
c6 if { input["x"] >= 0 }
c7 if { input["x"] <= 5 }
c8 if { input["y"] >= 2 }
c9 if { input["y"] <= 3 }
c10 if { c6; c7; c8; c9 }
c11 if { not c10 }
c12 if { c5; c11 }
rule_0 if { c12 }
c13 if { input["x"] >= 0 }
c14 if { input["x"] <= 1 }
c15 if { input["y"] >= 1 }
c16 if { input["y"] <= 3 }
c17 if { c13; c14; c15; c16 }
rule_1 if { c17 }
c18 if { input["x"] >= 4 }
c19 if { input["x"] <= 5 }
c20 if { input["y"] >= 0 }
c21 if { input["y"] <= 2 }
c22 if { c18; c19; c20; c21 }
c23 if { input["x"] >= 2 }
c24 if { input["x"] <= 5 }
c25 if { input["y"] >= 2 }
c26 if { input["y"] <= 3 }
c27 if { c23; c24; c25; c26 }
c28 if { not c27 }
c29 if { c22; c28 }
rule_2 if { c29 }
c30 if { input["x"] >= 0 }
c31 if { input["x"] <= 4 }
c32 if { input["y"] >= 4 }
c33 if { input["y"] <= 5 }
c34 if { c30; c31; c32; c33 }
rule_3 if { c34 }
c35 if { input["x"] >= 0 }
c36 if { input["x"] <= 5 }
c37 if { input["y"] >= 2 }
c38 if { input["y"] <= 3 }
c39 if { c35; c36; c37; c38 }
c40 if { input["x"] >= 0 }
c41 if { input["x"] <= 1 }
c42 if { input["y"] >= 1 }
c43 if { input["y"] <= 3 }
c44 if { c40; c41; c42; c43 }
c45 if { not c44 }
c46 if { c39; c45 }
c47 if { input["x"] >= 4 }
c48 if { input["x"] <= 5 }
c49 if { input["y"] >= 0 }
c50 if { input["y"] <= 2 }
c51 if { c47; c48; c49; c50 }
c52 if { not c51 }
c53 if { c46; c52 }
rule_4 if { c53 }
c54 if { input["x"] >= 2 }
c55 if { input["x"] <= 5 }
c56 if { input["y"] >= 2 }
c57 if { input["y"] <= 3 }
c58 if { c54; c55; c56; c57 }
rule_5 if { c58 }
c59 if { input["x"] >= 1 }
c60 if { input["x"] <= 3 }
c61 if { input["y"] >= 3 }
c62 if { input["y"] <= 4 }
c63 if { input["f"] == false }
c64 if { c59; c60; c61; c62; c63 }
c65 if { input["x"] >= 0 }
c66 if { input["x"] <= 1 }
c67 if { input["y"] >= 1 }
c68 if { input["y"] <= 3 }
c69 if { c65; c66; c67; c68 }
c70 if { not c69 }
c71 if { c64; c70 }
c72 if { input["x"] >= 0 }
c73 if { input["x"] <= 4 }
c74 if { input["y"] >= 4 }
c75 if { input["y"] <= 5 }
c76 if { c72; c73; c74; c75 }
c77 if { not c76 }
c78 if { c71; c77 }
rule_6 if { c78 }
c79 if { input["x"] == 0 }
c80 if { input["y"] == 1 }
c81 if { input["f"] == false }
c82 if { c79; c80; c81 }
c83 if { input["x"] == 0 }
c84 if { input["y"] == 1 }
c85 if { input["f"] == true }
c86 if { c83; c84; c85 }
c87 if { input["x"] == 0 }
c88 if { input["y"] == 2 }
c89 if { input["f"] == false }
c90 if { c87; c88; c89 }
c91 if { input["x"] == 0 }
c92 if { input["y"] == 2 }
c93 if { input["f"] == true }
c94 if { c91; c92; c93 }
c95 if { input["x"] == 0 }
c96 if { input["y"] == 3 }
c97 if { input["f"] == false }
c98 if { c95; c96; c97 }
c99 if { input["x"] == 0 }
c100 if { input["y"] == 3 }
c101 if { input["f"] == true }
c102 if { c99; c100; c101 }
c103 if { input["x"] == 0 }
c104 if { input["y"] == 4 }
c105 if { input["f"] == false }
c106 if { c103; c104; c105 }
c107 if { input["x"] == 0 }
c108 if { input["y"] == 4 }
c109 if { input["f"] == true }
c110 if { c107; c108; c109 }
c111 if { input["x"] == 0 }
c112 if { input["y"] == 5 }
c113 if { input["f"] == false }
c114 if { c111; c112; c113 }
c115 if { input["x"] == 0 }
c116 if { input["y"] == 5 }
c117 if { input["f"] == true }
c118 if { c115; c116; c117 }
c119 if { input["x"] == 1 }
c120 if { input["y"] == 1 }
c121 if { input["f"] == false }
c122 if { c119; c120; c121 }
c123 if { input["x"] == 1 }
c124 if { input["y"] == 1 }
c125 if { input["f"] == true }
c126 if { c123; c124; c125 }
c127 if { input["x"] == 1 }
c128 if { input["y"] == 2 }
c129 if { input["f"] == false }
c130 if { c127; c128; c129 }
c131 if { input["x"] == 1 }
c132 if { input["y"] == 2 }
c133 if { input["f"] == true }
c134 if { c131; c132; c133 }
c135 if { input["x"] == 1 }
c136 if { input["y"] == 3 }
c137 if { input["f"] == false }
c138 if { c135; c136; c137 }
c139 if { input["x"] == 1 }
c140 if { input["y"] == 3 }
c141 if { input["f"] == true }
c142 if { c139; c140; c141 }
c143 if { input["x"] == 1 }
c144 if { input["y"] == 4 }
c145 if { input["f"] == false }
c146 if { c143; c144; c145 }
c147 if { input["x"] == 1 }
c148 if { input["y"] == 4 }
c149 if { input["f"] == true }
c150 if { c147; c148; c149 }
c151 if { input["x"] == 1 }
c152 if { input["y"] == 5 }
c153 if { input["f"] == false }
c154 if { c151; c152; c153 }
c155 if { input["x"] == 1 }
c156 if { input["y"] == 5 }
c157 if { input["f"] == true }
c158 if { c155; c156; c157 }
c159 if { input["x"] == 2 }
c160 if { input["y"] == 2 }
c161 if { input["f"] == false }
c162 if { c159; c160; c161 }
c163 if { input["x"] == 2 }
c164 if { input["y"] == 2 }
c165 if { input["f"] == true }
c166 if { c163; c164; c165 }
c167 if { input["x"] == 2 }
c168 if { input["y"] == 3 }
c169 if { input["f"] == false }
c170 if { c167; c168; c169 }
c171 if { input["x"] == 2 }
c172 if { input["y"] == 3 }
c173 if { input["f"] == true }
c174 if { c171; c172; c173 }
c175 if { input["x"] == 2 }
c176 if { input["y"] == 4 }
c177 if { input["f"] == false }
c178 if { c175; c176; c177 }
c179 if { input["x"] == 2 }
c180 if { input["y"] == 4 }
c181 if { input["f"] == true }
c182 if { c179; c180; c181 }
c183 if { input["x"] == 2 }
c184 if { input["y"] == 5 }
c185 if { input["f"] == false }
c186 if { c183; c184; c185 }
c187 if { input["x"] == 2 }
c188 if { input["y"] == 5 }
c189 if { input["f"] == true }
c190 if { c187; c188; c189 }
c191 if { input["x"] == 3 }
c192 if { input["y"] == 2 }
c193 if { input["f"] == false }
c194 if { c191; c192; c193 }
c195 if { input["x"] == 3 }
c196 if { input["y"] == 2 }
c197 if { input["f"] == true }
c198 if { c195; c196; c197 }
c199 if { input["x"] == 3 }
c200 if { input["y"] == 3 }
c201 if { input["f"] == false }
c202 if { c199; c200; c201 }
c203 if { input["x"] == 3 }
c204 if { input["y"] == 3 }
c205 if { input["f"] == true }
c206 if { c203; c204; c205 }
c207 if { input["x"] == 3 }
c208 if { input["y"] == 4 }
c209 if { input["f"] == false }
c210 if { c207; c208; c209 }
c211 if { input["x"] == 3 }
c212 if { input["y"] == 4 }
c213 if { input["f"] == true }
c214 if { c211; c212; c213 }
c215 if { input["x"] == 3 }
c216 if { input["y"] == 5 }
c217 if { input["f"] == false }
c218 if { c215; c216; c217 }
c219 if { input["x"] == 3 }
c220 if { input["y"] == 5 }
c221 if { input["f"] == true }
c222 if { c219; c220; c221 }
c223 if { input["x"] == 4 }
c224 if { input["y"] == 0 }
c225 if { input["f"] == false }
c226 if { c223; c224; c225 }
c227 if { input["x"] == 4 }
c228 if { input["y"] == 0 }
c229 if { input["f"] == true }
c230 if { c227; c228; c229 }
c231 if { input["x"] == 4 }
c232 if { input["y"] == 1 }
c233 if { input["f"] == false }
c234 if { c231; c232; c233 }
c235 if { input["x"] == 4 }
c236 if { input["y"] == 1 }
c237 if { input["f"] == true }
c238 if { c235; c236; c237 }
c239 if { input["x"] == 4 }
c240 if { input["y"] == 2 }
c241 if { input["f"] == false }
c242 if { c239; c240; c241 }
c243 if { input["x"] == 4 }
c244 if { input["y"] == 2 }
c245 if { input["f"] == true }
c246 if { c243; c244; c245 }
c247 if { input["x"] == 4 }
c248 if { input["y"] == 3 }
c249 if { input["f"] == false }
c250 if { c247; c248; c249 }
c251 if { input["x"] == 4 }
c252 if { input["y"] == 3 }
c253 if { input["f"] == true }
c254 if { c251; c252; c253 }
c255 if { input["x"] == 4 }
c256 if { input["y"] == 4 }
c257 if { input["f"] == false }
c258 if { c255; c256; c257 }
c259 if { input["x"] == 4 }
c260 if { input["y"] == 4 }
c261 if { input["f"] == true }
c262 if { c259; c260; c261 }
c263 if { input["x"] == 4 }
c264 if { input["y"] == 5 }
c265 if { input["f"] == false }
c266 if { c263; c264; c265 }
c267 if { input["x"] == 4 }
c268 if { input["y"] == 5 }
c269 if { input["f"] == true }
c270 if { c267; c268; c269 }
c271 if { input["x"] == 5 }
c272 if { input["y"] == 0 }
c273 if { input["f"] == false }
c274 if { c271; c272; c273 }
c275 if { input["x"] == 5 }
c276 if { input["y"] == 0 }
c277 if { input["f"] == true }
c278 if { c275; c276; c277 }
c279 if { input["x"] == 5 }
c280 if { input["y"] == 1 }
c281 if { input["f"] == false }
c282 if { c279; c280; c281 }
c283 if { input["x"] == 5 }
c284 if { input["y"] == 1 }
c285 if { input["f"] == true }
c286 if { c283; c284; c285 }
c287 if { input["x"] == 5 }
c288 if { input["y"] == 2 }
c289 if { input["f"] == false }
c290 if { c287; c288; c289 }
c291 if { input["x"] == 5 }
c292 if { input["y"] == 2 }
c293 if { input["f"] == true }
c294 if { c291; c292; c293 }
c295 if { input["x"] == 5 }
c296 if { input["y"] == 3 }
c297 if { input["f"] == false }
c298 if { c295; c296; c297 }
c299 if { input["x"] == 5 }
c300 if { input["y"] == 3 }
c301 if { input["f"] == true }
c302 if { c299; c300; c301 }
