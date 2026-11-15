#!/usr/bin/env bash
# Reproduce every v3 number of the article. Run from the repository root after the README "Setup" step
# (Z3_LIBRARY, OPA and BALANA_CP exported; models/all-MiniLM-L6-v2/onnx/model.onnx in place).
# About half an hour on a 2-core machine; Synthetic360 and the timing repetitions take most of it.
set -euo pipefail
SECONDS=0
PY=${PYTHON:-python}
D=data/policies
rm -rf v3/results && mkdir -p v3/results
bash v3/fetch_xpa.sh                      # Pluto and Fedora, downloaded from the XPA repository and hash-checked
$PY -B v3/model_check.py > /dev/null      # stops here if the embedding model does not reproduce the stored thesis counts
$PY -B v3/funnel.py GEYSERS KMarket Continue-A Pluto Fedora CrossFramework Synthetic360
$PY -B v3/independent_check.py v3/results/pairs_GEYSERS.json        $D/GEYSERS.xml             file   > /dev/null
$PY -B v3/independent_check.py v3/results/pairs_KMarket.json        $D/KMarket.xml             file   > /dev/null
$PY -B v3/independent_check.py v3/results/pairs_Continue-A.json     $D/continue-a-xacml3.xml   file   > /dev/null
$PY -B v3/independent_check.py v3/results/pairs_Pluto.json          v3/data/xpa/pluto3.xml       file   > /dev/null
$PY -B v3/independent_check.py v3/results/pairs_Fedora.json         v3/data/xpa/fedora-rule3.xml file   > /dev/null
$PY -B v3/independent_check.py v3/results/pairs_CrossFramework.json $D/cross_source_corpus.xml policy > /dev/null
$PY -B v3/independent_check.py v3/results/pairs_Synthetic360.json   v3/data/synthetic360.xml   file   > /dev/null
$PY -B v3/replay.py KMarket CrossFramework Continue-A Pluto Fedora
$PY -B v3/inject.py Continue-A 100     > /dev/null
$PY -B v3/inject.py CrossFramework 100 > /dev/null
$PY -B v3/timing.py Continue-A 5       > /dev/null
$PY -B v3/timing.py CrossFramework 5   > /dev/null
$PY -B v3/examples/make_ci_example.py
$PY -B v3/ci_gate.py v3/examples/ci_baseline.xml v3/examples/ci_baseline.xml policy
$PY -B v3/ci_gate.py v3/examples/ci_baseline.xml v3/examples/ci_changed.xml policy | tee v3/results/ci_gate_output.txt || true
grep -q '^FAIL: 1 new conflict' v3/results/ci_gate_output.txt     # the CI example must fail the build
$PY -B v3/analyze.py --elapsed $SECONDS
