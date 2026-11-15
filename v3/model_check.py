"""Is the embedding model on disk the one the thesis runs used?

Two answers are recorded in results/model_check.json:
  matches_manifest   the SHA-256 of onnx/model.onnx equals the one pinned in models/all-MiniLM-L6-v2/manifest.json
  stored_counts      the model reproduces the nine screening counts that the thesis runs stored in
                     results/screen_scale/raw/ (serial E AND N AND G screen, 69,385 rule pairs in total)
A file that fails the first test but passes the second is another ONNX export of the same weights.

Usage:  python v3/model_check.py
"""
from __future__ import annotations
import glob
import json
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parent
sys.path.insert(0, str(ROOT / 'src'))
sys.path.insert(0, str(HERE))


def main():
    import funnel
    from pcproof.model import normalize
    from research.screening import ScreeningSession
    out = {'model_file': funnel.model_file(), 'stored_counts': []}
    session = ScreeningSession(funnel.MODEL_DIR)
    for family in ('heterogeneous', 'interval', 'disjoint'):
        for size in ('030', '100', '300'):
            name = f'{family}-{size}'
            stored = {json.loads(Path(f).read_text())['serial_kept'] for f in glob.glob(str(ROOT / 'results' / 'screen_scale' / 'raw' / f'{name}-rep*.json'))}
            assert len(stored) == 1, name
            folder = ROOT / 'results' / 'screen_scale' / 'heterogeneous_inputs' if family == 'heterogeneous' else ROOT / 'data' / 'scaling_inputs'
            s = session.screen(normalize(json.loads((folder / f'{name}.json').read_text())), 'E_AND_N_AND_G')
            near = sum(abs(r['embedding_cosine'] - funnel.EMBED_THRESHOLD) < 0.005 for r in s['scores'])
            out['stored_counts'].append({'input': name, 'pairs': s['eligible_pairs'], 'kept_stored': stored.pop(),
                                         'kept_now': len(s['kept_pairs']), 'pairs_within_0.005_of_threshold': near})
    out['pairs'] = sum(r['pairs'] for r in out['stored_counts'])
    out['reproduces_stored_counts'] = all(r['kept_stored'] == r['kept_now'] for r in out['stored_counts'])
    (HERE / 'results').mkdir(exist_ok=True)
    (HERE / 'results' / 'model_check.json').write_text(json.dumps(out, indent=1))
    print(json.dumps(out, indent=1))
    return 0 if out['reproduces_stored_counts'] else 1


if __name__ == '__main__':
    sys.exit(main())
