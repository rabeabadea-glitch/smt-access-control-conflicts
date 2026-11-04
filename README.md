> **Paper:** *SMT-based detection and order-independent repair of access-control conflicts across regulatory sources*,
> R. B. Al Haj Eid, M. Al-Dala'ien and M. Alhajeid (manuscript under review).
> This repository is the replication package for that paper and for the M.Sc. thesis below. The contents are the same
> as the thesis archives `Replication_Package.zip` and `Replication_Package_part2_chain_study_replay.zip`
> (part 2 is already merged here under `results/chain_study/replay`). The embedding model file
> `models/all-MiniLM-L6-v2/onnx/model.onnx` is not included; see *Setup* for the exact revision to download.

# Replication package

**Thesis:** SMT-Based Detection and Automated Resolution of Access-Control Conflicts Across Heterogeneous Security and Regulatory Frameworks
**Author:** Rabea Badei Al Haj Eid (M.Sc. Cyber Security, Princess Sumaya University for Technology)
**Supervisor:** Dr. Mu'awya Al-Dala'ien

This package holds the code, inputs, study scripts and raw outputs behind the final-revision results in the thesis (Chapter 6 and Appendix A), plus the raw rows of three earlier studies whose tables can be recomputed. Every path below is relative to this folder. The scripts use relative paths; some raw outputs record the absolute paths of the Linux container that produced them, as a record only. For publication, the machine-specific home directory in those recorded paths was replaced by `/home/user`; no number, status or decision changed.

## Contents

| Folder | What is in it |
|---|---|
| `src/pcproof` | Checking core: Common Policy Model, SMT verifier, native Z3 binding, one-step repair, Python export |
| `src/research` | XACML and Rego adapters, semantic screening, date profile, source-order compilation and the bounded refinement transaction (listed order). Unchanged since the frozen challenge; its file hashes match `data/challenge/execution/protocol.json` |
| `src/extensions` | `settled_refinement.py`: the bounded transaction with settled-winner pair selection (final revision) |
| `src/tests` | 60 unit tests; the audit fixtures they need are in `src/tests/fixtures/inputs` |
| `studies` | One script per final-revision study, plus `common.py` (paths and an independent decision evaluator) |
| `data/challenge` | The frozen 12-case repair challenge: design (hash-checked against `design/manifest.json`) and the frozen execution inputs |
| `data/policies` | Cross-source regulatory corpus with its clause-to-rule mapping, and the named XACML artifacts (GEYSERS, KMarket, Continue-A) |
| `data/scaling_inputs` | The eight disjoint and interval scaling workloads (10 to 300 rules) |
| `data/workflow_drivers` | The two earlier generated repair-family drivers, exactly as executed |
| `results` | Raw outputs and summaries of every final-revision study; `results/earlier` holds copied raw rows of three earlier studies |
| `tools` | Balana batch runner (`BalanaBatch.java`, Balana 1.2.24 jars) and the OPA 1.21.2 release record with checksums |
| `models` | The all-MiniLM-L6-v2 embedding model used by the screening stage (revision recorded in `manifest.json`) |
| `verification` | Solver checks of the Chapter 4 proofs (Table C.4) and the census of public Rego policies (Section 6.7.5), with their own README |

## Environment used for the final-revision studies

- Linux, CPython 3.12.3
- `pip install -r requirements.txt` (z3-solver 4.15.4.0, numpy 2.5.4, onnxruntime 1.23.2, tokenizers 0.22.1, rdflib 7.4.0)
- OpenJDK 21 (`java`, `javac`)
- OPA 1.21.2, official static Linux binary `opa_linux_amd64_static`, SHA-256 `830ab11f61ffec760b5e19db0d7ad02bf037e13f5ef4d665faeaf17632177527` (see `tools/opa/official_release.json`; on Windows use `opa_windows_amd64.exe` from the same release)

The earlier studies ran on Windows 11 with CPython 3.12.14 and the same Z3, OPA and Balana versions.

## Setup

```bash
python -m pip install -r requirements.txt
export Z3_LIBRARY=$(python -c "import z3, os; print(os.path.join(os.path.dirname(z3.__file__), 'lib', 'libz3.so'))")
export OPA=/path/to/opa_linux_amd64_static
javac -cp "tools/xacml/lib/*" -d tools/xacml/classes tools/xacml/BalanaBatch.java
export BALANA_CP="tools/xacml/classes:tools/xacml/lib/*"
```

On Windows, set `Z3_LIBRARY` to `libz3.dll` and use `;` instead of `:` in `BALANA_CP`.

