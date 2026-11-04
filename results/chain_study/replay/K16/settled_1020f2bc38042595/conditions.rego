package thesis

c0 if { true }
c1 if { input["x"] >= 0 }
c2 if { input["x"] <= 2 }
c3 if { input["y"] >= 1 }
c4 if { input["y"] <= 5 }
c5 if { input["f"] == true }
c6 if { c1; c2; c3; c4; c5 }
c7 if { input["x"] >= 2 }
c8 if { input["x"] <= 5 }
c9 if { input["y"] >= 1 }
c10 if { input["y"] <= 2 }
c11 if { c7; c8; c9; c10 }
c12 if { input["x"] >= 2 }
c13 if { input["x"] <= 2 }
c14 if { input["y"] >= 1 }
c15 if { input["y"] <= 1 }
c16 if { c12; c13; c14; c15 }
c17 if { not c16 }
c18 if { c11; c17 }
c19 if { not c18 }
c20 if { c6; c19 }
rule_0 if { c20 }
c21 if { input["x"] >= 0 }
c22 if { input["x"] <= 4 }
c23 if { input["y"] >= 1 }
c24 if { input["y"] <= 1 }
c25 if { c21; c22; c23; c24 }
c26 if { input["x"] >= 2 }
c27 if { input["x"] <= 2 }
c28 if { input["y"] >= 1 }
c29 if { input["y"] <= 1 }
c30 if { c26; c27; c28; c29 }
c31 if { not c30 }
c32 if { c25; c31 }
c33 if { input["x"] >= 0 }
c34 if { input["x"] <= 2 }
c35 if { input["y"] >= 1 }
c36 if { input["y"] <= 5 }
c37 if { input["f"] == true }
c38 if { c33; c34; c35; c36; c37 }
c39 if { input["x"] >= 2 }
c40 if { input["x"] <= 5 }
c41 if { input["y"] >= 1 }
c42 if { input["y"] <= 2 }
c43 if { c39; c40; c41; c42 }
c44 if { input["x"] >= 2 }
c45 if { input["x"] <= 2 }
c46 if { input["y"] >= 1 }
c47 if { input["y"] <= 1 }
c48 if { c44; c45; c46; c47 }
c49 if { not c48 }
c50 if { c43; c49 }
c51 if { not c50 }
c52 if { c38; c51 }
c53 if { not c52 }
c54 if { c32; c53 }
rule_1 if { c54 }
c55 if { input["x"] >= 4 }
c56 if { input["x"] <= 5 }
c57 if { input["y"] >= 3 }
c58 if { input["y"] <= 3 }
c59 if { c55; c56; c57; c58 }
rule_2 if { c59 }
c60 if { input["x"] >= 2 }
c61 if { input["x"] <= 2 }
c62 if { input["y"] >= 1 }
c63 if { input["y"] <= 1 }
c64 if { c60; c61; c62; c63 }
rule_3 if { c64 }
c65 if { input["x"] >= 2 }
c66 if { input["x"] <= 5 }
c67 if { input["y"] >= 1 }
c68 if { input["y"] <= 2 }
c69 if { c65; c66; c67; c68 }
c70 if { input["x"] >= 2 }
c71 if { input["x"] <= 2 }
c72 if { input["y"] >= 1 }
c73 if { input["y"] <= 1 }
c74 if { c70; c71; c72; c73 }
c75 if { not c74 }
c76 if { c69; c75 }
rule_4 if { c76 }
c77 if { input["x"] >= 0 }
c78 if { input["x"] <= 5 }
c79 if { input["y"] >= 1 }
c80 if { input["y"] <= 2 }
c81 if { input["f"] == true }
c82 if { c77; c78; c79; c80; c81 }
c83 if { input["x"] >= 1 }
c84 if { input["x"] <= 1 }
c85 if { input["y"] >= 2 }
c86 if { input["y"] <= 3 }
c87 if { c83; c84; c85; c86 }
c88 if { not c87 }
c89 if { c82; c88 }
c90 if { input["x"] >= 2 }
c91 if { input["x"] <= 2 }
c92 if { input["y"] >= 1 }
c93 if { input["y"] <= 1 }
c94 if { c90; c91; c92; c93 }
c95 if { not c94 }
c96 if { c89; c95 }
c97 if { input["x"] >= 0 }
c98 if { input["x"] <= 2 }
c99 if { input["y"] >= 1 }
c100 if { input["y"] <= 5 }
c101 if { input["f"] == true }
c102 if { c97; c98; c99; c100; c101 }
c103 if { input["x"] >= 2 }
c104 if { input["x"] <= 5 }
c105 if { input["y"] >= 1 }
c106 if { input["y"] <= 2 }
c107 if { c103; c104; c105; c106 }
c108 if { input["x"] >= 2 }
c109 if { input["x"] <= 2 }
c110 if { input["y"] >= 1 }
c111 if { input["y"] <= 1 }
c112 if { c108; c109; c110; c111 }
c113 if { not c112 }
c114 if { c107; c113 }
c115 if { not c114 }
c116 if { c102; c115 }
c117 if { not c116 }
c118 if { c96; c117 }
rule_5 if { c118 }
c119 if { input["x"] >= 1 }
c120 if { input["x"] <= 1 }
c121 if { input["y"] >= 2 }
c122 if { input["y"] <= 3 }
c123 if { c119; c120; c121; c122 }
rule_6 if { c123 }
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
c134 if { input["f"] == true }
c135 if { c132; c133; c134 }
c136 if { input["x"] == 0 }
c137 if { input["y"] == 3 }
c138 if { input["f"] == true }
c139 if { c136; c137; c138 }
c140 if { input["x"] == 0 }
c141 if { input["y"] == 4 }
c142 if { input["f"] == true }
c143 if { c140; c141; c142 }
c144 if { input["x"] == 0 }
c145 if { input["y"] == 5 }
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
c174 if { input["f"] == true }
c175 if { c172; c173; c174 }
c176 if { input["x"] == 1 }
c177 if { input["y"] == 5 }
c178 if { input["f"] == true }
c179 if { c176; c177; c178 }
c180 if { input["x"] == 2 }
c181 if { input["y"] == 1 }
c182 if { input["f"] == false }
c183 if { c180; c181; c182 }
c184 if { input["x"] == 2 }
c185 if { input["y"] == 1 }
c186 if { input["f"] == true }
c187 if { c184; c185; c186 }
c188 if { input["x"] == 2 }
c189 if { input["y"] == 2 }
c190 if { input["f"] == false }
c191 if { c188; c189; c190 }
c192 if { input["x"] == 2 }
c193 if { input["y"] == 2 }
c194 if { input["f"] == true }
c195 if { c192; c193; c194 }
c196 if { input["x"] == 2 }
c197 if { input["y"] == 3 }
c198 if { input["f"] == true }
c199 if { c196; c197; c198 }
c200 if { input["x"] == 2 }
c201 if { input["y"] == 4 }
c202 if { input["f"] == true }
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
c224 if { input["x"] == 4 }
c225 if { input["y"] == 1 }
c226 if { input["f"] == false }
c227 if { c224; c225; c226 }
c228 if { input["x"] == 4 }
c229 if { input["y"] == 1 }
c230 if { input["f"] == true }
c231 if { c228; c229; c230 }
c232 if { input["x"] == 4 }
c233 if { input["y"] == 2 }
c234 if { input["f"] == false }
c235 if { c232; c233; c234 }
c236 if { input["x"] == 4 }
c237 if { input["y"] == 2 }
c238 if { input["f"] == true }
c239 if { c236; c237; c238 }
c240 if { input["x"] == 4 }
c241 if { input["y"] == 3 }
c242 if { input["f"] == false }
c243 if { c240; c241; c242 }
c244 if { input["x"] == 4 }
c245 if { input["y"] == 3 }
c246 if { input["f"] == true }
c247 if { c244; c245; c246 }
c248 if { input["x"] == 5 }
c249 if { input["y"] == 1 }
c250 if { input["f"] == false }
c251 if { c248; c249; c250 }
c252 if { input["x"] == 5 }
c253 if { input["y"] == 1 }
c254 if { input["f"] == true }
c255 if { c252; c253; c254 }
c256 if { input["x"] == 5 }
c257 if { input["y"] == 2 }
c258 if { input["f"] == false }
c259 if { c256; c257; c258 }
c260 if { input["x"] == 5 }
c261 if { input["y"] == 2 }
c262 if { input["f"] == true }
c263 if { c260; c261; c262 }
c264 if { input["x"] == 5 }
c265 if { input["y"] == 3 }
c266 if { input["f"] == false }
c267 if { c264; c265; c266 }
c268 if { input["x"] == 5 }
c269 if { input["y"] == 3 }
c270 if { input["f"] == true }
c271 if { c268; c269; c270 }
