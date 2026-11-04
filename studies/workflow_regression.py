"""Re-run the two earlier generated repair-family drivers with each pair-selection rule.

The original drivers (data/workflow_drivers/run_workflow_studies.py and
run_workflow_second_family.py) generate their own fixtures from fixed seeds and
assert the expected outcome of every case; any different outcome stops the
driver with an AssertionError. This wrapper copies each driver, changes only
host paths (Windows DLL loading, output folder, protocol-hash lookup) and,
for the 'settled' rule, binds refine_bounded to extensions.settled_refinement.
The two injected-failure controls patch names inside the module that runs the
loop, so the patch target follows the selected module.

Usage (from the package root):  python studies/workflow_regression.py listed|settled
"""
import os
import re
import subprocess
import sys

from common import ROOT, RESULTS, DATA

rule = sys.argv[1]
assert rule in ('listed', 'settled')
OUT = RESULTS / 'workflow_regression'
patched_dir = OUT / 'patched_drivers' / rule
patched_dir.mkdir(parents=True, exist_ok=True)

BIND = ("\nif os.environ['PAIR_RULE'] == 'settled':\n"
        "    from extensions.settled_refinement import refine_settled as refine_bounded\n"
        "    _LOOP_MODULE = 'extensions.settled_refinement'\n"
        "else:\n"
        "    _LOOP_MODULE = 'research.workflow'\n")


def patch_first(text):
    text = text.replace("WORK=Path(__file__).resolve().parents[1];DEV=WORK.parent",
                        "WORK=Path(os.environ['STUDY_ROOT']);DEV=WORK.parent")
    text = re.sub(r"_dll=os\.add_dll_directory\([^\n]*\n", "", text)
    text = re.sub(r"os\.environ\['Z3_LIBRARY'\]=str\([^\n]*\n", "", text)
    text = text.replace("OUT=WORK/'results/workflow'", "OUT=Path(os.environ['STUDY_OUT'])")
    text = text.replace("from research.workflow import refine_bounded,apply_precedence",
                        "from research.workflow import refine_bounded,apply_precedence" + BIND)
    text = text.replace("patch('research.workflow.conj'", "patch(_LOOP_MODULE+'.conj'")
    text = text.replace("patch('research.workflow.audit'", "patch(_LOOP_MODULE+'.audit'")
    text = text.replace("hashlib.sha256((WORK/'protocols/workflow_protocol.json').read_bytes()).hexdigest()",
                        "'original protocol hash not recomputed in this rerun'")
    return text


def patch_second(text):
    text = text.replace("W=Path(__file__).resolve().parents[1];D=W.parent",
                        "W=Path(os.environ['STUDY_ROOT']);D=W.parent")
    text = re.sub(r"handle=os\.add_dll_directory\([^\n]*\n", "", text)
    text = text.replace("O=W/'results/workflow_second_family'", "O=Path(os.environ['STUDY_OUT'])")
    text = text.replace("from research.workflow import refine_bounded", "from research.workflow import refine_bounded" + BIND)
    text = text.replace("hashlib.sha256((W/'protocols/workflow_second_family_addendum.json').read_bytes()).hexdigest()",
                        "'original protocol hash not recomputed in this rerun'")
    return text


for name, patcher, label in [('run_workflow_studies.py', patch_first, 'first_family'),
                             ('run_workflow_second_family.py', patch_second, 'second_family')]:
    text = patcher((DATA / 'workflow_drivers' / name).read_text(encoding='utf-8'))
    if 'os.add_dll_directory' in text or 'PAIR_RULE' not in text:
        raise SystemExit('Patch did not apply cleanly to ' + name)
    target = patched_dir / name
    target.write_text(text, encoding='utf-8')
    env = dict(os.environ, STUDY_ROOT=str(ROOT), STUDY_OUT=str(OUT / label / rule), PAIR_RULE=rule,
               PYTHONPATH=str(ROOT / 'src'))
    proc = subprocess.run([sys.executable, '-B', str(target)], env=env, capture_output=True, text=True)
    (OUT / f'{label}_{rule}.stdout.txt').write_text(proc.stdout)
    (OUT / f'{label}_{rule}.stderr.txt').write_text(proc.stderr)
    print(label, rule, 'exit', proc.returncode, flush=True)
    if proc.returncode:
        print(proc.stderr[-3000:])
        sys.exit(proc.returncode)
