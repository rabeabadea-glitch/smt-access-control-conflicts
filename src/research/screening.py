"""Auditable semantic candidate gates; all gates are heuristics, never proof.

Text deliberately verbalizes normalized predicates. It does not pretend to be
source natural language, a regulatory interpretation, or learned NER.
"""
from __future__ import annotations
import hashlib, json, re, time
from pathlib import Path
import numpy as np
from rdflib import Graph, Namespace, Literal, URIRef
from tokenizers import Tokenizer
import onnxruntime as ort

MODEL_REVISION='1110a243fdf4706b3f48f1d95db1a4f5529b4d41'
EMBED_THRESHOLD=0.65
ENTITY_THRESHOLD=0.25
EX=Namespace('urn:pcproof:screen:')
QUERY='''PREFIX ex: <urn:pcproof:screen:>
SELECT DISTINCT ?a ?b WHERE {
  ?a ex:effect ?ea ; ex:source ?sa .
  ?b ex:effect ?eb ; ex:source ?sb .
  FILTER(STR(?a) < STR(?b) && ?ea != ?eb && ?sa != ?sb)
  FILTER(EXISTS { ?a ex:mentionsAttribute ?common . ?b ex:mentionsAttribute ?common . }
      || NOT EXISTS { ?a ex:mentionsAttribute ?aa . }
      || NOT EXISTS { ?b ex:mentionsAttribute ?bb . })
}'''

def digest(value):
    return hashlib.sha256(json.dumps(value,sort_keys=True,separators=(',',':'),ensure_ascii=True).encode()).hexdigest()

def source_attribute_key(record):
    if record.get('key'):return record['key']
    if 'AttributeId' in record and 'DataType' in record:
        return [record.get('Category','unknown'),record['AttributeId'],record['DataType']]
    return None

def attribute_identity(attr, mapping):
    record=mapping.get(attr,{})
    key=source_attribute_key(record)
    return json.dumps(key,separators=(',',':')) if key else attr

def attribute_label(attr,mapping):
    record=mapping.get(attr,{})
    key=source_attribute_key(record)
    if not key:return attr.replace('_',' ')
    category=key[0].rsplit(':',1)[-1].replace('-',' ')
    identifier=key[1].rsplit(':',1)[-1].rsplit('/',1)[-1].replace('-',' ').replace('_',' ')
    return category+' '+identifier

def verbalize(expr,mapping):
    if type(expr) is bool:return 'always applies' if expr else 'never applies'
    op=expr['op']
    if op in ('and','or'):
        return '('+(' and ' if op=='and' else ' or ').join(verbalize(x,mapping) for x in expr['args'])+')'
    if op=='not':return 'not ('+verbalize(expr['arg'],mapping)+')'
    words={'eq':'equals','ne':'does not equal','lt':'is less than','le':'is at most','gt':'is greater than','ge':'is at least'}
    value=json.dumps(expr['value'],ensure_ascii=False)
    return attribute_label(expr['attr'],mapping)+' '+words[op]+' '+value

def atoms(expr):
    if type(expr) is bool:return []
    if expr['op'] in ('and','or'):return [a for child in expr['args'] for a in atoms(child)]
    if expr['op']=='not':return atoms(expr['arg'])
    return [expr]

def entities(expr,mapping):
    out=set()
    for atom in atoms(expr):
        attr=attribute_identity(atom['attr'],mapping)
        out.add('attribute:'+attr)
        out.add('literal:'+attr+':'+json.dumps(atom['value'],sort_keys=True,ensure_ascii=True))
    return out

def entity_score(a,b):
    if not a or not b:return 1.0
    return len(a&b)/len(a|b)

