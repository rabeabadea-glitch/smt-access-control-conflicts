# v3 — pipeline and experiments of the IEEE Software article

Resubmission of manuscript SW-2026-04-0177, "Don't Trust Similarity, Verify It:
Solver-Backed Witnesses for Multi-Framework Policy Conflicts".

Everything in this folder is new in v3. Nothing outside it was changed: v3 imports the
verified core (`src/pcproof`), the screening primitives (`src/research/screening.py`) and
the Rego export (`src/research/rego.py`) as they are.

## What v3 adds

| File | What it does |
|---|---|
| `intake.py` | Reads XACML 3.0 rule by rule into the Common Policy Model. Each rule keeps the Targets it inherits, its own Target and its Condition. Combining algorithms are not applied; obligations, advice and descriptions are skipped and counted. A request is taken to carry one value per attribute, so `T-is-in(c, a)` is read as `a = c` and `T-at-least-one-member-of(T-bag(c1..cn), a)` as `a = c1 or ... or a = cn`; any other bag function stops the intake. |
| `structural.py` | The SPARQL scope query. It drops a Permit/Deny pair only when the two rules require different constants for the same attribute, so it cannot lose a conflict. Every run cross-checks it against the plain-Python rule of the core. |
| `funnel.py` | One table per policy set with every opposite-effect rule pair: similarity, entity overlap, scope query, the two text baselines, the Z3 verdict and the witness. All numbers of the article derive from these tables. |
| `independent_check.py` | Evaluator that shares no code with the pipeline. It re-reads the XML, enumerates the request space (or searches it when it is too large) and compares with Z3 pair by pair. |
| `replay.py` | Replays every witness in Balana (per-rule XACML policies) and in Open Policy Agent (Rego export). |
| `inject.py` | Plants rule pairs whose label is known by construction (flipped copies, single-request rules, near misses) and checks the solver and each filter on them. |
| `timing.py` | Wall-clock time of every filter variant of the ablation, one fresh process per repetition. |
| `ci_gate.py` | Pull-request gate: fails when a pair that was conflict-free in the base file is a conflict in the changed file. `examples/policy-gate.yml` is the GitHub Actions job. |
| `model_check.py` | Checks the embedding model on disk against `models/all-MiniLM-L6-v2/manifest.json` and against the screening counts stored by the thesis runs. |
| `analyze.py` | Builds `results/summary.json`, the ablation table, the threshold sweeps and the two figures. |
| `fetch_xpa.sh` | Downloads the Pluto and Fedora policy files from the XPA repository at a fixed commit and checks their SHA-256. |
| `run_all.sh` | Runs all of the above from an empty `results/` folder. |

Policy sets: `data/policies/GEYSERS.xml`, `KMarket.xml`, `continue-a-xacml3.xml`,
`cross_source_corpus.xml` (with `regulatory_mapping.md`, the clause-to-rule table), and
`v3/data/synthetic360.xml`.

Two further policy sets are not stored here, because their repository publishes no licence
for them. `fetch_xpa.sh` (called by `run_all.sh`) downloads them into `v3/data/xpa/` from
github.com/dianxiangxu/XPA at commit `89c000495d81a1a82ca8de2ab0fc73fecfc4e440` and checks
their hashes. For the same reason `results/replay/Pluto` and `results/replay/Fedora`, which
hold rule-by-rule copies of the two files, are not stored; `run_all.sh` regenerates them, and
their outcome is in `results/replay_summary.json`.

| Policy set | File in XPA | Rules | Used before in |
|---|---|---|---|
| Pluto | `Experiments/pluto3/pluto3.xml` | 21 (20 Permit, 1 default Deny) | Hu, Ahn and Kulkarni, IEEE TDSC 10(6), 2013, doi:10.1109/TDSC.2013.18 (access policy of the ARCHON digital library; listed there with 22 rules) |
| Fedora | `Experiments/fedora-rule3/fedora-rule3.xml` | 12 (5 Permit, 7 Deny) | Xu, Shrestha and Shen, SACMAT 2018, doi:10.1145/3205977.3205979 (policy of the Fedora repository software) |

## Reproduce

Follow the "Setup" section of the top-level README (Python packages, Z3, Balana, OPA and
the embedding model), then from the repository root:

```bash
export Z3_LIBRARY=...   OPA=...   BALANA_CP=...      # as in the top-level README
bash v3/run_all.sh
```

About half an hour on a 2-core machine. The script stops at once if the embedding model
does not reproduce the stored thesis counts.

## Changes against the v2 pipeline of the first submission

* The intake works per rule and applies no combining algorithm, so a rule pair is judged
  on applicability alone.
* The structural stage is a new SPARQL query that is sound by construction. The older
  shared-attribute gate is still reported (`older shared-attribute SPARQL gate` in
  `results/table2_ablation.csv`); on Continue-A it removes no pair.
* Filters are measured on opposite-effect pairs only, the pairs that can conflict.
  Results are reported as conflicts kept and solver calls saved, not as F1.
* The solver budget is 2 s per call (5 s in v2). No call came near either value.
