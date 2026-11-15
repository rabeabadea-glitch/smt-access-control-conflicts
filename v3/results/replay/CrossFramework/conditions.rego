package thesis

c0 if { true }
c1 if { input["a_eb7d4aff0b314c2a"] == "erase" }
c2 if { input["a_35d70cbe4d059037"] == "transaction-record" }
c3 if { input["a_06a19ef1cc65b3c0"] == "true" }
c4 if { c1; c2; c3 }
rule_0 if { c4 }
c5 if { input["a_eb7d4aff0b314c2a"] == "erase" }
c6 if { input["a_35d70cbe4d059037"] == "cdd-record" }
c7 if { input["a_06a19ef1cc65b3c0"] == "true" }
c8 if { input["a_27e42b437bca6fcd"] == "false" }
c9 if { c5; c6; c7; c8 }
rule_1 if { c9 }
c10 if { input["a_14d6618c55ea045b"] == "data-subject" }
c11 if { input["a_eb7d4aff0b314c2a"] == "read" }
c12 if { input["a_35d70cbe4d059037"] == "customer-file" }
c13 if { input["a_06a19ef1cc65b3c0"] == "true" }
c14 if { c10; c11; c12; c13 }
rule_2 if { c14 }
c15 if { input["a_14d6618c55ea045b"] == "data-subject" }
c16 if { input["a_eb7d4aff0b314c2a"] == "read" }
c17 if { input["a_35d70cbe4d059037"] == "kyc-file" }
c18 if { input["a_f84cff4964c93238"] == "false" }
c19 if { c15; c16; c17; c18 }
rule_3 if { c19 }
c20 if { input["a_eb7d4aff0b314c2a"] == "log" }
c21 if { input["a_06a19ef1cc65b3c0"] == "true" }
c22 if { input["a_7dd5994ca229e97c"] == "false" }
c23 if { c20; c21; c22 }
rule_4 if { c23 }
c24 if { input["a_eb7d4aff0b314c2a"] == "purge" }
c25 if { input["a_06a19ef1cc65b3c0"] == "true" }
c26 if { input["a_e6c971ef879983dd"] > 2 }
c27 if { c24; c25; c26 }
rule_5 if { c27 }
c28 if { input["a_eb7d4aff0b314c2a"] == "transmit" }
c29 if { input["a_06a19ef1cc65b3c0"] == "true" }
c30 if { input["a_0ad316ea2a75bf68"] == "false" }
c31 if { c28; c29; c30 }
rule_6 if { c31 }
c32 if { input["a_eb7d4aff0b314c2a"] == "erase" }
c33 if { input["a_35d70cbe4d059037"] == "transaction-record" }
c34 if { input["a_e6c971ef879983dd"] < 5 }
c35 if { c32; c33; c34 }
rule_7 if { c35 }
c36 if { input["a_eb7d4aff0b314c2a"] == "erase" }
c37 if { input["a_35d70cbe4d059037"] == "cdd-record" }
c38 if { input["a_27e42b437bca6fcd"] == "true" }
c39 if { c36; c37; c38 }
rule_8 if { c39 }
c40 if { input["a_14d6618c55ea045b"] == "data-subject" }
c41 if { input["a_eb7d4aff0b314c2a"] == "read" }
c42 if { input["a_35d70cbe4d059037"] == "customer-file" }
c43 if { input["a_f84cff4964c93238"] == "true" }
c44 if { c40; c41; c42; c43 }
rule_9 if { c44 }
c45 if { input["a_14d6618c55ea045b"] == "data-subject" }
c46 if { input["a_eb7d4aff0b314c2a"] == "read" }
c47 if { input["a_35d70cbe4d059037"] == "kyc-file" }
c48 if { input["a_f84cff4964c93238"] == "true" }
c49 if { c45; c46; c47; c48 }
rule_10 if { c49 }
c50 if { input["a_14d6618c55ea045b"] == "investigator" }
c51 if { input["a_eb7d4aff0b314c2a"] == "display-full-pan" }
c52 if { input["a_35d70cbe4d059037"] == "cardholder-data" }
c53 if { c50; c51; c52 }
rule_11 if { c53 }
c54 if { input["a_14d6618c55ea045b"] == "investigator" }
c55 if { input["a_eb7d4aff0b314c2a"] == "display-full-pan" }
c56 if { input["a_35d70cbe4d059037"] == "payment-card-record" }
c57 if { input["a_8ffbc5061a35b856"] == "true" }
c58 if { c54; c55; c56; c57 }
rule_12 if { c58 }
c59 if { input["a_eb7d4aff0b314c2a"] == "force-password-change" }
c60 if { input["a_35d70cbe4d059037"] == "credential" }
c61 if { input["a_4e4d26f3bc5318a0"] > 90 }
c62 if { c59; c60; c61 }
rule_13 if { c62 }
c63 if { input["a_eb7d4aff0b314c2a"] == "force-password-change" }
c64 if { input["a_35d70cbe4d059037"] == "svc-credential" }
c65 if { input["a_49bc3d106698b943"] == "true" }
c66 if { c63; c64; c65 }
rule_14 if { c66 }
c67 if { input["a_eb7d4aff0b314c2a"] == "log" }
c68 if { input["a_35d70cbe4d059037"] == "chd-access-event" }
c69 if { c67; c68 }
rule_15 if { c69 }
c70 if { input["a_eb7d4aff0b314c2a"] == "display-full-pan" }
c71 if { input["a_35d70cbe4d059037"] == "cardholder-data" }
c72 if { c70; c71 }
rule_16 if { c72 }
c73 if { input["a_eb7d4aff0b314c2a"] == "display-full-pan" }
c74 if { input["a_35d70cbe4d059037"] == "payment-card-record" }
c75 if { input["a_8ffbc5061a35b856"] == "false" }
c76 if { c73; c74; c75 }
rule_17 if { c76 }
c77 if { input["a_eb7d4aff0b314c2a"] == "force-password-change" }
c78 if { input["a_35d70cbe4d059037"] == "credential" }
c79 if { input["a_9eec283ff7a5e131"] == "false" }
c80 if { c77; c78; c79 }
rule_18 if { c80 }
c81 if { input["a_eb7d4aff0b314c2a"] == "force-password-change" }
c82 if { input["a_35d70cbe4d059037"] == "svc-credential" }
c83 if { input["a_49bc3d106698b943"] == "false" }
c84 if { c81; c82; c83 }
rule_19 if { c84 }
c85 if { input["a_eb7d4aff0b314c2a"] == "purge" }
c86 if { input["a_35d70cbe4d059037"] == "audit-workpaper" }
c87 if { input["a_e6c971ef879983dd"] < 7 }
c88 if { c85; c86; c87 }
rule_20 if { c88 }
c89 if { input["a_eb7d4aff0b314c2a"] == "transmit" }
c90 if { input["a_35d70cbe4d059037"] == "incident-report" }
c91 if { c89; c90 }
rule_21 if { c91 }
c92 if { input["a_eb7d4aff0b314c2a"] == "transmit" }
c93 if { input["a_35d70cbe4d059037"] == "major-incident-report" }
c94 if { input["a_0ad316ea2a75bf68"] == "true" }
c95 if { c92; c93; c94 }
rule_22 if { c95 }
c96 if { input["a_14d6618c55ea045b"] == "hr-manager" }
c97 if { input["a_eb7d4aff0b314c2a"] == "read" }
c98 if { input["a_35d70cbe4d059037"] == "leave-request" }
c99 if { c96; c97; c98 }
rule_23 if { c99 }
c100 if { input["a_14d6618c55ea045b"] == "guest" }
c101 if { input["a_eb7d4aff0b314c2a"] == "write" }
c102 if { input["a_35d70cbe4d059037"] == "system-config" }
c103 if { c100; c101; c102 }
rule_24 if { c103 }
