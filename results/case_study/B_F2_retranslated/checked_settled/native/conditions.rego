package thesis

c0 if { true }
c1 if { input["action"] == "erase" }
c2 if { input["record_type"] == "transaction-record" }
c3 if { input["contains_pii"] == "true" }
c4 if { c1; c2; c3 }
c5 if { input["action"] == "erase" }
c6 if { input["record_type"] == "transaction-record" }
c7 if { input["retention_age_years"] < 5 }
c8 if { c5; c6; c7 }
c9 if { not c8 }
c10 if { c4; c9 }
rule_0 if { c10 }
c11 if { input["action"] == "erase" }
c12 if { input["record_type"] == "cdd-record" }
c13 if { input["contains_pii"] == "true" }
c14 if { input["legal_hold"] == "false" }
c15 if { c11; c12; c13; c14 }
rule_1 if { c15 }
c16 if { input["role"] == "data-subject" }
c17 if { input["action"] == "read" }
c18 if { input["record_type"] == "customer-file" }
c19 if { input["contains_pii"] == "true" }
c20 if { c16; c17; c18; c19 }
c21 if { input["role"] == "data-subject" }
c22 if { input["action"] == "read" }
c23 if { input["record_type"] == "customer-file" }
c24 if { input["str_flag"] == "true" }
c25 if { c21; c22; c23; c24 }
c26 if { not c25 }
c27 if { c20; c26 }
rule_2 if { c27 }
c28 if { input["role"] == "data-subject" }
c29 if { input["action"] == "read" }
c30 if { input["record_type"] == "kyc-file" }
c31 if { input["str_flag"] == "false" }
c32 if { c28; c29; c30; c31 }
rule_3 if { c32 }
c33 if { input["action"] == "log" }
c34 if { input["contains_pii"] == "true" }
c35 if { input["documented_purpose"] == "false" }
c36 if { c33; c34; c35 }
c37 if { input["action"] == "log" }
c38 if { input["record_type"] == "chd-access-event" }
c39 if { c37; c38 }
c40 if { not c39 }
c41 if { c36; c40 }
rule_4 if { c41 }
c42 if { input["action"] == "purge" }
c43 if { input["contains_pii"] == "true" }
c44 if { input["retention_age_years"] > 2 }
c45 if { c42; c43; c44 }
c46 if { input["action"] == "purge" }
c47 if { input["record_type"] == "audit-workpaper" }
c48 if { input["retention_age_years"] < 7 }
c49 if { c46; c47; c48 }
c50 if { not c49 }
c51 if { c45; c50 }
rule_5 if { c51 }
c52 if { input["action"] == "transmit" }
c53 if { input["contains_pii"] == "true" }
c54 if { input["legal_basis"] == "false" }
c55 if { c52; c53; c54 }
c56 if { input["action"] == "transmit" }
c57 if { input["record_type"] == "incident-report" }
c58 if { c56; c57 }
c59 if { not c58 }
c60 if { c55; c59 }
rule_6 if { c60 }
c61 if { input["action"] == "erase" }
c62 if { input["record_type"] == "transaction-record" }
c63 if { input["retention_age_years"] < 5 }
c64 if { c61; c62; c63 }
rule_7 if { c64 }
c65 if { input["action"] == "erase" }
c66 if { input["record_type"] == "cdd-record" }
c67 if { input["legal_hold"] == "true" }
c68 if { c65; c66; c67 }
rule_8 if { c68 }
c69 if { input["role"] == "data-subject" }
c70 if { input["action"] == "read" }
c71 if { input["record_type"] == "customer-file" }
c72 if { input["str_flag"] == "true" }
c73 if { c69; c70; c71; c72 }
rule_9 if { c73 }
c74 if { input["role"] == "data-subject" }
c75 if { input["action"] == "read" }
c76 if { input["record_type"] == "kyc-file" }
c77 if { input["str_flag"] == "true" }
c78 if { c74; c75; c76; c77 }
rule_10 if { c78 }
c79 if { input["role"] == "investigator" }
c80 if { input["action"] == "display-full-pan" }
c81 if { input["record_type"] == "cardholder-data" }
c82 if { c79; c80; c81 }
rule_11 if { c82 }
c83 if { input["role"] == "investigator" }
c84 if { input["action"] == "display-full-pan" }
c85 if { input["record_type"] == "payment-card-record" }
c86 if { input["legitimate_need"] == "true" }
c87 if { c83; c84; c85; c86 }
rule_12 if { c87 }
c88 if { input["action"] == "force-password-change" }
c89 if { input["record_type"] == "svc-credential" }
c90 if { input["sole_factor"] == "true" }
c91 if { c88; c89; c90 }
rule_13 if { c91 }
c92 if { input["action"] == "log" }
c93 if { input["record_type"] == "chd-access-event" }
c94 if { c92; c93 }
rule_14 if { c94 }
c95 if { input["action"] == "display-full-pan" }
c96 if { input["record_type"] == "cardholder-data" }
c97 if { c95; c96 }
c98 if { input["role"] == "investigator" }
c99 if { input["action"] == "display-full-pan" }
c100 if { input["record_type"] == "cardholder-data" }
c101 if { c98; c99; c100 }
c102 if { not c101 }
c103 if { c97; c102 }
rule_15 if { c103 }
c104 if { input["action"] == "display-full-pan" }
c105 if { input["record_type"] == "payment-card-record" }
c106 if { input["legitimate_need"] == "false" }
c107 if { c104; c105; c106 }
rule_16 if { c107 }
c108 if { input["action"] == "force-password-change" }
c109 if { input["record_type"] == "svc-credential" }
c110 if { input["sole_factor"] == "false" }
c111 if { c108; c109; c110 }
rule_17 if { c111 }
c112 if { input["action"] == "purge" }
c113 if { input["record_type"] == "audit-workpaper" }
c114 if { input["retention_age_years"] < 7 }
c115 if { c112; c113; c114 }
rule_18 if { c115 }
c116 if { input["action"] == "transmit" }
c117 if { input["record_type"] == "incident-report" }
c118 if { c116; c117 }
rule_19 if { c118 }
c119 if { input["action"] == "transmit" }
c120 if { input["record_type"] == "major-incident-report" }
c121 if { input["legal_basis"] == "true" }
c122 if { c119; c120; c121 }
rule_20 if { c122 }
c123 if { input["role"] == "hr-manager" }
c124 if { input["action"] == "read" }
c125 if { input["record_type"] == "leave-request" }
c126 if { c123; c124; c125 }
rule_21 if { c126 }
c127 if { input["role"] == "guest" }
c128 if { input["action"] == "write" }
c129 if { input["record_type"] == "system-config" }
c130 if { c127; c128; c129 }
rule_22 if { c130 }
c131 if { input["action"] == "erase" }
c132 if { input["record_type"] == "transaction-record" }
c133 if { input["retention_age_years"] < 5 }
c134 if { c131; c132; c133 }
c135 if { input["action"] == "erase" }
c136 if { input["record_type"] == "transaction-record" }
c137 if { input["contains_pii"] == "true" }
c138 if { input["retention_age_years"] >= 5 }
c139 if { c135; c136; c137; c138 }
c140 if { input["role"] == "data-subject" }
c141 if { input["action"] == "read" }
c142 if { input["record_type"] == "customer-file" }
c143 if { input["str_flag"] == "true" }
c144 if { c140; c141; c142; c143 }
c145 if { input["role"] == "data-subject" }
c146 if { input["action"] == "read" }
c147 if { input["record_type"] == "customer-file" }
c148 if { input["contains_pii"] == "true" }
c149 if { input["str_flag"] == "false" }
c150 if { c145; c146; c147; c148; c149 }
c151 if { input["role"] == "investigator" }
c152 if { input["action"] == "display-full-pan" }
c153 if { input["record_type"] == "cardholder-data" }
c154 if { c151; c152; c153 }
c155 if { input["action"] == "log" }
c156 if { input["record_type"] == "chd-access-event" }
c157 if { c155; c156 }
c158 if { input["action"] == "purge" }
c159 if { input["record_type"] == "audit-workpaper" }
c160 if { input["retention_age_years"] < 7 }
c161 if { c158; c159; c160 }
c162 if { input["action"] == "transmit" }
c163 if { input["record_type"] == "incident-report" }
c164 if { c162; c163 }
c165 if { input["role"] == "guest" }
c166 if { input["action"] == "write" }
c167 if { input["record_type"] == "system-config" }
c168 if { c165; c166; c167 }
