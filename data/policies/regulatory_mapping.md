# Regulatory-Text → CPM Traceability Mapping

This document records how each clause of the source regulations and standards
was translated into an operational XACML rule in
`datasets/cross_source_corpus.xml`, and how that rule maps onto the fields of
the Common Policy Model (CPM). It implements the thesis objective *"show how
XACML rules and written regulatory clauses can be mapped into the CPM."*

Translation is **manual and documented** (this table is the artifact).
Automated NLP extraction of rules from regulatory text is out of scope and
listed as future work.

## Method

For each clause we performed four steps:

1. **Clause selection** — identify the sentence(s) that impose an
   access-control obligation (who may/must-not do what to which records,
   under which conditions).
2. **Decomposition** — split the clause into CPM fields:
   subject, action, resource, environment condition, effect.
3. **Exception audit** — list every exception, scope limit, or lawful-basis
   hook attached to the clause. Each becomes either an extra CPM condition
   (*governed* translation) or is deliberately dropped (*ungoverned*
   translation) to reproduce the real-world failure mode where different
   teams translate different documents.
4. **XACML encoding** — express the CPM fields as XACML 3.0 `Match`
   constraints (string equality in `Target`, numeric comparisons in
   `Condition`).

## Vocabulary

| CPM field | XACML attribute | Values used |
|---|---|---|
| subject.role | `urn:corp:subject:role` | data-subject, investigator, hr-manager, guest |
| action | `urn:oasis:...:action:action-id` | erase, read, log, purge, transmit, force-password-change, display-full-pan, write |
| resource.record-type | `urn:corp:resource:record-type` | transaction-record, cdd-record, customer-file, kyc-file, cardholder-data, payment-card-record, credential, svc-credential, chd-access-event, audit-workpaper, incident-report, major-incident-report, leave-request, system-config |
| resource.contains-pii | `urn:corp:resource:contains-pii` | true / false |
| resource.under-legal-hold | `urn:corp:resource:under-legal-hold` | true / false |
| resource.str-flag | `urn:corp:resource:str-flag` | true / false |
| resource.retention-age-years | `urn:corp:resource:retention-age-years` | integer |
| env.password-age-days | `urn:corp:env:password-age-days` | integer |
| env.compromise-evidence | `urn:corp:env:compromise-evidence` | true / false |
| env.documented-purpose | `urn:corp:env:documented-purpose` | true / false |
| env.legal-basis | `urn:corp:env:legal-basis` | true / false |
| env.legitimate-need | `urn:corp:env:legitimate-need` | true / false |
| env.sole-factor | `urn:corp:env:sole-factor` | true / false |

## Clause-to-rule traceability table

### Family F1 — GDPR erasure vs AMLD retention

| Source clause | Clause text (condensed) | Rule ID | Effect | CPM mapping | Exception handling |
|---|---|---|---|---|---|
| GDPR Art. 17(1) | The data subject has the right to obtain erasure of personal data without undue delay. | `GDPR-17-erase-ungoverned` | Permit | action=erase; resource: record-type=transaction-record, contains-pii=true | Art. 17(3)(b) **dropped** (ungoverned) |
| GDPR Art. 17(1) + 17(3)(b) | Erasure does not apply where processing is necessary for compliance with a legal obligation. | `GDPR-17-erase-governed` | Permit | as above + under-legal-hold=false; record-type=cdd-record | Art. 17(3)(b) **preserved** as legal-hold guard |
| AMLD Art. 40(1) | Institutions retain CDD documents and transaction records for five years after the business relationship ends. | `AMLD-40-retain-txn` | Deny | action=erase; record-type=transaction-record; retention-age-years < 5 | — |
| AMLD Art. 40(1) (governed) | Same clause, retention expressed as an active legal hold. | `AMLD-40-retain-cdd-governed` | Deny | action=erase; record-type=cdd-record; under-legal-hold=true | hold flag mirrors GDPR exception |

**Solver outcome:** ungoverned pair SAT (witness: erase transaction-record,
pii=true, age=4y); governed pair UNSAT (hold=false ∧ hold=true is
unsatisfiable).

### Family F2 — PCI password rotation vs NIST no-forced-rotation

| Source clause | Clause text (condensed) | Rule ID | Effect | CPM mapping | Exception handling |
|---|---|---|---|---|---|
| PCI DSS v4.0 Req 8.3.9 | If passwords are the only authentication factor, change them at least every 90 days. | `PCI-8-3-9-rotate-password` | Permit | action=force-password-change; record-type=credential; password-age-days > 90 | sole-factor scope **dropped** |
| PCI DSS Req 8.3.9 (governed) | Same clause with the sole-factor scope kept. | `PCI-8-3-9-rotate-password-governed` | Permit | record-type=svc-credential; sole-factor=true | scope **preserved** |
| NIST SP 800-63B §5.1.1.2 | Verifiers SHOULD NOT require periodic password changes absent evidence of compromise. | `NIST-63B-no-forced-rotation` | Deny | action=force-password-change; record-type=credential; compromise-evidence=false | — |
| NIST SP 800-63B (governed) | Org translation scopes the rule to multi-factor credentials. | `NIST-63B-no-forced-rotation-governed` | Deny | record-type=svc-credential; sole-factor=false | complements PCI scope |

**Solver outcome:** ungoverned SAT (witness: password-age=91,
compromise-evidence=false); governed UNSAT (sole-factor true ∧ false).

### Family F3 — PCI logging vs GDPR minimisation

