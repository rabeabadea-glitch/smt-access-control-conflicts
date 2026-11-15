package thesis

valid if {
    is_object(input)
    count(input) == 13
    is_string(input["a_eb7d4aff0b314c2a"])
    input["a_eb7d4aff0b314c2a"] in {"display-full-pan", "erase", "force-password-change", "log", "purge", "read", "transmit", "write", "__OTHER__"}
    is_string(input["a_35d70cbe4d059037"])
    input["a_35d70cbe4d059037"] in {"audit-workpaper", "cardholder-data", "cdd-record", "chd-access-event", "credential", "customer-file", "incident-report", "kyc-file", "leave-request", "major-incident-report", "payment-card-record", "svc-credential", "system-config", "transaction-record", "__OTHER__"}
    is_string(input["a_06a19ef1cc65b3c0"])
    input["a_06a19ef1cc65b3c0"] in {"true", "__OTHER__"}
    is_string(input["a_27e42b437bca6fcd"])
    input["a_27e42b437bca6fcd"] in {"false", "true", "__OTHER__"}
    is_string(input["a_14d6618c55ea045b"])
    input["a_14d6618c55ea045b"] in {"data-subject", "guest", "hr-manager", "investigator", "__OTHER__"}
    is_string(input["a_f84cff4964c93238"])
    input["a_f84cff4964c93238"] in {"false", "true", "__OTHER__"}
    is_string(input["a_7dd5994ca229e97c"])
    input["a_7dd5994ca229e97c"] in {"false", "__OTHER__"}
    is_number(input["a_e6c971ef879983dd"])
    input["a_e6c971ef879983dd"] == floor(input["a_e6c971ef879983dd"])
    input["a_e6c971ef879983dd"] >= 1
    input["a_e6c971ef879983dd"] <= 8
    is_string(input["a_0ad316ea2a75bf68"])
    input["a_0ad316ea2a75bf68"] in {"false", "true", "__OTHER__"}
    is_string(input["a_8ffbc5061a35b856"])
    input["a_8ffbc5061a35b856"] in {"false", "true", "__OTHER__"}
    is_number(input["a_4e4d26f3bc5318a0"])
    input["a_4e4d26f3bc5318a0"] == floor(input["a_4e4d26f3bc5318a0"])
    input["a_4e4d26f3bc5318a0"] >= 89
    input["a_4e4d26f3bc5318a0"] <= 91
    is_string(input["a_49bc3d106698b943"])
    input["a_49bc3d106698b943"] in {"false", "true", "__OTHER__"}
    is_string(input["a_9eec283ff7a5e131"])
    input["a_9eec283ff7a5e131"] in {"false", "__OTHER__"}
    c0
}

matched contains "GDPR-17-erase-ungoverned" if { valid; rule_0 }
matched contains "GDPR-17-erase-governed" if { valid; rule_1 }
matched contains "GDPR-15-subject-access-ungoverned" if { valid; rule_2 }
matched contains "GDPR-15-subject-access-governed" if { valid; rule_3 }
matched contains "GDPR-5c-minimisation" if { valid; rule_4 }
matched contains "GDPR-5e-storage-purge" if { valid; rule_5 }
matched contains "GDPR-6-restrict-transfer-ungoverned" if { valid; rule_6 }
matched contains "AMLD-40-retain-txn" if { valid; rule_7 }
matched contains "AMLD-40-retain-cdd-governed" if { valid; rule_8 }
matched contains "AMLD-39-tipping-off" if { valid; rule_9 }
matched contains "AMLD-39-tipping-off-governed" if { valid; rule_10 }
matched contains "AMLD-investigator-full-pan" if { valid; rule_11 }
matched contains "AMLD-investigator-full-pan-governed" if { valid; rule_12 }
matched contains "PCI-8-3-9-rotate-password" if { valid; rule_13 }
matched contains "PCI-8-3-9-rotate-password-governed" if { valid; rule_14 }
matched contains "PCI-10-2-log-access" if { valid; rule_15 }
matched contains "PCI-3-3-mask-pan" if { valid; rule_16 }
matched contains "PCI-3-3-mask-pan-governed" if { valid; rule_17 }
matched contains "NIST-63B-no-forced-rotation" if { valid; rule_18 }
matched contains "NIST-63B-no-forced-rotation-governed" if { valid; rule_19 }
matched contains "SOX-802-retain-audit" if { valid; rule_20 }
matched contains "DORA-19-report-incident" if { valid; rule_21 }
matched contains "DORA-19-report-incident-governed" if { valid; rule_22 }
matched contains "INT-hr-view-leave" if { valid; rule_23 }
matched contains "INT-deny-guest-write-config" if { valid; rule_24 }
permit if { valid; rule_0 }
permit if { valid; rule_1 }
permit if { valid; rule_2 }
permit if { valid; rule_3 }
permit if { valid; rule_5 }
permit if { valid; rule_11 }
permit if { valid; rule_12 }
permit if { valid; rule_13 }
permit if { valid; rule_14 }
permit if { valid; rule_15 }
permit if { valid; rule_21 }
permit if { valid; rule_22 }
permit if { valid; rule_23 }
default permit := false
deny if { valid; rule_4 }
deny if { valid; rule_6 }
deny if { valid; rule_7 }
deny if { valid; rule_8 }
deny if { valid; rule_9 }
deny if { valid; rule_10 }
deny if { valid; rule_16 }
deny if { valid; rule_17 }
deny if { valid; rule_18 }
deny if { valid; rule_19 }
deny if { valid; rule_20 }
deny if { valid; rule_24 }
default deny := false

decision := "InvalidRequest" if { not valid }
decision := "Conflict" if { valid; permit; deny }
decision := "Permit" if { valid; permit; not deny }
decision := "Deny" if { valid; deny; not permit }
decision := "NotApplicable" if { valid; not permit; not deny }
allow := decision == "Permit"
result := {"decision": decision, "matched": sort(matched), "allow": allow}
