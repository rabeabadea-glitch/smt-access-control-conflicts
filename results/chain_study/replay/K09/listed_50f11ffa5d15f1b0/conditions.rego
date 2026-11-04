package thesis

c0 if { true }
c1 if { input["x"] >= 0 }
c2 if { input["x"] <= 4 }
c3 if { input["y"] >= 3 }
c4 if { input["y"] <= 3 }
c5 if { c1; c2; c3; c4 }
rule_0 if { c5 }
c6 if { input["x"] >= 2 }
c7 if { input["x"] <= 3 }
c8 if { input["y"] >= 1 }
c9 if { input["y"] <= 2 }
c10 if { c6; c7; c8; c9 }
c11 if { input["x"] >= 1 }
c12 if { input["x"] <= 2 }
c13 if { input["y"] >= 0 }
c14 if { input["y"] <= 2 }
c15 if { c11; c12; c13; c14 }
c16 if { not c15 }
c17 if { c10; c16 }
rule_1 if { c17 }
c18 if { input["x"] >= 1 }
c19 if { input["x"] <= 2 }
c20 if { input["y"] >= 0 }
c21 if { input["y"] <= 2 }
c22 if { c18; c19; c20; c21 }
rule_2 if { c22 }
c23 if { input["x"] >= 0 }
c24 if { input["x"] <= 3 }
c25 if { input["y"] >= 1 }
c26 if { input["y"] <= 4 }
c27 if { c23; c24; c25; c26 }
c28 if { input["x"] >= 0 }
c29 if { input["x"] <= 4 }
c30 if { input["y"] >= 3 }
c31 if { input["y"] <= 3 }
c32 if { c28; c29; c30; c31 }
c33 if { not c32 }
c34 if { c27; c33 }
c35 if { input["x"] >= 2 }
c36 if { input["x"] <= 3 }
c37 if { input["y"] >= 1 }
c38 if { input["y"] <= 2 }
c39 if { c35; c36; c37; c38 }
c40 if { input["x"] >= 1 }
c41 if { input["x"] <= 2 }
c42 if { input["y"] >= 0 }
c43 if { input["y"] <= 2 }
c44 if { c40; c41; c42; c43 }
c45 if { not c44 }
c46 if { c39; c45 }
c47 if { not c46 }
c48 if { c34; c47 }
rule_3 if { c48 }
c49 if { input["x"] == 0 }
c50 if { input["y"] == 1 }
c51 if { input["f"] == false }
c52 if { c49; c50; c51 }
c53 if { input["x"] == 0 }
c54 if { input["y"] == 1 }
c55 if { input["f"] == true }
c56 if { c53; c54; c55 }
c57 if { input["x"] == 0 }
c58 if { input["y"] == 2 }
c59 if { input["f"] == false }
c60 if { c57; c58; c59 }
c61 if { input["x"] == 0 }
c62 if { input["y"] == 2 }
c63 if { input["f"] == true }
c64 if { c61; c62; c63 }
c65 if { input["x"] == 0 }
c66 if { input["y"] == 3 }
c67 if { input["f"] == false }
c68 if { c65; c66; c67 }
c69 if { input["x"] == 0 }
c70 if { input["y"] == 3 }
c71 if { input["f"] == true }
c72 if { c69; c70; c71 }
c73 if { input["x"] == 0 }
c74 if { input["y"] == 4 }
c75 if { input["f"] == false }
c76 if { c73; c74; c75 }
c77 if { input["x"] == 0 }
c78 if { input["y"] == 4 }
c79 if { input["f"] == true }
c80 if { c77; c78; c79 }
c81 if { input["x"] == 1 }
c82 if { input["y"] == 0 }
c83 if { input["f"] == false }
c84 if { c81; c82; c83 }
c85 if { input["x"] == 1 }
c86 if { input["y"] == 0 }
c87 if { input["f"] == true }
c88 if { c85; c86; c87 }
c89 if { input["x"] == 1 }
c90 if { input["y"] == 1 }
c91 if { input["f"] == false }
c92 if { c89; c90; c91 }
c93 if { input["x"] == 1 }
c94 if { input["y"] == 1 }
c95 if { input["f"] == true }
c96 if { c93; c94; c95 }
c97 if { input["x"] == 1 }
c98 if { input["y"] == 2 }
c99 if { input["f"] == false }
c100 if { c97; c98; c99 }
c101 if { input["x"] == 1 }
c102 if { input["y"] == 2 }
c103 if { input["f"] == true }
c104 if { c101; c102; c103 }
c105 if { input["x"] == 1 }
c106 if { input["y"] == 3 }
c107 if { input["f"] == false }
c108 if { c105; c106; c107 }
c109 if { input["x"] == 1 }
c110 if { input["y"] == 3 }
c111 if { input["f"] == true }
c112 if { c109; c110; c111 }
c113 if { input["x"] == 1 }
c114 if { input["y"] == 4 }
c115 if { input["f"] == false }
c116 if { c113; c114; c115 }
c117 if { input["x"] == 1 }
c118 if { input["y"] == 4 }
c119 if { input["f"] == true }
c120 if { c117; c118; c119 }
c121 if { input["x"] == 2 }
c122 if { input["y"] == 0 }
c123 if { input["f"] == false }
c124 if { c121; c122; c123 }
c125 if { input["x"] == 2 }
c126 if { input["y"] == 0 }
c127 if { input["f"] == true }
c128 if { c125; c126; c127 }
c129 if { input["x"] == 2 }
c130 if { input["y"] == 1 }
c131 if { input["f"] == false }
c132 if { c129; c130; c131 }
c133 if { input["x"] == 2 }
c134 if { input["y"] == 1 }
c135 if { input["f"] == true }
c136 if { c133; c134; c135 }
c137 if { input["x"] == 2 }
c138 if { input["y"] == 2 }
c139 if { input["f"] == false }
c140 if { c137; c138; c139 }
c141 if { input["x"] == 2 }
c142 if { input["y"] == 2 }
c143 if { input["f"] == true }
c144 if { c141; c142; c143 }
c145 if { input["x"] == 2 }
c146 if { input["y"] == 3 }
c147 if { input["f"] == false }
c148 if { c145; c146; c147 }
c149 if { input["x"] == 2 }
c150 if { input["y"] == 3 }
c151 if { input["f"] == true }
c152 if { c149; c150; c151 }
c153 if { input["x"] == 2 }
c154 if { input["y"] == 4 }
c155 if { input["f"] == false }
c156 if { c153; c154; c155 }
c157 if { input["x"] == 2 }
c158 if { input["y"] == 4 }
c159 if { input["f"] == true }
c160 if { c157; c158; c159 }
c161 if { input["x"] == 3 }
c162 if { input["y"] == 1 }
c163 if { input["f"] == false }
c164 if { c161; c162; c163 }
c165 if { input["x"] == 3 }
c166 if { input["y"] == 1 }
c167 if { input["f"] == true }
c168 if { c165; c166; c167 }
c169 if { input["x"] == 3 }
c170 if { input["y"] == 2 }
c171 if { input["f"] == false }
c172 if { c169; c170; c171 }
c173 if { input["x"] == 3 }
c174 if { input["y"] == 2 }
c175 if { input["f"] == true }
c176 if { c173; c174; c175 }
c177 if { input["x"] == 3 }
c178 if { input["y"] == 3 }
c179 if { input["f"] == false }
c180 if { c177; c178; c179 }
c181 if { input["x"] == 3 }
c182 if { input["y"] == 3 }
c183 if { input["f"] == true }
c184 if { c181; c182; c183 }
c185 if { input["x"] == 3 }
c186 if { input["y"] == 4 }
c187 if { input["f"] == false }
c188 if { c185; c186; c187 }
c189 if { input["x"] == 3 }
c190 if { input["y"] == 4 }
c191 if { input["f"] == true }
c192 if { c189; c190; c191 }
c193 if { input["x"] == 4 }
c194 if { input["y"] == 3 }
c195 if { input["f"] == false }
c196 if { c193; c194; c195 }
c197 if { input["x"] == 4 }
c198 if { input["y"] == 3 }
c199 if { input["f"] == true }
c200 if { c197; c198; c199 }
