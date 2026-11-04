package thesis

c0 if { true }
c1 if { input["action"] == "erase" }
c2 if { input["record_type"] == "transaction-record" }
c3 if { input["contains_pii"] == "true" }
c4 if { c1; c2; c3 }
rule_0 if { c4 }
c5 if { input["action"] == "erase" }
c6 if { input["record_type"] == "cdd-record" }
c7 if { input["contains_pii"] == "true" }
c8 if { input["legal_hold"] == "false" }
c9 if { c5; c6; c7; c8 }
rule_1 if { c9 }
c10 if { input["role"] == "data-subject" }
c11 if { input["action"] == "read" }
c12 if { input["record_type"] == "customer-file" }
c13 if { input["contains_pii"] == "true" }
c14 if { c10; c11; c12; c13 }
rule_2 if { c14 }
c15 if { input["role"] == "data-subject" }
c16 if { input["action"] == "read" }
c17 if { input["record_type"] == "kyc-file" }
c18 if { input["str_flag"] == "false" }
c19 if { c15; c16; c17; c18 }
rule_3 if { c19 }
c20 if { input["action"] == "log" }
c21 if { input["contains_pii"] == "true" }
c22 if { input["documented_purpose"] == "false" }
c23 if { c20; c21; c22 }
rule_4 if { c23 }
c24 if { input["action"] == "purge" }
c25 if { input["contains_pii"] == "true" }
c26 if { input["retention_age_years"] > 2 }
c27 if { c24; c25; c26 }
rule_5 if { c27 }
c28 if { input["action"] == "transmit" }
c29 if { input["contains_pii"] == "true" }
c30 if { input["legal_basis"] == "false" }
c31 if { c28; c29; c30 }
rule_6 if { c31 }
c32 if { input["action"] == "erase" }
c33 if { input["record_type"] == "transaction-record" }
c34 if { input["retention_age_years"] < 5 }
c35 if { c32; c33; c34 }
rule_7 if { c35 }
c36 if { input["action"] == "erase" }
c37 if { input["record_type"] == "cdd-record" }
c38 if { input["legal_hold"] == "true" }
c39 if { c36; c37; c38 }
rule_8 if { c39 }
c40 if { input["role"] == "data-subject" }
c41 if { input["action"] == "read" }
c42 if { input["record_type"] == "customer-file" }
c43 if { input["str_flag"] == "true" }
c44 if { c40; c41; c42; c43 }
rule_9 if { c44 }
c45 if { input["role"] == "data-subject" }
c46 if { input["action"] == "read" }
c47 if { input["record_type"] == "kyc-file" }
c48 if { input["str_flag"] == "true" }
c49 if { c45; c46; c47; c48 }
rule_10 if { c49 }
c50 if { input["role"] == "investigator" }
c51 if { input["action"] == "display-full-pan" }
c52 if { input["record_type"] == "cardholder-data" }
c53 if { c50; c51; c52 }
rule_11 if { c53 }
c54 if { input["role"] == "investigator" }
c55 if { input["action"] == "display-full-pan" }
c56 if { input["record_type"] == "payment-card-record" }
c57 if { input["legitimate_need"] == "true" }
c58 if { c54; c55; c56; c57 }
rule_12 if { c58 }
c59 if { input["action"] == "force-password-change" }
c60 if { input["record_type"] == "svc-credential" }
c61 if { input["sole_factor"] == "true" }
c62 if { c59; c60; c61 }
rule_13 if { c62 }
c63 if { input["action"] == "log" }
c64 if { input["record_type"] == "chd-access-event" }
c65 if { c63; c64 }
rule_14 if { c65 }
c66 if { input["action"] == "display-full-pan" }
c67 if { input["record_type"] == "cardholder-data" }
c68 if { c66; c67 }
rule_15 if { c68 }
c69 if { input["action"] == "display-full-pan" }
c70 if { input["record_type"] == "payment-card-record" }
c71 if { input["legitimate_need"] == "false" }
c72 if { c69; c70; c71 }
rule_16 if { c72 }
c73 if { input["action"] == "force-password-change" }
c74 if { input["record_type"] == "svc-credential" }
c75 if { input["sole_factor"] == "false" }
c76 if { c73; c74; c75 }
rule_17 if { c76 }
c77 if { input["action"] == "purge" }
c78 if { input["record_type"] == "audit-workpaper" }
c79 if { input["retention_age_years"] < 7 }
c80 if { c77; c78; c79 }
rule_18 if { c80 }
c81 if { input["action"] == "transmit" }
c82 if { input["record_type"] == "incident-report" }
c83 if { c81; c82 }
rule_19 if { c83 }
c84 if { input["action"] == "transmit" }
c85 if { input["record_type"] == "major-incident-report" }
c86 if { input["legal_basis"] == "true" }
c87 if { c84; c85; c86 }
rule_20 if { c87 }
c88 if { input["role"] == "hr-manager" }
c89 if { input["action"] == "read" }
c90 if { input["record_type"] == "leave-request" }
c91 if { c88; c89; c90 }
rule_21 if { c91 }
c92 if { input["role"] == "guest" }
c93 if { input["action"] == "write" }
c94 if { input["record_type"] == "system-config" }
c95 if { c92; c93; c94 }
rule_22 if { c95 }
c96 if { input["action"] == "erase" }
c97 if { input["record_type"] == "transaction-record" }
c98 if { input["retention_age_years"] < 5 }
c99 if { c96; c97; c98 }
c100 if { input["action"] == "erase" }
c101 if { input["record_type"] == "transaction-record" }
c102 if { input["contains_pii"] == "true" }
c103 if { input["retention_age_years"] >= 5 }
c104 if { c100; c101; c102; c103 }
c105 if { input["role"] == "data-subject" }
c106 if { input["action"] == "read" }
c107 if { input["record_type"] == "customer-file" }
c108 if { input["str_flag"] == "true" }
c109 if { c105; c106; c107; c108 }
c110 if { input["role"] == "data-subject" }
c111 if { input["action"] == "read" }
c112 if { input["record_type"] == "customer-file" }
c113 if { input["contains_pii"] == "true" }
c114 if { input["str_flag"] == "false" }
c115 if { c110; c111; c112; c113; c114 }
c116 if { input["role"] == "investigator" }
c117 if { input["action"] == "display-full-pan" }
c118 if { input["record_type"] == "cardholder-data" }
c119 if { c116; c117; c118 }
c120 if { input["action"] == "log" }
c121 if { input["record_type"] == "chd-access-event" }
c122 if { c120; c121 }
c123 if { input["action"] == "purge" }
c124 if { input["record_type"] == "audit-workpaper" }
c125 if { input["retention_age_years"] < 7 }
c126 if { c123; c124; c125 }
c127 if { input["action"] == "transmit" }
c128 if { input["record_type"] == "incident-report" }
c129 if { c127; c128 }
c130 if { input["role"] == "guest" }
c131 if { input["action"] == "write" }
c132 if { input["record_type"] == "system-config" }
c133 if { c130; c131; c132 }
