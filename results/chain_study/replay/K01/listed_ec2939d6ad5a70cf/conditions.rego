package thesis

c0 if { true }
c1 if { input["x"] >= 0 }
c2 if { input["x"] <= 4 }
c3 if { input["y"] >= 2 }
c4 if { input["y"] <= 3 }
c5 if { input["f"] == false }
c6 if { c1; c2; c3; c4; c5 }
rule_0 if { c6 }
c7 if { input["x"] >= 0 }
c8 if { input["x"] <= 3 }
c9 if { input["y"] >= 0 }
c10 if { input["y"] <= 1 }
c11 if { c7; c8; c9; c10 }
rule_1 if { c11 }
c12 if { input["x"] >= 2 }
c13 if { input["x"] <= 4 }
c14 if { input["y"] >= 5 }
c15 if { input["y"] <= 5 }
c16 if { c12; c13; c14; c15 }
c17 if { input["x"] >= 4 }
c18 if { input["x"] <= 5 }
c19 if { input["y"] >= 3 }
c20 if { input["y"] <= 5 }
c21 if { input["f"] == false }
c22 if { c17; c18; c19; c20; c21 }
c23 if { input["x"] >= 0 }
c24 if { input["x"] <= 4 }
c25 if { input["y"] >= 2 }
c26 if { input["y"] <= 3 }
c27 if { input["f"] == false }
c28 if { c23; c24; c25; c26; c27 }
c29 if { not c28 }
c30 if { c22; c29 }
c31 if { not c30 }
c32 if { c16; c31 }
c33 if { input["x"] >= 3 }
c34 if { input["x"] <= 4 }
c35 if { input["y"] >= 2 }
c36 if { input["y"] <= 5 }
c37 if { c33; c34; c35; c36 }
c38 if { input["x"] >= 0 }
c39 if { input["x"] <= 4 }
c40 if { input["y"] >= 2 }
c41 if { input["y"] <= 3 }
c42 if { input["f"] == false }
c43 if { c38; c39; c40; c41; c42 }
c44 if { not c43 }
c45 if { c37; c44 }
c46 if { not c45 }
c47 if { c32; c46 }
rule_2 if { c47 }
c48 if { input["x"] >= 4 }
c49 if { input["x"] <= 5 }
c50 if { input["y"] >= 3 }
c51 if { input["y"] <= 5 }
c52 if { input["f"] == false }
c53 if { c48; c49; c50; c51; c52 }
c54 if { input["x"] >= 0 }
c55 if { input["x"] <= 4 }
c56 if { input["y"] >= 2 }
c57 if { input["y"] <= 3 }
c58 if { input["f"] == false }
c59 if { c54; c55; c56; c57; c58 }
c60 if { not c59 }
c61 if { c53; c60 }
rule_3 if { c61 }
c62 if { input["x"] >= 3 }
c63 if { input["x"] <= 4 }
c64 if { input["y"] >= 2 }
c65 if { input["y"] <= 5 }
c66 if { c62; c63; c64; c65 }
c67 if { input["x"] >= 0 }
c68 if { input["x"] <= 4 }
c69 if { input["y"] >= 2 }
c70 if { input["y"] <= 3 }
c71 if { input["f"] == false }
c72 if { c67; c68; c69; c70; c71 }
c73 if { not c72 }
c74 if { c66; c73 }
rule_4 if { c74 }
c75 if { input["x"] >= 2 }
c76 if { input["x"] <= 5 }
c77 if { input["y"] >= 0 }
c78 if { input["y"] <= 4 }
c79 if { input["f"] == false }
c80 if { c75; c76; c77; c78; c79 }
c81 if { input["x"] >= 4 }
c82 if { input["x"] <= 5 }
c83 if { input["y"] >= 3 }
c84 if { input["y"] <= 5 }
c85 if { input["f"] == false }
c86 if { c81; c82; c83; c84; c85 }
c87 if { input["x"] >= 0 }
c88 if { input["x"] <= 4 }
c89 if { input["y"] >= 2 }
c90 if { input["y"] <= 3 }
c91 if { input["f"] == false }
c92 if { c87; c88; c89; c90; c91 }
c93 if { not c92 }
c94 if { c86; c93 }
c95 if { not c94 }
c96 if { c80; c95 }
c97 if { input["x"] >= 3 }
c98 if { input["x"] <= 4 }
c99 if { input["y"] >= 2 }
c100 if { input["y"] <= 5 }
c101 if { c97; c98; c99; c100 }
c102 if { input["x"] >= 0 }
c103 if { input["x"] <= 4 }
c104 if { input["y"] >= 2 }
c105 if { input["y"] <= 3 }
c106 if { input["f"] == false }
c107 if { c102; c103; c104; c105; c106 }
c108 if { not c107 }
c109 if { c101; c108 }
c110 if { not c109 }
c111 if { c96; c110 }
rule_5 if { c111 }
c112 if { input["x"] >= 3 }
c113 if { input["x"] <= 3 }
c114 if { input["y"] >= 3 }
c115 if { input["y"] <= 4 }
c116 if { input["f"] == true }
c117 if { c112; c113; c114; c115; c116 }
rule_6 if { c117 }
c118 if { input["x"] == 0 }
c119 if { input["y"] == 0 }
c120 if { input["f"] == false }
c121 if { c118; c119; c120 }
c122 if { input["x"] == 0 }
c123 if { input["y"] == 0 }
c124 if { input["f"] == true }
c125 if { c122; c123; c124 }
c126 if { input["x"] == 0 }
c127 if { input["y"] == 1 }
c128 if { input["f"] == false }
c129 if { c126; c127; c128 }
c130 if { input["x"] == 0 }
c131 if { input["y"] == 1 }
c132 if { input["f"] == true }
c133 if { c130; c131; c132 }
c134 if { input["x"] == 0 }
c135 if { input["y"] == 2 }
c136 if { input["f"] == false }
c137 if { c134; c135; c136 }
c138 if { input["x"] == 0 }
c139 if { input["y"] == 3 }
c140 if { input["f"] == false }
c141 if { c138; c139; c140 }
c142 if { input["x"] == 1 }
c143 if { input["y"] == 0 }
c144 if { input["f"] == false }
c145 if { c142; c143; c144 }
c146 if { input["x"] == 1 }
c147 if { input["y"] == 0 }
c148 if { input["f"] == true }
c149 if { c146; c147; c148 }
c150 if { input["x"] == 1 }
c151 if { input["y"] == 1 }
c152 if { input["f"] == false }
c153 if { c150; c151; c152 }
c154 if { input["x"] == 1 }
c155 if { input["y"] == 1 }
c156 if { input["f"] == true }
c157 if { c154; c155; c156 }
c158 if { input["x"] == 1 }
c159 if { input["y"] == 2 }
c160 if { input["f"] == false }
c161 if { c158; c159; c160 }
c162 if { input["x"] == 1 }
c163 if { input["y"] == 3 }
c164 if { input["f"] == false }
c165 if { c162; c163; c164 }
c166 if { input["x"] == 2 }
c167 if { input["y"] == 0 }
c168 if { input["f"] == false }
c169 if { c166; c167; c168 }
c170 if { input["x"] == 2 }
c171 if { input["y"] == 0 }
c172 if { input["f"] == true }
c173 if { c170; c171; c172 }
c174 if { input["x"] == 2 }
c175 if { input["y"] == 1 }
c176 if { input["f"] == false }
c177 if { c174; c175; c176 }
c178 if { input["x"] == 2 }
c179 if { input["y"] == 1 }
c180 if { input["f"] == true }
c181 if { c178; c179; c180 }
c182 if { input["x"] == 2 }
c183 if { input["y"] == 2 }
c184 if { input["f"] == false }
c185 if { c182; c183; c184 }
c186 if { input["x"] == 2 }
c187 if { input["y"] == 3 }
c188 if { input["f"] == false }
c189 if { c186; c187; c188 }
c190 if { input["x"] == 2 }
c191 if { input["y"] == 4 }
c192 if { input["f"] == false }
c193 if { c190; c191; c192 }
c194 if { input["x"] == 2 }
c195 if { input["y"] == 5 }
c196 if { input["f"] == false }
c197 if { c194; c195; c196 }
c198 if { input["x"] == 2 }
c199 if { input["y"] == 5 }
c200 if { input["f"] == true }
c201 if { c198; c199; c200 }
c202 if { input["x"] == 3 }
c203 if { input["y"] == 0 }
c204 if { input["f"] == false }
c205 if { c202; c203; c204 }
c206 if { input["x"] == 3 }
c207 if { input["y"] == 0 }
c208 if { input["f"] == true }
c209 if { c206; c207; c208 }
c210 if { input["x"] == 3 }
c211 if { input["y"] == 1 }
c212 if { input["f"] == false }
c213 if { c210; c211; c212 }
c214 if { input["x"] == 3 }
c215 if { input["y"] == 1 }
c216 if { input["f"] == true }
c217 if { c214; c215; c216 }
c218 if { input["x"] == 3 }
c219 if { input["y"] == 2 }
c220 if { input["f"] == false }
c221 if { c218; c219; c220 }
c222 if { input["x"] == 3 }
c223 if { input["y"] == 2 }
c224 if { input["f"] == true }
c225 if { c222; c223; c224 }
c226 if { input["x"] == 3 }
c227 if { input["y"] == 3 }
c228 if { input["f"] == false }
c229 if { c226; c227; c228 }
c230 if { input["x"] == 3 }
c231 if { input["y"] == 3 }
c232 if { input["f"] == true }
c233 if { c230; c231; c232 }
c234 if { input["x"] == 3 }
c235 if { input["y"] == 4 }
c236 if { input["f"] == false }
c237 if { c234; c235; c236 }
c238 if { input["x"] == 3 }
c239 if { input["y"] == 4 }
c240 if { input["f"] == true }
c241 if { c238; c239; c240 }
c242 if { input["x"] == 3 }
c243 if { input["y"] == 5 }
c244 if { input["f"] == false }
c245 if { c242; c243; c244 }
c246 if { input["x"] == 3 }
c247 if { input["y"] == 5 }
c248 if { input["f"] == true }
c249 if { c246; c247; c248 }
c250 if { input["x"] == 4 }
c251 if { input["y"] == 0 }
c252 if { input["f"] == false }
c253 if { c250; c251; c252 }
c254 if { input["x"] == 4 }
c255 if { input["y"] == 1 }
c256 if { input["f"] == false }
c257 if { c254; c255; c256 }
c258 if { input["x"] == 4 }
c259 if { input["y"] == 2 }
c260 if { input["f"] == false }
c261 if { c258; c259; c260 }
c262 if { input["x"] == 4 }
c263 if { input["y"] == 2 }
c264 if { input["f"] == true }
c265 if { c262; c263; c264 }
c266 if { input["x"] == 4 }
c267 if { input["y"] == 3 }
c268 if { input["f"] == false }
c269 if { c266; c267; c268 }
c270 if { input["x"] == 4 }
c271 if { input["y"] == 3 }
c272 if { input["f"] == true }
c273 if { c270; c271; c272 }
c274 if { input["x"] == 4 }
c275 if { input["y"] == 4 }
c276 if { input["f"] == false }
c277 if { c274; c275; c276 }
c278 if { input["x"] == 4 }
c279 if { input["y"] == 4 }
c280 if { input["f"] == true }
c281 if { c278; c279; c280 }
c282 if { input["x"] == 4 }
c283 if { input["y"] == 5 }
c284 if { input["f"] == false }
c285 if { c282; c283; c284 }
c286 if { input["x"] == 4 }
c287 if { input["y"] == 5 }
c288 if { input["f"] == true }
c289 if { c286; c287; c288 }
c290 if { input["x"] == 5 }
c291 if { input["y"] == 0 }
c292 if { input["f"] == false }
c293 if { c290; c291; c292 }
c294 if { input["x"] == 5 }
c295 if { input["y"] == 1 }
c296 if { input["f"] == false }
c297 if { c294; c295; c296 }
c298 if { input["x"] == 5 }
c299 if { input["y"] == 2 }
c300 if { input["f"] == false }
c301 if { c298; c299; c300 }
c302 if { input["x"] == 5 }
c303 if { input["y"] == 3 }
c304 if { input["f"] == false }
c305 if { c302; c303; c304 }
c306 if { input["x"] == 5 }
c307 if { input["y"] == 4 }
c308 if { input["f"] == false }
c309 if { c306; c307; c308 }
c310 if { input["x"] == 5 }
c311 if { input["y"] == 5 }
c312 if { input["f"] == false }
c313 if { c310; c311; c312 }
