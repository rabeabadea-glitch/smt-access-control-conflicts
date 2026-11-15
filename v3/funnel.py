"""v3 funnel: one pair table per dataset, every number in the article derives from it.

For every eligible pair (opposite effects; and different sources in the cross-framework
corpus) the table records
  cosine   similarity of the two verbalised rules (all-MiniLM-L6-v2, stage E)
  jaccard  overlap of the attribute/literal entities of the two rules (stage N)
  scope    whether the SPARQL scope query of structural.py keeps the pair (stage S, sound)
  graph    the older shared-attribute SPARQL gate of src/research/screening.py, kept for the record
  tfidf, keyword   the two text-only baselines
  status, solve_ms the exhaustive solver answer (SAT = one request fires both rules)
  witness  the request returned by the solver for SAT pairs
The screening primitives are the unmodified ones of src/research/screening.py and the
solver path is the unmodified pcproof.verify.Verifier.
"""
from __future__ import annotations
import itertools
import json
import math
import re
import sys
import time
from collections import defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / 'src'))
sys.path.insert(0, str(Path(__file__).resolve().parent))
import intake  # noqa: E402
import structural  # noqa: E402
from pcproof.model import conj  # noqa: E402
from pcproof.verify import Verifier  # noqa: E402
from research import screening  # noqa: E402

MODEL_DIR = ROOT / 'models' / 'all-MiniLM-L6-v2'
OUT = Path(__file__).resolve().parent / 'results'
EMBED_THRESHOLD = screening.EMBED_THRESHOLD      # 0.65
ENTITY_THRESHOLD = screening.ENTITY_THRESHOLD    # 0.25
TFIDF_THRESHOLD = 0.30                           # as in the v2 baseline
KEYWORD_THRESHOLD = 0.20                         # as in the v2 baseline
SOLVER_BUDGET_MS = 2000
DATASETS = {
    'GEYSERS': (ROOT / 'data/policies/GEYSERS.xml', 'file'),
    'KMarket': (ROOT / 'data/policies/KMarket.xml', 'file'),
    'Continue-A': (ROOT / 'data/policies/continue-a-xacml3.xml', 'file'),
    'Pluto': (Path(__file__).resolve().parent / 'data/xpa/pluto3.xml', 'file'),            # fetched by v3/fetch_xpa.sh
    'Fedora': (Path(__file__).resolve().parent / 'data/xpa/fedora-rule3.xml', 'file'),     # fetched by v3/fetch_xpa.sh
    'Synthetic360': (Path(__file__).resolve().parent / 'data/synthetic360.xml', 'file'),
    'CrossFramework': (ROOT / 'data/policies/cross_source_corpus.xml', 'policy'),
}


def model_file():
    """SHA-256 of the embedding model on disk and whether it is the file pinned in manifest.json."""
    path = MODEL_DIR / 'onnx' / 'model.onnx'
    if not path.exists():
        return None
    import hashlib
    h = hashlib.sha256()
    with open(path, 'rb') as f:
        for block in iter(lambda: f.read(1 << 20), b''):
            h.update(block)
    pinned = {x['path']: x['sha256'] for x in json.loads((MODEL_DIR / 'manifest.json').read_text())['files']}
    return {'sha256': h.hexdigest(), 'matches_manifest': h.hexdigest() == pinned.get('onnx/model.onnx')}


def eligible(rules, sources):
    return [(a, b) for a, b in itertools.combinations(rules, 2)
            if a['effect'] != b['effect'] and (sources == 'file' or a['source'] != b['source'])]


def scope(sources):
    return 'cross_source' if sources == 'policy' else 'within_source_opposite_effect'


def texts(display, mapping):
    return {r['id']: screening.verbalize(r['condition'], mapping) for r in display['rules']}


def tfidf_vectors(text):
    docs = {k: re.findall(r'\w+', v.lower()) for k, v in text.items()}
    df = defaultdict(int)
    for doc in docs.values():
        for t in set(doc):
            df[t] += 1
    n = len(docs)
    idf = {t: math.log(n / (1 + d)) for t, d in df.items()}
    out = {}
    for k, doc in docs.items():
        tf = defaultdict(int)
        for t in doc:
            tf[t] += 1
        total = len(doc) or 1
        vec = {t: (c / total) * idf[t] for t, c in tf.items()}
        out[k] = (vec, math.sqrt(sum(x * x for x in vec.values())))
    return out


