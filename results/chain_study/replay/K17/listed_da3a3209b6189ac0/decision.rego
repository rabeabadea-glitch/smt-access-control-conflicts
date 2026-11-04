package thesis

valid if {
    is_object(input)
    count(input) == 3
    is_number(input["x"])
    input["x"] == floor(input["x"])
    input["x"] >= 0
    input["x"] <= 5
    is_number(input["y"])
    input["y"] == floor(input["y"])
    input["y"] >= 0
    input["y"] <= 5
    is_boolean(input["f"])
    c0
}

matched contains "S3_r1" if { valid; rule_0 }
matched contains "S3_r2" if { valid; rule_1 }
matched contains "S2_r1" if { valid; rule_2 }
matched contains "S1_r1" if { valid; rule_3 }
matched contains "S1_r2" if { valid; rule_4 }
permit if { valid; rule_2 }
default permit := false
deny if { valid; rule_0 }
deny if { valid; rule_1 }
deny if { valid; rule_3 }
deny if { valid; rule_4 }
default deny := false

decision := "InvalidRequest" if { not valid }
decision := "Conflict" if { valid; permit; deny }
decision := "Permit" if { valid; permit; not deny }
decision := "Deny" if { valid; deny; not permit }
decision := "NotApplicable" if { valid; not permit; not deny }
allow := decision == "Permit"
result := {"decision": decision, "matched": sort(matched), "allow": allow}
