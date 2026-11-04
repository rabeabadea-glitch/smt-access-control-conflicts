#!/bin/bash
# Runs the remaining final-revision studies in order, after the order study has finished.
cd /home/user/pkg
export Z3_LIBRARY=/home/user/venv312/lib/python3.12/site-packages/z3/lib/libz3.so
export OPA=/home/user/tools/opa/opa
export BALANA_CP="/home/user/pkg/tools/xacml/classes:/home/user/pkg/tools/xacml/lib/*"
PY=/home/user/venv312/bin/python
while pgrep -f "studies/order_study.py run" >/dev/null; do sleep 10; done
mkdir -p tools/xacml/classes && javac -cp "tools/xacml/lib/*" -d tools/xacml/classes tools/xacml/BalanaBatch.java 2>/dev/null
$PY -B studies/order_study.py summarize > results/order_study/summarize.log 2>&1
$PY -B studies/native_replay.py > results/native_replay.log 2>&1 || echo "native failed"
$PY -B studies/retirement_study.py > results/retirement.log 2>&1 || echo "retirement failed"
$PY -B studies/workflow_regression.py listed > results/workflow_regression_listed.log 2>&1 || echo "regression listed failed"
$PY -B studies/workflow_regression.py settled > results/workflow_regression_settled.log 2>&1 || echo "regression settled failed"
$PY -B studies/case_study.py > results/case_study.log 2>&1 || echo "case study failed"
$PY -B studies/conversion_study.py > results/conversion_study.log 2>&1 || echo "conversion failed"
echo "STAGE1_DONE"
$PY -B studies/screen_scale_study.py 3 > results/screen_scale.log 2>&1 || echo "screen scale failed"
echo "ALL_DONE"
