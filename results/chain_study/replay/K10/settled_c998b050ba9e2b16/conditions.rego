package thesis

c0 if { true }
c1 if { input["x"] >= 0 }
c2 if { input["x"] <= 3 }
c3 if { input["y"] >= 1 }
c4 if { input["y"] <= 3 }
c5 if { input["f"] == true }
c6 if { c1; c2; c3; c4; c5 }
rule_0 if { c6 }
c7 if { input["x"] >= 4 }
c8 if { input["x"] <= 5 }
c9 if { input["y"] >= 4 }
c10 if { input["y"] <= 4 }
c11 if { c7; c8; c9; c10 }
rule_1 if { c11 }
c12 if { input["x"] >= 1 }
c13 if { input["x"] <= 2 }
c14 if { input["y"] >= 3 }
c15 if { input["y"] <= 5 }
c16 if { c12; c13; c14; c15 }
c17 if { input["x"] >= 0 }
c18 if { input["x"] <= 3 }
c19 if { input["y"] >= 1 }
c20 if { input["y"] <= 3 }
c21 if { input["f"] == true }
c22 if { c17; c18; c19; c20; c21 }
c23 if { not c22 }
c24 if { c16; c23 }
rule_2 if { c24 }
c25 if { input["x"] >= 2 }
c26 if { input["x"] <= 5 }
c27 if { input["y"] >= 4 }
c28 if { input["y"] <= 5 }
c29 if { input["f"] == true }
c30 if { c25; c26; c27; c28; c29 }
rule_3 if { c30 }
c31 if { input["x"] >= 0 }
c32 if { input["x"] <= 2 }
c33 if { input["y"] >= 3 }
c34 if { input["y"] <= 5 }
c35 if { c31; c32; c33; c34 }
c36 if { input["x"] >= 2 }
c37 if { input["x"] <= 5 }
c38 if { input["y"] >= 4 }
c39 if { input["y"] <= 5 }
c40 if { input["f"] == true }
c41 if { c36; c37; c38; c39; c40 }
c42 if { not c41 }
c43 if { c35; c42 }
c44 if { input["x"] >= 1 }
c45 if { input["x"] <= 2 }
c46 if { input["y"] >= 3 }
c47 if { input["y"] <= 5 }
c48 if { c44; c45; c46; c47 }
c49 if { input["x"] >= 0 }
c50 if { input["x"] <= 3 }
c51 if { input["y"] >= 1 }
c52 if { input["y"] <= 3 }
c53 if { input["f"] == true }
c54 if { c49; c50; c51; c52; c53 }
c55 if { not c54 }
c56 if { c48; c55 }
c57 if { not c56 }
c58 if { c43; c57 }
rule_4 if { c58 }
c59 if { input["x"] >= 1 }
c60 if { input["x"] <= 3 }
c61 if { input["y"] >= 0 }
c62 if { input["y"] <= 1 }
c63 if { input["f"] == false }
c64 if { c59; c60; c61; c62; c63 }
rule_5 if { c64 }
c65 if { input["x"] == 0 }
c66 if { input["y"] == 1 }
c67 if { input["f"] == true }
c68 if { c65; c66; c67 }
c69 if { input["x"] == 0 }
c70 if { input["y"] == 2 }
c71 if { input["f"] == true }
c72 if { c69; c70; c71 }
c73 if { input["x"] == 0 }
c74 if { input["y"] == 3 }
c75 if { input["f"] == false }
c76 if { c73; c74; c75 }
c77 if { input["x"] == 0 }
c78 if { input["y"] == 3 }
c79 if { input["f"] == true }
c80 if { c77; c78; c79 }
c81 if { input["x"] == 0 }
c82 if { input["y"] == 4 }
c83 if { input["f"] == false }
c84 if { c81; c82; c83 }
c85 if { input["x"] == 0 }
c86 if { input["y"] == 4 }
c87 if { input["f"] == true }
c88 if { c85; c86; c87 }
c89 if { input["x"] == 0 }
c90 if { input["y"] == 5 }
c91 if { input["f"] == false }
c92 if { c89; c90; c91 }
c93 if { input["x"] == 0 }
c94 if { input["y"] == 5 }
c95 if { input["f"] == true }
c96 if { c93; c94; c95 }
c97 if { input["x"] == 1 }
c98 if { input["y"] == 0 }
c99 if { input["f"] == false }
c100 if { c97; c98; c99 }
c101 if { input["x"] == 1 }
c102 if { input["y"] == 1 }
c103 if { input["f"] == false }
c104 if { c101; c102; c103 }
c105 if { input["x"] == 1 }
c106 if { input["y"] == 1 }
c107 if { input["f"] == true }
c108 if { c105; c106; c107 }
c109 if { input["x"] == 1 }
c110 if { input["y"] == 2 }
c111 if { input["f"] == true }
c112 if { c109; c110; c111 }
c113 if { input["x"] == 1 }
c114 if { input["y"] == 3 }
c115 if { input["f"] == false }
c116 if { c113; c114; c115 }
c117 if { input["x"] == 1 }
c118 if { input["y"] == 3 }
c119 if { input["f"] == true }
c120 if { c117; c118; c119 }
c121 if { input["x"] == 1 }
c122 if { input["y"] == 4 }
c123 if { input["f"] == false }
c124 if { c121; c122; c123 }
c125 if { input["x"] == 1 }
c126 if { input["y"] == 4 }
c127 if { input["f"] == true }
c128 if { c125; c126; c127 }
c129 if { input["x"] == 1 }
c130 if { input["y"] == 5 }
c131 if { input["f"] == false }
c132 if { c129; c130; c131 }
c133 if { input["x"] == 1 }
c134 if { input["y"] == 5 }
c135 if { input["f"] == true }
c136 if { c133; c134; c135 }
c137 if { input["x"] == 2 }
c138 if { input["y"] == 0 }
c139 if { input["f"] == false }
c140 if { c137; c138; c139 }
c141 if { input["x"] == 2 }
c142 if { input["y"] == 1 }
c143 if { input["f"] == false }
c144 if { c141; c142; c143 }
c145 if { input["x"] == 2 }
c146 if { input["y"] == 1 }
c147 if { input["f"] == true }
c148 if { c145; c146; c147 }
c149 if { input["x"] == 2 }
c150 if { input["y"] == 2 }
c151 if { input["f"] == true }
c152 if { c149; c150; c151 }
c153 if { input["x"] == 2 }
c154 if { input["y"] == 3 }
c155 if { input["f"] == false }
c156 if { c153; c154; c155 }
c157 if { input["x"] == 2 }
c158 if { input["y"] == 3 }
c159 if { input["f"] == true }
c160 if { c157; c158; c159 }
c161 if { input["x"] == 2 }
c162 if { input["y"] == 4 }
c163 if { input["f"] == false }
c164 if { c161; c162; c163 }
c165 if { input["x"] == 2 }
c166 if { input["y"] == 4 }
c167 if { input["f"] == true }
c168 if { c165; c166; c167 }
c169 if { input["x"] == 2 }
c170 if { input["y"] == 5 }
c171 if { input["f"] == false }
c172 if { c169; c170; c171 }
c173 if { input["x"] == 2 }
c174 if { input["y"] == 5 }
c175 if { input["f"] == true }
c176 if { c173; c174; c175 }
c177 if { input["x"] == 3 }
c178 if { input["y"] == 0 }
c179 if { input["f"] == false }
c180 if { c177; c178; c179 }
c181 if { input["x"] == 3 }
c182 if { input["y"] == 1 }
c183 if { input["f"] == false }
c184 if { c181; c182; c183 }
c185 if { input["x"] == 3 }
c186 if { input["y"] == 1 }
c187 if { input["f"] == true }
c188 if { c185; c186; c187 }
c189 if { input["x"] == 3 }
c190 if { input["y"] == 2 }
c191 if { input["f"] == true }
c192 if { c189; c190; c191 }
c193 if { input["x"] == 3 }
c194 if { input["y"] == 3 }
c195 if { input["f"] == true }
c196 if { c193; c194; c195 }
c197 if { input["x"] == 3 }
c198 if { input["y"] == 4 }
c199 if { input["f"] == true }
c200 if { c197; c198; c199 }
c201 if { input["x"] == 3 }
c202 if { input["y"] == 5 }
c203 if { input["f"] == true }
c204 if { c201; c202; c203 }
c205 if { input["x"] == 4 }
c206 if { input["y"] == 4 }
c207 if { input["f"] == false }
c208 if { c205; c206; c207 }
c209 if { input["x"] == 4 }
c210 if { input["y"] == 4 }
c211 if { input["f"] == true }
c212 if { c209; c210; c211 }
c213 if { input["x"] == 4 }
c214 if { input["y"] == 5 }
c215 if { input["f"] == true }
c216 if { c213; c214; c215 }
c217 if { input["x"] == 5 }
c218 if { input["y"] == 4 }
c219 if { input["f"] == false }
c220 if { c217; c218; c219 }
c221 if { input["x"] == 5 }
c222 if { input["y"] == 4 }
c223 if { input["f"] == true }
c224 if { c221; c222; c223 }
c225 if { input["x"] == 5 }
c226 if { input["y"] == 5 }
c227 if { input["f"] == true }
c228 if { c225; c226; c227 }
