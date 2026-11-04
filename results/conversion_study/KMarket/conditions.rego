package thesis

c0 if { true }
c1 if { input["a_d7cf2252c0c3cd95"] == "kmarket-silver" }
c2 if { input["a_b053dc07ffefa334"] > 500 }
c3 if { input["a_69e8e3c2477e0180"] == "Liquor" }
c4 if { input["a_69e8e3c2477e0180"] == "Drink" }
c5 if { input["a_b1ed0c665eccdc45"] > 50 }
c6 if { c4; c5 }
c7 if { input["a_69e8e3c2477e0180"] == "Medicine" }
c8 if { input["a_b1ed0c665eccdc45"] > 5 }
c9 if { c7; c8 }
c10 if { c2 }
c10 if { c3 }
c10 if { c6 }
c10 if { c9 }
c11 if { not c10 }
c12 if { c1; c11 }
rule_0 if { c12 }
c13 if { input["a_d7cf2252c0c3cd95"] == "kmarket-silver" }
c14 if { input["a_b053dc07ffefa334"] > 500 }
c15 if { input["a_69e8e3c2477e0180"] == "Liquor" }
c16 if { input["a_69e8e3c2477e0180"] == "Drink" }
c17 if { input["a_b1ed0c665eccdc45"] > 50 }
c18 if { c16; c17 }
c19 if { input["a_69e8e3c2477e0180"] == "Medicine" }
c20 if { input["a_b1ed0c665eccdc45"] > 5 }
c21 if { c19; c20 }
c22 if { c14 }
c22 if { c15 }
c22 if { c18 }
c22 if { c21 }
c23 if { c13; c22 }
rule_1 if { c23 }
