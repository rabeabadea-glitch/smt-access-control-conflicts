package thesis

valid if {
    is_object(input)
    count(input) == 4
    is_string(input["a_e232eb642850c70a"])
    input["a_e232eb642850c70a"] in {"kmarket-silver", "__OTHER__"}
    is_number(input["a_56d33ff3e4b7eebb"])
    input["a_56d33ff3e4b7eebb"] == floor(input["a_56d33ff3e4b7eebb"])
    input["a_56d33ff3e4b7eebb"] >= 499
    input["a_56d33ff3e4b7eebb"] <= 501
    is_string(input["a_343b8d05ea6a6c04"])
    input["a_343b8d05ea6a6c04"] in {"Drink", "Liquor", "Medicine", "__OTHER__"}
    is_number(input["a_8000bc4a22b7b38c"])
    input["a_8000bc4a22b7b38c"] == floor(input["a_8000bc4a22b7b38c"])
    input["a_8000bc4a22b7b38c"] >= 4
    input["a_8000bc4a22b7b38c"] <= 51
    c0
}

matched contains "total-amount" if { valid; rule_0 }
matched contains "deny-liquor" if { valid; rule_1 }
matched contains "max-drink-amount" if { valid; rule_2 }
matched contains "max-medicine-amount" if { valid; rule_3 }
matched contains "permit-rule" if { valid; rule_4 }
permit if { valid; rule_4 }
default permit := false
deny if { valid; rule_0 }
deny if { valid; rule_1 }
deny if { valid; rule_2 }
deny if { valid; rule_3 }
default deny := false

decision := "InvalidRequest" if { not valid }
decision := "Conflict" if { valid; permit; deny }
decision := "Permit" if { valid; permit; not deny }
decision := "Deny" if { valid; deny; not permit }
decision := "NotApplicable" if { valid; not permit; not deny }
allow := decision == "Permit"
result := {"decision": decision, "matched": sort(matched), "allow": allow}
