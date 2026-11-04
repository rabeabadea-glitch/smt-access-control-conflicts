package thesis

valid if {
    is_object(input)
    count(input) == 3
    is_boolean(input["p"])
    is_boolean(input["q"])
    is_boolean(input["r"])
    c0
}

matched contains "A_r1" if { valid; rule_0 }
matched contains "B_r1" if { valid; rule_1 }
matched contains "C_r1" if { valid; rule_2 }
matched contains "D_r1" if { valid; rule_3 }
permit if { valid; rule_0 }
permit if { valid; rule_2 }
default permit := false
deny if { valid; rule_1 }
deny if { valid; rule_3 }
default deny := false

decision := "InvalidRequest" if { not valid }
decision := "Conflict" if { valid; permit; deny }
decision := "Permit" if { valid; permit; not deny }
decision := "Deny" if { valid; deny; not permit }
decision := "NotApplicable" if { valid; not permit; not deny }
allow := decision == "Permit"
result := {"decision": decision, "matched": sort(matched), "allow": allow}