class Embedder:
    def __init__(self,modeldir):
        started=time.perf_counter()
        self.tok=Tokenizer.from_file(str(Path(modeldir)/'tokenizer.json'))
        self.tok.enable_truncation(max_length=256)
        self.tok.enable_padding(length=None)
        opts=ort.SessionOptions();opts.intra_op_num_threads=1;opts.inter_op_num_threads=1
        self.session=ort.InferenceSession(str(Path(modeldir)/'onnx/model.onnx'),sess_options=opts,providers=['CPUExecutionProvider'])
        self.load_ms=(time.perf_counter()-started)*1000
        self.inputs=[x.name for x in self.session.get_inputs()]
    def encode(self,texts,batchsize=16):
        vectors=[];counts=[]
        for start in range(0,len(texts),batchsize):
            batch=texts[start:start+batchsize]
            self.tok.no_truncation();self.tok.no_padding()
            raw=self.tok.encode_batch(batch)
            counts.extend([len(e.ids) for e in raw])
            self.tok.enable_truncation(max_length=256);self.tok.enable_padding(length=None)
            enc=self.tok.encode_batch(batch)
            data={'input_ids':np.asarray([x.ids for x in enc],dtype=np.int64),'attention_mask':np.asarray([x.attention_mask for x in enc],dtype=np.int64),'token_type_ids':np.asarray([x.type_ids for x in enc],dtype=np.int64)}
            output=self.session.run(None,{name:data[name] for name in self.inputs})[0]
            mask=data['attention_mask'][...,None].astype(np.float32)
            pooled=(output*mask).sum(axis=1)/np.maximum(mask.sum(axis=1),1e-9)
            normalized=pooled/np.maximum(np.linalg.norm(pooled,axis=1,keepdims=True),1e-12)
            if not np.isfinite(normalized).all():raise ValueError('Invalid embedding')
            vectors.extend(normalized)
        return np.asarray(vectors,dtype=np.float32),counts

def graph_gate(policy,mapping,pair_scope='cross_source'):
    graph=Graph();graph.bind('ex',EX)
    identifiers={r['id']:URIRef(EX+'rule/'+digest(r['id'])) for r in policy['rules']}
    reverse={str(v):k for k,v in identifiers.items()}
    mentions={}
    for rule in policy['rules']:
        node=identifiers[rule['id']]
        graph.add((node,EX.effect,Literal(rule['effect'])))
        graph.add((node,EX.source,Literal(rule['source'])))
        mentions[rule['id']]={attribute_identity(a['attr'],mapping) for a in atoms(rule['condition'])}
        for attr in sorted(mentions[rule['id']]):graph.add((node,EX.mentionsAttribute,URIRef(EX+'attribute/'+digest(attr))))
        for entity in sorted(entities(rule['condition'],mapping)):
            enode=URIRef(EX+'entity/'+digest(entity))
            graph.add((node,EX.mentionsEntity,enode));graph.add((enode,EX.label,Literal(entity)))
    query=QUERY if pair_scope=='cross_source' else QUERY.replace('?sa != ?sb','?sa = ?sb')
    kept={tuple(sorted((reverse[str(row.a)],reverse[str(row.b)]))) for row in graph.query(query)}
    # Check query execution against the directly stated structural heuristic.
    expected=set()
    import itertools
    for a,b in itertools.combinations(policy['rules'],2):
        source_ok=a['source']!=b['source'] if pair_scope=='cross_source' else a['source']==b['source']
        if not source_ok or a['effect']==b['effect']:continue
        x,y=mentions[a['id']],mentions[b['id']]
        if not x or not y or x&y:expected.add(tuple(sorted((a['id'],b['id']))))
    if kept!=expected:raise AssertionError('SPARQL/direct structural-gate disagreement')
    return kept,graph

MODES=['exhaustive','exact','attribute_jaccard','E','N','G','E_AND_N','E_AND_G','N_AND_G','E_AND_N_AND_G','E_OR_N_OR_G']
def mode_keep(mode,e,n,g,exact,jaccard):
    return {'exhaustive':True,'exact':exact,'attribute_jaccard':jaccard,'E':e,'N':n,'G':g,'E_AND_N':e and n,'E_AND_G':e and g,'N_AND_G':n and g,'E_AND_N_AND_G':e and n and g,'E_OR_N_OR_G':e or n or g}[mode]

def phase_modes(mode):
    parts=mode.replace('_AND_','_').replace('_OR_','_').split('_')
    return {'embedding':'E' in parts,'entity':'N' in parts,'graph':'G' in parts}

