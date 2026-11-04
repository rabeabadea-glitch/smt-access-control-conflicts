package thesis

c0 if { true }
c1 if { input["x"] >= 1 }
c2 if { input["x"] <= 1 }
c3 if { input["y"] >= 2 }
c4 if { input["y"] <= 3 }
c5 if { c1; c2; c3; c4 }
rule_0 if { c5 }
c6 if { input["x"] >= 0 }
c7 if { input["x"] <= 4 }
c8 if { input["y"] >= 1 }
c9 if { input["y"] <= 1 }
c10 if { c6; c7; c8; c9 }
c11 if { input["x"] >= 0 }
c12 if { input["x"] <= 2 }
c13 if { input["y"] >= 1 }
c14 if { input["y"] <= 5 }
c15 if { input["f"] == true }
c16 if { c11; c12; c13; c14; c15 }
c17 if { not c16 }
c18 if { c10; c17 }
c19 if { input["x"] >= 2 }
c20 if { input["x"] <= 2 }
c21 if { input["y"] >= 1 }
c22 if { input["y"] <= 1 }
c23 if { c19; c20; c21; c22 }
c24 if { not c23 }
c25 if { c18; c24 }
rule_1 if { c25 }
c26 if { input["x"] >= 0 }
c27 if { input["x"] <= 2 }
c28 if { input["y"] >= 1 }
c29 if { input["y"] <= 5 }
c30 if { input["f"] == true }
c31 if { c26; c27; c28; c29; c30 }
c32 if { input["x"] >= 2 }
c33 if { input["x"] <= 5 }
c34 if { input["y"] >= 1 }
c35 if { input["y"] <= 2 }
c36 if { c32; c33; c34; c35 }
c37 if { not c36 }
c38 if { c31; c37 }
rule_2 if { c38 }
c39 if { input["x"] >= 4 }
c40 if { input["x"] <= 5 }
c41 if { input["y"] >= 3 }
c42 if { input["y"] <= 3 }
c43 if { c39; c40; c41; c42 }
rule_3 if { c43 }
c44 if { input["x"] >= 2 }
c45 if { input["x"] <= 2 }
c46 if { input["y"] >= 1 }
c47 if { input["y"] <= 1 }
c48 if { c44; c45; c46; c47 }
rule_4 if { c48 }
c49 if { input["x"] >= 0 }
c50 if { input["x"] <= 5 }
c51 if { input["y"] >= 1 }
c52 if { input["y"] <= 2 }
c53 if { input["f"] == true }
c54 if { c49; c50; c51; c52; c53 }
c55 if { input["x"] >= 1 }
c56 if { input["x"] <= 1 }
c57 if { input["y"] >= 2 }
c58 if { input["y"] <= 3 }
c59 if { c55; c56; c57; c58 }
c60 if { not c59 }
c61 if { c54; c60 }
c62 if { input["x"] >= 0 }
c63 if { input["x"] <= 2 }
c64 if { input["y"] >= 1 }
c65 if { input["y"] <= 5 }
c66 if { input["f"] == true }
c67 if { c62; c63; c64; c65; c66 }
c68 if { not c67 }
c69 if { c61; c68 }
rule_5 if { c69 }
c70 if { input["x"] >= 2 }
c71 if { input["x"] <= 5 }
c72 if { input["y"] >= 1 }
c73 if { input["y"] <= 2 }
c74 if { c70; c71; c72; c73 }
c75 if { input["x"] >= 2 }
c76 if { input["x"] <= 2 }
c77 if { input["y"] >= 1 }
c78 if { input["y"] <= 1 }
c79 if { c75; c76; c77; c78 }
c80 if { not c79 }
c81 if { c74; c80 }
rule_6 if { c81 }
c82 if { input["x"] == 0 }
c83 if { input["y"] == 1 }
c84 if { input["f"] == false }
c85 if { c82; c83; c84 }
c86 if { input["x"] == 0 }
c87 if { input["y"] == 1 }
c88 if { input["f"] == true }
c89 if { c86; c87; c88 }
c90 if { input["x"] == 0 }
c91 if { input["y"] == 2 }
c92 if { input["f"] == true }
c93 if { c90; c91; c92 }
c94 if { input["x"] == 0 }
c95 if { input["y"] == 3 }
c96 if { input["f"] == true }
c97 if { c94; c95; c96 }
c98 if { input["x"] == 0 }
c99 if { input["y"] == 4 }
c100 if { input["f"] == true }
c101 if { c98; c99; c100 }
c102 if { input["x"] == 0 }
c103 if { input["y"] == 5 }
c104 if { input["f"] == true }
c105 if { c102; c103; c104 }
c106 if { input["x"] == 1 }
c107 if { input["y"] == 1 }
c108 if { input["f"] == false }
c109 if { c106; c107; c108 }
c110 if { input["x"] == 1 }
c111 if { input["y"] == 1 }
c112 if { input["f"] == true }
c113 if { c110; c111; c112 }
c114 if { input["x"] == 1 }
c115 if { input["y"] == 2 }
c116 if { input["f"] == false }
c117 if { c114; c115; c116 }
c118 if { input["x"] == 1 }
c119 if { input["y"] == 2 }
c120 if { input["f"] == true }
c121 if { c118; c119; c120 }
c122 if { input["x"] == 1 }
c123 if { input["y"] == 3 }
c124 if { input["f"] == false }
c125 if { c122; c123; c124 }
c126 if { input["x"] == 1 }
c127 if { input["y"] == 3 }
c128 if { input["f"] == true }
c129 if { c126; c127; c128 }
c130 if { input["x"] == 1 }
c131 if { input["y"] == 4 }
c132 if { input["f"] == true }
c133 if { c130; c131; c132 }
c134 if { input["x"] == 1 }
c135 if { input["y"] == 5 }
c136 if { input["f"] == true }
c137 if { c134; c135; c136 }
c138 if { input["x"] == 2 }
c139 if { input["y"] == 1 }
c140 if { input["f"] == false }
c141 if { c138; c139; c140 }
c142 if { input["x"] == 2 }
c143 if { input["y"] == 1 }
c144 if { input["f"] == true }
c145 if { c142; c143; c144 }
c146 if { input["x"] == 2 }
c147 if { input["y"] == 2 }
c148 if { input["f"] == false }
c149 if { c146; c147; c148 }
c150 if { input["x"] == 2 }
c151 if { input["y"] == 2 }
c152 if { input["f"] == true }
c153 if { c150; c151; c152 }
c154 if { input["x"] == 2 }
c155 if { input["y"] == 3 }
c156 if { input["f"] == true }
c157 if { c154; c155; c156 }
c158 if { input["x"] == 2 }
c159 if { input["y"] == 4 }
c160 if { input["f"] == true }
c161 if { c158; c159; c160 }
c162 if { input["x"] == 2 }
c163 if { input["y"] == 5 }
c164 if { input["f"] == true }
c165 if { c162; c163; c164 }
c166 if { input["x"] == 3 }
c167 if { input["y"] == 1 }
c168 if { input["f"] == false }
c169 if { c166; c167; c168 }
c170 if { input["x"] == 3 }
c171 if { input["y"] == 1 }
c172 if { input["f"] == true }
c173 if { c170; c171; c172 }
c174 if { input["x"] == 3 }
c175 if { input["y"] == 2 }
c176 if { input["f"] == false }
c177 if { c174; c175; c176 }
c178 if { input["x"] == 3 }
c179 if { input["y"] == 2 }
c180 if { input["f"] == true }
c181 if { c178; c179; c180 }
c182 if { input["x"] == 4 }
c183 if { input["y"] == 1 }
c184 if { input["f"] == false }
c185 if { c182; c183; c184 }
c186 if { input["x"] == 4 }
c187 if { input["y"] == 1 }
c188 if { input["f"] == true }
c189 if { c186; c187; c188 }
c190 if { input["x"] == 4 }
c191 if { input["y"] == 2 }
c192 if { input["f"] == false }
c193 if { c190; c191; c192 }
c194 if { input["x"] == 4 }
c195 if { input["y"] == 2 }
c196 if { input["f"] == true }
c197 if { c194; c195; c196 }
c198 if { input["x"] == 4 }
c199 if { input["y"] == 3 }
c200 if { input["f"] == false }
c201 if { c198; c199; c200 }
c202 if { input["x"] == 4 }
c203 if { input["y"] == 3 }
c204 if { input["f"] == true }
c205 if { c202; c203; c204 }
c206 if { input["x"] == 5 }
c207 if { input["y"] == 1 }
c208 if { input["f"] == false }
c209 if { c206; c207; c208 }
c210 if { input["x"] == 5 }
c211 if { input["y"] == 1 }
c212 if { input["f"] == true }
c213 if { c210; c211; c212 }
c214 if { input["x"] == 5 }
c215 if { input["y"] == 2 }
c216 if { input["f"] == false }
c217 if { c214; c215; c216 }
c218 if { input["x"] == 5 }
c219 if { input["y"] == 2 }
c220 if { input["f"] == true }
c221 if { c218; c219; c220 }
c222 if { input["x"] == 5 }
c223 if { input["y"] == 3 }
c224 if { input["f"] == false }
c225 if { c222; c223; c224 }
c226 if { input["x"] == 5 }
c227 if { input["y"] == 3 }
c228 if { input["f"] == true }
c229 if { c226; c227; c228 }
