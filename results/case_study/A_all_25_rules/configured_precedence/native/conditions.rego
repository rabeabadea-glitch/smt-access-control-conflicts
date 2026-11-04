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
c9 if { input["action"] == "erase" }
c10 if { input["record_type"] == "cdd-record" }
c11 if { input["legal_hold"] == "true" }
c12 if { c9; c10; c11 }
c13 if { input["role"] == "data-subject" }
c14 if { input["action"] == "read" }
c15 if { input["record_type"] == "customer-file" }
c16 if { input["str_flag"] == "true" }
c17 if { c13; c14; c15; c16 }
c18 if { input["role"] == "data-subject" }
c19 if { input["action"] == "read" }
c20 if { input["record_type"] == "kyc-file" }
c21 if { input["str_flag"] == "true" }
c22 if { c18; c19; c20; c21 }
c23 if { input["role"] == "investigator" }
c24 if { input["action"] == "display-full-pan" }
c25 if { input["record_type"] == "cardholder-data" }
c26 if { c23; c24; c25 }
c27 if { input["role"] == "investigator" }
c28 if { input["action"] == "display-full-pan" }
c29 if { input["record_type"] == "payment-card-record" }
c30 if { input["legitimate_need"] == "true" }
c31 if { c27; c28; c29; c30 }
c32 if { input["action"] == "force-password-change" }
c33 if { input["record_type"] == "credential" }
c34 if { input["password_age_days"] > 90 }
c35 if { c32; c33; c34 }
c36 if { input["action"] == "force-password-change" }
c37 if { input["record_type"] == "svc-credential" }
c38 if { input["sole_factor"] == "true" }
c39 if { c36; c37; c38 }
c40 if { input["action"] == "log" }
c41 if { input["record_type"] == "chd-access-event" }
c42 if { c40; c41 }
c43 if { input["action"] == "display-full-pan" }
c44 if { input["record_type"] == "cardholder-data" }
c45 if { c43; c44 }
c46 if { input["action"] == "display-full-pan" }
c47 if { input["record_type"] == "payment-card-record" }
c48 if { input["legitimate_need"] == "false" }
c49 if { c46; c47; c48 }
c50 if { input["action"] == "purge" }
c51 if { input["record_type"] == "audit-workpaper" }
c52 if { input["retention_age_years"] < 7 }
c53 if { c50; c51; c52 }
c54 if { input["action"] == "transmit" }
c55 if { input["record_type"] == "incident-report" }
c56 if { c54; c55 }
c57 if { input["action"] == "transmit" }
c58 if { input["record_type"] == "major-incident-report" }
c59 if { input["legal_basis"] == "true" }
c60 if { c57; c58; c59 }
c61 if { c8 }
c61 if { c12 }
c61 if { c17 }
c61 if { c22 }
c61 if { c26 }
c61 if { c31 }
c61 if { c35 }
c61 if { c39 }
c61 if { c42 }
c61 if { c45 }
c61 if { c49 }
c61 if { c53 }
c61 if { c56 }
c61 if { c60 }
c62 if { not c61 }
c63 if { c4; c62 }
rule_0 if { c63 }
c64 if { input["action"] == "erase" }
c65 if { input["record_type"] == "cdd-record" }
c66 if { input["contains_pii"] == "true" }
c67 if { input["legal_hold"] == "false" }
c68 if { c64; c65; c66; c67 }
c69 if { input["action"] == "erase" }
c70 if { input["record_type"] == "transaction-record" }
c71 if { input["retention_age_years"] < 5 }
c72 if { c69; c70; c71 }
c73 if { input["action"] == "erase" }
c74 if { input["record_type"] == "cdd-record" }
c75 if { input["legal_hold"] == "true" }
c76 if { c73; c74; c75 }
c77 if { input["role"] == "data-subject" }
c78 if { input["action"] == "read" }
c79 if { input["record_type"] == "customer-file" }
c80 if { input["str_flag"] == "true" }
c81 if { c77; c78; c79; c80 }
c82 if { input["role"] == "data-subject" }
c83 if { input["action"] == "read" }
c84 if { input["record_type"] == "kyc-file" }
c85 if { input["str_flag"] == "true" }
c86 if { c82; c83; c84; c85 }
c87 if { input["role"] == "investigator" }
c88 if { input["action"] == "display-full-pan" }
c89 if { input["record_type"] == "cardholder-data" }
c90 if { c87; c88; c89 }
c91 if { input["role"] == "investigator" }
c92 if { input["action"] == "display-full-pan" }
c93 if { input["record_type"] == "payment-card-record" }
c94 if { input["legitimate_need"] == "true" }
c95 if { c91; c92; c93; c94 }
c96 if { input["action"] == "force-password-change" }
c97 if { input["record_type"] == "credential" }
c98 if { input["password_age_days"] > 90 }
c99 if { c96; c97; c98 }
c100 if { input["action"] == "force-password-change" }
c101 if { input["record_type"] == "svc-credential" }
c102 if { input["sole_factor"] == "true" }
c103 if { c100; c101; c102 }
c104 if { input["action"] == "log" }
c105 if { input["record_type"] == "chd-access-event" }
c106 if { c104; c105 }
c107 if { input["action"] == "display-full-pan" }
c108 if { input["record_type"] == "cardholder-data" }
c109 if { c107; c108 }
c110 if { input["action"] == "display-full-pan" }
c111 if { input["record_type"] == "payment-card-record" }
c112 if { input["legitimate_need"] == "false" }
c113 if { c110; c111; c112 }
c114 if { input["action"] == "purge" }
c115 if { input["record_type"] == "audit-workpaper" }
c116 if { input["retention_age_years"] < 7 }
c117 if { c114; c115; c116 }
c118 if { input["action"] == "transmit" }
c119 if { input["record_type"] == "incident-report" }
c120 if { c118; c119 }
c121 if { input["action"] == "transmit" }
c122 if { input["record_type"] == "major-incident-report" }
c123 if { input["legal_basis"] == "true" }
c124 if { c121; c122; c123 }
c125 if { c72 }
c125 if { c76 }
c125 if { c81 }
c125 if { c86 }
c125 if { c90 }
c125 if { c95 }
c125 if { c99 }
c125 if { c103 }
c125 if { c106 }
c125 if { c109 }
c125 if { c113 }
c125 if { c117 }
c125 if { c120 }
c125 if { c124 }
c126 if { not c125 }
c127 if { c68; c126 }
rule_1 if { c127 }
c128 if { input["role"] == "data-subject" }
c129 if { input["action"] == "read" }
c130 if { input["record_type"] == "customer-file" }
c131 if { input["contains_pii"] == "true" }
c132 if { c128; c129; c130; c131 }
c133 if { input["action"] == "erase" }
c134 if { input["record_type"] == "transaction-record" }
c135 if { input["retention_age_years"] < 5 }
c136 if { c133; c134; c135 }
c137 if { input["action"] == "erase" }
c138 if { input["record_type"] == "cdd-record" }
c139 if { input["legal_hold"] == "true" }
c140 if { c137; c138; c139 }
c141 if { input["role"] == "data-subject" }
c142 if { input["action"] == "read" }
c143 if { input["record_type"] == "customer-file" }
c144 if { input["str_flag"] == "true" }
c145 if { c141; c142; c143; c144 }
c146 if { input["role"] == "data-subject" }
c147 if { input["action"] == "read" }
c148 if { input["record_type"] == "kyc-file" }
c149 if { input["str_flag"] == "true" }
c150 if { c146; c147; c148; c149 }
c151 if { input["role"] == "investigator" }
c152 if { input["action"] == "display-full-pan" }
c153 if { input["record_type"] == "cardholder-data" }
c154 if { c151; c152; c153 }
c155 if { input["role"] == "investigator" }
c156 if { input["action"] == "display-full-pan" }
c157 if { input["record_type"] == "payment-card-record" }
c158 if { input["legitimate_need"] == "true" }
c159 if { c155; c156; c157; c158 }
c160 if { input["action"] == "force-password-change" }
c161 if { input["record_type"] == "credential" }
c162 if { input["password_age_days"] > 90 }
c163 if { c160; c161; c162 }
c164 if { input["action"] == "force-password-change" }
c165 if { input["record_type"] == "svc-credential" }
c166 if { input["sole_factor"] == "true" }
c167 if { c164; c165; c166 }
c168 if { input["action"] == "log" }
c169 if { input["record_type"] == "chd-access-event" }
c170 if { c168; c169 }
c171 if { input["action"] == "display-full-pan" }
c172 if { input["record_type"] == "cardholder-data" }
c173 if { c171; c172 }
c174 if { input["action"] == "display-full-pan" }
c175 if { input["record_type"] == "payment-card-record" }
c176 if { input["legitimate_need"] == "false" }
c177 if { c174; c175; c176 }
c178 if { input["action"] == "purge" }
c179 if { input["record_type"] == "audit-workpaper" }
c180 if { input["retention_age_years"] < 7 }
c181 if { c178; c179; c180 }
c182 if { input["action"] == "transmit" }
c183 if { input["record_type"] == "incident-report" }
c184 if { c182; c183 }
c185 if { input["action"] == "transmit" }
c186 if { input["record_type"] == "major-incident-report" }
c187 if { input["legal_basis"] == "true" }
c188 if { c185; c186; c187 }
c189 if { c136 }
c189 if { c140 }
c189 if { c145 }
c189 if { c150 }
c189 if { c154 }
c189 if { c159 }
c189 if { c163 }
c189 if { c167 }
c189 if { c170 }
c189 if { c173 }
c189 if { c177 }
c189 if { c181 }
c189 if { c184 }
c189 if { c188 }
c190 if { not c189 }
c191 if { c132; c190 }
rule_2 if { c191 }
c192 if { input["role"] == "data-subject" }
c193 if { input["action"] == "read" }
c194 if { input["record_type"] == "kyc-file" }
c195 if { input["str_flag"] == "false" }
c196 if { c192; c193; c194; c195 }
c197 if { input["action"] == "erase" }
c198 if { input["record_type"] == "transaction-record" }
c199 if { input["retention_age_years"] < 5 }
c200 if { c197; c198; c199 }
c201 if { input["action"] == "erase" }
c202 if { input["record_type"] == "cdd-record" }
c203 if { input["legal_hold"] == "true" }
c204 if { c201; c202; c203 }
c205 if { input["role"] == "data-subject" }
c206 if { input["action"] == "read" }
c207 if { input["record_type"] == "customer-file" }
c208 if { input["str_flag"] == "true" }
c209 if { c205; c206; c207; c208 }
c210 if { input["role"] == "data-subject" }
c211 if { input["action"] == "read" }
c212 if { input["record_type"] == "kyc-file" }
c213 if { input["str_flag"] == "true" }
c214 if { c210; c211; c212; c213 }
c215 if { input["role"] == "investigator" }
c216 if { input["action"] == "display-full-pan" }
c217 if { input["record_type"] == "cardholder-data" }
c218 if { c215; c216; c217 }
c219 if { input["role"] == "investigator" }
c220 if { input["action"] == "display-full-pan" }
c221 if { input["record_type"] == "payment-card-record" }
c222 if { input["legitimate_need"] == "true" }
c223 if { c219; c220; c221; c222 }
c224 if { input["action"] == "force-password-change" }
c225 if { input["record_type"] == "credential" }
c226 if { input["password_age_days"] > 90 }
c227 if { c224; c225; c226 }
c228 if { input["action"] == "force-password-change" }
c229 if { input["record_type"] == "svc-credential" }
c230 if { input["sole_factor"] == "true" }
c231 if { c228; c229; c230 }
c232 if { input["action"] == "log" }
c233 if { input["record_type"] == "chd-access-event" }
c234 if { c232; c233 }
c235 if { input["action"] == "display-full-pan" }
c236 if { input["record_type"] == "cardholder-data" }
c237 if { c235; c236 }
c238 if { input["action"] == "display-full-pan" }
c239 if { input["record_type"] == "payment-card-record" }
c240 if { input["legitimate_need"] == "false" }
c241 if { c238; c239; c240 }
c242 if { input["action"] == "purge" }
c243 if { input["record_type"] == "audit-workpaper" }
c244 if { input["retention_age_years"] < 7 }
c245 if { c242; c243; c244 }
c246 if { input["action"] == "transmit" }
c247 if { input["record_type"] == "incident-report" }
c248 if { c246; c247 }
c249 if { input["action"] == "transmit" }
c250 if { input["record_type"] == "major-incident-report" }
c251 if { input["legal_basis"] == "true" }
c252 if { c249; c250; c251 }
c253 if { c200 }
c253 if { c204 }
c253 if { c209 }
c253 if { c214 }
c253 if { c218 }
c253 if { c223 }
c253 if { c227 }
c253 if { c231 }
c253 if { c234 }
c253 if { c237 }
c253 if { c241 }
c253 if { c245 }
c253 if { c248 }
c253 if { c252 }
c254 if { not c253 }
c255 if { c196; c254 }
rule_3 if { c255 }
c256 if { input["action"] == "log" }
c257 if { input["contains_pii"] == "true" }
c258 if { input["documented_purpose"] == "false" }
c259 if { c256; c257; c258 }
c260 if { input["action"] == "erase" }
c261 if { input["record_type"] == "transaction-record" }
c262 if { input["retention_age_years"] < 5 }
c263 if { c260; c261; c262 }
c264 if { input["action"] == "erase" }
c265 if { input["record_type"] == "cdd-record" }
c266 if { input["legal_hold"] == "true" }
c267 if { c264; c265; c266 }
c268 if { input["role"] == "data-subject" }
c269 if { input["action"] == "read" }
c270 if { input["record_type"] == "customer-file" }
c271 if { input["str_flag"] == "true" }
c272 if { c268; c269; c270; c271 }
c273 if { input["role"] == "data-subject" }
c274 if { input["action"] == "read" }
c275 if { input["record_type"] == "kyc-file" }
c276 if { input["str_flag"] == "true" }
c277 if { c273; c274; c275; c276 }
c278 if { input["role"] == "investigator" }
c279 if { input["action"] == "display-full-pan" }
c280 if { input["record_type"] == "cardholder-data" }
c281 if { c278; c279; c280 }
c282 if { input["role"] == "investigator" }
c283 if { input["action"] == "display-full-pan" }
c284 if { input["record_type"] == "payment-card-record" }
c285 if { input["legitimate_need"] == "true" }
c286 if { c282; c283; c284; c285 }
c287 if { input["action"] == "force-password-change" }
c288 if { input["record_type"] == "credential" }
c289 if { input["password_age_days"] > 90 }
c290 if { c287; c288; c289 }
c291 if { input["action"] == "force-password-change" }
c292 if { input["record_type"] == "svc-credential" }
c293 if { input["sole_factor"] == "true" }
c294 if { c291; c292; c293 }
c295 if { input["action"] == "log" }
c296 if { input["record_type"] == "chd-access-event" }
c297 if { c295; c296 }
c298 if { input["action"] == "display-full-pan" }
c299 if { input["record_type"] == "cardholder-data" }
c300 if { c298; c299 }
c301 if { input["action"] == "display-full-pan" }
c302 if { input["record_type"] == "payment-card-record" }
c303 if { input["legitimate_need"] == "false" }
c304 if { c301; c302; c303 }
c305 if { input["action"] == "purge" }
c306 if { input["record_type"] == "audit-workpaper" }
c307 if { input["retention_age_years"] < 7 }
c308 if { c305; c306; c307 }
c309 if { input["action"] == "transmit" }
c310 if { input["record_type"] == "incident-report" }
c311 if { c309; c310 }
c312 if { input["action"] == "transmit" }
c313 if { input["record_type"] == "major-incident-report" }
c314 if { input["legal_basis"] == "true" }
c315 if { c312; c313; c314 }
c316 if { c263 }
c316 if { c267 }
c316 if { c272 }
c316 if { c277 }
c316 if { c281 }
c316 if { c286 }
c316 if { c290 }
c316 if { c294 }
c316 if { c297 }
c316 if { c300 }
c316 if { c304 }
c316 if { c308 }
c316 if { c311 }
c316 if { c315 }
c317 if { not c316 }
c318 if { c259; c317 }
rule_4 if { c318 }
c319 if { input["action"] == "purge" }
c320 if { input["contains_pii"] == "true" }
c321 if { input["retention_age_years"] > 2 }
c322 if { c319; c320; c321 }
c323 if { input["action"] == "erase" }
c324 if { input["record_type"] == "transaction-record" }
c325 if { input["retention_age_years"] < 5 }
c326 if { c323; c324; c325 }
c327 if { input["action"] == "erase" }
c328 if { input["record_type"] == "cdd-record" }
c329 if { input["legal_hold"] == "true" }
c330 if { c327; c328; c329 }
c331 if { input["role"] == "data-subject" }
c332 if { input["action"] == "read" }
c333 if { input["record_type"] == "customer-file" }
c334 if { input["str_flag"] == "true" }
c335 if { c331; c332; c333; c334 }
c336 if { input["role"] == "data-subject" }
c337 if { input["action"] == "read" }
c338 if { input["record_type"] == "kyc-file" }
c339 if { input["str_flag"] == "true" }
c340 if { c336; c337; c338; c339 }
c341 if { input["role"] == "investigator" }
c342 if { input["action"] == "display-full-pan" }
c343 if { input["record_type"] == "cardholder-data" }
c344 if { c341; c342; c343 }
c345 if { input["role"] == "investigator" }
c346 if { input["action"] == "display-full-pan" }
c347 if { input["record_type"] == "payment-card-record" }
c348 if { input["legitimate_need"] == "true" }
c349 if { c345; c346; c347; c348 }
c350 if { input["action"] == "force-password-change" }
c351 if { input["record_type"] == "credential" }
c352 if { input["password_age_days"] > 90 }
c353 if { c350; c351; c352 }
c354 if { input["action"] == "force-password-change" }
c355 if { input["record_type"] == "svc-credential" }
c356 if { input["sole_factor"] == "true" }
c357 if { c354; c355; c356 }
c358 if { input["action"] == "log" }
c359 if { input["record_type"] == "chd-access-event" }
c360 if { c358; c359 }
c361 if { input["action"] == "display-full-pan" }
c362 if { input["record_type"] == "cardholder-data" }
c363 if { c361; c362 }
c364 if { input["action"] == "display-full-pan" }
c365 if { input["record_type"] == "payment-card-record" }
c366 if { input["legitimate_need"] == "false" }
c367 if { c364; c365; c366 }
c368 if { input["action"] == "purge" }
c369 if { input["record_type"] == "audit-workpaper" }
c370 if { input["retention_age_years"] < 7 }
c371 if { c368; c369; c370 }
c372 if { input["action"] == "transmit" }
c373 if { input["record_type"] == "incident-report" }
c374 if { c372; c373 }
c375 if { input["action"] == "transmit" }
c376 if { input["record_type"] == "major-incident-report" }
c377 if { input["legal_basis"] == "true" }
c378 if { c375; c376; c377 }
c379 if { c326 }
c379 if { c330 }
c379 if { c335 }
c379 if { c340 }
c379 if { c344 }
c379 if { c349 }
c379 if { c353 }
c379 if { c357 }
c379 if { c360 }
c379 if { c363 }
c379 if { c367 }
c379 if { c371 }
c379 if { c374 }
c379 if { c378 }
c380 if { not c379 }
c381 if { c322; c380 }
rule_5 if { c381 }
c382 if { input["action"] == "transmit" }
c383 if { input["contains_pii"] == "true" }
c384 if { input["legal_basis"] == "false" }
c385 if { c382; c383; c384 }
c386 if { input["action"] == "erase" }
c387 if { input["record_type"] == "transaction-record" }
c388 if { input["retention_age_years"] < 5 }
c389 if { c386; c387; c388 }
c390 if { input["action"] == "erase" }
c391 if { input["record_type"] == "cdd-record" }
c392 if { input["legal_hold"] == "true" }
c393 if { c390; c391; c392 }
c394 if { input["role"] == "data-subject" }
c395 if { input["action"] == "read" }
c396 if { input["record_type"] == "customer-file" }
c397 if { input["str_flag"] == "true" }
c398 if { c394; c395; c396; c397 }
c399 if { input["role"] == "data-subject" }
c400 if { input["action"] == "read" }
c401 if { input["record_type"] == "kyc-file" }
c402 if { input["str_flag"] == "true" }
c403 if { c399; c400; c401; c402 }
c404 if { input["role"] == "investigator" }
c405 if { input["action"] == "display-full-pan" }
c406 if { input["record_type"] == "cardholder-data" }
c407 if { c404; c405; c406 }
c408 if { input["role"] == "investigator" }
c409 if { input["action"] == "display-full-pan" }
c410 if { input["record_type"] == "payment-card-record" }
c411 if { input["legitimate_need"] == "true" }
c412 if { c408; c409; c410; c411 }
c413 if { input["action"] == "force-password-change" }
c414 if { input["record_type"] == "credential" }
c415 if { input["password_age_days"] > 90 }
c416 if { c413; c414; c415 }
c417 if { input["action"] == "force-password-change" }
c418 if { input["record_type"] == "svc-credential" }
c419 if { input["sole_factor"] == "true" }
c420 if { c417; c418; c419 }
c421 if { input["action"] == "log" }
c422 if { input["record_type"] == "chd-access-event" }
c423 if { c421; c422 }
c424 if { input["action"] == "display-full-pan" }
c425 if { input["record_type"] == "cardholder-data" }
c426 if { c424; c425 }
c427 if { input["action"] == "display-full-pan" }
c428 if { input["record_type"] == "payment-card-record" }
c429 if { input["legitimate_need"] == "false" }
c430 if { c427; c428; c429 }
c431 if { input["action"] == "purge" }
c432 if { input["record_type"] == "audit-workpaper" }
c433 if { input["retention_age_years"] < 7 }
c434 if { c431; c432; c433 }
c435 if { input["action"] == "transmit" }
c436 if { input["record_type"] == "incident-report" }
c437 if { c435; c436 }
c438 if { input["action"] == "transmit" }
c439 if { input["record_type"] == "major-incident-report" }
c440 if { input["legal_basis"] == "true" }
c441 if { c438; c439; c440 }
c442 if { c389 }
c442 if { c393 }
c442 if { c398 }
c442 if { c403 }
c442 if { c407 }
c442 if { c412 }
c442 if { c416 }
c442 if { c420 }
c442 if { c423 }
c442 if { c426 }
c442 if { c430 }
c442 if { c434 }
c442 if { c437 }
c442 if { c441 }
c443 if { not c442 }
c444 if { c385; c443 }
rule_6 if { c444 }
c445 if { input["action"] == "erase" }
c446 if { input["record_type"] == "transaction-record" }
c447 if { input["retention_age_years"] < 5 }
c448 if { c445; c446; c447 }
rule_7 if { c448 }
c449 if { input["action"] == "erase" }
c450 if { input["record_type"] == "cdd-record" }
c451 if { input["legal_hold"] == "true" }
c452 if { c449; c450; c451 }
rule_8 if { c452 }
c453 if { input["role"] == "data-subject" }
c454 if { input["action"] == "read" }
c455 if { input["record_type"] == "customer-file" }
c456 if { input["str_flag"] == "true" }
c457 if { c453; c454; c455; c456 }
rule_9 if { c457 }
c458 if { input["role"] == "data-subject" }
c459 if { input["action"] == "read" }
c460 if { input["record_type"] == "kyc-file" }
c461 if { input["str_flag"] == "true" }
c462 if { c458; c459; c460; c461 }
rule_10 if { c462 }
c463 if { input["role"] == "investigator" }
c464 if { input["action"] == "display-full-pan" }
c465 if { input["record_type"] == "cardholder-data" }
c466 if { c463; c464; c465 }
rule_11 if { c466 }
c467 if { input["role"] == "investigator" }
c468 if { input["action"] == "display-full-pan" }
c469 if { input["record_type"] == "payment-card-record" }
c470 if { input["legitimate_need"] == "true" }
c471 if { c467; c468; c469; c470 }
rule_12 if { c471 }
c472 if { input["action"] == "force-password-change" }
c473 if { input["record_type"] == "credential" }
c474 if { input["password_age_days"] > 90 }
c475 if { c472; c473; c474 }
c476 if { input["action"] == "erase" }
c477 if { input["record_type"] == "transaction-record" }
c478 if { input["retention_age_years"] < 5 }
c479 if { c476; c477; c478 }
c480 if { input["action"] == "erase" }
c481 if { input["record_type"] == "cdd-record" }
c482 if { input["legal_hold"] == "true" }
c483 if { c480; c481; c482 }
c484 if { input["role"] == "data-subject" }
c485 if { input["action"] == "read" }
c486 if { input["record_type"] == "customer-file" }
c487 if { input["str_flag"] == "true" }
c488 if { c484; c485; c486; c487 }
c489 if { input["role"] == "data-subject" }
c490 if { input["action"] == "read" }
c491 if { input["record_type"] == "kyc-file" }
c492 if { input["str_flag"] == "true" }
c493 if { c489; c490; c491; c492 }
c494 if { input["role"] == "investigator" }
c495 if { input["action"] == "display-full-pan" }
c496 if { input["record_type"] == "cardholder-data" }
c497 if { c494; c495; c496 }
c498 if { input["role"] == "investigator" }
c499 if { input["action"] == "display-full-pan" }
c500 if { input["record_type"] == "payment-card-record" }
c501 if { input["legitimate_need"] == "true" }
c502 if { c498; c499; c500; c501 }
c503 if { c479 }
c503 if { c483 }
c503 if { c488 }
c503 if { c493 }
c503 if { c497 }
c503 if { c502 }
c504 if { not c503 }
c505 if { c475; c504 }
rule_13 if { c505 }
c506 if { input["action"] == "force-password-change" }
c507 if { input["record_type"] == "svc-credential" }
c508 if { input["sole_factor"] == "true" }
c509 if { c506; c507; c508 }
c510 if { input["action"] == "erase" }
c511 if { input["record_type"] == "transaction-record" }
c512 if { input["retention_age_years"] < 5 }
c513 if { c510; c511; c512 }
c514 if { input["action"] == "erase" }
c515 if { input["record_type"] == "cdd-record" }
c516 if { input["legal_hold"] == "true" }
c517 if { c514; c515; c516 }
c518 if { input["role"] == "data-subject" }
c519 if { input["action"] == "read" }
c520 if { input["record_type"] == "customer-file" }
c521 if { input["str_flag"] == "true" }
c522 if { c518; c519; c520; c521 }
c523 if { input["role"] == "data-subject" }
c524 if { input["action"] == "read" }
c525 if { input["record_type"] == "kyc-file" }
c526 if { input["str_flag"] == "true" }
c527 if { c523; c524; c525; c526 }
c528 if { input["role"] == "investigator" }
c529 if { input["action"] == "display-full-pan" }
c530 if { input["record_type"] == "cardholder-data" }
c531 if { c528; c529; c530 }
c532 if { input["role"] == "investigator" }
c533 if { input["action"] == "display-full-pan" }
c534 if { input["record_type"] == "payment-card-record" }
c535 if { input["legitimate_need"] == "true" }
c536 if { c532; c533; c534; c535 }
c537 if { c513 }
c537 if { c517 }
c537 if { c522 }
c537 if { c527 }
c537 if { c531 }
c537 if { c536 }
c538 if { not c537 }
c539 if { c509; c538 }
rule_14 if { c539 }
c540 if { input["action"] == "log" }
c541 if { input["record_type"] == "chd-access-event" }
c542 if { c540; c541 }
c543 if { input["action"] == "erase" }
c544 if { input["record_type"] == "transaction-record" }
c545 if { input["retention_age_years"] < 5 }
c546 if { c543; c544; c545 }
c547 if { input["action"] == "erase" }
c548 if { input["record_type"] == "cdd-record" }
c549 if { input["legal_hold"] == "true" }
c550 if { c547; c548; c549 }
c551 if { input["role"] == "data-subject" }
c552 if { input["action"] == "read" }
c553 if { input["record_type"] == "customer-file" }
c554 if { input["str_flag"] == "true" }
c555 if { c551; c552; c553; c554 }
c556 if { input["role"] == "data-subject" }
c557 if { input["action"] == "read" }
c558 if { input["record_type"] == "kyc-file" }
c559 if { input["str_flag"] == "true" }
c560 if { c556; c557; c558; c559 }
c561 if { input["role"] == "investigator" }
c562 if { input["action"] == "display-full-pan" }
c563 if { input["record_type"] == "cardholder-data" }
c564 if { c561; c562; c563 }
c565 if { input["role"] == "investigator" }
c566 if { input["action"] == "display-full-pan" }
c567 if { input["record_type"] == "payment-card-record" }
c568 if { input["legitimate_need"] == "true" }
c569 if { c565; c566; c567; c568 }
c570 if { c546 }
c570 if { c550 }
c570 if { c555 }
c570 if { c560 }
c570 if { c564 }
c570 if { c569 }
c571 if { not c570 }
c572 if { c542; c571 }
rule_15 if { c572 }
c573 if { input["action"] == "display-full-pan" }
c574 if { input["record_type"] == "cardholder-data" }
c575 if { c573; c574 }
c576 if { input["action"] == "erase" }
c577 if { input["record_type"] == "transaction-record" }
c578 if { input["retention_age_years"] < 5 }
c579 if { c576; c577; c578 }
c580 if { input["action"] == "erase" }
c581 if { input["record_type"] == "cdd-record" }
c582 if { input["legal_hold"] == "true" }
c583 if { c580; c581; c582 }
c584 if { input["role"] == "data-subject" }
c585 if { input["action"] == "read" }
c586 if { input["record_type"] == "customer-file" }
c587 if { input["str_flag"] == "true" }
c588 if { c584; c585; c586; c587 }
c589 if { input["role"] == "data-subject" }
c590 if { input["action"] == "read" }
c591 if { input["record_type"] == "kyc-file" }
c592 if { input["str_flag"] == "true" }
c593 if { c589; c590; c591; c592 }
c594 if { input["role"] == "investigator" }
c595 if { input["action"] == "display-full-pan" }
c596 if { input["record_type"] == "cardholder-data" }
c597 if { c594; c595; c596 }
c598 if { input["role"] == "investigator" }
c599 if { input["action"] == "display-full-pan" }
c600 if { input["record_type"] == "payment-card-record" }
c601 if { input["legitimate_need"] == "true" }
c602 if { c598; c599; c600; c601 }
c603 if { c579 }
c603 if { c583 }
c603 if { c588 }
c603 if { c593 }
c603 if { c597 }
c603 if { c602 }
c604 if { not c603 }
c605 if { c575; c604 }
rule_16 if { c605 }
c606 if { input["action"] == "display-full-pan" }
c607 if { input["record_type"] == "payment-card-record" }
c608 if { input["legitimate_need"] == "false" }
c609 if { c606; c607; c608 }
c610 if { input["action"] == "erase" }
c611 if { input["record_type"] == "transaction-record" }
c612 if { input["retention_age_years"] < 5 }
c613 if { c610; c611; c612 }
c614 if { input["action"] == "erase" }
c615 if { input["record_type"] == "cdd-record" }
c616 if { input["legal_hold"] == "true" }
c617 if { c614; c615; c616 }
c618 if { input["role"] == "data-subject" }
c619 if { input["action"] == "read" }
c620 if { input["record_type"] == "customer-file" }
c621 if { input["str_flag"] == "true" }
c622 if { c618; c619; c620; c621 }
c623 if { input["role"] == "data-subject" }
c624 if { input["action"] == "read" }
c625 if { input["record_type"] == "kyc-file" }
c626 if { input["str_flag"] == "true" }
c627 if { c623; c624; c625; c626 }
c628 if { input["role"] == "investigator" }
c629 if { input["action"] == "display-full-pan" }
c630 if { input["record_type"] == "cardholder-data" }
c631 if { c628; c629; c630 }
c632 if { input["role"] == "investigator" }
c633 if { input["action"] == "display-full-pan" }
c634 if { input["record_type"] == "payment-card-record" }
c635 if { input["legitimate_need"] == "true" }
c636 if { c632; c633; c634; c635 }
c637 if { c613 }
c637 if { c617 }
c637 if { c622 }
c637 if { c627 }
c637 if { c631 }
c637 if { c636 }
c638 if { not c637 }
c639 if { c609; c638 }
rule_17 if { c639 }
c640 if { input["action"] == "force-password-change" }
c641 if { input["record_type"] == "credential" }
c642 if { input["compromise_evidence"] == "false" }
c643 if { c640; c641; c642 }
rule_18 if { c643 }
c644 if { input["action"] == "force-password-change" }
c645 if { input["record_type"] == "svc-credential" }
c646 if { input["sole_factor"] == "false" }
c647 if { c644; c645; c646 }
rule_19 if { c647 }
c648 if { input["action"] == "purge" }
c649 if { input["record_type"] == "audit-workpaper" }
c650 if { input["retention_age_years"] < 7 }
c651 if { c648; c649; c650 }
rule_20 if { c651 }
c652 if { input["action"] == "transmit" }
c653 if { input["record_type"] == "incident-report" }
c654 if { c652; c653 }
rule_21 if { c654 }
c655 if { input["action"] == "transmit" }
c656 if { input["record_type"] == "major-incident-report" }
c657 if { input["legal_basis"] == "true" }
c658 if { c655; c656; c657 }
rule_22 if { c658 }
c659 if { input["role"] == "hr-manager" }
c660 if { input["action"] == "read" }
c661 if { input["record_type"] == "leave-request" }
c662 if { c659; c660; c661 }
rule_23 if { c662 }
c663 if { input["role"] == "guest" }
c664 if { input["action"] == "write" }
c665 if { input["record_type"] == "system-config" }
c666 if { c663; c664; c665 }
rule_24 if { c666 }
c667 if { input["action"] == "erase" }
c668 if { input["record_type"] == "transaction-record" }
c669 if { input["retention_age_years"] < 5 }
c670 if { c667; c668; c669 }
c671 if { input["action"] == "erase" }
c672 if { input["record_type"] == "transaction-record" }
c673 if { input["contains_pii"] == "true" }
c674 if { input["retention_age_years"] >= 5 }
c675 if { c671; c672; c673; c674 }
c676 if { input["role"] == "data-subject" }
c677 if { input["action"] == "read" }
c678 if { input["record_type"] == "customer-file" }
c679 if { input["str_flag"] == "true" }
c680 if { c676; c677; c678; c679 }
c681 if { input["role"] == "data-subject" }
c682 if { input["action"] == "read" }
c683 if { input["record_type"] == "customer-file" }
c684 if { input["contains_pii"] == "true" }
c685 if { input["str_flag"] == "false" }
c686 if { c681; c682; c683; c684; c685 }
c687 if { input["role"] == "investigator" }
c688 if { input["action"] == "display-full-pan" }
c689 if { input["record_type"] == "cardholder-data" }
c690 if { c687; c688; c689 }
c691 if { input["action"] == "log" }
c692 if { input["record_type"] == "chd-access-event" }
c693 if { c691; c692 }
c694 if { input["action"] == "purge" }
c695 if { input["record_type"] == "audit-workpaper" }
c696 if { input["retention_age_years"] < 7 }
c697 if { c694; c695; c696 }
c698 if { input["action"] == "transmit" }
c699 if { input["record_type"] == "incident-report" }
c700 if { c698; c699 }
c701 if { input["role"] == "guest" }
c702 if { input["action"] == "write" }
c703 if { input["record_type"] == "system-config" }
c704 if { c701; c702; c703 }
