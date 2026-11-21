# Verification records

Two checks added during the style revision of October 2026. The scripts are kept exactly as they were executed, so a few lines name the paths of the Linux container that ran them. Change those lines before running (listed below).

## proof_checks: solver checks of the Chapter 4 propositions (Table C.4)

| File | What it does |
|---|---|
| `lemmas.py` | The 35 set-level steps of the proofs in Chapter 4, each written as an SMT-LIB query whose `unsat` answer means the step holds |
| `dags.py` | Uniqueness of the closed form (Equation 4.10) for every acyclic choice relation on 1 to 5 rules (1 + 3 + 25 + 543 + 29,281 = 29,853 relations) |
| `run.py` | Runs every lemma and every uniqueness script with Z3 (binary) and cvc5 (Python API) and writes `results.json` and the `.smt2` files in `smt/` |
| `vacuity.py`, `controls.py` | Checks that the hypotheses of each lemma are satisfiable (no lemma holds vacuously) and that deliberately false variants are found false |
| `results.json`, `vacuity.json`, `controls.json`, `*_28oct.log` | The outputs of the run of 28 October 2026 |

Lines to change: `Z3 = ...` in `run.py`, `vacuity.py` and `controls.py` (path of a `z3` binary, 4.15.4 was used). cvc5 is imported from Python (`pip install cvc5`).

```bash
cd verification/proof_checks
python run.py        # about 5 minutes; ends with ALL HOLD
python vacuity.py
python controls.py
```

## rego_census: public Rego policies against the Rego profile (Section 6.7.5, Table C.5)

`repos/` holds the 203 non-test `.rego` files of three Open Policy Agent repositories at the commits in `repos/pinned_commits.json`, with each repository's license (Apache-2.0). They are copied unchanged; nothing else from the repositories is needed.

| File | What it does |
|---|---|
| `census.py` | Runs the unchanged Rego mapper of `src/research/rego.py` on every file and parses each file with OPA 1.21.2 to record the language features it uses; writes `census.json` (203 files) |
| `census_distinct.py` | Removes byte-identical copies (160 distinct modules), adds the OPA v1 parse, the authorization-style subset and the smaller constructs behind rejections; writes `census_distinct.json` |
| `accepted_audit.py` | Lists what the accepted modules contain |

Lines to change: `sys.path.insert(0, ...)` in `census.py` and `accepted_audit.py` (path of this package's `src` folder), `OPA = ...` in `census.py` and `census_distinct.py` (path of the OPA 1.21.2 binary), and `ROOT` and the output path in `accepted_audit.py`.

```bash
cd verification/rego_census
python census.py repos census_new.json
python census_distinct.py repos census_new.json census_distinct_new.json
```

On 1 November 2026 both commands were run on the files in `repos/`, and the two new outputs were identical to `census.json` and `census_distinct.json`.

## extra_checks: two re-checks added on 21 November 2026

| File | What it does |
|---|---|
| `refusal_check.py` | Re-runs the 17 refused listed-order runs of the chained-priority benchmark (Section 6.4.3). Their refusal code is also used when the solver gives no answer, so the script prints the status of the query that checks the narrowed losing rule. UNSAT means the edit really would have emptied the rule. |
| `rerun_case.py` | Re-checks the case study (Sections 6.2 and 6.4.4). It evaluates every rule with numpy over all 31,492,800 requests and compares the overlapping pairs with a fresh Z3 scan and with `results/case_study/summary.json`. It also checks the witnesses, the Conflict counts and the settled-winner repair. |
| `refusal_check_output.txt`, `rerun_case_output.txt` | Outputs of the run of 21 November 2026 (Windows 11, Python 3.12.14, Z3 4.15.4, numpy 2.3.5) |

Both scripts write nothing and find the package from their own location, so no lines need changing. Set `Z3_LIBRARY` as in the main README. OPA and Balana are not used.

```bash
python verification/extra_checks/refusal_check.py   # about 1 minute; ends with {(True, 'UNSAT'): 17}
python verification/extra_checks/rerun_case.py      # about 1 minute; both "grid == solver == recorded" lines print True
```
