package thesis

c0 if { true }
c1 if { input["x"] >= 1 }
c2 if { input["x"] <= 1 }
c3 if { input["y"] >= 2 }
c4 if { input["y"] <= 3 }
c5 if { c1; c2; c3; c4 }
rule_0 if { c5 }
c6 if { input["x"] >= 2 }
c7 if { input["x"] <= 2 }
c8 if { input["y"] >= 1 }
c9 if { input["y"] <= 1 }
c10 if { c6; c7; c8; c9 }
rule_1 if { c10 }
c11 if { input["x"] >= 0 }
c12 if { input["x"] <= 4 }
c13 if { input["y"] >= 1 }
c14 if { input["y"] <= 1 }
c15 if { c11; c12; c13; c14 }
c16 if { input["x"] >= 2 }
c17 if { input["x"] <= 2 }
c18 if { input["y"] >= 1 }
c19 if { input["y"] <= 1 }
c20 if { c16; c17; c18; c19 }
c21 if { not c20 }
c22 if { c15; c21 }
c23 if { input["x"] >= 0 }
c24 if { input["x"] <= 2 }
c25 if { input["y"] >= 1 }
c26 if { input["y"] <= 5 }
c27 if { input["f"] == true }
c28 if { c23; c24; c25; c26; c27 }
c29 if { not c28 }
c30 if { c22; c29 }
rule_2 if { c30 }
c31 if { input["x"] >= 2 }
c32 if { input["x"] <= 5 }
c33 if { input["y"] >= 1 }
c34 if { input["y"] <= 2 }
c35 if { c31; c32; c33; c34 }
c36 if { input["x"] >= 2 }
c37 if { input["x"] <= 2 }
c38 if { input["y"] >= 1 }
c39 if { input["y"] <= 1 }
c40 if { c36; c37; c38; c39 }
c41 if { not c40 }
c42 if { c35; c41 }
rule_3 if { c42 }
c43 if { input["x"] >= 0 }
c44 if { input["x"] <= 2 }
c45 if { input["y"] >= 1 }
c46 if { input["y"] <= 5 }
c47 if { input["f"] == true }
c48 if { c43; c44; c45; c46; c47 }
c49 if { input["x"] >= 2 }
c50 if { input["x"] <= 5 }
c51 if { input["y"] >= 1 }
c52 if { input["y"] <= 2 }
c53 if { c49; c50; c51; c52 }
c54 if { input["x"] >= 2 }
c55 if { input["x"] <= 2 }
c56 if { input["y"] >= 1 }
c57 if { input["y"] <= 1 }
c58 if { c54; c55; c56; c57 }
c59 if { not c58 }
c60 if { c53; c59 }
c61 if { not c60 }
c62 if { c48; c61 }
rule_4 if { c62 }
c63 if { input["x"] >= 0 }
c64 if { input["x"] <= 5 }
c65 if { input["y"] >= 1 }
c66 if { input["y"] <= 2 }
c67 if { input["f"] == true }
c68 if { c63; c64; c65; c66; c67 }
c69 if { input["x"] >= 1 }
c70 if { input["x"] <= 1 }
c71 if { input["y"] >= 2 }
c72 if { input["y"] <= 3 }
c73 if { c69; c70; c71; c72 }
c74 if { not c73 }
c75 if { c68; c74 }
c76 if { input["x"] >= 2 }
c77 if { input["x"] <= 2 }
c78 if { input["y"] >= 1 }
c79 if { input["y"] <= 1 }
c80 if { c76; c77; c78; c79 }
c81 if { not c80 }
c82 if { c75; c81 }
c83 if { input["x"] >= 0 }
c84 if { input["x"] <= 2 }
c85 if { input["y"] >= 1 }
c86 if { input["y"] <= 5 }
c87 if { input["f"] == true }
c88 if { c83; c84; c85; c86; c87 }
c89 if { input["x"] >= 2 }
c90 if { input["x"] <= 5 }
c91 if { input["y"] >= 1 }
c92 if { input["y"] <= 2 }
c93 if { c89; c90; c91; c92 }
c94 if { input["x"] >= 2 }
c95 if { input["x"] <= 2 }
c96 if { input["y"] >= 1 }
c97 if { input["y"] <= 1 }
c98 if { c94; c95; c96; c97 }
c99 if { not c98 }
c100 if { c93; c99 }
c101 if { not c100 }
c102 if { c88; c101 }
c103 if { not c102 }
c104 if { c82; c103 }
rule_5 if { c104 }
c105 if { input["x"] >= 4 }
c106 if { input["x"] <= 5 }
c107 if { input["y"] >= 3 }
c108 if { input["y"] <= 3 }
c109 if { c105; c106; c107; c108 }
rule_6 if { c109 }
c110 if { input["x"] == 0 }
c111 if { input["y"] == 1 }
c112 if { input["f"] == false }
c113 if { c110; c111; c112 }
c114 if { input["x"] == 0 }
c115 if { input["y"] == 1 }
c116 if { input["f"] == true }
c117 if { c114; c115; c116 }
c118 if { input["x"] == 0 }
c119 if { input["y"] == 2 }
c120 if { input["f"] == true }
c121 if { c118; c119; c120 }
c122 if { input["x"] == 0 }
c123 if { input["y"] == 3 }
c124 if { input["f"] == true }
c125 if { c122; c123; c124 }
c126 if { input["x"] == 0 }
c127 if { input["y"] == 4 }
c128 if { input["f"] == true }
c129 if { c126; c127; c128 }
c130 if { input["x"] == 0 }
c131 if { input["y"] == 5 }
c132 if { input["f"] == true }
c133 if { c130; c131; c132 }
c134 if { input["x"] == 1 }
c135 if { input["y"] == 1 }
c136 if { input["f"] == false }
c137 if { c134; c135; c136 }
c138 if { input["x"] == 1 }
c139 if { input["y"] == 1 }
c140 if { input["f"] == true }
c141 if { c138; c139; c140 }
c142 if { input["x"] == 1 }
c143 if { input["y"] == 2 }
c144 if { input["f"] == false }
c145 if { c142; c143; c144 }
c146 if { input["x"] == 1 }
c147 if { input["y"] == 2 }
c148 if { input["f"] == true }
c149 if { c146; c147; c148 }
c150 if { input["x"] == 1 }
c151 if { input["y"] == 3 }
c152 if { input["f"] == false }
c153 if { c150; c151; c152 }
c154 if { input["x"] == 1 }
c155 if { input["y"] == 3 }
c156 if { input["f"] == true }
c157 if { c154; c155; c156 }
c158 if { input["x"] == 1 }
c159 if { input["y"] == 4 }
c160 if { input["f"] == true }
c161 if { c158; c159; c160 }
c162 if { input["x"] == 1 }
c163 if { input["y"] == 5 }
c164 if { input["f"] == true }
c165 if { c162; c163; c164 }
c166 if { input["x"] == 2 }
c167 if { input["y"] == 1 }
c168 if { input["f"] == false }
c169 if { c166; c167; c168 }
c170 if { input["x"] == 2 }
c171 if { input["y"] == 1 }
c172 if { input["f"] == true }
c173 if { c170; c171; c172 }
c174 if { input["x"] == 2 }
c175 if { input["y"] == 2 }
c176 if { input["f"] == false }
c177 if { c174; c175; c176 }
c178 if { input["x"] == 2 }
c179 if { input["y"] == 2 }
c180 if { input["f"] == true }
c181 if { c178; c179; c180 }
c182 if { input["x"] == 2 }
c183 if { input["y"] == 3 }
c184 if { input["f"] == true }
c185 if { c182; c183; c184 }
c186 if { input["x"] == 2 }
c187 if { input["y"] == 4 }
c188 if { input["f"] == true }
c189 if { c186; c187; c188 }
c190 if { input["x"] == 2 }
c191 if { input["y"] == 5 }
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
c210 if { input["x"] == 4 }
c211 if { input["y"] == 1 }
c212 if { input["f"] == false }
c213 if { c210; c211; c212 }
c214 if { input["x"] == 4 }
c215 if { input["y"] == 1 }
c216 if { input["f"] == true }
c217 if { c214; c215; c216 }
c218 if { input["x"] == 4 }
c219 if { input["y"] == 2 }
c220 if { input["f"] == false }
c221 if { c218; c219; c220 }
c222 if { input["x"] == 4 }
c223 if { input["y"] == 2 }
c224 if { input["f"] == true }
c225 if { c222; c223; c224 }
c226 if { input["x"] == 4 }
c227 if { input["y"] == 3 }
c228 if { input["f"] == false }
c229 if { c226; c227; c228 }
c230 if { input["x"] == 4 }
c231 if { input["y"] == 3 }
c232 if { input["f"] == true }
c233 if { c230; c231; c232 }
c234 if { input["x"] == 5 }
c235 if { input["y"] == 1 }
c236 if { input["f"] == false }
c237 if { c234; c235; c236 }
c238 if { input["x"] == 5 }
c239 if { input["y"] == 1 }
c240 if { input["f"] == true }
c241 if { c238; c239; c240 }
c242 if { input["x"] == 5 }
c243 if { input["y"] == 2 }
c244 if { input["f"] == false }
c245 if { c242; c243; c244 }
c246 if { input["x"] == 5 }
c247 if { input["y"] == 2 }
c248 if { input["f"] == true }
c249 if { c246; c247; c248 }
c250 if { input["x"] == 5 }
c251 if { input["y"] == 3 }
c252 if { input["f"] == false }
c253 if { c250; c251; c252 }
c254 if { input["x"] == 5 }
c255 if { input["y"] == 3 }
c256 if { input["f"] == true }
c257 if { c254; c255; c256 }
