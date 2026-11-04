package thesis

c0 if { true }
c1 if { input["x"] >= 0 }
c2 if { input["x"] <= 0 }
c3 if { input["y"] >= 1 }
c4 if { input["y"] <= 1 }
c5 if { input["f"] == false }
c6 if { c1; c2; c3; c4; c5 }
rule_0 if { c6 }
c7 if { input["x"] >= 4 }
c8 if { input["x"] <= 5 }
c9 if { input["y"] >= 1 }
c10 if { input["y"] <= 5 }
c11 if { c7; c8; c9; c10 }
rule_1 if { c11 }
c12 if { input["x"] >= 1 }
c13 if { input["x"] <= 3 }
c14 if { input["y"] >= 2 }
c15 if { input["y"] <= 3 }
c16 if { input["f"] == false }
c17 if { c12; c13; c14; c15; c16 }
rule_2 if { c17 }
c18 if { input["x"] >= 3 }
c19 if { input["x"] <= 5 }
c20 if { input["y"] >= 1 }
c21 if { input["y"] <= 5 }
c22 if { input["f"] == true }
c23 if { c18; c19; c20; c21; c22 }
rule_3 if { c23 }
c24 if { input["x"] >= 2 }
c25 if { input["x"] <= 5 }
c26 if { input["y"] >= 1 }
c27 if { input["y"] <= 5 }
c28 if { input["f"] == true }
c29 if { c24; c25; c26; c27; c28 }
rule_4 if { c29 }
c30 if { input["x"] >= 2 }
c31 if { input["x"] <= 5 }
c32 if { input["y"] >= 1 }
c33 if { input["y"] <= 2 }
c34 if { c30; c31; c32; c33 }
c35 if { input["x"] >= 4 }
c36 if { input["x"] <= 5 }
c37 if { input["y"] >= 1 }
c38 if { input["y"] <= 5 }
c39 if { c35; c36; c37; c38 }
c40 if { not c39 }
c41 if { c34; c40 }
c42 if { input["x"] >= 1 }
c43 if { input["x"] <= 3 }
c44 if { input["y"] >= 2 }
c45 if { input["y"] <= 3 }
c46 if { input["f"] == false }
c47 if { c42; c43; c44; c45; c46 }
c48 if { not c47 }
c49 if { c41; c48 }
c50 if { input["x"] >= 3 }
c51 if { input["x"] <= 5 }
c52 if { input["y"] >= 1 }
c53 if { input["y"] <= 5 }
c54 if { input["f"] == true }
c55 if { c50; c51; c52; c53; c54 }
c56 if { not c55 }
c57 if { c49; c56 }
c58 if { input["x"] >= 2 }
c59 if { input["x"] <= 5 }
c60 if { input["y"] >= 1 }
c61 if { input["y"] <= 5 }
c62 if { input["f"] == true }
c63 if { c58; c59; c60; c61; c62 }
c64 if { not c63 }
c65 if { c57; c64 }
rule_5 if { c65 }
c66 if { input["x"] >= 4 }
c67 if { input["x"] <= 4 }
c68 if { input["y"] >= 2 }
c69 if { input["y"] <= 5 }
c70 if { c66; c67; c68; c69 }
rule_6 if { c70 }
c71 if { input["x"] == 0 }
c72 if { input["y"] == 1 }
c73 if { input["f"] == false }
c74 if { c71; c72; c73 }
c75 if { input["x"] == 1 }
c76 if { input["y"] == 2 }
c77 if { input["f"] == false }
c78 if { c75; c76; c77 }
c79 if { input["x"] == 1 }
c80 if { input["y"] == 3 }
c81 if { input["f"] == false }
c82 if { c79; c80; c81 }
c83 if { input["x"] == 2 }
c84 if { input["y"] == 1 }
c85 if { input["f"] == false }
c86 if { c83; c84; c85 }
c87 if { input["x"] == 2 }
c88 if { input["y"] == 1 }
c89 if { input["f"] == true }
c90 if { c87; c88; c89 }
c91 if { input["x"] == 2 }
c92 if { input["y"] == 2 }
c93 if { input["f"] == false }
c94 if { c91; c92; c93 }
c95 if { input["x"] == 2 }
c96 if { input["y"] == 2 }
c97 if { input["f"] == true }
c98 if { c95; c96; c97 }
c99 if { input["x"] == 2 }
c100 if { input["y"] == 3 }
c101 if { input["f"] == false }
c102 if { c99; c100; c101 }
c103 if { input["x"] == 2 }
c104 if { input["y"] == 3 }
c105 if { input["f"] == true }
c106 if { c103; c104; c105 }
c107 if { input["x"] == 2 }
c108 if { input["y"] == 4 }
c109 if { input["f"] == true }
c110 if { c107; c108; c109 }
c111 if { input["x"] == 2 }
c112 if { input["y"] == 5 }
c113 if { input["f"] == true }
c114 if { c111; c112; c113 }
c115 if { input["x"] == 3 }
c116 if { input["y"] == 1 }
c117 if { input["f"] == false }
c118 if { c115; c116; c117 }
c119 if { input["x"] == 3 }
c120 if { input["y"] == 1 }
c121 if { input["f"] == true }
c122 if { c119; c120; c121 }
c123 if { input["x"] == 3 }
c124 if { input["y"] == 2 }
c125 if { input["f"] == false }
c126 if { c123; c124; c125 }
c127 if { input["x"] == 3 }
c128 if { input["y"] == 2 }
c129 if { input["f"] == true }
c130 if { c127; c128; c129 }
c131 if { input["x"] == 3 }
c132 if { input["y"] == 3 }
c133 if { input["f"] == false }
c134 if { c131; c132; c133 }
c135 if { input["x"] == 3 }
c136 if { input["y"] == 3 }
c137 if { input["f"] == true }
c138 if { c135; c136; c137 }
c139 if { input["x"] == 3 }
c140 if { input["y"] == 4 }
c141 if { input["f"] == true }
c142 if { c139; c140; c141 }
c143 if { input["x"] == 3 }
c144 if { input["y"] == 5 }
c145 if { input["f"] == true }
c146 if { c143; c144; c145 }
c147 if { input["x"] == 4 }
c148 if { input["y"] == 1 }
c149 if { input["f"] == false }
c150 if { c147; c148; c149 }
c151 if { input["x"] == 4 }
c152 if { input["y"] == 1 }
c153 if { input["f"] == true }
c154 if { c151; c152; c153 }
c155 if { input["x"] == 4 }
c156 if { input["y"] == 2 }
c157 if { input["f"] == false }
c158 if { c155; c156; c157 }
c159 if { input["x"] == 4 }
c160 if { input["y"] == 2 }
c161 if { input["f"] == true }
c162 if { c159; c160; c161 }
c163 if { input["x"] == 4 }
c164 if { input["y"] == 3 }
c165 if { input["f"] == false }
c166 if { c163; c164; c165 }
c167 if { input["x"] == 4 }
c168 if { input["y"] == 3 }
c169 if { input["f"] == true }
c170 if { c167; c168; c169 }
c171 if { input["x"] == 4 }
c172 if { input["y"] == 4 }
c173 if { input["f"] == false }
c174 if { c171; c172; c173 }
c175 if { input["x"] == 4 }
c176 if { input["y"] == 4 }
c177 if { input["f"] == true }
c178 if { c175; c176; c177 }
c179 if { input["x"] == 4 }
c180 if { input["y"] == 5 }
c181 if { input["f"] == false }
c182 if { c179; c180; c181 }
c183 if { input["x"] == 4 }
c184 if { input["y"] == 5 }
c185 if { input["f"] == true }
c186 if { c183; c184; c185 }
c187 if { input["x"] == 5 }
c188 if { input["y"] == 1 }
c189 if { input["f"] == false }
c190 if { c187; c188; c189 }
c191 if { input["x"] == 5 }
c192 if { input["y"] == 1 }
c193 if { input["f"] == true }
c194 if { c191; c192; c193 }
c195 if { input["x"] == 5 }
c196 if { input["y"] == 2 }
c197 if { input["f"] == false }
c198 if { c195; c196; c197 }
c199 if { input["x"] == 5 }
c200 if { input["y"] == 2 }
c201 if { input["f"] == true }
c202 if { c199; c200; c201 }
c203 if { input["x"] == 5 }
c204 if { input["y"] == 3 }
c205 if { input["f"] == false }
c206 if { c203; c204; c205 }
c207 if { input["x"] == 5 }
c208 if { input["y"] == 3 }
c209 if { input["f"] == true }
c210 if { c207; c208; c209 }
c211 if { input["x"] == 5 }
c212 if { input["y"] == 4 }
c213 if { input["f"] == false }
c214 if { c211; c212; c213 }
c215 if { input["x"] == 5 }
c216 if { input["y"] == 4 }
c217 if { input["f"] == true }
c218 if { c215; c216; c217 }
c219 if { input["x"] == 5 }
c220 if { input["y"] == 5 }
c221 if { input["f"] == false }
c222 if { c219; c220; c221 }
c223 if { input["x"] == 5 }
c224 if { input["y"] == 5 }
c225 if { input["f"] == true }
c226 if { c223; c224; c225 }
