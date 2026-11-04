package thesis

c0 if { true }
c1 if { input["x"] >= 2 }
c2 if { input["x"] <= 5 }
c3 if { input["y"] >= 1 }
c4 if { input["y"] <= 5 }
c5 if { input["f"] == true }
c6 if { c1; c2; c3; c4; c5 }
rule_0 if { c6 }
c7 if { input["x"] >= 4 }
c8 if { input["x"] <= 4 }
c9 if { input["y"] >= 2 }
c10 if { input["y"] <= 5 }
c11 if { c7; c8; c9; c10 }
c12 if { input["x"] >= 2 }
c13 if { input["x"] <= 5 }
c14 if { input["y"] >= 1 }
c15 if { input["y"] <= 2 }
c16 if { c12; c13; c14; c15 }
c17 if { input["x"] >= 2 }
c18 if { input["x"] <= 5 }
c19 if { input["y"] >= 1 }
c20 if { input["y"] <= 5 }
c21 if { input["f"] == true }
c22 if { c17; c18; c19; c20; c21 }
c23 if { not c22 }
c24 if { c16; c23 }
c25 if { not c24 }
c26 if { c11; c25 }
rule_1 if { c26 }
c27 if { input["x"] >= 1 }
c28 if { input["x"] <= 3 }
c29 if { input["y"] >= 2 }
c30 if { input["y"] <= 3 }
c31 if { input["f"] == false }
c32 if { c27; c28; c29; c30; c31 }
rule_2 if { c32 }
c33 if { input["x"] >= 2 }
c34 if { input["x"] <= 5 }
c35 if { input["y"] >= 1 }
c36 if { input["y"] <= 2 }
c37 if { c33; c34; c35; c36 }
c38 if { input["x"] >= 2 }
c39 if { input["x"] <= 5 }
c40 if { input["y"] >= 1 }
c41 if { input["y"] <= 5 }
c42 if { input["f"] == true }
c43 if { c38; c39; c40; c41; c42 }
c44 if { not c43 }
c45 if { c37; c44 }
c46 if { input["x"] >= 1 }
c47 if { input["x"] <= 3 }
c48 if { input["y"] >= 2 }
c49 if { input["y"] <= 3 }
c50 if { input["f"] == false }
c51 if { c46; c47; c48; c49; c50 }
c52 if { not c51 }
c53 if { c45; c52 }
c54 if { input["x"] >= 4 }
c55 if { input["x"] <= 5 }
c56 if { input["y"] >= 1 }
c57 if { input["y"] <= 5 }
c58 if { c54; c55; c56; c57 }
c59 if { not c58 }
c60 if { c53; c59 }
rule_3 if { c60 }
c61 if { input["x"] >= 4 }
c62 if { input["x"] <= 5 }
c63 if { input["y"] >= 1 }
c64 if { input["y"] <= 5 }
c65 if { c61; c62; c63; c64 }
rule_4 if { c65 }
c66 if { input["x"] >= 0 }
c67 if { input["x"] <= 0 }
c68 if { input["y"] >= 1 }
c69 if { input["y"] <= 1 }
c70 if { input["f"] == false }
c71 if { c66; c67; c68; c69; c70 }
rule_5 if { c71 }
c72 if { input["x"] >= 3 }
c73 if { input["x"] <= 5 }
c74 if { input["y"] >= 1 }
c75 if { input["y"] <= 5 }
c76 if { input["f"] == true }
c77 if { c72; c73; c74; c75; c76 }
rule_6 if { c77 }
c78 if { input["x"] == 0 }
c79 if { input["y"] == 1 }
c80 if { input["f"] == false }
c81 if { c78; c79; c80 }
c82 if { input["x"] == 1 }
c83 if { input["y"] == 2 }
c84 if { input["f"] == false }
c85 if { c82; c83; c84 }
c86 if { input["x"] == 1 }
c87 if { input["y"] == 3 }
c88 if { input["f"] == false }
c89 if { c86; c87; c88 }
c90 if { input["x"] == 2 }
c91 if { input["y"] == 1 }
c92 if { input["f"] == false }
c93 if { c90; c91; c92 }
c94 if { input["x"] == 2 }
c95 if { input["y"] == 1 }
c96 if { input["f"] == true }
c97 if { c94; c95; c96 }
c98 if { input["x"] == 2 }
c99 if { input["y"] == 2 }
c100 if { input["f"] == false }
c101 if { c98; c99; c100 }
c102 if { input["x"] == 2 }
c103 if { input["y"] == 2 }
c104 if { input["f"] == true }
c105 if { c102; c103; c104 }
c106 if { input["x"] == 2 }
c107 if { input["y"] == 3 }
c108 if { input["f"] == false }
c109 if { c106; c107; c108 }
c110 if { input["x"] == 2 }
c111 if { input["y"] == 3 }
c112 if { input["f"] == true }
c113 if { c110; c111; c112 }
c114 if { input["x"] == 2 }
c115 if { input["y"] == 4 }
c116 if { input["f"] == true }
c117 if { c114; c115; c116 }
c118 if { input["x"] == 2 }
c119 if { input["y"] == 5 }
c120 if { input["f"] == true }
c121 if { c118; c119; c120 }
c122 if { input["x"] == 3 }
c123 if { input["y"] == 1 }
c124 if { input["f"] == false }
c125 if { c122; c123; c124 }
c126 if { input["x"] == 3 }
c127 if { input["y"] == 1 }
c128 if { input["f"] == true }
c129 if { c126; c127; c128 }
c130 if { input["x"] == 3 }
c131 if { input["y"] == 2 }
c132 if { input["f"] == false }
c133 if { c130; c131; c132 }
c134 if { input["x"] == 3 }
c135 if { input["y"] == 2 }
c136 if { input["f"] == true }
c137 if { c134; c135; c136 }
c138 if { input["x"] == 3 }
c139 if { input["y"] == 3 }
c140 if { input["f"] == false }
c141 if { c138; c139; c140 }
c142 if { input["x"] == 3 }
c143 if { input["y"] == 3 }
c144 if { input["f"] == true }
c145 if { c142; c143; c144 }
c146 if { input["x"] == 3 }
c147 if { input["y"] == 4 }
c148 if { input["f"] == true }
c149 if { c146; c147; c148 }
c150 if { input["x"] == 3 }
c151 if { input["y"] == 5 }
c152 if { input["f"] == true }
c153 if { c150; c151; c152 }
c154 if { input["x"] == 4 }
c155 if { input["y"] == 1 }
c156 if { input["f"] == false }
c157 if { c154; c155; c156 }
c158 if { input["x"] == 4 }
c159 if { input["y"] == 1 }
c160 if { input["f"] == true }
c161 if { c158; c159; c160 }
c162 if { input["x"] == 4 }
c163 if { input["y"] == 2 }
c164 if { input["f"] == false }
c165 if { c162; c163; c164 }
c166 if { input["x"] == 4 }
c167 if { input["y"] == 2 }
c168 if { input["f"] == true }
c169 if { c166; c167; c168 }
c170 if { input["x"] == 4 }
c171 if { input["y"] == 3 }
c172 if { input["f"] == false }
c173 if { c170; c171; c172 }
c174 if { input["x"] == 4 }
c175 if { input["y"] == 3 }
c176 if { input["f"] == true }
c177 if { c174; c175; c176 }
c178 if { input["x"] == 4 }
c179 if { input["y"] == 4 }
c180 if { input["f"] == false }
c181 if { c178; c179; c180 }
c182 if { input["x"] == 4 }
c183 if { input["y"] == 4 }
c184 if { input["f"] == true }
c185 if { c182; c183; c184 }
c186 if { input["x"] == 4 }
c187 if { input["y"] == 5 }
c188 if { input["f"] == false }
c189 if { c186; c187; c188 }
c190 if { input["x"] == 4 }
c191 if { input["y"] == 5 }
c192 if { input["f"] == true }
c193 if { c190; c191; c192 }
c194 if { input["x"] == 5 }
c195 if { input["y"] == 1 }
c196 if { input["f"] == false }
c197 if { c194; c195; c196 }
c198 if { input["x"] == 5 }
c199 if { input["y"] == 1 }
c200 if { input["f"] == true }
c201 if { c198; c199; c200 }
c202 if { input["x"] == 5 }
c203 if { input["y"] == 2 }
c204 if { input["f"] == false }
c205 if { c202; c203; c204 }
c206 if { input["x"] == 5 }
c207 if { input["y"] == 2 }
c208 if { input["f"] == true }
c209 if { c206; c207; c208 }
c210 if { input["x"] == 5 }
c211 if { input["y"] == 3 }
c212 if { input["f"] == false }
c213 if { c210; c211; c212 }
c214 if { input["x"] == 5 }
c215 if { input["y"] == 3 }
c216 if { input["f"] == true }
c217 if { c214; c215; c216 }
c218 if { input["x"] == 5 }
c219 if { input["y"] == 4 }
c220 if { input["f"] == false }
c221 if { c218; c219; c220 }
c222 if { input["x"] == 5 }
c223 if { input["y"] == 4 }
c224 if { input["f"] == true }
c225 if { c222; c223; c224 }
c226 if { input["x"] == 5 }
c227 if { input["y"] == 5 }
c228 if { input["f"] == false }
c229 if { c226; c227; c228 }
c230 if { input["x"] == 5 }
c231 if { input["y"] == 5 }
c232 if { input["f"] == true }
c233 if { c230; c231; c232 }
