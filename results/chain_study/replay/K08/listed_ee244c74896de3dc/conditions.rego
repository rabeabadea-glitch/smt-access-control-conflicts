package thesis

c0 if { true }
c1 if { input["x"] >= 2 }
c2 if { input["x"] <= 5 }
c3 if { input["y"] >= 1 }
c4 if { input["y"] <= 2 }
c5 if { c1; c2; c3; c4 }
c6 if { input["x"] >= 4 }
c7 if { input["x"] <= 5 }
c8 if { input["y"] >= 1 }
c9 if { input["y"] <= 5 }
c10 if { c6; c7; c8; c9 }
c11 if { not c10 }
c12 if { c5; c11 }
c13 if { input["x"] >= 2 }
c14 if { input["x"] <= 5 }
c15 if { input["y"] >= 1 }
c16 if { input["y"] <= 5 }
c17 if { input["f"] == true }
c18 if { c13; c14; c15; c16; c17 }
c19 if { not c18 }
c20 if { c12; c19 }
c21 if { input["x"] >= 1 }
c22 if { input["x"] <= 3 }
c23 if { input["y"] >= 2 }
c24 if { input["y"] <= 3 }
c25 if { input["f"] == false }
c26 if { c21; c22; c23; c24; c25 }
c27 if { not c26 }
c28 if { c20; c27 }
rule_0 if { c28 }
c29 if { input["x"] >= 4 }
c30 if { input["x"] <= 5 }
c31 if { input["y"] >= 1 }
c32 if { input["y"] <= 5 }
c33 if { c29; c30; c31; c32 }
rule_1 if { c33 }
c34 if { input["x"] >= 2 }
c35 if { input["x"] <= 5 }
c36 if { input["y"] >= 1 }
c37 if { input["y"] <= 5 }
c38 if { input["f"] == true }
c39 if { c34; c35; c36; c37; c38 }
rule_2 if { c39 }
c40 if { input["x"] >= 1 }
c41 if { input["x"] <= 3 }
c42 if { input["y"] >= 2 }
c43 if { input["y"] <= 3 }
c44 if { input["f"] == false }
c45 if { c40; c41; c42; c43; c44 }
rule_3 if { c45 }
c46 if { input["x"] >= 0 }
c47 if { input["x"] <= 0 }
c48 if { input["y"] >= 1 }
c49 if { input["y"] <= 1 }
c50 if { input["f"] == false }
c51 if { c46; c47; c48; c49; c50 }
rule_4 if { c51 }
c52 if { input["x"] >= 3 }
c53 if { input["x"] <= 5 }
c54 if { input["y"] >= 1 }
c55 if { input["y"] <= 5 }
c56 if { input["f"] == true }
c57 if { c52; c53; c54; c55; c56 }
rule_5 if { c57 }
c58 if { input["x"] >= 4 }
c59 if { input["x"] <= 4 }
c60 if { input["y"] >= 2 }
c61 if { input["y"] <= 5 }
c62 if { c58; c59; c60; c61 }
rule_6 if { c62 }
c63 if { input["x"] == 0 }
c64 if { input["y"] == 1 }
c65 if { input["f"] == false }
c66 if { c63; c64; c65 }
c67 if { input["x"] == 1 }
c68 if { input["y"] == 2 }
c69 if { input["f"] == false }
c70 if { c67; c68; c69 }
c71 if { input["x"] == 1 }
c72 if { input["y"] == 3 }
c73 if { input["f"] == false }
c74 if { c71; c72; c73 }
c75 if { input["x"] == 2 }
c76 if { input["y"] == 1 }
c77 if { input["f"] == false }
c78 if { c75; c76; c77 }
c79 if { input["x"] == 2 }
c80 if { input["y"] == 1 }
c81 if { input["f"] == true }
c82 if { c79; c80; c81 }
c83 if { input["x"] == 2 }
c84 if { input["y"] == 2 }
c85 if { input["f"] == false }
c86 if { c83; c84; c85 }
c87 if { input["x"] == 2 }
c88 if { input["y"] == 2 }
c89 if { input["f"] == true }
c90 if { c87; c88; c89 }
c91 if { input["x"] == 2 }
c92 if { input["y"] == 3 }
c93 if { input["f"] == false }
c94 if { c91; c92; c93 }
c95 if { input["x"] == 2 }
c96 if { input["y"] == 3 }
c97 if { input["f"] == true }
c98 if { c95; c96; c97 }
c99 if { input["x"] == 2 }
c100 if { input["y"] == 4 }
c101 if { input["f"] == true }
c102 if { c99; c100; c101 }
c103 if { input["x"] == 2 }
c104 if { input["y"] == 5 }
c105 if { input["f"] == true }
c106 if { c103; c104; c105 }
c107 if { input["x"] == 3 }
c108 if { input["y"] == 1 }
c109 if { input["f"] == false }
c110 if { c107; c108; c109 }
c111 if { input["x"] == 3 }
c112 if { input["y"] == 1 }
c113 if { input["f"] == true }
c114 if { c111; c112; c113 }
c115 if { input["x"] == 3 }
c116 if { input["y"] == 2 }
c117 if { input["f"] == false }
c118 if { c115; c116; c117 }
c119 if { input["x"] == 3 }
c120 if { input["y"] == 2 }
c121 if { input["f"] == true }
c122 if { c119; c120; c121 }
c123 if { input["x"] == 3 }
c124 if { input["y"] == 3 }
c125 if { input["f"] == false }
c126 if { c123; c124; c125 }
c127 if { input["x"] == 3 }
c128 if { input["y"] == 3 }
c129 if { input["f"] == true }
c130 if { c127; c128; c129 }
c131 if { input["x"] == 3 }
c132 if { input["y"] == 4 }
c133 if { input["f"] == true }
c134 if { c131; c132; c133 }
c135 if { input["x"] == 3 }
c136 if { input["y"] == 5 }
c137 if { input["f"] == true }
c138 if { c135; c136; c137 }
c139 if { input["x"] == 4 }
c140 if { input["y"] == 1 }
c141 if { input["f"] == false }
c142 if { c139; c140; c141 }
c143 if { input["x"] == 4 }
c144 if { input["y"] == 1 }
c145 if { input["f"] == true }
c146 if { c143; c144; c145 }
c147 if { input["x"] == 4 }
c148 if { input["y"] == 2 }
c149 if { input["f"] == false }
c150 if { c147; c148; c149 }
c151 if { input["x"] == 4 }
c152 if { input["y"] == 2 }
c153 if { input["f"] == true }
c154 if { c151; c152; c153 }
c155 if { input["x"] == 4 }
c156 if { input["y"] == 3 }
c157 if { input["f"] == false }
c158 if { c155; c156; c157 }
c159 if { input["x"] == 4 }
c160 if { input["y"] == 3 }
c161 if { input["f"] == true }
c162 if { c159; c160; c161 }
c163 if { input["x"] == 4 }
c164 if { input["y"] == 4 }
c165 if { input["f"] == false }
c166 if { c163; c164; c165 }
c167 if { input["x"] == 4 }
c168 if { input["y"] == 4 }
c169 if { input["f"] == true }
c170 if { c167; c168; c169 }
c171 if { input["x"] == 4 }
c172 if { input["y"] == 5 }
c173 if { input["f"] == false }
c174 if { c171; c172; c173 }
c175 if { input["x"] == 4 }
c176 if { input["y"] == 5 }
c177 if { input["f"] == true }
c178 if { c175; c176; c177 }
c179 if { input["x"] == 5 }
c180 if { input["y"] == 1 }
c181 if { input["f"] == false }
c182 if { c179; c180; c181 }
c183 if { input["x"] == 5 }
c184 if { input["y"] == 1 }
c185 if { input["f"] == true }
c186 if { c183; c184; c185 }
c187 if { input["x"] == 5 }
c188 if { input["y"] == 2 }
c189 if { input["f"] == false }
c190 if { c187; c188; c189 }
c191 if { input["x"] == 5 }
c192 if { input["y"] == 2 }
c193 if { input["f"] == true }
c194 if { c191; c192; c193 }
c195 if { input["x"] == 5 }
c196 if { input["y"] == 3 }
c197 if { input["f"] == false }
c198 if { c195; c196; c197 }
c199 if { input["x"] == 5 }
c200 if { input["y"] == 3 }
c201 if { input["f"] == true }
c202 if { c199; c200; c201 }
c203 if { input["x"] == 5 }
c204 if { input["y"] == 4 }
c205 if { input["f"] == false }
c206 if { c203; c204; c205 }
c207 if { input["x"] == 5 }
c208 if { input["y"] == 4 }
c209 if { input["f"] == true }
c210 if { c207; c208; c209 }
c211 if { input["x"] == 5 }
c212 if { input["y"] == 5 }
c213 if { input["f"] == false }
c214 if { c211; c212; c213 }
c215 if { input["x"] == 5 }
c216 if { input["y"] == 5 }
c217 if { input["f"] == true }
c218 if { c215; c216; c217 }
