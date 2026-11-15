package thesis

c0 if { true }
c1 if { input["a_e232eb642850c70a"] == "kmarket-silver" }
c2 if { input["a_56d33ff3e4b7eebb"] > 500 }
c3 if { c1; c2 }
rule_0 if { c3 }
c4 if { input["a_e232eb642850c70a"] == "kmarket-silver" }
c5 if { input["a_343b8d05ea6a6c04"] == "Liquor" }
c6 if { c4; c5 }
rule_1 if { c6 }
c7 if { input["a_e232eb642850c70a"] == "kmarket-silver" }
c8 if { input["a_343b8d05ea6a6c04"] == "Drink" }
c9 if { input["a_8000bc4a22b7b38c"] > 50 }
c10 if { c7; c8; c9 }
rule_2 if { c10 }
c11 if { input["a_e232eb642850c70a"] == "kmarket-silver" }
c12 if { input["a_343b8d05ea6a6c04"] == "Medicine" }
c13 if { input["a_8000bc4a22b7b38c"] > 5 }
c14 if { c11; c12; c13 }
rule_3 if { c14 }
c15 if { input["a_e232eb642850c70a"] == "kmarket-silver" }
rule_4 if { c15 }