| Source clause | Clause text (condensed) | Rule ID | Effect | CPM mapping |
|---|---|---|---|---|
| PCI DSS Req 10.2 | Log all individual user access to cardholder data. | `PCI-10-2-log-access` | Permit | action=log; record-type=chd-access-event |
| GDPR Art. 5(1)(c) | Personal data must be limited to what is necessary for the purpose. | `GDPR-5c-minimisation` | Deny | action=log; contains-pii=true; documented-purpose=false |

**Solver outcome:** SAT (witness: log a chd-access-event containing PII with
no documented purpose). Resolution path: document the PCI Req 10 purpose,
making documented-purpose=true.

### Family F4 — GDPR subject access vs AMLD tipping-off

| Source clause | Clause text (condensed) | Rule ID | Effect | CPM mapping | Exception handling |
|---|---|---|---|---|---|
| GDPR Art. 15(1) | The data subject may obtain access to their personal data. | `GDPR-15-subject-access-ungoverned` | Permit | role=data-subject; action=read; record-type=customer-file; contains-pii=true | Art. 23(1)(e) **dropped** |
| GDPR Art. 15 + Art. 23(1)(e) | Member-State law may restrict Art. 15 to safeguard investigations. | `GDPR-15-subject-access-governed` | Permit | record-type=kyc-file; str-flag=false | restriction **preserved** |
| AMLD Art. 39(1) | Do not disclose to the customer that an STR has been or will be filed. | `AMLD-39-tipping-off` | Deny | role=data-subject; action=read; record-type=customer-file; str-flag=true | — |
| AMLD Art. 39(1) (governed) | Same, on KYC files. | `AMLD-39-tipping-off-governed` | Deny | record-type=kyc-file; str-flag=true | pairs with governed Art. 15 rule |

**Solver outcome:** ungoverned SAT (witness: data-subject reads their
STR-flagged customer file); governed UNSAT (str-flag false ∧ true).

### Family F5 — AML investigation vs PCI PAN masking

| Source clause | Clause text (condensed) | Rule ID | Effect | CPM mapping | Exception handling |
|---|---|---|---|---|---|
| AMLD Art. 32 (FIU powers, operational practice) | Investigators may view full card numbers in flagged transactions. | `AMLD-investigator-full-pan` | Permit | role=investigator; action=display-full-pan; record-type=cardholder-data | — |
| AMLD (governed) | Access requires a recorded legitimate business need. | `AMLD-investigator-full-pan-governed` | Permit | record-type=payment-card-record; legitimate-need=true | aligned with PCI exception |
| PCI DSS Req 3.3 | Mask PAN when displayed; only personnel with a legitimate business need may see the full PAN. | `PCI-3-3-mask-pan` | Deny | action=display-full-pan; record-type=cardholder-data | need exception **dropped** |
| PCI DSS Req 3.3 (governed) | Same clause with the exception kept. | `PCI-3-3-mask-pan-governed` | Deny | record-type=payment-card-record; legitimate-need=false | exception **preserved** |

**Solver outcome:** ungoverned SAT (witness: investigator displays full PAN);
governed UNSAT (legitimate-need true ∧ false).

### Family F6 — GDPR storage limitation vs SOX retention

| Source clause | Clause text (condensed) | Rule ID | Effect | CPM mapping |
|---|---|---|---|---|
| GDPR Art. 5(1)(e) | Personal data kept no longer than necessary; org policy purges PII older than 2 years. | `GDPR-5e-storage-purge` | Permit | action=purge; contains-pii=true; retention-age-years > 2 |
| SOX §802 | Audit workpapers retained for seven years. | `SOX-802-retain-audit` | Deny | action=purge; record-type=audit-workpaper; retention-age-years < 7 |

**Solver outcome:** SAT — the witness demonstrates numeric reasoning: Z3
picks retention-age-years = 3, inside the open interval (2, 7) where both
rules apply.

### Family F7 — DORA incident reporting vs GDPR transfer restriction

| Source clause | Clause text (condensed) | Rule ID | Effect | CPM mapping | Exception handling |
|---|---|---|---|---|---|
| DORA Art. 19(1) | Report major ICT-related incidents to the competent authority. | `DORA-19-report-incident` | Permit | action=transmit; record-type=incident-report | lawful basis **not recorded** |
| DORA Art. 19 (governed) | Reporting proceeds under GDPR Art. 6(1)(c) legal obligation. | `DORA-19-report-incident-governed` | Permit | record-type=major-incident-report; legal-basis=true | basis **recorded** |
| GDPR Art. 6(1) | Processing lawful only with a lawful basis. | `GDPR-6-restrict-transfer-ungoverned` | Deny | action=transmit; contains-pii=true; legal-basis=false | Art. 6(1)(c) recognition dropped |

**Solver outcome:** ungoverned SAT (witness: transmit incident-report with
PII, no recorded basis); governed UNSAT (legal-basis true ∧ false).

### Benign controls (true negatives)

| Rule ID | Effect | Purpose |
|---|---|---|
| `INT-hr-view-leave` | Permit | Unrelated HR rule; must conflict with nothing. |
| `INT-deny-guest-write-config` | Deny | Only `write` rule in the corpus; must conflict with nothing. |

## Summary of expected solver outcomes

| Category | Pairs | Expected | Verified by |
|---|---|---|---|
| Planted ungoverned conflicts | 7 | SAT + witness | `case_study.py` |
| Governed translations | 5 | UNSAT | `case_study.py` |
| All other cross-effect pairs | 149 | UNSAT | `case_study.py` |

The distinction between the ungoverned and governed variants is the central
demonstration: **the source regulations are not inconsistent — conflicts
appear when translation drops an exception.** The framework detects exactly
the dropped-exception translations and proves the correct translations
conflict-free.
