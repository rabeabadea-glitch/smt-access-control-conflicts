package thesis

c0 if { true }
c1 if { input["x"] >= 1 }
c2 if { input["x"] <= 2 }
c3 if { input["y"] >= 1 }
c4 if { input["y"] <= 4 }
c5 if { c1; c2; c3; c4 }
c6 if { input["x"] >= 1 }
c7 if { input["x"] <= 2 }
c8 if { input["y"] >= 3 }
c9 if { input["y"] <= 4 }
c10 if { c6; c7; c8; c9 }
c11 if { not c10 }
c12 if { c5; c11 }
rule_0 if { c12 }
c13 if { input["x"] >= 2 }
c14 if { input["x"] <= 3 }
c15 if { input["y"] >= 2 }
c16 if { input["y"] <= 3 }
c17 if { c13; c14; c15; c16 }
rule_1 if { c17 }
c18 if { input["x"] >= 0 }
c19 if { input["x"] <= 3 }
c20 if { input["y"] >= 0 }
c21 if { input["y"] <= 2 }
c22 if { c18; c19; c20; c21 }
c23 if { input["x"] >= 1 }
c24 if { input["x"] <= 2 }
c25 if { input["y"] >= 1 }
c26 if { input["y"] <= 4 }
c27 if { c23; c24; c25; c26 }
c28 if { not c27 }
c29 if { c22; c28 }
c30 if { input["x"] >= 2 }
c31 if { input["x"] <= 3 }
c32 if { input["y"] >= 2 }
c33 if { input["y"] <= 3 }
c34 if { c30; c31; c32; c33 }
c35 if { not c34 }
c36 if { c29; c35 }
rule_2 if { c36 }
c37 if { input["x"] >= 2 }
c38 if { input["x"] <= 3 }
c39 if { input["y"] >= 5 }
c40 if { input["y"] <= 5 }
c41 if { c37; c38; c39; c40 }
rule_3 if { c41 }
c42 if { input["x"] >= 3 }
c43 if { input["x"] <= 5 }
c44 if { input["y"] >= 0 }
c45 if { input["y"] <= 5 }
c46 if { input["f"] == true }
c47 if { c42; c43; c44; c45; c46 }
c48 if { input["x"] >= 0 }
c49 if { input["x"] <= 3 }
c50 if { input["y"] >= 0 }
c51 if { input["y"] <= 2 }
c52 if { c48; c49; c50; c51 }
c53 if { input["x"] >= 1 }
c54 if { input["x"] <= 2 }
c55 if { input["y"] >= 1 }
c56 if { input["y"] <= 4 }
c57 if { c53; c54; c55; c56 }
c58 if { not c57 }
c59 if { c52; c58 }
c60 if { input["x"] >= 2 }
c61 if { input["x"] <= 3 }
c62 if { input["y"] >= 2 }
c63 if { input["y"] <= 3 }
c64 if { c60; c61; c62; c63 }
c65 if { not c64 }
c66 if { c59; c65 }
c67 if { not c66 }
c68 if { c47; c67 }
rule_4 if { c68 }
c69 if { input["x"] >= 1 }
c70 if { input["x"] <= 2 }
c71 if { input["y"] >= 3 }
c72 if { input["y"] <= 4 }
c73 if { c69; c70; c71; c72 }
c74 if { input["x"] >= 2 }
c75 if { input["x"] <= 3 }
c76 if { input["y"] >= 2 }
c77 if { input["y"] <= 3 }
c78 if { c74; c75; c76; c77 }
c79 if { not c78 }
c80 if { c73; c79 }
rule_5 if { c80 }
c81 if { input["x"] == 0 }
c82 if { input["y"] == 0 }
c83 if { input["f"] == false }
c84 if { c81; c82; c83 }
c85 if { input["x"] == 0 }
c86 if { input["y"] == 0 }
c87 if { input["f"] == true }
c88 if { c85; c86; c87 }
c89 if { input["x"] == 0 }
c90 if { input["y"] == 1 }
c91 if { input["f"] == false }
c92 if { c89; c90; c91 }
c93 if { input["x"] == 0 }
c94 if { input["y"] == 1 }
c95 if { input["f"] == true }
c96 if { c93; c94; c95 }
c97 if { input["x"] == 0 }
c98 if { input["y"] == 2 }
c99 if { input["f"] == false }
c100 if { c97; c98; c99 }
c101 if { input["x"] == 0 }
c102 if { input["y"] == 2 }
c103 if { input["f"] == true }
c104 if { c101; c102; c103 }
c105 if { input["x"] == 1 }
c106 if { input["y"] == 0 }
c107 if { input["f"] == false }
c108 if { c105; c106; c107 }
c109 if { input["x"] == 1 }
c110 if { input["y"] == 0 }
c111 if { input["f"] == true }
c112 if { c109; c110; c111 }
c113 if { input["x"] == 1 }
c114 if { input["y"] == 1 }
c115 if { input["f"] == false }
c116 if { c113; c114; c115 }
c117 if { input["x"] == 1 }
c118 if { input["y"] == 1 }
c119 if { input["f"] == true }
c120 if { c117; c118; c119 }
c121 if { input["x"] == 1 }
c122 if { input["y"] == 2 }
c123 if { input["f"] == false }
c124 if { c121; c122; c123 }
c125 if { input["x"] == 1 }
c126 if { input["y"] == 2 }
c127 if { input["f"] == true }
c128 if { c125; c126; c127 }
c129 if { input["x"] == 1 }
c130 if { input["y"] == 3 }
c131 if { input["f"] == false }
c132 if { c129; c130; c131 }
c133 if { input["x"] == 1 }
c134 if { input["y"] == 3 }
c135 if { input["f"] == true }
c136 if { c133; c134; c135 }
c137 if { input["x"] == 1 }
c138 if { input["y"] == 4 }
c139 if { input["f"] == false }
c140 if { c137; c138; c139 }
c141 if { input["x"] == 1 }
c142 if { input["y"] == 4 }
c143 if { input["f"] == true }
c144 if { c141; c142; c143 }
c145 if { input["x"] == 2 }
c146 if { input["y"] == 0 }
c147 if { input["f"] == false }
c148 if { c145; c146; c147 }
c149 if { input["x"] == 2 }
c150 if { input["y"] == 0 }
c151 if { input["f"] == true }
c152 if { c149; c150; c151 }
c153 if { input["x"] == 2 }
c154 if { input["y"] == 1 }
c155 if { input["f"] == false }
c156 if { c153; c154; c155 }
c157 if { input["x"] == 2 }
c158 if { input["y"] == 1 }
c159 if { input["f"] == true }
c160 if { c157; c158; c159 }
c161 if { input["x"] == 2 }
c162 if { input["y"] == 2 }
c163 if { input["f"] == false }
c164 if { c161; c162; c163 }
c165 if { input["x"] == 2 }
c166 if { input["y"] == 2 }
c167 if { input["f"] == true }
c168 if { c165; c166; c167 }
c169 if { input["x"] == 2 }
c170 if { input["y"] == 3 }
c171 if { input["f"] == false }
c172 if { c169; c170; c171 }
c173 if { input["x"] == 2 }
c174 if { input["y"] == 3 }
c175 if { input["f"] == true }
c176 if { c173; c174; c175 }
c177 if { input["x"] == 2 }
c178 if { input["y"] == 4 }
c179 if { input["f"] == false }
c180 if { c177; c178; c179 }
c181 if { input["x"] == 2 }
c182 if { input["y"] == 4 }
c183 if { input["f"] == true }
c184 if { c181; c182; c183 }
c185 if { input["x"] == 2 }
c186 if { input["y"] == 5 }
c187 if { input["f"] == false }
c188 if { c185; c186; c187 }
c189 if { input["x"] == 2 }
c190 if { input["y"] == 5 }
c191 if { input["f"] == true }
c192 if { c189; c190; c191 }
c193 if { input["x"] == 3 }
c194 if { input["y"] == 0 }
c195 if { input["f"] == false }
c196 if { c193; c194; c195 }
c197 if { input["x"] == 3 }
c198 if { input["y"] == 0 }
c199 if { input["f"] == true }
c200 if { c197; c198; c199 }
c201 if { input["x"] == 3 }
c202 if { input["y"] == 1 }
c203 if { input["f"] == false }
c204 if { c201; c202; c203 }
c205 if { input["x"] == 3 }
c206 if { input["y"] == 1 }
c207 if { input["f"] == true }
c208 if { c205; c206; c207 }
c209 if { input["x"] == 3 }
c210 if { input["y"] == 2 }
c211 if { input["f"] == false }
c212 if { c209; c210; c211 }
c213 if { input["x"] == 3 }
c214 if { input["y"] == 2 }
c215 if { input["f"] == true }
c216 if { c213; c214; c215 }
c217 if { input["x"] == 3 }
c218 if { input["y"] == 3 }
c219 if { input["f"] == false }
c220 if { c217; c218; c219 }
c221 if { input["x"] == 3 }
c222 if { input["y"] == 3 }
c223 if { input["f"] == true }
c224 if { c221; c222; c223 }
c225 if { input["x"] == 3 }
c226 if { input["y"] == 4 }
c227 if { input["f"] == true }
c228 if { c225; c226; c227 }
c229 if { input["x"] == 3 }
c230 if { input["y"] == 5 }
c231 if { input["f"] == false }
c232 if { c229; c230; c231 }
c233 if { input["x"] == 3 }
c234 if { input["y"] == 5 }
c235 if { input["f"] == true }
c236 if { c233; c234; c235 }
c237 if { input["x"] == 4 }
c238 if { input["y"] == 0 }
c239 if { input["f"] == true }
c240 if { c237; c238; c239 }
c241 if { input["x"] == 4 }
c242 if { input["y"] == 1 }
c243 if { input["f"] == true }
c244 if { c241; c242; c243 }
c245 if { input["x"] == 4 }
c246 if { input["y"] == 2 }
c247 if { input["f"] == true }
c248 if { c245; c246; c247 }
c249 if { input["x"] == 4 }
c250 if { input["y"] == 3 }
c251 if { input["f"] == true }
c252 if { c249; c250; c251 }
c253 if { input["x"] == 4 }
c254 if { input["y"] == 4 }
c255 if { input["f"] == true }
c256 if { c253; c254; c255 }
c257 if { input["x"] == 4 }
c258 if { input["y"] == 5 }
c259 if { input["f"] == true }
c260 if { c257; c258; c259 }
c261 if { input["x"] == 5 }
c262 if { input["y"] == 0 }
c263 if { input["f"] == true }
c264 if { c261; c262; c263 }
c265 if { input["x"] == 5 }
c266 if { input["y"] == 1 }
c267 if { input["f"] == true }
c268 if { c265; c266; c267 }
c269 if { input["x"] == 5 }
c270 if { input["y"] == 2 }
c271 if { input["f"] == true }
c272 if { c269; c270; c271 }
c273 if { input["x"] == 5 }
c274 if { input["y"] == 3 }
c275 if { input["f"] == true }
c276 if { c273; c274; c275 }
c277 if { input["x"] == 5 }
c278 if { input["y"] == 4 }
c279 if { input["f"] == true }
c280 if { c277; c278; c279 }
c281 if { input["x"] == 5 }
c282 if { input["y"] == 5 }
c283 if { input["f"] == true }
c284 if { c281; c282; c283 }
