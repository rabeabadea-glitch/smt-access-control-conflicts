package thesis

c0 if { true }
c1 if { input["x"] >= 2 }
c2 if { input["x"] <= 3 }
c3 if { input["y"] >= 5 }
c4 if { input["y"] <= 5 }
c5 if { c1; c2; c3; c4 }
rule_0 if { c5 }
c6 if { input["x"] >= 3 }
c7 if { input["x"] <= 5 }
c8 if { input["y"] >= 0 }
c9 if { input["y"] <= 5 }
c10 if { input["f"] == true }
c11 if { c6; c7; c8; c9; c10 }
c12 if { input["x"] >= 0 }
c13 if { input["x"] <= 3 }
c14 if { input["y"] >= 0 }
c15 if { input["y"] <= 2 }
c16 if { c12; c13; c14; c15 }
c17 if { not c16 }
c18 if { c11; c17 }
rule_1 if { c18 }
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
c31 if { input["x"] >= 2 }
c32 if { input["x"] <= 3 }
c33 if { input["y"] >= 2 }
c34 if { input["y"] <= 3 }
c35 if { c31; c32; c33; c34 }
c36 if { not c35 }
c37 if { c30; c36 }
rule_2 if { c37 }
c38 if { input["x"] >= 1 }
c39 if { input["x"] <= 2 }
c40 if { input["y"] >= 1 }
c41 if { input["y"] <= 4 }
c42 if { c38; c39; c40; c41 }
c43 if { input["x"] >= 1 }
c44 if { input["x"] <= 2 }
c45 if { input["y"] >= 3 }
c46 if { input["y"] <= 4 }
c47 if { c43; c44; c45; c46 }
c48 if { not c47 }
c49 if { c42; c48 }
rule_3 if { c49 }
c50 if { input["x"] >= 1 }
c51 if { input["x"] <= 2 }
c52 if { input["y"] >= 3 }
c53 if { input["y"] <= 4 }
c54 if { c50; c51; c52; c53 }
c55 if { input["x"] >= 2 }
c56 if { input["x"] <= 3 }
c57 if { input["y"] >= 2 }
c58 if { input["y"] <= 3 }
c59 if { c55; c56; c57; c58 }
c60 if { not c59 }
c61 if { c54; c60 }
rule_4 if { c61 }
c62 if { input["x"] >= 2 }
c63 if { input["x"] <= 3 }
c64 if { input["y"] >= 2 }
c65 if { input["y"] <= 3 }
c66 if { c62; c63; c64; c65 }
rule_5 if { c66 }
c67 if { input["x"] == 0 }
c68 if { input["y"] == 0 }
c69 if { input["f"] == false }
c70 if { c67; c68; c69 }
c71 if { input["x"] == 0 }
c72 if { input["y"] == 0 }
c73 if { input["f"] == true }
c74 if { c71; c72; c73 }
c75 if { input["x"] == 0 }
c76 if { input["y"] == 1 }
c77 if { input["f"] == false }
c78 if { c75; c76; c77 }
c79 if { input["x"] == 0 }
c80 if { input["y"] == 1 }
c81 if { input["f"] == true }
c82 if { c79; c80; c81 }
c83 if { input["x"] == 0 }
c84 if { input["y"] == 2 }
c85 if { input["f"] == false }
c86 if { c83; c84; c85 }
c87 if { input["x"] == 0 }
c88 if { input["y"] == 2 }
c89 if { input["f"] == true }
c90 if { c87; c88; c89 }
c91 if { input["x"] == 1 }
c92 if { input["y"] == 0 }
c93 if { input["f"] == false }
c94 if { c91; c92; c93 }
c95 if { input["x"] == 1 }
c96 if { input["y"] == 0 }
c97 if { input["f"] == true }
c98 if { c95; c96; c97 }
c99 if { input["x"] == 1 }
c100 if { input["y"] == 1 }
c101 if { input["f"] == false }
c102 if { c99; c100; c101 }
c103 if { input["x"] == 1 }
c104 if { input["y"] == 1 }
c105 if { input["f"] == true }
c106 if { c103; c104; c105 }
c107 if { input["x"] == 1 }
c108 if { input["y"] == 2 }
c109 if { input["f"] == false }
c110 if { c107; c108; c109 }
c111 if { input["x"] == 1 }
c112 if { input["y"] == 2 }
c113 if { input["f"] == true }
c114 if { c111; c112; c113 }
c115 if { input["x"] == 1 }
c116 if { input["y"] == 3 }
c117 if { input["f"] == false }
c118 if { c115; c116; c117 }
c119 if { input["x"] == 1 }
c120 if { input["y"] == 3 }
c121 if { input["f"] == true }
c122 if { c119; c120; c121 }
c123 if { input["x"] == 1 }
c124 if { input["y"] == 4 }
c125 if { input["f"] == false }
c126 if { c123; c124; c125 }
c127 if { input["x"] == 1 }
c128 if { input["y"] == 4 }
c129 if { input["f"] == true }
c130 if { c127; c128; c129 }
c131 if { input["x"] == 2 }
c132 if { input["y"] == 0 }
c133 if { input["f"] == false }
c134 if { c131; c132; c133 }
c135 if { input["x"] == 2 }
c136 if { input["y"] == 0 }
c137 if { input["f"] == true }
c138 if { c135; c136; c137 }
c139 if { input["x"] == 2 }
c140 if { input["y"] == 1 }
c141 if { input["f"] == false }
c142 if { c139; c140; c141 }
c143 if { input["x"] == 2 }
c144 if { input["y"] == 1 }
c145 if { input["f"] == true }
c146 if { c143; c144; c145 }
c147 if { input["x"] == 2 }
c148 if { input["y"] == 2 }
c149 if { input["f"] == false }
c150 if { c147; c148; c149 }
c151 if { input["x"] == 2 }
c152 if { input["y"] == 2 }
c153 if { input["f"] == true }
c154 if { c151; c152; c153 }
c155 if { input["x"] == 2 }
c156 if { input["y"] == 3 }
c157 if { input["f"] == false }
c158 if { c155; c156; c157 }
c159 if { input["x"] == 2 }
c160 if { input["y"] == 3 }
c161 if { input["f"] == true }
c162 if { c159; c160; c161 }
c163 if { input["x"] == 2 }
c164 if { input["y"] == 4 }
c165 if { input["f"] == false }
c166 if { c163; c164; c165 }
c167 if { input["x"] == 2 }
c168 if { input["y"] == 4 }
c169 if { input["f"] == true }
c170 if { c167; c168; c169 }
c171 if { input["x"] == 2 }
c172 if { input["y"] == 5 }
c173 if { input["f"] == false }
c174 if { c171; c172; c173 }
c175 if { input["x"] == 2 }
c176 if { input["y"] == 5 }
c177 if { input["f"] == true }
c178 if { c175; c176; c177 }
c179 if { input["x"] == 3 }
c180 if { input["y"] == 0 }
c181 if { input["f"] == false }
c182 if { c179; c180; c181 }
c183 if { input["x"] == 3 }
c184 if { input["y"] == 0 }
c185 if { input["f"] == true }
c186 if { c183; c184; c185 }
c187 if { input["x"] == 3 }
c188 if { input["y"] == 1 }
c189 if { input["f"] == false }
c190 if { c187; c188; c189 }
c191 if { input["x"] == 3 }
c192 if { input["y"] == 1 }
c193 if { input["f"] == true }
c194 if { c191; c192; c193 }
c195 if { input["x"] == 3 }
c196 if { input["y"] == 2 }
c197 if { input["f"] == false }
c198 if { c195; c196; c197 }
c199 if { input["x"] == 3 }
c200 if { input["y"] == 2 }
c201 if { input["f"] == true }
c202 if { c199; c200; c201 }
c203 if { input["x"] == 3 }
c204 if { input["y"] == 3 }
c205 if { input["f"] == false }
c206 if { c203; c204; c205 }
c207 if { input["x"] == 3 }
c208 if { input["y"] == 3 }
c209 if { input["f"] == true }
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
c225 if { input["f"] == true }
c226 if { c223; c224; c225 }
c227 if { input["x"] == 4 }
c228 if { input["y"] == 1 }
c229 if { input["f"] == true }
c230 if { c227; c228; c229 }
c231 if { input["x"] == 4 }
c232 if { input["y"] == 2 }
c233 if { input["f"] == true }
c234 if { c231; c232; c233 }
c235 if { input["x"] == 4 }
c236 if { input["y"] == 3 }
c237 if { input["f"] == true }
c238 if { c235; c236; c237 }
c239 if { input["x"] == 4 }
c240 if { input["y"] == 4 }
c241 if { input["f"] == true }
c242 if { c239; c240; c241 }
c243 if { input["x"] == 4 }
c244 if { input["y"] == 5 }
c245 if { input["f"] == true }
c246 if { c243; c244; c245 }
c247 if { input["x"] == 5 }
c248 if { input["y"] == 0 }
c249 if { input["f"] == true }
c250 if { c247; c248; c249 }
c251 if { input["x"] == 5 }
c252 if { input["y"] == 1 }
c253 if { input["f"] == true }
c254 if { c251; c252; c253 }
c255 if { input["x"] == 5 }
c256 if { input["y"] == 2 }
c257 if { input["f"] == true }
c258 if { c255; c256; c257 }
c259 if { input["x"] == 5 }
c260 if { input["y"] == 3 }
c261 if { input["f"] == true }
c262 if { c259; c260; c261 }
c263 if { input["x"] == 5 }
c264 if { input["y"] == 4 }
c265 if { input["f"] == true }
c266 if { c263; c264; c265 }
c267 if { input["x"] == 5 }
c268 if { input["y"] == 5 }
c269 if { input["f"] == true }
c270 if { c267; c268; c269 }
