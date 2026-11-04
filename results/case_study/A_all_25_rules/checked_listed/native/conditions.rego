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
c60 if { input["record_type"] == "credential" }
c61 if { input["password_age_days"] > 90 }
c62 if { c59; c60; c61 }
rule_13 if { c62 }
c63 if { input["action"] == "force-password-change" }
c64 if { input["record_type"] == "svc-credential" }
c65 if { input["sole_factor"] == "true" }
c66 if { c63; c64; c65 }
rule_14 if { c66 }
c67 if { input["action"] == "log" }
c68 if { input["record_type"] == "chd-access-event" }
c69 if { c67; c68 }
rule_15 if { c69 }
c70 if { input["action"] == "display-full-pan" }
c71 if { input["record_type"] == "cardholder-data" }
c72 if { c70; c71 }
rule_16 if { c72 }
c73 if { input["action"] == "display-full-pan" }
c74 if { input["record_type"] == "payment-card-record" }
c75 if { input["legitimate_need"] == "false" }
c76 if { c73; c74; c75 }
rule_17 if { c76 }
c77 if { input["action"] == "force-password-change" }
c78 if { input["record_type"] == "credential" }
c79 if { input["compromise_evidence"] == "false" }
c80 if { c77; c78; c79 }
rule_18 if { c80 }
c81 if { input["action"] == "force-password-change" }
c82 if { input["record_type"] == "svc-credential" }
c83 if { input["sole_factor"] == "false" }
c84 if { c81; c82; c83 }
rule_19 if { c84 }
c85 if { input["action"] == "purge" }
c86 if { input["record_type"] == "audit-workpaper" }
c87 if { input["retention_age_years"] < 7 }
c88 if { c85; c86; c87 }
rule_20 if { c88 }
c89 if { input["action"] == "transmit" }
c90 if { input["record_type"] == "incident-report" }
c91 if { c89; c90 }
rule_21 if { c91 }
c92 if { input["action"] == "transmit" }
c93 if { input["record_type"] == "major-incident-report" }
c94 if { input["legal_basis"] == "true" }
c95 if { c92; c93; c94 }
rule_22 if { c95 }
c96 if { input["role"] == "hr-manager" }
c97 if { input["action"] == "read" }
c98 if { input["record_type"] == "leave-request" }
c99 if { c96; c97; c98 }
rule_23 if { c99 }
c100 if { input["role"] == "guest" }
c101 if { input["action"] == "write" }
c102 if { input["record_type"] == "system-config" }
c103 if { c100; c101; c102 }
rule_24 if { c103 }
c104 if { input["action"] == "erase" }
c105 if { input["record_type"] == "transaction-record" }
c106 if { input["retention_age_years"] < 5 }
c107 if { c104; c105; c106 }
c108 if { input["action"] == "erase" }
c109 if { input["record_type"] == "transaction-record" }
c110 if { input["contains_pii"] == "true" }
c111 if { input["retention_age_years"] >= 5 }
c112 if { c108; c109; c110; c111 }
c113 if { input["role"] == "data-subject" }
c114 if { input["action"] == "read" }
c115 if { input["record_type"] == "customer-file" }
c116 if { input["str_flag"] == "true" }
c117 if { c113; c114; c115; c116 }
c118 if { input["role"] == "data-subject" }
c119 if { input["action"] == "read" }
c120 if { input["record_type"] == "customer-file" }
c121 if { input["contains_pii"] == "true" }
c122 if { input["str_flag"] == "false" }
c123 if { c118; c119; c120; c121; c122 }
c124 if { input["role"] == "investigator" }
c125 if { input["action"] == "display-full-pan" }
c126 if { input["record_type"] == "cardholder-data" }
c127 if { c124; c125; c126 }
c128 if { input["action"] == "log" }
c129 if { input["record_type"] == "chd-access-event" }
c130 if { c128; c129 }
c131 if { input["action"] == "purge" }
c132 if { input["record_type"] == "audit-workpaper" }
c133 if { input["retention_age_years"] < 7 }
c134 if { c131; c132; c133 }
c135 if { input["action"] == "transmit" }
c136 if { input["record_type"] == "incident-report" }
c137 if { c135; c136 }
c138 if { input["role"] == "guest" }
c139 if { input["action"] == "write" }
c140 if { input["record_type"] == "system-config" }
c141 if { c138; c139; c140 }