def tfidf_cosine(a, b):
    (va, na), (vb, nb) = a, b
    if not na or not nb:
        return 0.0
    small, large = (va, vb) if len(va) < len(vb) else (vb, va)
    return sum(x * large.get(t, 0.0) for t, x in small.items()) / (na * nb)


def keywords(expr):
    return {json.dumps(a['value']).strip('"').lower() for a in screening.atoms(expr)}


def jaccard(x, y):
    return len(x & y) / len(x | y) if x | y else 0.0


def build(name, with_model=True):
    path, sources = DATASETS[name]
    m = intake.load(path, sources)
    cpm, display, mapping = m['cpm'], m['display'], m['mapping']
    ids = {r['id']: r for r in cpm['rules']}
    shown = {r['id']: r for r in display['rules']}
    pairs = eligible(display['rules'], sources)
    # stage scores -----------------------------------------------------------
    text = texts(display, mapping)
    vec = {}
    if with_model and pairs:
        emb = screening.Embedder(MODEL_DIR)
        vectors, _ = emb.encode([text[r['id']] for r in display['rules']])
        vec = {r['id']: vectors[i] for i, r in enumerate(display['rules'])}
    ents = {r['id']: screening.entities(r['condition'], mapping) for r in display['rules']}
    gpairs = screening.graph_gate(display, mapping, scope(sources))[0] if pairs else set()
    spairs = structural.kept_pairs(display['rules'], pairs)
    tv = tfidf_vectors(text)
    kw = {r['id']: keywords(r['condition']) for r in display['rules']}
    # exhaustive solver ---------------------------------------------------------
    v = Verifier(cpm, SOLVER_BUDGET_MS)
    own = {r['id']: v.check(r['condition'])['status'] for r in cpm['rules']}
    rows = []
    for a, b in pairs:
        ans = v.check(conj(ids[a['id']]['condition'], ids[b['id']]['condition']))
        rows.append({
            'pair': [a['id'], b['id']], 'effects': [a['effect'], b['effect']],
            'cosine': float(vec[a['id']] @ vec[b['id']]) if vec else None,
            'jaccard': screening.entity_score(ents[a['id']], ents[b['id']]),
            'graph': tuple(sorted((a['id'], b['id']))) in gpairs,
            'scope': tuple(sorted((a['id'], b['id']))) in spairs,
            'tfidf': tfidf_cosine(tv[a['id']], tv[b['id']]),
            'keyword': jaccard(kw[a['id']], kw[b['id']]),
            'status': ans['status'], 'solve_ms': ans['elapsed_ms'], 'witness': ans['witness'],
        })
    table = {'dataset': name, 'stats': m['stats'], 'eligible_pairs': len(pairs),
             'all_pairs': len(cpm['rules']) * (len(cpm['rules']) - 1) // 2,
             'dead_rules': sum(s == 'UNSAT' for s in own.values()),
             'own_scope_status': {s: list(own.values()).count(s) for s in set(own.values())},
             'thresholds': {'embedding_cosine': EMBED_THRESHOLD, 'entity_jaccard': ENTITY_THRESHOLD,
                            'tfidf': TFIDF_THRESHOLD, 'keyword': KEYWORD_THRESHOLD, 'solver_budget_ms': SOLVER_BUDGET_MS},
             'model_revision': screening.MODEL_REVISION if vec else None,
             'model_file': model_file() if vec else None,
             'z3': v.z.version, 'rows': rows}
    return table, m


if __name__ == '__main__':
    OUT.mkdir(exist_ok=True)
    with_model = (MODEL_DIR / 'onnx' / 'model.onnx').exists()
    for name in sys.argv[1:] or DATASETS:
        t = time.perf_counter()
        table, _ = build(name, with_model)
        (OUT / f'pairs_{name}.json').write_text(json.dumps(table, indent=1))
        st = defaultdict(int)
        for r in table['rows']:
            st[r['status']] += 1
        print(name, table['stats']['rules'], 'rules', table['eligible_pairs'], 'pairs', dict(st),
              'model' if with_model else 'NO MODEL (stage E missing)', f'{time.perf_counter() - t:.1f}s', flush=True)
