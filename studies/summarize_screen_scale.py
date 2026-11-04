"""Summarize the screening-at-scale raw runs (medians over repetitions).

Usage (from the package root):  python studies/summarize_screen_scale.py
Reads results/screen_scale/raw/*.json and writes results/screen_scale/summary.json.
"""
import json
import statistics
from collections import defaultdict

from common import RESULTS

OUT = RESULTS / 'screen_scale'
COUNTS = ('rules', 'eligible_pairs', 'serial_kept', 'exact_kept', 'sat_pairs', 'serial_retained_sat', 'exact_retained_sat')


def main():
    groups = defaultdict(list)
    for path in sorted((OUT / 'raw').glob('*.json')):
        r = json.loads(path.read_text())
        groups[(r['family'], r['rules'])].append(r)
    rows = []
    for (family, n), runs in sorted(groups.items(), key=lambda x: (x[0][0], x[0][1])):
        for key in COUNTS:
            assert len({r[key] for r in runs}) == 1, (family, n, key)
        med = lambda f: round(statistics.median(f(r) for r in runs) / 1000, 3)
        first = runs[0]
        row = {k: first[k] for k in COUNTS}
        row.update({
            'family': family, 'repetitions': len(runs),
            'unresolved_pairs': sum(r['unresolved_pairs'] for r in runs),
            'label_disagreements': sum(r['label_disagreements'] for r in runs),
            'serial_screen_s': med(lambda r: r['serial_screen_ms']),
            'model_loading_embedding_s': med(lambda r: r['serial_phase_ms']['model_loading_embedding_ms']),
            'rdf_build_query_s': med(lambda r: r['serial_phase_ms']['rdf_build_query_ms']),
            'serial_candidate_s': med(lambda r: r['serial_candidate_ms']),
            'triage_s': med(lambda r: r['serial_screen_ms'] + r['serial_candidate_ms']),
            'triage_range_s': [round(min(r['serial_screen_ms'] + r['serial_candidate_ms'] for r in runs) / 1000, 3),
                               round(max(r['serial_screen_ms'] + r['serial_candidate_ms'] for r in runs) / 1000, 3)],
            'exhaustive_s': med(lambda r: r['exhaustive_ms']),
            'exhaustive_range_s': [round(min(r['exhaustive_ms'] for r in runs) / 1000, 3),
                                   round(max(r['exhaustive_ms'] for r in runs) / 1000, 3)],
            'equality_screen_and_candidates_s': med(lambda r: r['exact_screen_and_candidate_ms']),
            'certified_with_screen_s': med(lambda r: r['serial_screen_ms'] + r['serial_candidate_ms'] + r['exhaustive_ms']),
            'conflicts_missed_by_serial_screen': first['sat_pairs'] - first['serial_retained_sat'],
            'missed_percent': round(100 * (first['sat_pairs'] - first['serial_retained_sat']) / first['sat_pairs'], 2)
            if first['sat_pairs'] else None,
            'pairs_removed_percent': round(100 * (1 - first['serial_kept'] / first['eligible_pairs']), 2),
        })
        rows.append(row)
    (OUT / 'summary.json').write_text(json.dumps({
        'note': 'Medians over fresh-process repetitions on one Linux container (2 vCPU). Triage = serial screen '
                '(model loading, embeddings, entity gate, RDF/SPARQL gate) + SMT checks of the kept pairs only; '
                'no certificate. Certified use needs the exhaustive audit in addition.',
        'rows': rows}, indent=1))
    for r in rows:
        print(r['family'], r['rules'], r['repetitions'], f"{r['serial_kept']}/{r['eligible_pairs']}",
              f"{r['serial_retained_sat']}/{r['sat_pairs']}", r['triage_s'], r['exhaustive_s'], r['missed_percent'])


if __name__ == '__main__':
    main()
