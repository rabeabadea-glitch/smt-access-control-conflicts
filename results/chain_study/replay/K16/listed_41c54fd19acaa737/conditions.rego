package thesis

c0 if { true }
c1 if { input["x"] >= 2 }
c2 if { input["x"] <= 5 }
c3 if { input["y"] >= 1 }
c4 if { input["y"] <= 2 }
c5 if { c1; c2; c3; c4 }
c6 if { input["x"] >= 2 }
c7 if { input["x"] <= 2 }
c8 if { input["y"] >= 1 }
c9 if { input["y"] <= 1 }
c10 if { c6; c7; c8; c9 }
c11 if { not c10 }
c12 if { c5; c11 }
rule_0 if { c12 }
c13 if { input["x"] >= 0 }
c14 if { input["x"] <= 2 }
c15 if { input["y"] >= 1 }
c16 if { input["y"] <= 5 }
c17 if { input["f"] == true }
c18 if { c13; c14; c15; c16; c17 }
c19 if { input["x"] >= 2 }
c20 if { input["x"] <= 5 }
c21 if { input["y"] >= 1 }
c22 if { input["y"] <= 2 }
c23 if { c19; c20; c21; c22 }
c24 if { not c23 }
c25 if { c18; c24 }
rule_1 if { c25 }
c26 if { input["x"] >= 1 }
c27 if { input["x"] <= 1 }
c28 if { input["y"] >= 2 }
c29 if { input["y"] <= 3 }
c30 if { c26; c27; c28; c29 }
rule_2 if { c30 }
c31 if { input["x"] >= 4 }
c32 if { input["x"] <= 5 }
c33 if { input["y"] >= 3 }
c34 if { input["y"] <= 3 }
c35 if { c31; c32; c33; c34 }
rule_3 if { c35 }
c36 if { input["x"] >= 0 }
c37 if { input["x"] <= 5 }
c38 if { input["y"] >= 1 }
c39 if { input["y"] <= 2 }
c40 if { input["f"] == true }
c41 if { c36; c37; c38; c39; c40 }
c42 if { input["x"] >= 0 }
c43 if { input["x"] <= 2 }
c44 if { input["y"] >= 1 }
c45 if { input["y"] <= 5 }
c46 if { input["f"] == true }
c47 if { c42; c43; c44; c45; c46 }
c48 if { input["x"] >= 2 }
c49 if { input["x"] <= 5 }
c50 if { input["y"] >= 1 }
c51 if { input["y"] <= 2 }
c52 if { c48; c49; c50; c51 }
c53 if { not c52 }
c54 if { c47; c53 }
c55 if { not c54 }
c56 if { c41; c55 }
c57 if { input["x"] >= 2 }
c58 if { input["x"] <= 2 }
c59 if { input["y"] >= 1 }
c60 if { input["y"] <= 1 }
c61 if { c57; c58; c59; c60 }
c62 if { not c61 }
c63 if { c56; c62 }
rule_4 if { c63 }
c64 if { input["x"] >= 0 }
c65 if { input["x"] <= 4 }
c66 if { input["y"] >= 1 }
c67 if { input["y"] <= 1 }
c68 if { c64; c65; c66; c67 }
c69 if { input["x"] >= 0 }
c70 if { input["x"] <= 2 }
c71 if { input["y"] >= 1 }
c72 if { input["y"] <= 5 }
c73 if { input["f"] == true }
c74 if { c69; c70; c71; c72; c73 }
c75 if { input["x"] >= 2 }
c76 if { input["x"] <= 5 }
c77 if { input["y"] >= 1 }
c78 if { input["y"] <= 2 }
c79 if { c75; c76; c77; c78 }
c80 if { not c79 }
c81 if { c74; c80 }
c82 if { not c81 }
c83 if { c68; c82 }
c84 if { input["x"] >= 2 }
c85 if { input["x"] <= 2 }
c86 if { input["y"] >= 1 }
c87 if { input["y"] <= 1 }
c88 if { c84; c85; c86; c87 }
c89 if { not c88 }
c90 if { c83; c89 }
rule_5 if { c90 }
c91 if { input["x"] >= 2 }
c92 if { input["x"] <= 2 }
c93 if { input["y"] >= 1 }
c94 if { input["y"] <= 1 }
c95 if { c91; c92; c93; c94 }
rule_6 if { c95 }
c96 if { input["x"] == 0 }
c97 if { input["y"] == 1 }
c98 if { input["f"] == false }
c99 if { c96; c97; c98 }
c100 if { input["x"] == 0 }
c101 if { input["y"] == 1 }
c102 if { input["f"] == true }
c103 if { c100; c101; c102 }
c104 if { input["x"] == 0 }
c105 if { input["y"] == 2 }
c106 if { input["f"] == true }
c107 if { c104; c105; c106 }
c108 if { input["x"] == 0 }
c109 if { input["y"] == 3 }
c110 if { input["f"] == true }
c111 if { c108; c109; c110 }
c112 if { input["x"] == 0 }
c113 if { input["y"] == 4 }
c114 if { input["f"] == true }
c115 if { c112; c113; c114 }
c116 if { input["x"] == 0 }
c117 if { input["y"] == 5 }
c118 if { input["f"] == true }
c119 if { c116; c117; c118 }
c120 if { input["x"] == 1 }
c121 if { input["y"] == 1 }
c122 if { input["f"] == false }
c123 if { c120; c121; c122 }
c124 if { input["x"] == 1 }
c125 if { input["y"] == 1 }
c126 if { input["f"] == true }
c127 if { c124; c125; c126 }
c128 if { input["x"] == 1 }
c129 if { input["y"] == 2 }
c130 if { input["f"] == false }
c131 if { c128; c129; c130 }
c132 if { input["x"] == 1 }
c133 if { input["y"] == 2 }
c134 if { input["f"] == true }
c135 if { c132; c133; c134 }
c136 if { input["x"] == 1 }
c137 if { input["y"] == 3 }
c138 if { input["f"] == false }
c139 if { c136; c137; c138 }
c140 if { input["x"] == 1 }
c141 if { input["y"] == 3 }
c142 if { input["f"] == true }
c143 if { c140; c141; c142 }
c144 if { input["x"] == 1 }
c145 if { input["y"] == 4 }
c146 if { input["f"] == true }
c147 if { c144; c145; c146 }
c148 if { input["x"] == 1 }
c149 if { input["y"] == 5 }
c150 if { input["f"] == true }
c151 if { c148; c149; c150 }
c152 if { input["x"] == 2 }
c153 if { input["y"] == 1 }
c154 if { input["f"] == false }
c155 if { c152; c153; c154 }
c156 if { input["x"] == 2 }
c157 if { input["y"] == 1 }
c158 if { input["f"] == true }
c159 if { c156; c157; c158 }
c160 if { input["x"] == 2 }
c161 if { input["y"] == 2 }
c162 if { input["f"] == false }
c163 if { c160; c161; c162 }
c164 if { input["x"] == 2 }
c165 if { input["y"] == 2 }
c166 if { input["f"] == true }
c167 if { c164; c165; c166 }
c168 if { input["x"] == 2 }
c169 if { input["y"] == 3 }
c170 if { input["f"] == true }
c171 if { c168; c169; c170 }
c172 if { input["x"] == 2 }
c173 if { input["y"] == 4 }
c174 if { input["f"] == true }
c175 if { c172; c173; c174 }
c176 if { input["x"] == 2 }
c177 if { input["y"] == 5 }
c178 if { input["f"] == true }
c179 if { c176; c177; c178 }
c180 if { input["x"] == 3 }
c181 if { input["y"] == 1 }
c182 if { input["f"] == false }
c183 if { c180; c181; c182 }
c184 if { input["x"] == 3 }
c185 if { input["y"] == 1 }
c186 if { input["f"] == true }
c187 if { c184; c185; c186 }
c188 if { input["x"] == 3 }
c189 if { input["y"] == 2 }
c190 if { input["f"] == false }
c191 if { c188; c189; c190 }
c192 if { input["x"] == 3 }
c193 if { input["y"] == 2 }
c194 if { input["f"] == true }
c195 if { c192; c193; c194 }
c196 if { input["x"] == 4 }
c197 if { input["y"] == 1 }
c198 if { input["f"] == false }
c199 if { c196; c197; c198 }
c200 if { input["x"] == 4 }
c201 if { input["y"] == 1 }
c202 if { input["f"] == true }
c203 if { c200; c201; c202 }
c204 if { input["x"] == 4 }
c205 if { input["y"] == 2 }
c206 if { input["f"] == false }
c207 if { c204; c205; c206 }
c208 if { input["x"] == 4 }
c209 if { input["y"] == 2 }
c210 if { input["f"] == true }
c211 if { c208; c209; c210 }
c212 if { input["x"] == 4 }
c213 if { input["y"] == 3 }
c214 if { input["f"] == false }
c215 if { c212; c213; c214 }
c216 if { input["x"] == 4 }
c217 if { input["y"] == 3 }
c218 if { input["f"] == true }
c219 if { c216; c217; c218 }
c220 if { input["x"] == 5 }
c221 if { input["y"] == 1 }
c222 if { input["f"] == false }
c223 if { c220; c221; c222 }
c224 if { input["x"] == 5 }
c225 if { input["y"] == 1 }
c226 if { input["f"] == true }
c227 if { c224; c225; c226 }
c228 if { input["x"] == 5 }
c229 if { input["y"] == 2 }
c230 if { input["f"] == false }
c231 if { c228; c229; c230 }
c232 if { input["x"] == 5 }
c233 if { input["y"] == 2 }
c234 if { input["f"] == true }
c235 if { c232; c233; c234 }
c236 if { input["x"] == 5 }
c237 if { input["y"] == 3 }
c238 if { input["f"] == false }
c239 if { c236; c237; c238 }
c240 if { input["x"] == 5 }
c241 if { input["y"] == 3 }
c242 if { input["f"] == true }
c243 if { c240; c241; c242 }
