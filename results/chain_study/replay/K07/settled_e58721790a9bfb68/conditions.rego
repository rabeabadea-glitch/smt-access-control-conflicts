package thesis

c0 if { true }
c1 if { input["x"] >= 4 }
c2 if { input["x"] <= 5 }
c3 if { input["y"] >= 0 }
c4 if { input["y"] <= 2 }
c5 if { c1; c2; c3; c4 }
rule_0 if { c5 }
c6 if { input["x"] >= 1 }
c7 if { input["x"] <= 1 }
c8 if { input["y"] >= 4 }
c9 if { input["y"] <= 4 }
c10 if { input["f"] == false }
c11 if { c6; c7; c8; c9; c10 }
rule_1 if { c11 }
c12 if { input["x"] >= 4 }
c13 if { input["x"] <= 4 }
c14 if { input["y"] >= 2 }
c15 if { input["y"] <= 5 }
c16 if { c12; c13; c14; c15 }
rule_2 if { c16 }
c17 if { input["x"] >= 0 }
c18 if { input["x"] <= 2 }
c19 if { input["y"] >= 2 }
c20 if { input["y"] <= 5 }
c21 if { input["f"] == false }
c22 if { c17; c18; c19; c20; c21 }
c23 if { input["x"] >= 0 }
c24 if { input["x"] <= 1 }
c25 if { input["y"] >= 0 }
c26 if { input["y"] <= 2 }
c27 if { input["f"] == false }
c28 if { c23; c24; c25; c26; c27 }
c29 if { not c28 }
c30 if { c22; c29 }
c31 if { input["x"] >= 1 }
c32 if { input["x"] <= 3 }
c33 if { input["y"] >= 2 }
c34 if { input["y"] <= 4 }
c35 if { input["f"] == false }
c36 if { c31; c32; c33; c34; c35 }
c37 if { input["x"] >= 1 }
c38 if { input["x"] <= 1 }
c39 if { input["y"] >= 4 }
c40 if { input["y"] <= 4 }
c41 if { input["f"] == false }
c42 if { c37; c38; c39; c40; c41 }
c43 if { not c42 }
c44 if { c36; c43 }
c45 if { not c44 }
c46 if { c30; c45 }
rule_3 if { c46 }
c47 if { input["x"] >= 1 }
c48 if { input["x"] <= 3 }
c49 if { input["y"] >= 2 }
c50 if { input["y"] <= 4 }
c51 if { input["f"] == false }
c52 if { c47; c48; c49; c50; c51 }
c53 if { input["x"] >= 1 }
c54 if { input["x"] <= 1 }
c55 if { input["y"] >= 4 }
c56 if { input["y"] <= 4 }
c57 if { input["f"] == false }
c58 if { c53; c54; c55; c56; c57 }
c59 if { not c58 }
c60 if { c52; c59 }
rule_4 if { c60 }
c61 if { input["x"] >= 0 }
c62 if { input["x"] <= 1 }
c63 if { input["y"] >= 0 }
c64 if { input["y"] <= 2 }
c65 if { input["f"] == false }
c66 if { c61; c62; c63; c64; c65 }
rule_5 if { c66 }
c67 if { input["x"] == 0 }
c68 if { input["y"] == 0 }
c69 if { input["f"] == false }
c70 if { c67; c68; c69 }
c71 if { input["x"] == 0 }
c72 if { input["y"] == 1 }
c73 if { input["f"] == false }
c74 if { c71; c72; c73 }
c75 if { input["x"] == 0 }
c76 if { input["y"] == 2 }
c77 if { input["f"] == false }
c78 if { c75; c76; c77 }
c79 if { input["x"] == 0 }
c80 if { input["y"] == 3 }
c81 if { input["f"] == false }
c82 if { c79; c80; c81 }
c83 if { input["x"] == 0 }
c84 if { input["y"] == 4 }
c85 if { input["f"] == false }
c86 if { c83; c84; c85 }
c87 if { input["x"] == 0 }
c88 if { input["y"] == 5 }
c89 if { input["f"] == false }
c90 if { c87; c88; c89 }
c91 if { input["x"] == 1 }
c92 if { input["y"] == 0 }
c93 if { input["f"] == false }
c94 if { c91; c92; c93 }
c95 if { input["x"] == 1 }
c96 if { input["y"] == 1 }
c97 if { input["f"] == false }
c98 if { c95; c96; c97 }
c99 if { input["x"] == 1 }
c100 if { input["y"] == 2 }
c101 if { input["f"] == false }
c102 if { c99; c100; c101 }
c103 if { input["x"] == 1 }
c104 if { input["y"] == 3 }
c105 if { input["f"] == false }
c106 if { c103; c104; c105 }
c107 if { input["x"] == 1 }
c108 if { input["y"] == 4 }
c109 if { input["f"] == false }
c110 if { c107; c108; c109 }
c111 if { input["x"] == 1 }
c112 if { input["y"] == 5 }
c113 if { input["f"] == false }
c114 if { c111; c112; c113 }
c115 if { input["x"] == 2 }
c116 if { input["y"] == 2 }
c117 if { input["f"] == false }
c118 if { c115; c116; c117 }
c119 if { input["x"] == 2 }
c120 if { input["y"] == 3 }
c121 if { input["f"] == false }
c122 if { c119; c120; c121 }
c123 if { input["x"] == 2 }
c124 if { input["y"] == 4 }
c125 if { input["f"] == false }
c126 if { c123; c124; c125 }
c127 if { input["x"] == 2 }
c128 if { input["y"] == 5 }
c129 if { input["f"] == false }
c130 if { c127; c128; c129 }
c131 if { input["x"] == 3 }
c132 if { input["y"] == 2 }
c133 if { input["f"] == false }
c134 if { c131; c132; c133 }
c135 if { input["x"] == 3 }
c136 if { input["y"] == 3 }
c137 if { input["f"] == false }
c138 if { c135; c136; c137 }
c139 if { input["x"] == 3 }
c140 if { input["y"] == 4 }
c141 if { input["f"] == false }
c142 if { c139; c140; c141 }
c143 if { input["x"] == 4 }
c144 if { input["y"] == 0 }
c145 if { input["f"] == false }
c146 if { c143; c144; c145 }
c147 if { input["x"] == 4 }
c148 if { input["y"] == 0 }
c149 if { input["f"] == true }
c150 if { c147; c148; c149 }
c151 if { input["x"] == 4 }
c152 if { input["y"] == 1 }
c153 if { input["f"] == false }
c154 if { c151; c152; c153 }
c155 if { input["x"] == 4 }
c156 if { input["y"] == 1 }
c157 if { input["f"] == true }
c158 if { c155; c156; c157 }
c159 if { input["x"] == 4 }
c160 if { input["y"] == 2 }
c161 if { input["f"] == false }
c162 if { c159; c160; c161 }
c163 if { input["x"] == 4 }
c164 if { input["y"] == 2 }
c165 if { input["f"] == true }
c166 if { c163; c164; c165 }
c167 if { input["x"] == 4 }
c168 if { input["y"] == 3 }
c169 if { input["f"] == false }
c170 if { c167; c168; c169 }
c171 if { input["x"] == 4 }
c172 if { input["y"] == 3 }
c173 if { input["f"] == true }
c174 if { c171; c172; c173 }
c175 if { input["x"] == 4 }
c176 if { input["y"] == 4 }
c177 if { input["f"] == false }
c178 if { c175; c176; c177 }
c179 if { input["x"] == 4 }
c180 if { input["y"] == 4 }
c181 if { input["f"] == true }
c182 if { c179; c180; c181 }
c183 if { input["x"] == 4 }
c184 if { input["y"] == 5 }
c185 if { input["f"] == false }
c186 if { c183; c184; c185 }
c187 if { input["x"] == 4 }
c188 if { input["y"] == 5 }
c189 if { input["f"] == true }
c190 if { c187; c188; c189 }
c191 if { input["x"] == 5 }
c192 if { input["y"] == 0 }
c193 if { input["f"] == false }
c194 if { c191; c192; c193 }
c195 if { input["x"] == 5 }
c196 if { input["y"] == 0 }
c197 if { input["f"] == true }
c198 if { c195; c196; c197 }
c199 if { input["x"] == 5 }
c200 if { input["y"] == 1 }
c201 if { input["f"] == false }
c202 if { c199; c200; c201 }
c203 if { input["x"] == 5 }
c204 if { input["y"] == 1 }
c205 if { input["f"] == true }
c206 if { c203; c204; c205 }
c207 if { input["x"] == 5 }
c208 if { input["y"] == 2 }
c209 if { input["f"] == false }
c210 if { c207; c208; c209 }
c211 if { input["x"] == 5 }
c212 if { input["y"] == 2 }
c213 if { input["f"] == true }
c214 if { c211; c212; c213 }
