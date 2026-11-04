package thesis

valid if {
    is_object(input)
    count(input) == 4
    is_boolean(input["p"])
    is_boolean(input["q"])
    is_boolean(input["r"])
    is_boolean(input["s"])
    c0
}

matched contains "A_r1" if { valid; rule_0 }
matched contains "A_r2" if { valid; rule_1 }
matched contains "B_r1" if { valid; rule_2 }
matched contains "B_r2" if { valid; rule_3 }
matched contains "C_r1" if { valid; rule_4 }
matched contains "C_r2" if { valid; rule_5 }
matched contains "D_r1" if { valid; rule_6 }
matched contains "D_r2" if { valid; rule_7 }
permit if { valid; rule_0 }
permit if { valid; rule_2 }
permit if { valid; rule_4 }
permit if { valid; rule_6 }
default permit := false
deny if { valid; rule_1 }
deny if { valid; rule_3 }
deny if { valid; rule_5 }
deny if { valid; rule_7 }
default deny := false

decision := "InvalidRequest" if { not valid }
decision := "Conflict" if { valid; permit; deny }
decision := "Permit" if { valid; permit; not deny }
decision := "Deny" if { valid; deny; not permit }
decision := "NotApplicable" if { valid; not permit; not deny }
allow := decision == "Permit"
result := {"decision": decision, "matched": sort(matched), "allow": allow}
