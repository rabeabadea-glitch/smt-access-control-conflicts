package thesis

c0 if { true }
c1 if { input["x"] >= 2 }
c2 if { input["x"] <= 2 }
c3 if { input["y"] >= 3 }
c4 if { input["y"] <= 5 }
c5 if { c1; c2; c3; c4 }
c6 if { input["x"] >= 1 }
c7 if { input["x"] <= 3 }
c8 if { input["y"] >= 5 }
c9 if { input["y"] <= 5 }
c10 if { c6; c7; c8; c9 }
c11 if { not c10 }
c12 if { c5; c11 }
rule_0 if { c12 }
c13 if { input["x"] >= 5 }
c14 if { input["x"] <= 5 }
c15 if { input["y"] >= 0 }
c16 if { input["y"] <= 4 }
c17 if { c13; c14; c15; c16 }
rule_1 if { c17 }
c18 if { input["x"] >= 0 }
c19 if { input["x"] <= 2 }
c20 if { input["y"] >= 0 }
c21 if { input["y"] <= 1 }
c22 if { c18; c19; c20; c21 }
rule_2 if { c22 }
c23 if { input["x"] >= 3 }
c24 if { input["x"] <= 5 }
c25 if { input["y"] >= 3 }
c26 if { input["y"] <= 4 }
c27 if { c23; c24; c25; c26 }
rule_3 if { c27 }
c28 if { input["x"] >= 2 }
c29 if { input["x"] <= 2 }
c30 if { input["y"] >= 0 }
c31 if { input["y"] <= 4 }
c32 if { c28; c29; c30; c31 }
c33 if { input["x"] >= 2 }
c34 if { input["x"] <= 2 }
c35 if { input["y"] >= 3 }
c36 if { input["y"] <= 5 }
c37 if { c33; c34; c35; c36 }
c38 if { not c37 }
c39 if { c32; c38 }
c40 if { input["x"] >= 1 }
c41 if { input["x"] <= 2 }
c42 if { input["y"] >= 0 }
c43 if { input["y"] <= 3 }
c44 if { c40; c41; c42; c43 }
c45 if { input["x"] >= 0 }
c46 if { input["x"] <= 2 }
c47 if { input["y"] >= 0 }
c48 if { input["y"] <= 1 }
c49 if { c45; c46; c47; c48 }
c50 if { not c49 }
c51 if { c44; c50 }
c52 if { not c51 }
c53 if { c39; c52 }
rule_4 if { c53 }
c54 if { input["x"] >= 1 }
c55 if { input["x"] <= 3 }
c56 if { input["y"] >= 5 }
c57 if { input["y"] <= 5 }
c58 if { c54; c55; c56; c57 }
rule_5 if { c58 }
c59 if { input["x"] >= 1 }
c60 if { input["x"] <= 1 }
c61 if { input["y"] >= 4 }
c62 if { input["y"] <= 5 }
c63 if { c59; c60; c61; c62 }
rule_6 if { c63 }
c64 if { input["x"] >= 1 }
c65 if { input["x"] <= 2 }
c66 if { input["y"] >= 0 }
c67 if { input["y"] <= 3 }
c68 if { c64; c65; c66; c67 }
c69 if { input["x"] >= 0 }
c70 if { input["x"] <= 2 }
c71 if { input["y"] >= 0 }
c72 if { input["y"] <= 1 }
c73 if { c69; c70; c71; c72 }
c74 if { not c73 }
c75 if { c68; c74 }
rule_7 if { c75 }
c76 if { input["x"] == 0 }
c77 if { input["y"] == 0 }
c78 if { input["f"] == false }
c79 if { c76; c77; c78 }
c80 if { input["x"] == 0 }
c81 if { input["y"] == 0 }
c82 if { input["f"] == true }
c83 if { c80; c81; c82 }
c84 if { input["x"] == 0 }
c85 if { input["y"] == 1 }
c86 if { input["f"] == false }
c87 if { c84; c85; c86 }
c88 if { input["x"] == 0 }
c89 if { input["y"] == 1 }
c90 if { input["f"] == true }
c91 if { c88; c89; c90 }
c92 if { input["x"] == 1 }
c93 if { input["y"] == 0 }
c94 if { input["f"] == false }
c95 if { c92; c93; c94 }
c96 if { input["x"] == 1 }
c97 if { input["y"] == 0 }
c98 if { input["f"] == true }
c99 if { c96; c97; c98 }
c100 if { input["x"] == 1 }
c101 if { input["y"] == 1 }
c102 if { input["f"] == false }
c103 if { c100; c101; c102 }
c104 if { input["x"] == 1 }
c105 if { input["y"] == 1 }
c106 if { input["f"] == true }
c107 if { c104; c105; c106 }
c108 if { input["x"] == 1 }
c109 if { input["y"] == 2 }
c110 if { input["f"] == false }
c111 if { c108; c109; c110 }
c112 if { input["x"] == 1 }
c113 if { input["y"] == 2 }
c114 if { input["f"] == true }
c115 if { c112; c113; c114 }
c116 if { input["x"] == 1 }
c117 if { input["y"] == 3 }
c118 if { input["f"] == false }
c119 if { c116; c117; c118 }
c120 if { input["x"] == 1 }
c121 if { input["y"] == 3 }
c122 if { input["f"] == true }
c123 if { c120; c121; c122 }
c124 if { input["x"] == 1 }
c125 if { input["y"] == 4 }
c126 if { input["f"] == false }
c127 if { c124; c125; c126 }
c128 if { input["x"] == 1 }
c129 if { input["y"] == 4 }
c130 if { input["f"] == true }
c131 if { c128; c129; c130 }
c132 if { input["x"] == 1 }
c133 if { input["y"] == 5 }
c134 if { input["f"] == false }
c135 if { c132; c133; c134 }
c136 if { input["x"] == 1 }
c137 if { input["y"] == 5 }
c138 if { input["f"] == true }
c139 if { c136; c137; c138 }
c140 if { input["x"] == 2 }
c141 if { input["y"] == 0 }
c142 if { input["f"] == false }
c143 if { c140; c141; c142 }
c144 if { input["x"] == 2 }
c145 if { input["y"] == 0 }
c146 if { input["f"] == true }
c147 if { c144; c145; c146 }
c148 if { input["x"] == 2 }
c149 if { input["y"] == 1 }
c150 if { input["f"] == false }
c151 if { c148; c149; c150 }
c152 if { input["x"] == 2 }
c153 if { input["y"] == 1 }
c154 if { input["f"] == true }
c155 if { c152; c153; c154 }
c156 if { input["x"] == 2 }
c157 if { input["y"] == 2 }
c158 if { input["f"] == false }
c159 if { c156; c157; c158 }
c160 if { input["x"] == 2 }
c161 if { input["y"] == 2 }
c162 if { input["f"] == true }
c163 if { c160; c161; c162 }
c164 if { input["x"] == 2 }
c165 if { input["y"] == 3 }
c166 if { input["f"] == false }
c167 if { c164; c165; c166 }
c168 if { input["x"] == 2 }
c169 if { input["y"] == 3 }
c170 if { input["f"] == true }
c171 if { c168; c169; c170 }
c172 if { input["x"] == 2 }
c173 if { input["y"] == 4 }
c174 if { input["f"] == false }
c175 if { c172; c173; c174 }
c176 if { input["x"] == 2 }
c177 if { input["y"] == 4 }
c178 if { input["f"] == true }
c179 if { c176; c177; c178 }
c180 if { input["x"] == 2 }
c181 if { input["y"] == 5 }
c182 if { input["f"] == false }
c183 if { c180; c181; c182 }
c184 if { input["x"] == 2 }
c185 if { input["y"] == 5 }
c186 if { input["f"] == true }
c187 if { c184; c185; c186 }
c188 if { input["x"] == 3 }
c189 if { input["y"] == 3 }
c190 if { input["f"] == false }
c191 if { c188; c189; c190 }
c192 if { input["x"] == 3 }
c193 if { input["y"] == 3 }
c194 if { input["f"] == true }
c195 if { c192; c193; c194 }
c196 if { input["x"] == 3 }
c197 if { input["y"] == 4 }
c198 if { input["f"] == false }
c199 if { c196; c197; c198 }
c200 if { input["x"] == 3 }
c201 if { input["y"] == 4 }
c202 if { input["f"] == true }
c203 if { c200; c201; c202 }
c204 if { input["x"] == 3 }
c205 if { input["y"] == 5 }
c206 if { input["f"] == false }
c207 if { c204; c205; c206 }
c208 if { input["x"] == 3 }
c209 if { input["y"] == 5 }
c210 if { input["f"] == true }
c211 if { c208; c209; c210 }
c212 if { input["x"] == 4 }
c213 if { input["y"] == 3 }
c214 if { input["f"] == false }
c215 if { c212; c213; c214 }
c216 if { input["x"] == 4 }
c217 if { input["y"] == 3 }
c218 if { input["f"] == true }
c219 if { c216; c217; c218 }
c220 if { input["x"] == 4 }
c221 if { input["y"] == 4 }
c222 if { input["f"] == false }
c223 if { c220; c221; c222 }
c224 if { input["x"] == 4 }
c225 if { input["y"] == 4 }
c226 if { input["f"] == true }
c227 if { c224; c225; c226 }
c228 if { input["x"] == 5 }
c229 if { input["y"] == 0 }
c230 if { input["f"] == false }
c231 if { c228; c229; c230 }
c232 if { input["x"] == 5 }
c233 if { input["y"] == 0 }
c234 if { input["f"] == true }
c235 if { c232; c233; c234 }
c236 if { input["x"] == 5 }
c237 if { input["y"] == 1 }
c238 if { input["f"] == false }
c239 if { c236; c237; c238 }
c240 if { input["x"] == 5 }
c241 if { input["y"] == 1 }
c242 if { input["f"] == true }
c243 if { c240; c241; c242 }
c244 if { input["x"] == 5 }
c245 if { input["y"] == 2 }
c246 if { input["f"] == false }
c247 if { c244; c245; c246 }
c248 if { input["x"] == 5 }
c249 if { input["y"] == 2 }
c250 if { input["f"] == true }
c251 if { c248; c249; c250 }
c252 if { input["x"] == 5 }
c253 if { input["y"] == 3 }
c254 if { input["f"] == false }
c255 if { c252; c253; c254 }
c256 if { input["x"] == 5 }
c257 if { input["y"] == 3 }
c258 if { input["f"] == true }
c259 if { c256; c257; c258 }
c260 if { input["x"] == 5 }
c261 if { input["y"] == 4 }
c262 if { input["f"] == false }
c263 if { c260; c261; c262 }
c264 if { input["x"] == 5 }
c265 if { input["y"] == 4 }
c266 if { input["f"] == true }
c267 if { c264; c265; c266 }
