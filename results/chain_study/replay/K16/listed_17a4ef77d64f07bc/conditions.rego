package thesis

c0 if { true }
c1 if { input["x"] >= 0 }
c2 if { input["x"] <= 2 }
c3 if { input["y"] >= 1 }
c4 if { input["y"] <= 5 }
c5 if { input["f"] == true }
c6 if { c1; c2; c3; c4; c5 }
c7 if { input["x"] >= 2 }
c8 if { input["x"] <= 5 }
c9 if { input["y"] >= 1 }
c10 if { input["y"] <= 2 }
c11 if { c7; c8; c9; c10 }
c12 if { not c11 }
c13 if { c6; c12 }
rule_0 if { c13 }
c14 if { input["x"] >= 0 }
c15 if { input["x"] <= 4 }
c16 if { input["y"] >= 1 }
c17 if { input["y"] <= 1 }
c18 if { c14; c15; c16; c17 }
c19 if { input["x"] >= 0 }
c20 if { input["x"] <= 2 }
c21 if { input["y"] >= 1 }
c22 if { input["y"] <= 5 }
c23 if { input["f"] == true }
c24 if { c19; c20; c21; c22; c23 }
c25 if { not c24 }
c26 if { c18; c25 }
c27 if { input["x"] >= 2 }
c28 if { input["x"] <= 2 }
c29 if { input["y"] >= 1 }
c30 if { input["y"] <= 1 }
c31 if { c27; c28; c29; c30 }
c32 if { not c31 }
c33 if { c26; c32 }
rule_1 if { c33 }
c34 if { input["x"] >= 4 }
c35 if { input["x"] <= 5 }
c36 if { input["y"] >= 3 }
c37 if { input["y"] <= 3 }
c38 if { c34; c35; c36; c37 }
rule_2 if { c38 }
c39 if { input["x"] >= 2 }
c40 if { input["x"] <= 2 }
c41 if { input["y"] >= 1 }
c42 if { input["y"] <= 1 }
c43 if { c39; c40; c41; c42 }
rule_3 if { c43 }
c44 if { input["x"] >= 2 }
c45 if { input["x"] <= 5 }
c46 if { input["y"] >= 1 }
c47 if { input["y"] <= 2 }
c48 if { c44; c45; c46; c47 }
c49 if { input["x"] >= 2 }
c50 if { input["x"] <= 2 }
c51 if { input["y"] >= 1 }
c52 if { input["y"] <= 1 }
c53 if { c49; c50; c51; c52 }
c54 if { not c53 }
c55 if { c48; c54 }
rule_4 if { c55 }
c56 if { input["x"] >= 0 }
c57 if { input["x"] <= 5 }
c58 if { input["y"] >= 1 }
c59 if { input["y"] <= 2 }
c60 if { input["f"] == true }
c61 if { c56; c57; c58; c59; c60 }
c62 if { input["x"] >= 0 }
c63 if { input["x"] <= 2 }
c64 if { input["y"] >= 1 }
c65 if { input["y"] <= 5 }
c66 if { input["f"] == true }
c67 if { c62; c63; c64; c65; c66 }
c68 if { input["x"] >= 2 }
c69 if { input["x"] <= 5 }
c70 if { input["y"] >= 1 }
c71 if { input["y"] <= 2 }
c72 if { c68; c69; c70; c71 }
c73 if { not c72 }
c74 if { c67; c73 }
c75 if { not c74 }
c76 if { c61; c75 }
c77 if { input["x"] >= 2 }
c78 if { input["x"] <= 2 }
c79 if { input["y"] >= 1 }
c80 if { input["y"] <= 1 }
c81 if { c77; c78; c79; c80 }
c82 if { not c81 }
c83 if { c76; c82 }
rule_5 if { c83 }
c84 if { input["x"] >= 1 }
c85 if { input["x"] <= 1 }
c86 if { input["y"] >= 2 }
c87 if { input["y"] <= 3 }
c88 if { c84; c85; c86; c87 }
rule_6 if { c88 }
c89 if { input["x"] == 0 }
c90 if { input["y"] == 1 }
c91 if { input["f"] == false }
c92 if { c89; c90; c91 }
c93 if { input["x"] == 0 }
c94 if { input["y"] == 1 }
c95 if { input["f"] == true }
c96 if { c93; c94; c95 }
c97 if { input["x"] == 0 }
c98 if { input["y"] == 2 }
c99 if { input["f"] == true }
c100 if { c97; c98; c99 }
c101 if { input["x"] == 0 }
c102 if { input["y"] == 3 }
c103 if { input["f"] == true }
c104 if { c101; c102; c103 }
c105 if { input["x"] == 0 }
c106 if { input["y"] == 4 }
c107 if { input["f"] == true }
c108 if { c105; c106; c107 }
c109 if { input["x"] == 0 }
c110 if { input["y"] == 5 }
c111 if { input["f"] == true }
c112 if { c109; c110; c111 }
c113 if { input["x"] == 1 }
c114 if { input["y"] == 1 }
c115 if { input["f"] == false }
c116 if { c113; c114; c115 }
c117 if { input["x"] == 1 }
c118 if { input["y"] == 1 }
c119 if { input["f"] == true }
c120 if { c117; c118; c119 }
c121 if { input["x"] == 1 }
c122 if { input["y"] == 2 }
c123 if { input["f"] == false }
c124 if { c121; c122; c123 }
c125 if { input["x"] == 1 }
c126 if { input["y"] == 2 }
c127 if { input["f"] == true }
c128 if { c125; c126; c127 }
c129 if { input["x"] == 1 }
c130 if { input["y"] == 3 }
c131 if { input["f"] == false }
c132 if { c129; c130; c131 }
c133 if { input["x"] == 1 }
c134 if { input["y"] == 3 }
c135 if { input["f"] == true }
c136 if { c133; c134; c135 }
c137 if { input["x"] == 1 }
c138 if { input["y"] == 4 }
c139 if { input["f"] == true }
c140 if { c137; c138; c139 }
c141 if { input["x"] == 1 }
c142 if { input["y"] == 5 }
c143 if { input["f"] == true }
c144 if { c141; c142; c143 }
c145 if { input["x"] == 2 }
c146 if { input["y"] == 1 }
c147 if { input["f"] == false }
c148 if { c145; c146; c147 }
c149 if { input["x"] == 2 }
c150 if { input["y"] == 1 }
c151 if { input["f"] == true }
c152 if { c149; c150; c151 }
c153 if { input["x"] == 2 }
c154 if { input["y"] == 2 }
c155 if { input["f"] == false }
c156 if { c153; c154; c155 }
c157 if { input["x"] == 2 }
c158 if { input["y"] == 2 }
c159 if { input["f"] == true }
c160 if { c157; c158; c159 }
c161 if { input["x"] == 2 }
c162 if { input["y"] == 3 }
c163 if { input["f"] == true }
c164 if { c161; c162; c163 }
c165 if { input["x"] == 2 }
c166 if { input["y"] == 4 }
c167 if { input["f"] == true }
c168 if { c165; c166; c167 }
c169 if { input["x"] == 2 }
c170 if { input["y"] == 5 }
c171 if { input["f"] == true }
c172 if { c169; c170; c171 }
c173 if { input["x"] == 3 }
c174 if { input["y"] == 1 }
c175 if { input["f"] == false }
c176 if { c173; c174; c175 }
c177 if { input["x"] == 3 }
c178 if { input["y"] == 1 }
c179 if { input["f"] == true }
c180 if { c177; c178; c179 }
c181 if { input["x"] == 3 }
c182 if { input["y"] == 2 }
c183 if { input["f"] == false }
c184 if { c181; c182; c183 }
c185 if { input["x"] == 3 }
c186 if { input["y"] == 2 }
c187 if { input["f"] == true }
c188 if { c185; c186; c187 }
c189 if { input["x"] == 4 }
c190 if { input["y"] == 1 }
c191 if { input["f"] == false }
c192 if { c189; c190; c191 }
c193 if { input["x"] == 4 }
c194 if { input["y"] == 1 }
c195 if { input["f"] == true }
c196 if { c193; c194; c195 }
c197 if { input["x"] == 4 }
c198 if { input["y"] == 2 }
c199 if { input["f"] == false }
c200 if { c197; c198; c199 }
c201 if { input["x"] == 4 }
c202 if { input["y"] == 2 }
c203 if { input["f"] == true }
c204 if { c201; c202; c203 }
c205 if { input["x"] == 4 }
c206 if { input["y"] == 3 }
c207 if { input["f"] == false }
c208 if { c205; c206; c207 }
c209 if { input["x"] == 4 }
c210 if { input["y"] == 3 }
c211 if { input["f"] == true }
c212 if { c209; c210; c211 }
c213 if { input["x"] == 5 }
c214 if { input["y"] == 1 }
c215 if { input["f"] == false }
c216 if { c213; c214; c215 }
c217 if { input["x"] == 5 }
c218 if { input["y"] == 1 }
c219 if { input["f"] == true }
c220 if { c217; c218; c219 }
c221 if { input["x"] == 5 }
c222 if { input["y"] == 2 }
c223 if { input["f"] == false }
c224 if { c221; c222; c223 }
c225 if { input["x"] == 5 }
c226 if { input["y"] == 2 }
c227 if { input["f"] == true }
c228 if { c225; c226; c227 }
c229 if { input["x"] == 5 }
c230 if { input["y"] == 3 }
c231 if { input["f"] == false }
c232 if { c229; c230; c231 }
c233 if { input["x"] == 5 }
c234 if { input["y"] == 3 }
c235 if { input["f"] == true }
c236 if { c233; c234; c235 }