class ScreeningSession:
    """Reusable integration API. It screens candidates; it does not certify them.

    The caller must pass a validated CPM, preserve all omitted pairs, and run a
    complete supported-fragment verification before claiming conflict freedom.
    Sources are never rewritten. An optional within-source scope is explicitly
    diagnostic and cannot be reported as cross-source conflict detection.
    """
    def __init__(self,modeldir):
        self.modeldir=Path(modeldir);self.embedder=None
    def screen(self,policy,mode='E_AND_N_AND_G',mapping=None,pair_scope='cross_source'):
        if mode not in MODES:raise ValueError('Unknown screening mode')
        if pair_scope not in ('cross_source','within_source_opposite_effect'):raise ValueError('Unknown pair scope')
        from pcproof.verify import can_skip_exact, attr_mentions
        import itertools
        started=time.perf_counter();mapping=mapping or {};needed=phase_modes(mode)
        pairs=[(a,b) for a,b in itertools.combinations(policy['rules'],2)
               if a['effect']!=b['effect'] and ((a['source']!=b['source']) if pair_scope=='cross_source' else (a['source']==b['source']))]
        phases={};representation_counts={'truncated_rules':0};errors=[];rules=policy['rules'];vec={};ents={};gpairs=None
        if needed['embedding'] and pairs:
            tick=time.perf_counter()
            try:
                if self.embedder is None:self.embedder=Embedder(self.modeldir)
                vectors,counts=self.embedder.encode([verbalize(r['condition'],mapping) for r in rules])
                vec={r['id']:vectors[i] for i,r in enumerate(rules)}
                representation_counts['truncated_rules']=sum(c>256 for c in counts)
            except Exception as error:errors.append({'gate':'E','error':repr(error),'policy':'retain_unknown_pairs'})
            phases['model_loading_embedding_ms']=(time.perf_counter()-tick)*1000
        if needed['entity'] and pairs:
            tick=time.perf_counter()
            try:ents={r['id']:entities(r['condition'],mapping) for r in rules}
            except Exception as error:errors.append({'gate':'N','error':repr(error),'policy':'retain_unknown_pairs'});ents={}
            phases['entity_ms']=(time.perf_counter()-tick)*1000
        if needed['graph'] and pairs:
            tick=time.perf_counter()
            try:gpairs,_=graph_gate(policy,mapping,pair_scope)
            except Exception as error:errors.append({'gate':'G','error':repr(error),'policy':'retain_unknown_pairs'})
            phases['rdf_build_query_ms']=(time.perf_counter()-tick)*1000
        rows=[];kept=[];dropped=[]
        for a,b in pairs:
            cosine=float(np.dot(vec[a['id']],vec[b['id']])) if a['id'] in vec and b['id'] in vec else None
            n=entity_score(ents[a['id']],ents[b['id']]) if a['id'] in ents and b['id'] in ents else None
            g=tuple(sorted((a['id'],b['id']))) in gpairs if gpairs is not None else None
            x,y=attr_mentions(a['condition']),attr_mentions(b['condition']);j=len(x&y)/max(1,len(x|y))
            retain=mode_keep(mode,cosine is None or cosine>=EMBED_THRESHOLD,n is None or n>=ENTITY_THRESHOLD,g is None or g,not can_skip_exact(a,b),j>=.5)
            pair=[a['id'],b['id']];(kept if retain else dropped).append(pair)
            rows.append({'pair':pair,'embedding_cosine':cosine,'entity_jaccard':n,'sparql_keep':g,'retained':retain})
        return {'status':'HEURISTIC_SCREEN_ONLY','mode':mode,'pair_scope':pair_scope,'eligible_pairs':len(pairs),'kept_pairs':kept,'dropped_pairs':dropped,'scores':rows,'errors':errors,'phase_ms':phases,'representation_counts':representation_counts,'elapsed_ms':(time.perf_counter()-started)*1000,'model_revision':MODEL_REVISION,'thresholds':{'embedding_cosine':EMBED_THRESHOLD,'entity_jaccard':ENTITY_THRESHOLD},'text_profile':'deterministic_structured_predicate_verbalization','final_exhaustive_certification_required':True}
