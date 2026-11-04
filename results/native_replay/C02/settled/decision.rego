package thesis

valid if {
    is_object(input)
    count(input) == 6
    is_boolean(input["p"])
    is_boolean(input["q"])
    is_boolean(input["r"])
    is_boolean(input["s"])
    is_boolean(input["t"])
    is_boolean(input["u"])
    c0
}

matched contains "urn:challenge:A::Permit" if { valid; rule_0 }
matched contains "urn:challenge:A::Deny" if { valid; rule_1 }
matched contains "urn:challenge:B::Permit" if { valid; rule_2 }
matched contains "urn:challenge:B::Deny" if { valid; rule_3 }
matched contains "urn:challenge:C::Permit" if { valid; rule_4 }
matched contains "urn:challenge:C::Deny" if { valid; rule_5 }
matched contains "D_r1" if { valid; rule_6 }
matched contains "D_r2" if { valid; rule_7 }
matched contains "D_r3" if { valid; rule_8 }
matched contains "D_r4" if { valid; rule_9 }
matched contains "E_r1" if { valid; rule_10 }
matched contains "E_r2" if { valid; rule_11 }
matched contains "E_r3" if { valid; rule_12 }
matched contains "E_r4" if { valid; rule_13 }
matched contains "F_r1" if { valid; rule_14 }
matched contains "F_r2" if { valid; rule_15 }
matched contains "F_r3" if { valid; rule_16 }
matched contains "F_r4" if { valid; rule_17 }
permit if { valid; rule_0 }
permit if { valid; rule_2 }
permit if { valid; rule_4 }
permit if { valid; rule_6 }
permit if { valid; rule_9 }
permit if { valid; rule_11 }
permit if { valid; rule_12 }
permit if { valid; rule_14 }
permit if { valid; rule_17 }
default permit := false
deny if { valid; rule_1 }
deny if { valid; rule_3 }
deny if { valid; rule_5 }
deny if { valid; rule_7 }
deny if { valid; rule_8 }
deny if { valid; rule_10 }
deny if { valid; rule_13 }
deny if { valid; rule_15 }
deny if { valid; rule_16 }
default deny := false

decision := "InvalidRequest" if { not valid }
decision := "Conflict" if { valid; permit; deny }
decision := "Permit" if { valid; permit; not deny }
decision := "Deny" if { valid; deny; not permit }
decision := "NotApplicable" if { valid; not permit; not deny }
allow := decision == "Permit"
result := {"decision": decision, "matched": sort(matched), "allow": allow}
