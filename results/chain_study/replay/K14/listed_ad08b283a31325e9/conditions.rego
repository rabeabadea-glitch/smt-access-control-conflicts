package thesis

c0 if { true }
c1 if { input["x"] >= 2 }
c2 if { input["x"] <= 3 }
c3 if { input["y"] >= 0 }
c4 if { input["y"] <= 4 }
c5 if { c1; c2; c3; c4 }
c6 if { input["x"] >= 2 }
c7 if { input["x"] <= 4 }
c8 if { input["y"] >= 0 }
c9 if { input["y"] <= 2 }
c10 if { c6; c7; c8; c9 }
c11 if { not c10 }
c12 if { c5; c11 }
rule_0 if { c12 }
c13 if { input["x"] >= 4 }
c14 if { input["x"] <= 4 }
c15 if { input["y"] >= 1 }
c16 if { input["y"] <= 2 }
c17 if { c13; c14; c15; c16 }
rule_1 if { c17 }
c18 if { input["x"] >= 2 }
c19 if { input["x"] <= 4 }
c20 if { input["y"] >= 0 }
c21 if { input["y"] <= 2 }
c22 if { c18; c19; c20; c21 }
c23 if { input["x"] >= 4 }
c24 if { input["x"] <= 4 }
c25 if { input["y"] >= 1 }
c26 if { input["y"] <= 2 }
c27 if { c23; c24; c25; c26 }
c28 if { not c27 }
c29 if { c22; c28 }
c30 if { input["x"] >= 1 }
c31 if { input["x"] <= 3 }
c32 if { input["y"] >= 1 }
c33 if { input["y"] <= 3 }
c34 if { c30; c31; c32; c33 }
c35 if { not c34 }
c36 if { c29; c35 }
rule_2 if { c36 }
c37 if { input["x"] >= 4 }
c38 if { input["x"] <= 5 }
c39 if { input["y"] >= 3 }
c40 if { input["y"] <= 3 }
c41 if { input["f"] == true }
c42 if { c37; c38; c39; c40; c41 }
rule_3 if { c42 }
c43 if { input["x"] >= 1 }
c44 if { input["x"] <= 3 }
c45 if { input["y"] >= 1 }
c46 if { input["y"] <= 3 }
c47 if { c43; c44; c45; c46 }
rule_4 if { c47 }
c48 if { input["x"] == 1 }
c49 if { input["y"] == 1 }
c50 if { input["f"] == false }
c51 if { c48; c49; c50 }
c52 if { input["x"] == 1 }
c53 if { input["y"] == 1 }
c54 if { input["f"] == true }
c55 if { c52; c53; c54 }
c56 if { input["x"] == 1 }
c57 if { input["y"] == 2 }
c58 if { input["f"] == false }
c59 if { c56; c57; c58 }
c60 if { input["x"] == 1 }
c61 if { input["y"] == 2 }
c62 if { input["f"] == true }
c63 if { c60; c61; c62 }
c64 if { input["x"] == 1 }
c65 if { input["y"] == 3 }
c66 if { input["f"] == false }
c67 if { c64; c65; c66 }
c68 if { input["x"] == 1 }
c69 if { input["y"] == 3 }
c70 if { input["f"] == true }
c71 if { c68; c69; c70 }
c72 if { input["x"] == 2 }
c73 if { input["y"] == 0 }
c74 if { input["f"] == false }
c75 if { c72; c73; c74 }
c76 if { input["x"] == 2 }
c77 if { input["y"] == 0 }
c78 if { input["f"] == true }
c79 if { c76; c77; c78 }
c80 if { input["x"] == 2 }
c81 if { input["y"] == 1 }
c82 if { input["f"] == false }
c83 if { c80; c81; c82 }
c84 if { input["x"] == 2 }
c85 if { input["y"] == 1 }
c86 if { input["f"] == true }
c87 if { c84; c85; c86 }
c88 if { input["x"] == 2 }
c89 if { input["y"] == 2 }
c90 if { input["f"] == false }
c91 if { c88; c89; c90 }
c92 if { input["x"] == 2 }
c93 if { input["y"] == 2 }
c94 if { input["f"] == true }
c95 if { c92; c93; c94 }
c96 if { input["x"] == 2 }
c97 if { input["y"] == 3 }
c98 if { input["f"] == false }
c99 if { c96; c97; c98 }
c100 if { input["x"] == 2 }
c101 if { input["y"] == 3 }
c102 if { input["f"] == true }
c103 if { c100; c101; c102 }
c104 if { input["x"] == 2 }
c105 if { input["y"] == 4 }
c106 if { input["f"] == false }
c107 if { c104; c105; c106 }
c108 if { input["x"] == 2 }
c109 if { input["y"] == 4 }
c110 if { input["f"] == true }
c111 if { c108; c109; c110 }
c112 if { input["x"] == 3 }
c113 if { input["y"] == 0 }
c114 if { input["f"] == false }
c115 if { c112; c113; c114 }
c116 if { input["x"] == 3 }
c117 if { input["y"] == 0 }
c118 if { input["f"] == true }
c119 if { c116; c117; c118 }
c120 if { input["x"] == 3 }
c121 if { input["y"] == 1 }
c122 if { input["f"] == false }
c123 if { c120; c121; c122 }
c124 if { input["x"] == 3 }
c125 if { input["y"] == 1 }
c126 if { input["f"] == true }
c127 if { c124; c125; c126 }
c128 if { input["x"] == 3 }
c129 if { input["y"] == 2 }
c130 if { input["f"] == false }
c131 if { c128; c129; c130 }
c132 if { input["x"] == 3 }
c133 if { input["y"] == 2 }
c134 if { input["f"] == true }
c135 if { c132; c133; c134 }
c136 if { input["x"] == 3 }
c137 if { input["y"] == 3 }
c138 if { input["f"] == false }
c139 if { c136; c137; c138 }
c140 if { input["x"] == 3 }
c141 if { input["y"] == 3 }
c142 if { input["f"] == true }
c143 if { c140; c141; c142 }
c144 if { input["x"] == 3 }
c145 if { input["y"] == 4 }
c146 if { input["f"] == false }
c147 if { c144; c145; c146 }
c148 if { input["x"] == 3 }
c149 if { input["y"] == 4 }
c150 if { input["f"] == true }
c151 if { c148; c149; c150 }
c152 if { input["x"] == 4 }
c153 if { input["y"] == 0 }
c154 if { input["f"] == false }
c155 if { c152; c153; c154 }
c156 if { input["x"] == 4 }
c157 if { input["y"] == 0 }
c158 if { input["f"] == true }
c159 if { c156; c157; c158 }
c160 if { input["x"] == 4 }
c161 if { input["y"] == 1 }
c162 if { input["f"] == false }
c163 if { c160; c161; c162 }
c164 if { input["x"] == 4 }
c165 if { input["y"] == 1 }
c166 if { input["f"] == true }
c167 if { c164; c165; c166 }
c168 if { input["x"] == 4 }
c169 if { input["y"] == 2 }
c170 if { input["f"] == false }
c171 if { c168; c169; c170 }
c172 if { input["x"] == 4 }
c173 if { input["y"] == 2 }
c174 if { input["f"] == true }
c175 if { c172; c173; c174 }
c176 if { input["x"] == 4 }
c177 if { input["y"] == 3 }
c178 if { input["f"] == true }
c179 if { c176; c177; c178 }
c180 if { input["x"] == 5 }
c181 if { input["y"] == 3 }
c182 if { input["f"] == true }
c183 if { c180; c181; c182 }
