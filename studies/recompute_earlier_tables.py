"""Recompute three thesis tables from the raw rows of earlier studies (copied into results/earlier).

Table 6.3: screening on the 622 supplementary pair occurrences.
Table 6.14: controlled scaling, 80 fresh-process runs.
Table 6.15: complete-path wall time and sampled memory, 30 runs.
Usage (from the package root):  python studies/recompute_earlier_tables.py
"""
import glob
import json
import re
import statistics
from pathlib import Path

from common import RESULTS, save

E = RESULTS / 'earlier'
out = {}
rows = json.loads((E / 'screening_supplemental_194/pair_rows.json').read_text())
sat = lambda r: r['solver']['status'] == 'SAT'
E_ = lambda r: r['embedding_cosine'] >= 0.65
N_ = lambda r: r['entity_jaccard'] >= 0.25
G_ = lambda r: bool(r['sparql_keep'])
modes = {'E': E_, 'N': N_, 'G': G_, 'E AND N': lambda r: E_(r) and N_(r), 'E AND G': lambda r: E_(r) and G_(r),
         'N AND G': lambda r: N_(r) and G_(r), 'E AND N AND G': lambda r: E_(r) and N_(r) and G_(r),
         'E OR N OR G': lambda r: E_(r) or N_(r) or G_(r), 'Attribute Jaccard 0.5': lambda r: r['attribute_jaccard'] >= 0.5}
P = sum(map(sat, rows))
table = {}
for k, f in modes.items():
    kept = [r for r in rows if f(r)]
    ks = sum(map(sat, kept))
    table[k] = {'kept': len(kept), 'conflicts_kept': ks, 'conflicts_missed': P - ks,
                'recall_pct': round(100 * ks / P, 2), 'reduction_pct': round(100 * (1 - len(kept) / len(rows)), 2)}
out['screening_622'] = {'pairs': len(rows), 'reachable_conflicts': P, 'modes': table}
groups = {}
for f in glob.glob(str(E / 'scaling/raw/*.outer.json')):
    m = re.search(r'(disjoint|interval)-(\d+)-(exact|exhaustive)-rep(\d)', f)
    groups.setdefault(f'{int(m.group(2))}-{m.group(1)}-{m.group(3)}', []).append(json.loads(Path(f).read_text()))
out['controlled_scaling'] = {k: {'runs': len(v), 'passed': sum(1 for d in v if d['completed'] and d['returncode'] == 0),
                                 'median_s': round(statistics.median(d['outer_wall_ms'] / 1000 for d in v), 3),
                                 'min_s': round(min(d['outer_wall_ms'] for d in v) / 1000, 3),
                                 'max_s': round(max(d['outer_wall_ms'] for d in v) / 1000, 3)}
                             for k, v in sorted(groups.items(), key=lambda kv: (int(kv[0].split('-')[0]), kv[0]))}
fc = json.loads((E / 'full_chain/run_rows.json').read_text())
path = {}
for grp in (1, 2, 4):
    for mode in ('EXHAUSTIVE', 'E_AND_N_AND_G'):
        rs = [r for r in fc if r['groups'] == grp and r['mode'] == mode]
        path[f'{2 * grp}-files-{mode}'] = {'runs': len(rs), 'median_s': round(statistics.median(r['wall_ms'] / 1000 for r in rs), 3),
                                           'min_s': round(min(r['wall_ms'] for r in rs) / 1000, 3),
                                           'max_s': round(max(r['wall_ms'] for r in rs) / 1000, 3),
                                           'median_sampled_MiB': round(statistics.median(r['sampled_max_tree_working_set_MiB'] for r in rs), 1)}
out['complete_path'] = path
save(RESULTS / 'earlier_tables_recomputed.json', out)
print(json.dumps(out, indent=1))