If `models/all-MiniLM-L6-v2/onnx/model.onnx` is missing (it is large), copy the folder `06_Thesis_Development/Research_Completion/models/all-MiniLM-L6-v2` from the project, or download revision `1110a243fdf4706b3f48f1d95db1a4f5529b4d41` of `sentence-transformers/all-MiniLM-L6-v2` and check the hashes in `manifest.json`. Only the screening-at-scale study needs it.

## Unit tests

```bash
cd src && python -m unittest discover -s tests
```

Expected: 60 tests, all passing.

## Studies (run from this folder)

Each command writes into `results/`. To reproduce rather than overwrite, move the saved folder aside first and compare the new summary with it. Statuses, reasons, counts and decisions should match exactly; times depend on the machine.

| Study | Command | Thesis | Approx. time |
|---|---|---|---|
| Rule order (12 cases x 21 orders x 2 rules) | `python studies/order_study.py prepare 20` then `python studies/order_study.py run 2` then `python studies/order_study.py summarize` | Section 6.4 | 1 hour |
| Chained-priority benchmark (20 new cases x 12 orders x 2 rules, added 1 November 2026) | `python studies/chain_study.py prepare`, then `python studies/chain_study.py run 2`, then `python studies/chain_study.py replay`, then `python studies/chain_study.py summarize` | Section 6.4 | 15 minutes |
| Engine replay of frozen-order outputs | `python studies/native_replay.py` | Section 6.4 | 2 minutes |
| Rule retirement for all methods | `python studies/retirement_study.py` | Section 6.4 | 5 minutes |
| Earlier repair families, both rules | `python studies/workflow_regression.py listed`, then `python studies/workflow_regression.py settled`, then `python studies/compare_regression.py` | Section 6.4 | 5 minutes |
| Cross-source case study | `python studies/case_study.py` | Section 6.4 | 10 minutes |
| Documented conversions | `python studies/conversion_study.py` | Section 6.7 | 3 minutes |
| Screening at scale (3 repetitions) | `python studies/screen_scale_study.py 3`, then `python studies/summarize_screen_scale.py` | Section 6.6 | 1.5 hours |
| Recompute earlier tables | `python studies/recompute_earlier_tables.py` | Tables 6.3, 6.14, 6.15 | seconds |

## Trying one case by hand

`studies/try_case.py` runs one frozen challenge case and prints the status, the refusal reason, the edits and the scores. It writes nothing, so it is safe to use for practice or to show a result live.

```bash
python studies/try_case.py C05 settled      # accepted after 2 edits
python studies/try_case.py C08 listed       # refused: no authorized direction
python studies/try_case.py C04 listed 3     # one of the shuffled orders of the order study
```

## How the studies were actually run

`results/executed_run_script.sh` is the shell script that ran the studies after the order study, kept as a record. Its absolute paths are those of the Linux container used for the final revision; use the commands in the table above instead.

## Notes

- The engine replay files of the chained-priority benchmark (`results/chain_study/replay`, about 21,000 small XML, Rego and JSON files) are delivered in a second archive, `Replication_Package_part2_chain_study_replay.zip`, to keep each archive under a file-size limit. Unzip it over this folder. `results/chain_study/replay_summary.json` is in this archive, and `python studies/chain_study.py replay` regenerates the folder.
- All approval records in the inputs are artificial and bound to a policy hash. They are not real organizational approvals.
- The cross-source corpus was written by the researcher; it is test material, not an independent sample of real policies.
- `data/policies/regulatory_mapping.md` is kept exactly as written during the proposal. Its closing summary table (7 planted, 5 governed and "149 other" pairs) predates the final corpus and does not add up. The corpus has 156 opposite-effect rule pairs, of which 131 are cross-source and eligible; the case study (`results/case_study/summary.json`) finds 7 of them satisfiable and 124 unsatisfiable, the 5 governed pairs among the latter. Use these figures, as the thesis does.
- The frozen challenge was designed before the repair code ran on it. The settled-winner rule was designed after the order effect on case C04 had been seen, so the 12 cases are not a blind test of it. The chained-priority benchmark (`studies/chain_study.py`) was written afterwards, on 1 November 2026, to test it on new cases: its generator, seed and acceptance rules are recorded in `results/chain_study/protocol.json` with the hashes of the code, and `run` refuses to start if either the code or a case has changed since `prepare`.
- Licenses: the corpus and the named artifacts in `data/policies` are distributed under the MIT license in `data/policies/LICENSE`; Balana is Apache-2.0; OPA is Apache-2.0; the embedding model is Apache-2.0.
