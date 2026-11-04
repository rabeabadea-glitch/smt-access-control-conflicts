package thesis

valid if {
    is_object(input)
    count(input) == 4
    is_string(input["a_d7cf2252c0c3cd95"])
    input["a_d7cf2252c0c3cd95"] in {"kmarket-silver", "__OTHER__"}
    is_number(input["a_b053dc07ffefa334"])
    input["a_b053dc07ffefa334"] == floor(input["a_b053dc07ffefa334"])
    input["a_b053dc07ffefa334"] >= 499
    input["a_b053dc07ffefa334"] <= 501
    is_string(input["a_69e8e3c2477e0180"])
    input["a_69e8e3c2477e0180"] in {"Drink", "Liquor", "Medicine", "__OTHER__"}
    is_number(input["a_b1ed0c665eccdc45"])
    input["a_b1ed0c665eccdc45"] == floor(input["a_b1ed0c665eccdc45"])
    input["a_b1ed0c665eccdc45"] >= 4
    input["a_b1ed0c665eccdc45"] <= 51
    c0
}

matched contains "sample-kmarket-policy-set::Permit" if { valid; rule_0 }
matched contains "sample-kmarket-policy-set::Deny" if { valid; rule_1 }
permit if { valid; rule_0 }
default permit := false
deny if { valid; rule_1 }
default deny := false

decision := "InvalidRequest" if { not valid }
decision := "Conflict" if { valid; permit; deny }
decision := "Permit" if { valid; permit; not deny }
decision := "Deny" if { valid; deny; not permit }
decision := "NotApplicable" if { valid; not permit; not deny }
allow := decision == "Permit"
result := {"decision": decision, "matched": sort(matched), "allow": allow}
