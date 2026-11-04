package thesis

c0 if { true }
c1 if { input["x"] >= 1 }
c2 if { input["x"] <= 1 }
c3 if { input["y"] >= 4 }
c4 if { input["y"] <= 4 }
c5 if { input["f"] == false }
c6 if { c1; c2; c3; c4; c5 }
rule_0 if { c6 }
c7 if { input["x"] >= 0 }
c8 if { input["x"] <= 1 }
c9 if { input["y"] >= 0 }
c10 if { input["y"] <= 2 }
c11 if { input["f"] == false }
c12 if { c7; c8; c9; c10; c11 }
rule_1 if { c12 }
c13 if { input["x"] >= 1 }
c14 if { input["x"] <= 3 }
c15 if { input["y"] >= 2 }
c16 if { input["y"] <= 4 }
c17 if { input["f"] == false }
c18 if { c13; c14; c15; c16; c17 }
c19 if { input["x"] >= 1 }
c20 if { input["x"] <= 1 }
c21 if { input["y"] >= 4 }
c22 if { input["y"] <= 4 }
c23 if { input["f"] == false }
c24 if { c19; c20; c21; c22; c23 }
c25 if { not c24 }
c26 if { c18; c25 }
rule_2 if { c26 }
c27 if { input["x"] >= 0 }
c28 if { input["x"] <= 2 }
c29 if { input["y"] >= 2 }
c30 if { input["y"] <= 5 }
c31 if { input["f"] == false }
c32 if { c27; c28; c29; c30; c31 }
c33 if { input["x"] >= 0 }
c34 if { input["x"] <= 1 }
c35 if { input["y"] >= 0 }
c36 if { input["y"] <= 2 }
c37 if { input["f"] == false }
c38 if { c33; c34; c35; c36; c37 }
c39 if { not c38 }
c40 if { c32; c39 }
c41 if { input["x"] >= 1 }
c42 if { input["x"] <= 3 }
c43 if { input["y"] >= 2 }
c44 if { input["y"] <= 4 }
c45 if { input["f"] == false }
c46 if { c41; c42; c43; c44; c45 }
c47 if { input["x"] >= 1 }
c48 if { input["x"] <= 1 }
c49 if { input["y"] >= 4 }
c50 if { input["y"] <= 4 }
c51 if { input["f"] == false }
c52 if { c47; c48; c49; c50; c51 }
c53 if { not c52 }
c54 if { c46; c53 }
c55 if { not c54 }
c56 if { c40; c55 }
rule_3 if { c56 }
c57 if { input["x"] >= 4 }
c58 if { input["x"] <= 5 }
c59 if { input["y"] >= 0 }
c60 if { input["y"] <= 2 }
c61 if { c57; c58; c59; c60 }
rule_4 if { c61 }
c62 if { input["x"] >= 4 }
c63 if { input["x"] <= 4 }
c64 if { input["y"] >= 2 }
c65 if { input["y"] <= 5 }
c66 if { c62; c63; c64; c65 }
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
