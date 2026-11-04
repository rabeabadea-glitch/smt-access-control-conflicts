package thesis

c0 if { true }
c1 if { input["x"] >= 0 }
c2 if { input["x"] <= 2 }
c3 if { input["y"] >= 1 }
c4 if { input["y"] <= 4 }
c5 if { c1; c2; c3; c4 }
c6 if { input["x"] >= 0 }
c7 if { input["x"] <= 1 }
c8 if { input["y"] >= 2 }
c9 if { input["y"] <= 5 }
c10 if { input["f"] == true }
c11 if { c6; c7; c8; c9; c10 }
c12 if { not c11 }
c13 if { c5; c12 }
rule_0 if { c13 }
c14 if { input["x"] >= 1 }
c15 if { input["x"] <= 5 }
c16 if { input["y"] >= 4 }
c17 if { input["y"] <= 4 }
c18 if { input["f"] == true }
c19 if { c14; c15; c16; c17; c18 }
c20 if { input["x"] >= 0 }
c21 if { input["x"] <= 2 }
c22 if { input["y"] >= 1 }
c23 if { input["y"] <= 4 }
c24 if { c20; c21; c22; c23 }
c25 if { not c24 }
c26 if { c19; c25 }
c27 if { input["x"] >= 3 }
c28 if { input["x"] <= 4 }
c29 if { input["y"] >= 2 }
c30 if { input["y"] <= 4 }
c31 if { c27; c28; c29; c30 }
c32 if { not c31 }
c33 if { c26; c32 }
rule_1 if { c33 }
c34 if { input["x"] >= 3 }
c35 if { input["x"] <= 4 }
c36 if { input["y"] >= 2 }
c37 if { input["y"] <= 4 }
c38 if { c34; c35; c36; c37 }
rule_2 if { c38 }
c39 if { input["x"] >= 0 }
c40 if { input["x"] <= 1 }
c41 if { input["y"] >= 2 }
c42 if { input["y"] <= 5 }
c43 if { input["f"] == true }
c44 if { c39; c40; c41; c42; c43 }
rule_3 if { c44 }
c45 if { input["x"] >= 0 }
c46 if { input["x"] <= 3 }
c47 if { input["y"] >= 1 }
c48 if { input["y"] <= 2 }
c49 if { c45; c46; c47; c48 }
c50 if { input["x"] >= 0 }
c51 if { input["x"] <= 1 }
c52 if { input["y"] >= 2 }
c53 if { input["y"] <= 5 }
c54 if { input["f"] == true }
c55 if { c50; c51; c52; c53; c54 }
c56 if { not c55 }
c57 if { c49; c56 }
rule_4 if { c57 }
c58 if { input["x"] == 0 }
c59 if { input["y"] == 1 }
c60 if { input["f"] == false }
c61 if { c58; c59; c60 }
c62 if { input["x"] == 0 }
c63 if { input["y"] == 1 }
c64 if { input["f"] == true }
c65 if { c62; c63; c64 }
c66 if { input["x"] == 0 }
c67 if { input["y"] == 2 }
c68 if { input["f"] == false }
c69 if { c66; c67; c68 }
c70 if { input["x"] == 0 }
c71 if { input["y"] == 2 }
c72 if { input["f"] == true }
c73 if { c70; c71; c72 }
c74 if { input["x"] == 0 }
c75 if { input["y"] == 3 }
c76 if { input["f"] == false }
c77 if { c74; c75; c76 }
c78 if { input["x"] == 0 }
c79 if { input["y"] == 3 }
c80 if { input["f"] == true }
c81 if { c78; c79; c80 }
c82 if { input["x"] == 0 }
c83 if { input["y"] == 4 }
c84 if { input["f"] == false }
c85 if { c82; c83; c84 }
c86 if { input["x"] == 0 }
c87 if { input["y"] == 4 }
c88 if { input["f"] == true }
c89 if { c86; c87; c88 }
c90 if { input["x"] == 0 }
c91 if { input["y"] == 5 }
c92 if { input["f"] == true }
c93 if { c90; c91; c92 }
c94 if { input["x"] == 1 }
c95 if { input["y"] == 1 }
c96 if { input["f"] == false }
c97 if { c94; c95; c96 }
c98 if { input["x"] == 1 }
c99 if { input["y"] == 1 }
c100 if { input["f"] == true }
c101 if { c98; c99; c100 }
c102 if { input["x"] == 1 }
c103 if { input["y"] == 2 }
c104 if { input["f"] == false }
c105 if { c102; c103; c104 }
c106 if { input["x"] == 1 }
c107 if { input["y"] == 2 }
c108 if { input["f"] == true }
c109 if { c106; c107; c108 }
c110 if { input["x"] == 1 }
c111 if { input["y"] == 3 }
c112 if { input["f"] == false }
c113 if { c110; c111; c112 }
c114 if { input["x"] == 1 }
c115 if { input["y"] == 3 }
c116 if { input["f"] == true }
c117 if { c114; c115; c116 }
c118 if { input["x"] == 1 }
c119 if { input["y"] == 4 }
c120 if { input["f"] == false }
c121 if { c118; c119; c120 }
c122 if { input["x"] == 1 }
c123 if { input["y"] == 4 }
c124 if { input["f"] == true }
c125 if { c122; c123; c124 }
c126 if { input["x"] == 1 }
c127 if { input["y"] == 5 }
c128 if { input["f"] == true }
c129 if { c126; c127; c128 }
c130 if { input["x"] == 2 }
c131 if { input["y"] == 1 }
c132 if { input["f"] == false }
c133 if { c130; c131; c132 }
c134 if { input["x"] == 2 }
c135 if { input["y"] == 1 }
c136 if { input["f"] == true }
c137 if { c134; c135; c136 }
c138 if { input["x"] == 2 }
c139 if { input["y"] == 2 }
c140 if { input["f"] == false }
c141 if { c138; c139; c140 }
c142 if { input["x"] == 2 }
c143 if { input["y"] == 2 }
c144 if { input["f"] == true }
c145 if { c142; c143; c144 }
c146 if { input["x"] == 2 }
c147 if { input["y"] == 3 }
c148 if { input["f"] == false }
c149 if { c146; c147; c148 }
c150 if { input["x"] == 2 }
c151 if { input["y"] == 3 }
c152 if { input["f"] == true }
c153 if { c150; c151; c152 }
c154 if { input["x"] == 2 }
c155 if { input["y"] == 4 }
c156 if { input["f"] == false }
c157 if { c154; c155; c156 }
c158 if { input["x"] == 2 }
c159 if { input["y"] == 4 }
c160 if { input["f"] == true }
c161 if { c158; c159; c160 }
c162 if { input["x"] == 3 }
c163 if { input["y"] == 1 }
c164 if { input["f"] == false }
c165 if { c162; c163; c164 }
c166 if { input["x"] == 3 }
c167 if { input["y"] == 1 }
c168 if { input["f"] == true }
c169 if { c166; c167; c168 }
c170 if { input["x"] == 3 }
c171 if { input["y"] == 2 }
c172 if { input["f"] == false }
c173 if { c170; c171; c172 }
c174 if { input["x"] == 3 }
c175 if { input["y"] == 2 }
c176 if { input["f"] == true }
c177 if { c174; c175; c176 }
c178 if { input["x"] == 3 }
c179 if { input["y"] == 3 }
c180 if { input["f"] == false }
c181 if { c178; c179; c180 }
c182 if { input["x"] == 3 }
c183 if { input["y"] == 3 }
c184 if { input["f"] == true }
c185 if { c182; c183; c184 }
c186 if { input["x"] == 3 }
c187 if { input["y"] == 4 }
c188 if { input["f"] == false }
c189 if { c186; c187; c188 }
c190 if { input["x"] == 3 }
c191 if { input["y"] == 4 }
c192 if { input["f"] == true }
c193 if { c190; c191; c192 }
c194 if { input["x"] == 4 }
c195 if { input["y"] == 2 }
c196 if { input["f"] == false }
c197 if { c194; c195; c196 }
c198 if { input["x"] == 4 }
c199 if { input["y"] == 2 }
c200 if { input["f"] == true }
c201 if { c198; c199; c200 }
c202 if { input["x"] == 4 }
c203 if { input["y"] == 3 }
c204 if { input["f"] == false }
c205 if { c202; c203; c204 }
c206 if { input["x"] == 4 }
c207 if { input["y"] == 3 }
c208 if { input["f"] == true }
c209 if { c206; c207; c208 }
c210 if { input["x"] == 4 }
c211 if { input["y"] == 4 }
c212 if { input["f"] == false }
c213 if { c210; c211; c212 }
c214 if { input["x"] == 4 }
c215 if { input["y"] == 4 }
c216 if { input["f"] == true }
c217 if { c214; c215; c216 }
c218 if { input["x"] == 5 }
c219 if { input["y"] == 4 }
c220 if { input["f"] == true }
c221 if { c218; c219; c220 }
