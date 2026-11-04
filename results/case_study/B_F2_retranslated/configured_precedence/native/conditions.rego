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
c33 if { input["record_type"] == "svc-credential" }
c34 if { input["sole_factor"] == "true" }
c35 if { c32; c33; c34 }
c36 if { input["action"] == "log" }
c37 if { input["record_type"] == "chd-access-event" }
c38 if { c36; c37 }
c39 if { input["action"] == "display-full-pan" }
c40 if { input["record_type"] == "cardholder-data" }
c41 if { c39; c40 }
c42 if { input["action"] == "display-full-pan" }
c43 if { input["record_type"] == "payment-card-record" }
c44 if { input["legitimate_need"] == "false" }
c45 if { c42; c43; c44 }
c46 if { input["action"] == "purge" }
c47 if { input["record_type"] == "audit-workpaper" }
c48 if { input["retention_age_years"] < 7 }
c49 if { c46; c47; c48 }
c50 if { input["action"] == "transmit" }
c51 if { input["record_type"] == "incident-report" }
c52 if { c50; c51 }
c53 if { input["action"] == "transmit" }
c54 if { input["record_type"] == "major-incident-report" }
c55 if { input["legal_basis"] == "true" }
c56 if { c53; c54; c55 }
c57 if { c8 }
c57 if { c12 }
c57 if { c17 }
c57 if { c22 }
c57 if { c26 }
c57 if { c31 }
c57 if { c35 }
c57 if { c38 }
c57 if { c41 }
c57 if { c45 }
c57 if { c49 }
c57 if { c52 }
c57 if { c56 }
c58 if { not c57 }
c59 if { c4; c58 }
rule_0 if { c59 }
c60 if { input["action"] == "erase" }
c61 if { input["record_type"] == "cdd-record" }
c62 if { input["contains_pii"] == "true" }
c63 if { input["legal_hold"] == "false" }
c64 if { c60; c61; c62; c63 }
c65 if { input["action"] == "erase" }
c66 if { input["record_type"] == "transaction-record" }
c67 if { input["retention_age_years"] < 5 }
c68 if { c65; c66; c67 }
c69 if { input["action"] == "erase" }
c70 if { input["record_type"] == "cdd-record" }
c71 if { input["legal_hold"] == "true" }
c72 if { c69; c70; c71 }
c73 if { input["role"] == "data-subject" }
c74 if { input["action"] == "read" }
c75 if { input["record_type"] == "customer-file" }
c76 if { input["str_flag"] == "true" }
c77 if { c73; c74; c75; c76 }
c78 if { input["role"] == "data-subject" }
c79 if { input["action"] == "read" }
c80 if { input["record_type"] == "kyc-file" }
c81 if { input["str_flag"] == "true" }
c82 if { c78; c79; c80; c81 }
c83 if { input["role"] == "investigator" }
c84 if { input["action"] == "display-full-pan" }
c85 if { input["record_type"] == "cardholder-data" }
c86 if { c83; c84; c85 }
c87 if { input["role"] == "investigator" }
c88 if { input["action"] == "display-full-pan" }
c89 if { input["record_type"] == "payment-card-record" }
c90 if { input["legitimate_need"] == "true" }
c91 if { c87; c88; c89; c90 }
c92 if { input["action"] == "force-password-change" }
c93 if { input["record_type"] == "svc-credential" }
c94 if { input["sole_factor"] == "true" }
c95 if { c92; c93; c94 }
c96 if { input["action"] == "log" }
c97 if { input["record_type"] == "chd-access-event" }
c98 if { c96; c97 }
c99 if { input["action"] == "display-full-pan" }
c100 if { input["record_type"] == "cardholder-data" }
c101 if { c99; c100 }
c102 if { input["action"] == "display-full-pan" }
c103 if { input["record_type"] == "payment-card-record" }
c104 if { input["legitimate_need"] == "false" }
c105 if { c102; c103; c104 }
c106 if { input["action"] == "purge" }
c107 if { input["record_type"] == "audit-workpaper" }
c108 if { input["retention_age_years"] < 7 }
c109 if { c106; c107; c108 }
c110 if { input["action"] == "transmit" }
c111 if { input["record_type"] == "incident-report" }
c112 if { c110; c111 }
c113 if { input["action"] == "transmit" }
c114 if { input["record_type"] == "major-incident-report" }
c115 if { input["legal_basis"] == "true" }
c116 if { c113; c114; c115 }
c117 if { c68 }
c117 if { c72 }
c117 if { c77 }
c117 if { c82 }
c117 if { c86 }
c117 if { c91 }
c117 if { c95 }
c117 if { c98 }
c117 if { c101 }
c117 if { c105 }
c117 if { c109 }
c117 if { c112 }
c117 if { c116 }
c118 if { not c117 }
c119 if { c64; c118 }
rule_1 if { c119 }
c120 if { input["role"] == "data-subject" }
c121 if { input["action"] == "read" }
c122 if { input["record_type"] == "customer-file" }
c123 if { input["contains_pii"] == "true" }
c124 if { c120; c121; c122; c123 }
c125 if { input["action"] == "erase" }
c126 if { input["record_type"] == "transaction-record" }
c127 if { input["retention_age_years"] < 5 }
c128 if { c125; c126; c127 }
c129 if { input["action"] == "erase" }
c130 if { input["record_type"] == "cdd-record" }
c131 if { input["legal_hold"] == "true" }
c132 if { c129; c130; c131 }
c133 if { input["role"] == "data-subject" }
c134 if { input["action"] == "read" }
c135 if { input["record_type"] == "customer-file" }
c136 if { input["str_flag"] == "true" }
c137 if { c133; c134; c135; c136 }
c138 if { input["role"] == "data-subject" }
c139 if { input["action"] == "read" }
c140 if { input["record_type"] == "kyc-file" }
c141 if { input["str_flag"] == "true" }
c142 if { c138; c139; c140; c141 }
c143 if { input["role"] == "investigator" }
c144 if { input["action"] == "display-full-pan" }
c145 if { input["record_type"] == "cardholder-data" }
c146 if { c143; c144; c145 }
c147 if { input["role"] == "investigator" }
c148 if { input["action"] == "display-full-pan" }
c149 if { input["record_type"] == "payment-card-record" }
c150 if { input["legitimate_need"] == "true" }
c151 if { c147; c148; c149; c150 }
c152 if { input["action"] == "force-password-change" }
c153 if { input["record_type"] == "svc-credential" }
c154 if { input["sole_factor"] == "true" }
c155 if { c152; c153; c154 }
c156 if { input["action"] == "log" }
c157 if { input["record_type"] == "chd-access-event" }
c158 if { c156; c157 }
c159 if { input["action"] == "display-full-pan" }
c160 if { input["record_type"] == "cardholder-data" }
c161 if { c159; c160 }
c162 if { input["action"] == "display-full-pan" }
c163 if { input["record_type"] == "payment-card-record" }
c164 if { input["legitimate_need"] == "false" }
c165 if { c162; c163; c164 }
c166 if { input["action"] == "purge" }
c167 if { input["record_type"] == "audit-workpaper" }
c168 if { input["retention_age_years"] < 7 }
c169 if { c166; c167; c168 }
c170 if { input["action"] == "transmit" }
c171 if { input["record_type"] == "incident-report" }
c172 if { c170; c171 }
c173 if { input["action"] == "transmit" }
c174 if { input["record_type"] == "major-incident-report" }
c175 if { input["legal_basis"] == "true" }
c176 if { c173; c174; c175 }
c177 if { c128 }
c177 if { c132 }
c177 if { c137 }
c177 if { c142 }
c177 if { c146 }
c177 if { c151 }
c177 if { c155 }
c177 if { c158 }
c177 if { c161 }
c177 if { c165 }
c177 if { c169 }
c177 if { c172 }
c177 if { c176 }
c178 if { not c177 }
c179 if { c124; c178 }
rule_2 if { c179 }
c180 if { input["role"] == "data-subject" }
c181 if { input["action"] == "read" }
c182 if { input["record_type"] == "kyc-file" }
c183 if { input["str_flag"] == "false" }
c184 if { c180; c181; c182; c183 }
c185 if { input["action"] == "erase" }
c186 if { input["record_type"] == "transaction-record" }
c187 if { input["retention_age_years"] < 5 }
c188 if { c185; c186; c187 }
c189 if { input["action"] == "erase" }
c190 if { input["record_type"] == "cdd-record" }
c191 if { input["legal_hold"] == "true" }
c192 if { c189; c190; c191 }
c193 if { input["role"] == "data-subject" }
c194 if { input["action"] == "read" }
c195 if { input["record_type"] == "customer-file" }
c196 if { input["str_flag"] == "true" }
c197 if { c193; c194; c195; c196 }
c198 if { input["role"] == "data-subject" }
c199 if { input["action"] == "read" }
c200 if { input["record_type"] == "kyc-file" }
c201 if { input["str_flag"] == "true" }
c202 if { c198; c199; c200; c201 }
c203 if { input["role"] == "investigator" }
c204 if { input["action"] == "display-full-pan" }
c205 if { input["record_type"] == "cardholder-data" }
c206 if { c203; c204; c205 }
c207 if { input["role"] == "investigator" }
c208 if { input["action"] == "display-full-pan" }
c209 if { input["record_type"] == "payment-card-record" }
c210 if { input["legitimate_need"] == "true" }
c211 if { c207; c208; c209; c210 }
c212 if { input["action"] == "force-password-change" }
c213 if { input["record_type"] == "svc-credential" }
c214 if { input["sole_factor"] == "true" }
c215 if { c212; c213; c214 }
c216 if { input["action"] == "log" }
c217 if { input["record_type"] == "chd-access-event" }
c218 if { c216; c217 }
c219 if { input["action"] == "display-full-pan" }
c220 if { input["record_type"] == "cardholder-data" }
c221 if { c219; c220 }
c222 if { input["action"] == "display-full-pan" }
c223 if { input["record_type"] == "payment-card-record" }
c224 if { input["legitimate_need"] == "false" }
c225 if { c222; c223; c224 }
c226 if { input["action"] == "purge" }
c227 if { input["record_type"] == "audit-workpaper" }
c228 if { input["retention_age_years"] < 7 }
c229 if { c226; c227; c228 }
c230 if { input["action"] == "transmit" }
c231 if { input["record_type"] == "incident-report" }
c232 if { c230; c231 }
c233 if { input["action"] == "transmit" }
c234 if { input["record_type"] == "major-incident-report" }
c235 if { input["legal_basis"] == "true" }
c236 if { c233; c234; c235 }
c237 if { c188 }
c237 if { c192 }
c237 if { c197 }
c237 if { c202 }
c237 if { c206 }
c237 if { c211 }
c237 if { c215 }
c237 if { c218 }
c237 if { c221 }
c237 if { c225 }
c237 if { c229 }
c237 if { c232 }
c237 if { c236 }
c238 if { not c237 }
c239 if { c184; c238 }
rule_3 if { c239 }
c240 if { input["action"] == "log" }
c241 if { input["contains_pii"] == "true" }
c242 if { input["documented_purpose"] == "false" }
c243 if { c240; c241; c242 }
c244 if { input["action"] == "erase" }
c245 if { input["record_type"] == "transaction-record" }
c246 if { input["retention_age_years"] < 5 }
c247 if { c244; c245; c246 }
c248 if { input["action"] == "erase" }
c249 if { input["record_type"] == "cdd-record" }
c250 if { input["legal_hold"] == "true" }
c251 if { c248; c249; c250 }
c252 if { input["role"] == "data-subject" }
c253 if { input["action"] == "read" }
c254 if { input["record_type"] == "customer-file" }
c255 if { input["str_flag"] == "true" }
c256 if { c252; c253; c254; c255 }
c257 if { input["role"] == "data-subject" }
c258 if { input["action"] == "read" }
c259 if { input["record_type"] == "kyc-file" }
c260 if { input["str_flag"] == "true" }
c261 if { c257; c258; c259; c260 }
c262 if { input["role"] == "investigator" }
c263 if { input["action"] == "display-full-pan" }
c264 if { input["record_type"] == "cardholder-data" }
c265 if { c262; c263; c264 }
c266 if { input["role"] == "investigator" }
c267 if { input["action"] == "display-full-pan" }
c268 if { input["record_type"] == "payment-card-record" }
c269 if { input["legitimate_need"] == "true" }
c270 if { c266; c267; c268; c269 }
c271 if { input["action"] == "force-password-change" }
c272 if { input["record_type"] == "svc-credential" }
c273 if { input["sole_factor"] == "true" }
c274 if { c271; c272; c273 }
c275 if { input["action"] == "log" }
c276 if { input["record_type"] == "chd-access-event" }
c277 if { c275; c276 }
c278 if { input["action"] == "display-full-pan" }
c279 if { input["record_type"] == "cardholder-data" }
c280 if { c278; c279 }
c281 if { input["action"] == "display-full-pan" }
c282 if { input["record_type"] == "payment-card-record" }
c283 if { input["legitimate_need"] == "false" }
c284 if { c281; c282; c283 }
c285 if { input["action"] == "purge" }
c286 if { input["record_type"] == "audit-workpaper" }
c287 if { input["retention_age_years"] < 7 }
c288 if { c285; c286; c287 }
c289 if { input["action"] == "transmit" }
c290 if { input["record_type"] == "incident-report" }
c291 if { c289; c290 }
c292 if { input["action"] == "transmit" }
c293 if { input["record_type"] == "major-incident-report" }
c294 if { input["legal_basis"] == "true" }
c295 if { c292; c293; c294 }
c296 if { c247 }
c296 if { c251 }
c296 if { c256 }
c296 if { c261 }
c296 if { c265 }
c296 if { c270 }
c296 if { c274 }
c296 if { c277 }
c296 if { c280 }
c296 if { c284 }
c296 if { c288 }
c296 if { c291 }
c296 if { c295 }
c297 if { not c296 }
c298 if { c243; c297 }
rule_4 if { c298 }
c299 if { input["action"] == "purge" }
c300 if { input["contains_pii"] == "true" }
c301 if { input["retention_age_years"] > 2 }
c302 if { c299; c300; c301 }
c303 if { input["action"] == "erase" }
c304 if { input["record_type"] == "transaction-record" }
c305 if { input["retention_age_years"] < 5 }
c306 if { c303; c304; c305 }
c307 if { input["action"] == "erase" }
c308 if { input["record_type"] == "cdd-record" }
c309 if { input["legal_hold"] == "true" }
c310 if { c307; c308; c309 }
c311 if { input["role"] == "data-subject" }
c312 if { input["action"] == "read" }
c313 if { input["record_type"] == "customer-file" }
c314 if { input["str_flag"] == "true" }
c315 if { c311; c312; c313; c314 }
c316 if { input["role"] == "data-subject" }
c317 if { input["action"] == "read" }
c318 if { input["record_type"] == "kyc-file" }
c319 if { input["str_flag"] == "true" }
c320 if { c316; c317; c318; c319 }
c321 if { input["role"] == "investigator" }
c322 if { input["action"] == "display-full-pan" }
c323 if { input["record_type"] == "cardholder-data" }
c324 if { c321; c322; c323 }
c325 if { input["role"] == "investigator" }
c326 if { input["action"] == "display-full-pan" }
c327 if { input["record_type"] == "payment-card-record" }
c328 if { input["legitimate_need"] == "true" }
c329 if { c325; c326; c327; c328 }
c330 if { input["action"] == "force-password-change" }
c331 if { input["record_type"] == "svc-credential" }
c332 if { input["sole_factor"] == "true" }
c333 if { c330; c331; c332 }
c334 if { input["action"] == "log" }
c335 if { input["record_type"] == "chd-access-event" }
c336 if { c334; c335 }
c337 if { input["action"] == "display-full-pan" }
c338 if { input["record_type"] == "cardholder-data" }
c339 if { c337; c338 }
c340 if { input["action"] == "display-full-pan" }
c341 if { input["record_type"] == "payment-card-record" }
c342 if { input["legitimate_need"] == "false" }
c343 if { c340; c341; c342 }
c344 if { input["action"] == "purge" }
c345 if { input["record_type"] == "audit-workpaper" }
c346 if { input["retention_age_years"] < 7 }
c347 if { c344; c345; c346 }
c348 if { input["action"] == "transmit" }
c349 if { input["record_type"] == "incident-report" }
c350 if { c348; c349 }
c351 if { input["action"] == "transmit" }
c352 if { input["record_type"] == "major-incident-report" }
c353 if { input["legal_basis"] == "true" }
c354 if { c351; c352; c353 }
c355 if { c306 }
c355 if { c310 }
c355 if { c315 }
c355 if { c320 }
c355 if { c324 }
c355 if { c329 }
c355 if { c333 }
c355 if { c336 }
c355 if { c339 }
c355 if { c343 }
c355 if { c347 }
c355 if { c350 }
c355 if { c354 }
c356 if { not c355 }
c357 if { c302; c356 }
rule_5 if { c357 }
c358 if { input["action"] == "transmit" }
c359 if { input["contains_pii"] == "true" }
c360 if { input["legal_basis"] == "false" }
c361 if { c358; c359; c360 }
c362 if { input["action"] == "erase" }
c363 if { input["record_type"] == "transaction-record" }
c364 if { input["retention_age_years"] < 5 }
c365 if { c362; c363; c364 }
c366 if { input["action"] == "erase" }
c367 if { input["record_type"] == "cdd-record" }
c368 if { input["legal_hold"] == "true" }
c369 if { c366; c367; c368 }
c370 if { input["role"] == "data-subject" }
c371 if { input["action"] == "read" }
c372 if { input["record_type"] == "customer-file" }
c373 if { input["str_flag"] == "true" }
c374 if { c370; c371; c372; c373 }
c375 if { input["role"] == "data-subject" }
c376 if { input["action"] == "read" }
c377 if { input["record_type"] == "kyc-file" }
c378 if { input["str_flag"] == "true" }
c379 if { c375; c376; c377; c378 }
c380 if { input["role"] == "investigator" }
c381 if { input["action"] == "display-full-pan" }
c382 if { input["record_type"] == "cardholder-data" }
c383 if { c380; c381; c382 }
c384 if { input["role"] == "investigator" }
c385 if { input["action"] == "display-full-pan" }
c386 if { input["record_type"] == "payment-card-record" }
c387 if { input["legitimate_need"] == "true" }
c388 if { c384; c385; c386; c387 }
c389 if { input["action"] == "force-password-change" }
c390 if { input["record_type"] == "svc-credential" }
c391 if { input["sole_factor"] == "true" }
c392 if { c389; c390; c391 }
c393 if { input["action"] == "log" }
c394 if { input["record_type"] == "chd-access-event" }
c395 if { c393; c394 }
c396 if { input["action"] == "display-full-pan" }
c397 if { input["record_type"] == "cardholder-data" }
c398 if { c396; c397 }
c399 if { input["action"] == "display-full-pan" }
c400 if { input["record_type"] == "payment-card-record" }
c401 if { input["legitimate_need"] == "false" }
c402 if { c399; c400; c401 }
c403 if { input["action"] == "purge" }
c404 if { input["record_type"] == "audit-workpaper" }
c405 if { input["retention_age_years"] < 7 }
c406 if { c403; c404; c405 }
c407 if { input["action"] == "transmit" }
c408 if { input["record_type"] == "incident-report" }
c409 if { c407; c408 }
c410 if { input["action"] == "transmit" }
c411 if { input["record_type"] == "major-incident-report" }
c412 if { input["legal_basis"] == "true" }
c413 if { c410; c411; c412 }
c414 if { c365 }
c414 if { c369 }
c414 if { c374 }
c414 if { c379 }
c414 if { c383 }
c414 if { c388 }
c414 if { c392 }
c414 if { c395 }
c414 if { c398 }
c414 if { c402 }
c414 if { c406 }
c414 if { c409 }
c414 if { c413 }
c415 if { not c414 }
c416 if { c361; c415 }
rule_6 if { c416 }
c417 if { input["action"] == "erase" }
c418 if { input["record_type"] == "transaction-record" }
c419 if { input["retention_age_years"] < 5 }
c420 if { c417; c418; c419 }
rule_7 if { c420 }
c421 if { input["action"] == "erase" }
c422 if { input["record_type"] == "cdd-record" }
c423 if { input["legal_hold"] == "true" }
c424 if { c421; c422; c423 }
rule_8 if { c424 }
c425 if { input["role"] == "data-subject" }
c426 if { input["action"] == "read" }
c427 if { input["record_type"] == "customer-file" }
c428 if { input["str_flag"] == "true" }
c429 if { c425; c426; c427; c428 }
rule_9 if { c429 }
c430 if { input["role"] == "data-subject" }
c431 if { input["action"] == "read" }
c432 if { input["record_type"] == "kyc-file" }
c433 if { input["str_flag"] == "true" }
c434 if { c430; c431; c432; c433 }
rule_10 if { c434 }
c435 if { input["role"] == "investigator" }
c436 if { input["action"] == "display-full-pan" }
c437 if { input["record_type"] == "cardholder-data" }
c438 if { c435; c436; c437 }
rule_11 if { c438 }
c439 if { input["role"] == "investigator" }
c440 if { input["action"] == "display-full-pan" }
c441 if { input["record_type"] == "payment-card-record" }
c442 if { input["legitimate_need"] == "true" }
c443 if { c439; c440; c441; c442 }
rule_12 if { c443 }
c444 if { input["action"] == "force-password-change" }
c445 if { input["record_type"] == "svc-credential" }
c446 if { input["sole_factor"] == "true" }
c447 if { c444; c445; c446 }
c448 if { input["action"] == "erase" }
c449 if { input["record_type"] == "transaction-record" }
c450 if { input["retention_age_years"] < 5 }
c451 if { c448; c449; c450 }
c452 if { input["action"] == "erase" }
c453 if { input["record_type"] == "cdd-record" }
c454 if { input["legal_hold"] == "true" }
c455 if { c452; c453; c454 }
c456 if { input["role"] == "data-subject" }
c457 if { input["action"] == "read" }
c458 if { input["record_type"] == "customer-file" }
c459 if { input["str_flag"] == "true" }
c460 if { c456; c457; c458; c459 }
c461 if { input["role"] == "data-subject" }
c462 if { input["action"] == "read" }
c463 if { input["record_type"] == "kyc-file" }
c464 if { input["str_flag"] == "true" }
c465 if { c461; c462; c463; c464 }
c466 if { input["role"] == "investigator" }
c467 if { input["action"] == "display-full-pan" }
c468 if { input["record_type"] == "cardholder-data" }
c469 if { c466; c467; c468 }
c470 if { input["role"] == "investigator" }
c471 if { input["action"] == "display-full-pan" }
c472 if { input["record_type"] == "payment-card-record" }
c473 if { input["legitimate_need"] == "true" }
c474 if { c470; c471; c472; c473 }
c475 if { c451 }
c475 if { c455 }
c475 if { c460 }
c475 if { c465 }
c475 if { c469 }
c475 if { c474 }
c476 if { not c475 }
c477 if { c447; c476 }
rule_13 if { c477 }
c478 if { input["action"] == "log" }
c479 if { input["record_type"] == "chd-access-event" }
c480 if { c478; c479 }
c481 if { input["action"] == "erase" }
c482 if { input["record_type"] == "transaction-record" }
c483 if { input["retention_age_years"] < 5 }
c484 if { c481; c482; c483 }
c485 if { input["action"] == "erase" }
c486 if { input["record_type"] == "cdd-record" }
c487 if { input["legal_hold"] == "true" }
c488 if { c485; c486; c487 }
c489 if { input["role"] == "data-subject" }
c490 if { input["action"] == "read" }
c491 if { input["record_type"] == "customer-file" }
c492 if { input["str_flag"] == "true" }
c493 if { c489; c490; c491; c492 }
c494 if { input["role"] == "data-subject" }
c495 if { input["action"] == "read" }
c496 if { input["record_type"] == "kyc-file" }
c497 if { input["str_flag"] == "true" }
c498 if { c494; c495; c496; c497 }
c499 if { input["role"] == "investigator" }
c500 if { input["action"] == "display-full-pan" }
c501 if { input["record_type"] == "cardholder-data" }
c502 if { c499; c500; c501 }
c503 if { input["role"] == "investigator" }
c504 if { input["action"] == "display-full-pan" }
c505 if { input["record_type"] == "payment-card-record" }
c506 if { input["legitimate_need"] == "true" }
c507 if { c503; c504; c505; c506 }
c508 if { c484 }
c508 if { c488 }
c508 if { c493 }
c508 if { c498 }
c508 if { c502 }
c508 if { c507 }
c509 if { not c508 }
c510 if { c480; c509 }
rule_14 if { c510 }
c511 if { input["action"] == "display-full-pan" }
c512 if { input["record_type"] == "cardholder-data" }
c513 if { c511; c512 }
c514 if { input["action"] == "erase" }
c515 if { input["record_type"] == "transaction-record" }
c516 if { input["retention_age_years"] < 5 }
c517 if { c514; c515; c516 }
c518 if { input["action"] == "erase" }
c519 if { input["record_type"] == "cdd-record" }
c520 if { input["legal_hold"] == "true" }
c521 if { c518; c519; c520 }
c522 if { input["role"] == "data-subject" }
c523 if { input["action"] == "read" }
c524 if { input["record_type"] == "customer-file" }
c525 if { input["str_flag"] == "true" }
c526 if { c522; c523; c524; c525 }
c527 if { input["role"] == "data-subject" }
c528 if { input["action"] == "read" }
c529 if { input["record_type"] == "kyc-file" }
c530 if { input["str_flag"] == "true" }
c531 if { c527; c528; c529; c530 }
c532 if { input["role"] == "investigator" }
c533 if { input["action"] == "display-full-pan" }
c534 if { input["record_type"] == "cardholder-data" }
c535 if { c532; c533; c534 }
c536 if { input["role"] == "investigator" }
c537 if { input["action"] == "display-full-pan" }
c538 if { input["record_type"] == "payment-card-record" }
c539 if { input["legitimate_need"] == "true" }
c540 if { c536; c537; c538; c539 }
c541 if { c517 }
c541 if { c521 }
c541 if { c526 }
c541 if { c531 }
c541 if { c535 }
c541 if { c540 }
c542 if { not c541 }
c543 if { c513; c542 }
rule_15 if { c543 }
c544 if { input["action"] == "display-full-pan" }
c545 if { input["record_type"] == "payment-card-record" }
c546 if { input["legitimate_need"] == "false" }
c547 if { c544; c545; c546 }
c548 if { input["action"] == "erase" }
c549 if { input["record_type"] == "transaction-record" }
c550 if { input["retention_age_years"] < 5 }
c551 if { c548; c549; c550 }
c552 if { input["action"] == "erase" }
c553 if { input["record_type"] == "cdd-record" }
c554 if { input["legal_hold"] == "true" }
c555 if { c552; c553; c554 }
c556 if { input["role"] == "data-subject" }
c557 if { input["action"] == "read" }
c558 if { input["record_type"] == "customer-file" }
c559 if { input["str_flag"] == "true" }
c560 if { c556; c557; c558; c559 }
c561 if { input["role"] == "data-subject" }
c562 if { input["action"] == "read" }
c563 if { input["record_type"] == "kyc-file" }
c564 if { input["str_flag"] == "true" }
c565 if { c561; c562; c563; c564 }
c566 if { input["role"] == "investigator" }
c567 if { input["action"] == "display-full-pan" }
c568 if { input["record_type"] == "cardholder-data" }
c569 if { c566; c567; c568 }
c570 if { input["role"] == "investigator" }
c571 if { input["action"] == "display-full-pan" }
c572 if { input["record_type"] == "payment-card-record" }
c573 if { input["legitimate_need"] == "true" }
c574 if { c570; c571; c572; c573 }
c575 if { c551 }
c575 if { c555 }
c575 if { c560 }
c575 if { c565 }
c575 if { c569 }
c575 if { c574 }
c576 if { not c575 }
c577 if { c547; c576 }
rule_16 if { c577 }
c578 if { input["action"] == "force-password-change" }
c579 if { input["record_type"] == "svc-credential" }
c580 if { input["sole_factor"] == "false" }
c581 if { c578; c579; c580 }
rule_17 if { c581 }
c582 if { input["action"] == "purge" }
c583 if { input["record_type"] == "audit-workpaper" }
c584 if { input["retention_age_years"] < 7 }
c585 if { c582; c583; c584 }
rule_18 if { c585 }
c586 if { input["action"] == "transmit" }
c587 if { input["record_type"] == "incident-report" }
c588 if { c586; c587 }
rule_19 if { c588 }
c589 if { input["action"] == "transmit" }
c590 if { input["record_type"] == "major-incident-report" }
c591 if { input["legal_basis"] == "true" }
c592 if { c589; c590; c591 }
rule_20 if { c592 }
c593 if { input["role"] == "hr-manager" }
c594 if { input["action"] == "read" }
c595 if { input["record_type"] == "leave-request" }
c596 if { c593; c594; c595 }
rule_21 if { c596 }
c597 if { input["role"] == "guest" }
c598 if { input["action"] == "write" }
c599 if { input["record_type"] == "system-config" }
c600 if { c597; c598; c599 }
rule_22 if { c600 }
c601 if { input["action"] == "erase" }
c602 if { input["record_type"] == "transaction-record" }
c603 if { input["retention_age_years"] < 5 }
c604 if { c601; c602; c603 }
c605 if { input["action"] == "erase" }
c606 if { input["record_type"] == "transaction-record" }
c607 if { input["contains_pii"] == "true" }
c608 if { input["retention_age_years"] >= 5 }
c609 if { c605; c606; c607; c608 }
c610 if { input["role"] == "data-subject" }
c611 if { input["action"] == "read" }
c612 if { input["record_type"] == "customer-file" }
c613 if { input["str_flag"] == "true" }
c614 if { c610; c611; c612; c613 }
c615 if { input["role"] == "data-subject" }
c616 if { input["action"] == "read" }
c617 if { input["record_type"] == "customer-file" }
c618 if { input["contains_pii"] == "true" }
c619 if { input["str_flag"] == "false" }
c620 if { c615; c616; c617; c618; c619 }
c621 if { input["role"] == "investigator" }
c622 if { input["action"] == "display-full-pan" }
c623 if { input["record_type"] == "cardholder-data" }
c624 if { c621; c622; c623 }
c625 if { input["action"] == "log" }
c626 if { input["record_type"] == "chd-access-event" }
c627 if { c625; c626 }
c628 if { input["action"] == "purge" }
c629 if { input["record_type"] == "audit-workpaper" }
c630 if { input["retention_age_years"] < 7 }
c631 if { c628; c629; c630 }
c632 if { input["action"] == "transmit" }
c633 if { input["record_type"] == "incident-report" }
c634 if { c632; c633 }
c635 if { input["role"] == "guest" }
c636 if { input["action"] == "write" }
c637 if { input["record_type"] == "system-config" }
c638 if { c635; c636; c637 }
