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
c13 if { input["x"] >= 3 }
c14 if { input["x"] <= 5 }
c15 if { input["y"] >= 0 }
c16 if { input["y"] <= 5 }
c17 if { input["f"] == true }
c18 if { c13; c14; c15; c16; c17 }
c19 if { input["x"] >= 0 }
c20 if { input["x"] <= 3 }
c21 if { input["y"] >= 0 }
c22 if { input["y"] <= 2 }
c23 if { c19; c20; c21; c22 }
c24 if { input["x"] >= 1 }
c25 if { input["x"] <= 2 }
c26 if { input["y"] >= 1 }
c27 if { input["y"] <= 4 }
c28 if { c24; c25; c26; c27 }
c29 if { not c28 }
c30 if { c23; c29 }
c31 if { not c30 }
c32 if { c18; c31 }
rule_1 if { c32 }
c33 if { input["x"] >= 0 }
c34 if { input["x"] <= 3 }
c35 if { input["y"] >= 0 }
c36 if { input["y"] <= 2 }
c37 if { c33; c34; c35; c36 }
c38 if { input["x"] >= 1 }
c39 if { input["x"] <= 2 }
c40 if { input["y"] >= 1 }
c41 if { input["y"] <= 4 }
c42 if { c38; c39; c40; c41 }
c43 if { not c42 }
c44 if { c37; c43 }
c45 if { input["x"] >= 2 }
c46 if { input["x"] <= 3 }
c47 if { input["y"] >= 2 }
c48 if { input["y"] <= 3 }
c49 if { c45; c46; c47; c48 }
c50 if { not c49 }
c51 if { c44; c50 }
rule_2 if { c51 }
c52 if { input["x"] >= 2 }
c53 if { input["x"] <= 3 }
c54 if { input["y"] >= 2 }
c55 if { input["y"] <= 3 }
c56 if { c52; c53; c54; c55 }
rule_3 if { c56 }
c57 if { input["x"] >= 2 }
c58 if { input["x"] <= 3 }
c59 if { input["y"] >= 5 }
c60 if { input["y"] <= 5 }
c61 if { c57; c58; c59; c60 }
rule_4 if { c61 }
c62 if { input["x"] >= 1 }
c63 if { input["x"] <= 2 }
c64 if { input["y"] >= 3 }
c65 if { input["y"] <= 4 }
c66 if { c62; c63; c64; c65 }
c67 if { input["x"] >= 2 }
c68 if { input["x"] <= 3 }
c69 if { input["y"] >= 2 }
c70 if { input["y"] <= 3 }
c71 if { c67; c68; c69; c70 }
c72 if { not c71 }
c73 if { c66; c72 }
rule_5 if { c73 }
c74 if { input["x"] == 0 }
c75 if { input["y"] == 0 }
c76 if { input["f"] == false }
c77 if { c74; c75; c76 }
c78 if { input["x"] == 0 }
c79 if { input["y"] == 0 }
c80 if { input["f"] == true }
c81 if { c78; c79; c80 }
c82 if { input["x"] == 0 }
c83 if { input["y"] == 1 }
c84 if { input["f"] == false }
c85 if { c82; c83; c84 }
c86 if { input["x"] == 0 }
c87 if { input["y"] == 1 }
c88 if { input["f"] == true }
c89 if { c86; c87; c88 }
c90 if { input["x"] == 0 }
c91 if { input["y"] == 2 }
c92 if { input["f"] == false }
c93 if { c90; c91; c92 }
c94 if { input["x"] == 0 }
c95 if { input["y"] == 2 }
c96 if { input["f"] == true }
c97 if { c94; c95; c96 }
c98 if { input["x"] == 1 }
c99 if { input["y"] == 0 }
c100 if { input["f"] == false }
c101 if { c98; c99; c100 }
c102 if { input["x"] == 1 }
c103 if { input["y"] == 0 }
c104 if { input["f"] == true }
c105 if { c102; c103; c104 }
c106 if { input["x"] == 1 }
c107 if { input["y"] == 1 }
c108 if { input["f"] == false }
c109 if { c106; c107; c108 }
c110 if { input["x"] == 1 }
c111 if { input["y"] == 1 }
c112 if { input["f"] == true }
c113 if { c110; c111; c112 }
c114 if { input["x"] == 1 }
c115 if { input["y"] == 2 }
c116 if { input["f"] == false }
c117 if { c114; c115; c116 }
c118 if { input["x"] == 1 }
c119 if { input["y"] == 2 }
c120 if { input["f"] == true }
c121 if { c118; c119; c120 }
c122 if { input["x"] == 1 }
c123 if { input["y"] == 3 }
c124 if { input["f"] == false }
c125 if { c122; c123; c124 }
c126 if { input["x"] == 1 }
c127 if { input["y"] == 3 }
c128 if { input["f"] == true }
c129 if { c126; c127; c128 }
c130 if { input["x"] == 1 }
c131 if { input["y"] == 4 }
c132 if { input["f"] == false }
c133 if { c130; c131; c132 }
c134 if { input["x"] == 1 }
c135 if { input["y"] == 4 }
c136 if { input["f"] == true }
c137 if { c134; c135; c136 }
c138 if { input["x"] == 2 }
c139 if { input["y"] == 0 }
c140 if { input["f"] == false }
c141 if { c138; c139; c140 }
c142 if { input["x"] == 2 }
c143 if { input["y"] == 0 }
c144 if { input["f"] == true }
c145 if { c142; c143; c144 }
c146 if { input["x"] == 2 }
c147 if { input["y"] == 1 }
c148 if { input["f"] == false }
c149 if { c146; c147; c148 }
c150 if { input["x"] == 2 }
c151 if { input["y"] == 1 }
c152 if { input["f"] == true }
c153 if { c150; c151; c152 }
c154 if { input["x"] == 2 }
c155 if { input["y"] == 2 }
c156 if { input["f"] == false }
c157 if { c154; c155; c156 }
c158 if { input["x"] == 2 }
c159 if { input["y"] == 2 }
c160 if { input["f"] == true }
c161 if { c158; c159; c160 }
c162 if { input["x"] == 2 }
c163 if { input["y"] == 3 }
c164 if { input["f"] == false }
c165 if { c162; c163; c164 }
c166 if { input["x"] == 2 }
c167 if { input["y"] == 3 }
c168 if { input["f"] == true }
c169 if { c166; c167; c168 }
c170 if { input["x"] == 2 }
c171 if { input["y"] == 4 }
c172 if { input["f"] == false }
c173 if { c170; c171; c172 }
c174 if { input["x"] == 2 }
c175 if { input["y"] == 4 }
c176 if { input["f"] == true }
c177 if { c174; c175; c176 }
c178 if { input["x"] == 2 }
c179 if { input["y"] == 5 }
c180 if { input["f"] == false }
c181 if { c178; c179; c180 }
c182 if { input["x"] == 2 }
c183 if { input["y"] == 5 }
c184 if { input["f"] == true }
c185 if { c182; c183; c184 }
c186 if { input["x"] == 3 }
c187 if { input["y"] == 0 }
c188 if { input["f"] == false }
c189 if { c186; c187; c188 }
c190 if { input["x"] == 3 }
c191 if { input["y"] == 0 }
c192 if { input["f"] == true }
c193 if { c190; c191; c192 }
c194 if { input["x"] == 3 }
c195 if { input["y"] == 1 }
c196 if { input["f"] == false }
c197 if { c194; c195; c196 }
c198 if { input["x"] == 3 }
c199 if { input["y"] == 1 }
c200 if { input["f"] == true }
c201 if { c198; c199; c200 }
c202 if { input["x"] == 3 }
c203 if { input["y"] == 2 }
c204 if { input["f"] == false }
c205 if { c202; c203; c204 }
c206 if { input["x"] == 3 }
c207 if { input["y"] == 2 }
c208 if { input["f"] == true }
c209 if { c206; c207; c208 }
c210 if { input["x"] == 3 }
c211 if { input["y"] == 3 }
c212 if { input["f"] == false }
c213 if { c210; c211; c212 }
c214 if { input["x"] == 3 }
c215 if { input["y"] == 3 }
c216 if { input["f"] == true }
c217 if { c214; c215; c216 }
c218 if { input["x"] == 3 }
c219 if { input["y"] == 4 }
c220 if { input["f"] == true }
c221 if { c218; c219; c220 }
c222 if { input["x"] == 3 }
c223 if { input["y"] == 5 }
c224 if { input["f"] == false }
c225 if { c222; c223; c224 }
c226 if { input["x"] == 3 }
c227 if { input["y"] == 5 }
c228 if { input["f"] == true }
c229 if { c226; c227; c228 }
c230 if { input["x"] == 4 }
c231 if { input["y"] == 0 }
c232 if { input["f"] == true }
c233 if { c230; c231; c232 }
c234 if { input["x"] == 4 }
c235 if { input["y"] == 1 }
c236 if { input["f"] == true }
c237 if { c234; c235; c236 }
c238 if { input["x"] == 4 }
c239 if { input["y"] == 2 }
c240 if { input["f"] == true }
c241 if { c238; c239; c240 }
c242 if { input["x"] == 4 }
c243 if { input["y"] == 3 }
c244 if { input["f"] == true }
c245 if { c242; c243; c244 }
c246 if { input["x"] == 4 }
c247 if { input["y"] == 4 }
c248 if { input["f"] == true }
c249 if { c246; c247; c248 }
c250 if { input["x"] == 4 }
c251 if { input["y"] == 5 }
c252 if { input["f"] == true }
c253 if { c250; c251; c252 }
c254 if { input["x"] == 5 }
c255 if { input["y"] == 0 }
c256 if { input["f"] == true }
c257 if { c254; c255; c256 }
c258 if { input["x"] == 5 }
c259 if { input["y"] == 1 }
c260 if { input["f"] == true }
c261 if { c258; c259; c260 }
c262 if { input["x"] == 5 }
c263 if { input["y"] == 2 }
c264 if { input["f"] == true }
c265 if { c262; c263; c264 }
c266 if { input["x"] == 5 }
c267 if { input["y"] == 3 }
c268 if { input["f"] == true }
c269 if { c266; c267; c268 }
c270 if { input["x"] == 5 }
c271 if { input["y"] == 4 }
c272 if { input["f"] == true }
c273 if { c270; c271; c272 }
c274 if { input["x"] == 5 }
c275 if { input["y"] == 5 }
c276 if { input["f"] == true }
c277 if { c274; c275; c276 }
