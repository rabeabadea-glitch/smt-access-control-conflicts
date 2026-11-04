package thesis

c0 if { true }
c1 if { input["x"] >= 1 }
c2 if { input["x"] <= 1 }
c3 if { input["y"] >= 4 }
c4 if { input["y"] <= 5 }
c5 if { c1; c2; c3; c4 }
rule_0 if { c5 }
c6 if { input["x"] >= 3 }
c7 if { input["x"] <= 5 }
c8 if { input["y"] >= 3 }
c9 if { input["y"] <= 4 }
c10 if { c6; c7; c8; c9 }
rule_1 if { c10 }
c11 if { input["x"] >= 0 }
c12 if { input["x"] <= 2 }
c13 if { input["y"] >= 0 }
c14 if { input["y"] <= 1 }
c15 if { c11; c12; c13; c14 }
rule_2 if { c15 }
c16 if { input["x"] >= 1 }
c17 if { input["x"] <= 2 }
c18 if { input["y"] >= 0 }
c19 if { input["y"] <= 3 }
c20 if { c16; c17; c18; c19 }
c21 if { input["x"] >= 0 }
c22 if { input["x"] <= 2 }
c23 if { input["y"] >= 0 }
c24 if { input["y"] <= 1 }
c25 if { c21; c22; c23; c24 }
c26 if { not c25 }
c27 if { c20; c26 }
rule_3 if { c27 }
c28 if { input["x"] >= 1 }
c29 if { input["x"] <= 3 }
c30 if { input["y"] >= 5 }
c31 if { input["y"] <= 5 }
c32 if { c28; c29; c30; c31 }
rule_4 if { c32 }
c33 if { input["x"] >= 2 }
c34 if { input["x"] <= 2 }
c35 if { input["y"] >= 0 }
c36 if { input["y"] <= 4 }
c37 if { c33; c34; c35; c36 }
c38 if { input["x"] >= 1 }
c39 if { input["x"] <= 2 }
c40 if { input["y"] >= 0 }
c41 if { input["y"] <= 3 }
c42 if { c38; c39; c40; c41 }
c43 if { input["x"] >= 0 }
c44 if { input["x"] <= 2 }
c45 if { input["y"] >= 0 }
c46 if { input["y"] <= 1 }
c47 if { c43; c44; c45; c46 }
c48 if { not c47 }
c49 if { c42; c48 }
c50 if { not c49 }
c51 if { c37; c50 }
c52 if { input["x"] >= 2 }
c53 if { input["x"] <= 2 }
c54 if { input["y"] >= 3 }
c55 if { input["y"] <= 5 }
c56 if { c52; c53; c54; c55 }
c57 if { input["x"] >= 1 }
c58 if { input["x"] <= 3 }
c59 if { input["y"] >= 5 }
c60 if { input["y"] <= 5 }
c61 if { c57; c58; c59; c60 }
c62 if { not c61 }
c63 if { c56; c62 }
c64 if { not c63 }
c65 if { c51; c64 }
rule_5 if { c65 }
c66 if { input["x"] >= 5 }
c67 if { input["x"] <= 5 }
c68 if { input["y"] >= 0 }
c69 if { input["y"] <= 4 }
c70 if { c66; c67; c68; c69 }
rule_6 if { c70 }
c71 if { input["x"] >= 2 }
c72 if { input["x"] <= 2 }
c73 if { input["y"] >= 3 }
c74 if { input["y"] <= 5 }
c75 if { c71; c72; c73; c74 }
c76 if { input["x"] >= 1 }
c77 if { input["x"] <= 3 }
c78 if { input["y"] >= 5 }
c79 if { input["y"] <= 5 }
c80 if { c76; c77; c78; c79 }
c81 if { not c80 }
c82 if { c75; c81 }
rule_7 if { c82 }
c83 if { input["x"] == 0 }
c84 if { input["y"] == 0 }
c85 if { input["f"] == false }
c86 if { c83; c84; c85 }
c87 if { input["x"] == 0 }
c88 if { input["y"] == 0 }
c89 if { input["f"] == true }
c90 if { c87; c88; c89 }
c91 if { input["x"] == 0 }
c92 if { input["y"] == 1 }
c93 if { input["f"] == false }
c94 if { c91; c92; c93 }
c95 if { input["x"] == 0 }
c96 if { input["y"] == 1 }
c97 if { input["f"] == true }
c98 if { c95; c96; c97 }
c99 if { input["x"] == 1 }
c100 if { input["y"] == 0 }
c101 if { input["f"] == false }
c102 if { c99; c100; c101 }
c103 if { input["x"] == 1 }
c104 if { input["y"] == 0 }
c105 if { input["f"] == true }
c106 if { c103; c104; c105 }
c107 if { input["x"] == 1 }
c108 if { input["y"] == 1 }
c109 if { input["f"] == false }
c110 if { c107; c108; c109 }
c111 if { input["x"] == 1 }
c112 if { input["y"] == 1 }
c113 if { input["f"] == true }
c114 if { c111; c112; c113 }
c115 if { input["x"] == 1 }
c116 if { input["y"] == 2 }
c117 if { input["f"] == false }
c118 if { c115; c116; c117 }
c119 if { input["x"] == 1 }
c120 if { input["y"] == 2 }
c121 if { input["f"] == true }
c122 if { c119; c120; c121 }
c123 if { input["x"] == 1 }
c124 if { input["y"] == 3 }
c125 if { input["f"] == false }
c126 if { c123; c124; c125 }
c127 if { input["x"] == 1 }
c128 if { input["y"] == 3 }
c129 if { input["f"] == true }
c130 if { c127; c128; c129 }
c131 if { input["x"] == 1 }
c132 if { input["y"] == 4 }
c133 if { input["f"] == false }
c134 if { c131; c132; c133 }
c135 if { input["x"] == 1 }
c136 if { input["y"] == 4 }
c137 if { input["f"] == true }
c138 if { c135; c136; c137 }
c139 if { input["x"] == 1 }
c140 if { input["y"] == 5 }
c141 if { input["f"] == false }
c142 if { c139; c140; c141 }
c143 if { input["x"] == 1 }
c144 if { input["y"] == 5 }
c145 if { input["f"] == true }
c146 if { c143; c144; c145 }
c147 if { input["x"] == 2 }
c148 if { input["y"] == 0 }
c149 if { input["f"] == false }
c150 if { c147; c148; c149 }
c151 if { input["x"] == 2 }
c152 if { input["y"] == 0 }
c153 if { input["f"] == true }
c154 if { c151; c152; c153 }
c155 if { input["x"] == 2 }
c156 if { input["y"] == 1 }
c157 if { input["f"] == false }
c158 if { c155; c156; c157 }
c159 if { input["x"] == 2 }
c160 if { input["y"] == 1 }
c161 if { input["f"] == true }
c162 if { c159; c160; c161 }
c163 if { input["x"] == 2 }
c164 if { input["y"] == 2 }
c165 if { input["f"] == false }
c166 if { c163; c164; c165 }
c167 if { input["x"] == 2 }
c168 if { input["y"] == 2 }
c169 if { input["f"] == true }
c170 if { c167; c168; c169 }
c171 if { input["x"] == 2 }
c172 if { input["y"] == 3 }
c173 if { input["f"] == false }
c174 if { c171; c172; c173 }
c175 if { input["x"] == 2 }
c176 if { input["y"] == 3 }
c177 if { input["f"] == true }
c178 if { c175; c176; c177 }
c179 if { input["x"] == 2 }
c180 if { input["y"] == 4 }
c181 if { input["f"] == false }
c182 if { c179; c180; c181 }
c183 if { input["x"] == 2 }
c184 if { input["y"] == 4 }
c185 if { input["f"] == true }
c186 if { c183; c184; c185 }
c187 if { input["x"] == 2 }
c188 if { input["y"] == 5 }
c189 if { input["f"] == false }
c190 if { c187; c188; c189 }
c191 if { input["x"] == 2 }
c192 if { input["y"] == 5 }
c193 if { input["f"] == true }
c194 if { c191; c192; c193 }
c195 if { input["x"] == 3 }
c196 if { input["y"] == 3 }
c197 if { input["f"] == false }
c198 if { c195; c196; c197 }
c199 if { input["x"] == 3 }
c200 if { input["y"] == 3 }
c201 if { input["f"] == true }
c202 if { c199; c200; c201 }
c203 if { input["x"] == 3 }
c204 if { input["y"] == 4 }
c205 if { input["f"] == false }
c206 if { c203; c204; c205 }
c207 if { input["x"] == 3 }
c208 if { input["y"] == 4 }
c209 if { input["f"] == true }
c210 if { c207; c208; c209 }
c211 if { input["x"] == 3 }
c212 if { input["y"] == 5 }
c213 if { input["f"] == false }
c214 if { c211; c212; c213 }
c215 if { input["x"] == 3 }
c216 if { input["y"] == 5 }
c217 if { input["f"] == true }
c218 if { c215; c216; c217 }
c219 if { input["x"] == 4 }
c220 if { input["y"] == 3 }
c221 if { input["f"] == false }
c222 if { c219; c220; c221 }
c223 if { input["x"] == 4 }
c224 if { input["y"] == 3 }
c225 if { input["f"] == true }
c226 if { c223; c224; c225 }
c227 if { input["x"] == 4 }
c228 if { input["y"] == 4 }
c229 if { input["f"] == false }
c230 if { c227; c228; c229 }
c231 if { input["x"] == 4 }
c232 if { input["y"] == 4 }
c233 if { input["f"] == true }
c234 if { c231; c232; c233 }
c235 if { input["x"] == 5 }
c236 if { input["y"] == 0 }
c237 if { input["f"] == false }
c238 if { c235; c236; c237 }
c239 if { input["x"] == 5 }
c240 if { input["y"] == 0 }
c241 if { input["f"] == true }
c242 if { c239; c240; c241 }
c243 if { input["x"] == 5 }
c244 if { input["y"] == 1 }
c245 if { input["f"] == false }
c246 if { c243; c244; c245 }
c247 if { input["x"] == 5 }
c248 if { input["y"] == 1 }
c249 if { input["f"] == true }
c250 if { c247; c248; c249 }
c251 if { input["x"] == 5 }
c252 if { input["y"] == 2 }
c253 if { input["f"] == false }
c254 if { c251; c252; c253 }
c255 if { input["x"] == 5 }
c256 if { input["y"] == 2 }
c257 if { input["f"] == true }
c258 if { c255; c256; c257 }
c259 if { input["x"] == 5 }
c260 if { input["y"] == 3 }
c261 if { input["f"] == false }
c262 if { c259; c260; c261 }
c263 if { input["x"] == 5 }
c264 if { input["y"] == 3 }
c265 if { input["f"] == true }
c266 if { c263; c264; c265 }
c267 if { input["x"] == 5 }
c268 if { input["y"] == 4 }
c269 if { input["f"] == false }
c270 if { c267; c268; c269 }
c271 if { input["x"] == 5 }
c272 if { input["y"] == 4 }
c273 if { input["f"] == true }
c274 if { c271; c272; c273 }
