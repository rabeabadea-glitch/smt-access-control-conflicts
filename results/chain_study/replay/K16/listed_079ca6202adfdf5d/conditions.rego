package thesis

c0 if { true }
c1 if { input["x"] >= 4 }
c2 if { input["x"] <= 5 }
c3 if { input["y"] >= 3 }
c4 if { input["y"] <= 3 }
c5 if { c1; c2; c3; c4 }
rule_0 if { c5 }
c6 if { input["x"] >= 0 }
c7 if { input["x"] <= 5 }
c8 if { input["y"] >= 1 }
c9 if { input["y"] <= 2 }
c10 if { input["f"] == true }
c11 if { c6; c7; c8; c9; c10 }
c12 if { input["x"] >= 2 }
c13 if { input["x"] <= 2 }
c14 if { input["y"] >= 1 }
c15 if { input["y"] <= 1 }
c16 if { c12; c13; c14; c15 }
c17 if { not c16 }
c18 if { c11; c17 }
c19 if { input["x"] >= 0 }
c20 if { input["x"] <= 2 }
c21 if { input["y"] >= 1 }
c22 if { input["y"] <= 5 }
c23 if { input["f"] == true }
c24 if { c19; c20; c21; c22; c23 }
c25 if { not c24 }
c26 if { c18; c25 }
rule_1 if { c26 }
c27 if { input["x"] >= 2 }
c28 if { input["x"] <= 5 }
c29 if { input["y"] >= 1 }
c30 if { input["y"] <= 2 }
c31 if { c27; c28; c29; c30 }
c32 if { input["x"] >= 2 }
c33 if { input["x"] <= 2 }
c34 if { input["y"] >= 1 }
c35 if { input["y"] <= 1 }
c36 if { c32; c33; c34; c35 }
c37 if { not c36 }
c38 if { c31; c37 }
rule_2 if { c38 }
c39 if { input["x"] >= 2 }
c40 if { input["x"] <= 2 }
c41 if { input["y"] >= 1 }
c42 if { input["y"] <= 1 }
c43 if { c39; c40; c41; c42 }
rule_3 if { c43 }
c44 if { input["x"] >= 0 }
c45 if { input["x"] <= 2 }
c46 if { input["y"] >= 1 }
c47 if { input["y"] <= 5 }
c48 if { input["f"] == true }
c49 if { c44; c45; c46; c47; c48 }
c50 if { input["x"] >= 2 }
c51 if { input["x"] <= 5 }
c52 if { input["y"] >= 1 }
c53 if { input["y"] <= 2 }
c54 if { c50; c51; c52; c53 }
c55 if { input["x"] >= 2 }
c56 if { input["x"] <= 2 }
c57 if { input["y"] >= 1 }
c58 if { input["y"] <= 1 }
c59 if { c55; c56; c57; c58 }
c60 if { not c59 }
c61 if { c54; c60 }
c62 if { not c61 }
c63 if { c49; c62 }
rule_4 if { c63 }
c64 if { input["x"] >= 1 }
c65 if { input["x"] <= 1 }
c66 if { input["y"] >= 2 }
c67 if { input["y"] <= 3 }
c68 if { c64; c65; c66; c67 }
rule_5 if { c68 }
c69 if { input["x"] >= 0 }
c70 if { input["x"] <= 4 }
c71 if { input["y"] >= 1 }
c72 if { input["y"] <= 1 }
c73 if { c69; c70; c71; c72 }
c74 if { input["x"] >= 2 }
c75 if { input["x"] <= 2 }
c76 if { input["y"] >= 1 }
c77 if { input["y"] <= 1 }
c78 if { c74; c75; c76; c77 }
c79 if { not c78 }
c80 if { c73; c79 }
c81 if { input["x"] >= 0 }
c82 if { input["x"] <= 2 }
c83 if { input["y"] >= 1 }
c84 if { input["y"] <= 5 }
c85 if { input["f"] == true }
c86 if { c81; c82; c83; c84; c85 }
c87 if { input["x"] >= 2 }
c88 if { input["x"] <= 5 }
c89 if { input["y"] >= 1 }
c90 if { input["y"] <= 2 }
c91 if { c87; c88; c89; c90 }
c92 if { input["x"] >= 2 }
c93 if { input["x"] <= 2 }
c94 if { input["y"] >= 1 }
c95 if { input["y"] <= 1 }
c96 if { c92; c93; c94; c95 }
c97 if { not c96 }
c98 if { c91; c97 }
c99 if { not c98 }
c100 if { c86; c99 }
c101 if { not c100 }
c102 if { c80; c101 }
rule_6 if { c102 }
c103 if { input["x"] == 0 }
c104 if { input["y"] == 1 }
c105 if { input["f"] == false }
c106 if { c103; c104; c105 }
c107 if { input["x"] == 0 }
c108 if { input["y"] == 1 }
c109 if { input["f"] == true }
c110 if { c107; c108; c109 }
c111 if { input["x"] == 0 }
c112 if { input["y"] == 2 }
c113 if { input["f"] == true }
c114 if { c111; c112; c113 }
c115 if { input["x"] == 0 }
c116 if { input["y"] == 3 }
c117 if { input["f"] == true }
c118 if { c115; c116; c117 }
c119 if { input["x"] == 0 }
c120 if { input["y"] == 4 }
c121 if { input["f"] == true }
c122 if { c119; c120; c121 }
c123 if { input["x"] == 0 }
c124 if { input["y"] == 5 }
c125 if { input["f"] == true }
c126 if { c123; c124; c125 }
c127 if { input["x"] == 1 }
c128 if { input["y"] == 1 }
c129 if { input["f"] == false }
c130 if { c127; c128; c129 }
c131 if { input["x"] == 1 }
c132 if { input["y"] == 1 }
c133 if { input["f"] == true }
c134 if { c131; c132; c133 }
c135 if { input["x"] == 1 }
c136 if { input["y"] == 2 }
c137 if { input["f"] == false }
c138 if { c135; c136; c137 }
c139 if { input["x"] == 1 }
c140 if { input["y"] == 2 }
c141 if { input["f"] == true }
c142 if { c139; c140; c141 }
c143 if { input["x"] == 1 }
c144 if { input["y"] == 3 }
c145 if { input["f"] == false }
c146 if { c143; c144; c145 }
c147 if { input["x"] == 1 }
c148 if { input["y"] == 3 }
c149 if { input["f"] == true }
c150 if { c147; c148; c149 }
c151 if { input["x"] == 1 }
c152 if { input["y"] == 4 }
c153 if { input["f"] == true }
c154 if { c151; c152; c153 }
c155 if { input["x"] == 1 }
c156 if { input["y"] == 5 }
c157 if { input["f"] == true }
c158 if { c155; c156; c157 }
c159 if { input["x"] == 2 }
c160 if { input["y"] == 1 }
c161 if { input["f"] == false }
c162 if { c159; c160; c161 }
c163 if { input["x"] == 2 }
c164 if { input["y"] == 1 }
c165 if { input["f"] == true }
c166 if { c163; c164; c165 }
c167 if { input["x"] == 2 }
c168 if { input["y"] == 2 }
c169 if { input["f"] == false }
c170 if { c167; c168; c169 }
c171 if { input["x"] == 2 }
c172 if { input["y"] == 2 }
c173 if { input["f"] == true }
c174 if { c171; c172; c173 }
c175 if { input["x"] == 2 }
c176 if { input["y"] == 3 }
c177 if { input["f"] == true }
c178 if { c175; c176; c177 }
c179 if { input["x"] == 2 }
c180 if { input["y"] == 4 }
c181 if { input["f"] == true }
c182 if { c179; c180; c181 }
c183 if { input["x"] == 2 }
c184 if { input["y"] == 5 }
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
c203 if { input["x"] == 4 }
c204 if { input["y"] == 1 }
c205 if { input["f"] == false }
c206 if { c203; c204; c205 }
c207 if { input["x"] == 4 }
c208 if { input["y"] == 1 }
c209 if { input["f"] == true }
c210 if { c207; c208; c209 }
c211 if { input["x"] == 4 }
c212 if { input["y"] == 2 }
c213 if { input["f"] == false }
c214 if { c211; c212; c213 }
c215 if { input["x"] == 4 }
c216 if { input["y"] == 2 }
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
c227 if { input["x"] == 5 }
c228 if { input["y"] == 1 }
c229 if { input["f"] == false }
c230 if { c227; c228; c229 }
c231 if { input["x"] == 5 }
c232 if { input["y"] == 1 }
c233 if { input["f"] == true }
c234 if { c231; c232; c233 }
c235 if { input["x"] == 5 }
c236 if { input["y"] == 2 }
c237 if { input["f"] == false }
c238 if { c235; c236; c237 }
c239 if { input["x"] == 5 }
c240 if { input["y"] == 2 }
c241 if { input["f"] == true }
c242 if { c239; c240; c241 }
c243 if { input["x"] == 5 }
c244 if { input["y"] == 3 }
c245 if { input["f"] == false }
c246 if { c243; c244; c245 }
c247 if { input["x"] == 5 }
c248 if { input["y"] == 3 }
c249 if { input["f"] == true }
c250 if { c247; c248; c249 }
