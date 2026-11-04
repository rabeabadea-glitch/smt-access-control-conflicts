"""Research XACML 3.0 total-singleton profile. Does not silently flatten combiners.

The source XML evaluator, typed-tree compiler and writer are separate paths.
This module does not implement missing attributes, bags, advice or obligations.
"""
from __future__ import annotations
import hashlib,json,itertools,xml.etree.ElementTree as ET
from pathlib import Path
from collections import defaultdict
from pcproof.model import normalize,evaluate
from research import temporal

NS='urn:oasis:names:tc:xacml:3.0:core:schema:wd-17'
FN='urn:oasis:names:tc:xacml:1.0:function:'
XS='http://www.w3.org/2001/XMLSchema#'
ET.register_namespace('',NS)
OPS={'equal':'eq','less-than':'lt','less-than-or-equal':'le','greater-than':'gt','greater-than-or-equal':'ge'}
INV={'eq':'eq','ne':'ne','lt':'gt','le':'ge','gt':'lt','ge':'le'}
COMBINERS={'first-applicable','deny-overrides','permit-overrides','ordered-deny-overrides','ordered-permit-overrides','deny-unless-permit','permit-unless-deny'}
def valid_combiner(uri,kind):
    context='rule' if kind=='Policy' else 'policy'
    allowed={f'urn:oasis:names:tc:xacml:{version}:{context}-combining-algorithm:{name}' for version,names in [('1.0',{'first-applicable','deny-overrides','permit-overrides'}),('3.0',{'deny-overrides','permit-overrides','ordered-deny-overrides','ordered-permit-overrides','deny-unless-permit','permit-unless-deny'})] for name in names}
    # Ordered overrides were introduced in XACML1.1 and retained in2.0/3.0.
    allowed|={f'urn:oasis:names:tc:xacml:1.1:{context}-combining-algorithm:{name}' for name in ['ordered-deny-overrides','ordered-permit-overrides']}
    return uri in allowed
class Unsupported(ValueError):pass
def local(e):return e.tag.rsplit('}',1)[-1]
def children(e,name):return [x for x in e if local(x)==name]
def child(e,name):return next((x for x in e if local(x)==name),None)
def sid(category,attr,datatype,issuer=''):
    return 'a_'+hashlib.sha256(json.dumps([category,attr,datatype,issuer]).encode()).hexdigest()[:16]
def key(e):return sid(e.get('Category'),e.get('AttributeId'),e.get('DataType'),e.get('Issuer',''))
def typed(value,datatype):
    if datatype==XS+'dateTime':return temporal.to_milliseconds(value)
    if datatype==XS+'string':return value or ''
    if datatype==XS+'integer':return int((value or '').strip())
    if datatype==XS+'boolean':
        if value.strip() not in ['true','false','0','1']:raise Unsupported('Invalid Boolean literal')
        return value.strip() in ['true','1']
    raise Unsupported('Unsupported datatype '+str(datatype))
def opid(fid):
    for typ in ['string','integer','boolean','dateTime']:
        for tail,op in OPS.items():
            if fid==FN+typ+'-'+tail:
                if typ not in ['integer','dateTime'] and op not in ['eq','ne']:raise Unsupported('Unordered enum/Boolean order '+fid)
                return typ,op
    raise Unsupported('Unsupported comparison '+str(fid))
def code(e):return json.dumps(e,sort_keys=True,separators=(',',':'))
def joint(op,*args):
    flat=[]
    for e in args:
        if e is (False if op=='and' else True):return e
        if e is (True if op=='and' else False):continue
        if isinstance(e,dict) and e.get('op')==op:flat.extend(e['args'])
        else:flat.append(e)
    d={code(e):e for e in flat};flat=list(d.values())
    if not flat:return op=='and'
    if len(flat)==1:return flat[0]
    # CPM connective arity limit is1000. Chunk larger expressions without loss.
    if len(flat)>1000:flat=[joint(op,*flat[i:i+1000]) for i in range(0,len(flat),1000)]
    return {'op':op,'args':flat}
def AND(*a):return joint('and',*a)
def OR(*a):return joint('or',*a)
def NOT(a):
    if type(a) is bool:return not a
    if a.get('op')=='not':return a['arg']
    return {'op':'not','arg':a}
def atom(a,op,c):return {'op':op,'attr':a,'value':c}

def descriptor(e):
    missing=[k for k in ['Category','AttributeId','DataType','MustBePresent'] if k not in e.attrib]
    if missing:raise Unsupported('AttributeDesignator missing '+','.join(missing))
    if e.get('MustBePresent') not in ['true','false','0','1']:raise Unsupported('Invalid MustBePresent')
    if e.get('DataType') not in [XS+'string',XS+'integer',XS+'boolean',XS+'dateTime']:raise Unsupported('Unsupported datatype '+e.get('DataType',''))
    return {'name':key(e),'Category':e.get('Category'),'AttributeId':e.get('AttributeId'),'DataType':e.get('DataType'),'Issuer':e.get('Issuer',''),'MustBePresent':e.get('MustBePresent')}
def scalar(e,attrs,constants):
    tag=local(e)
    if tag=='AttributeDesignator':
        d=descriptor(e);attrs.setdefault(d['name'],{k:v for k,v in d.items() if k!='MustBePresent'})
        return {'kind':'attr','descriptor':d}
    if tag=='AttributeValue':return {'kind':'literal','datatype':e.get('DataType'),'value':typed(e.text,e.get('DataType'))}
    if tag=='Apply' and e.get('FunctionId') in [FN+t+'-one-and-only' for t in ['string','integer','boolean','dateTime']]:
        if len(e)!=1:raise Unsupported('one-and-only arity')
        x=scalar(e[0],attrs,constants)
        if x['kind']!='attr':raise Unsupported('one-and-only requires attribute bag')
        if e.get('FunctionId')!=FN+x['descriptor']['DataType'].rsplit('#',1)[-1]+'-one-and-only':raise Unsupported('one-and-only datatype mismatch')
        return {'kind':'one','function':e.get('FunctionId'),'arg':x}
    raise Unsupported('Unsupported scalar '+tag)
def attr_of(x):
    if x['kind']=='one':return x['arg']['descriptor']
    if x['kind']=='attr':return x['descriptor']
    return None
def comparison(fid,left,right,constants):
    typ,op=opid(fid);a=attr_of(left);b=attr_of(right)
    if a and right['kind']=='literal':c=right;name=a['name']
    elif b and left['kind']=='literal':c=left;name=b['name'];op=INV[op];a=b
    else:raise Unsupported('Require attribute-to-constant comparison')
    if a['DataType']!=c['datatype'] or a['DataType']!=XS+typ:raise Unsupported('Comparison datatype mismatch')
    constants[name].add(c['value'])
    return atom(name,op,c['value'])
def expr(e,attrs,constants):
    if local(e)=='AttributeValue':
        v=typed(e.text,e.get('DataType'))
        if type(v) is not bool:raise Unsupported('Non-Boolean condition')
        return v,{'kind':'bool','value':v}
    if local(e)!='Apply':raise Unsupported('Unsupported condition '+local(e))
    fid=e.get('FunctionId','')
    if fid in [FN+'and',FN+'or',FN+'not']:
        if not len(e) or (fid==FN+'not' and len(e)!=1):raise Unsupported('Boolean function arity')
        pairs=[expr(x,attrs,constants) for x in e];es=[p[0] for p in pairs]
        return (NOT(es[0]) if fid==FN+'not' else joint(fid.rsplit(':',1)[-1],*es)),{'kind':'apply','function':fid,'args':[p[1] for p in pairs]}
    if len(e)!=2:raise Unsupported('Comparison arity')
    # Bare designators are bags: comparison conditions require one-and-only.
    l=scalar(e[0],attrs,constants);r=scalar(e[1],attrs,constants)
    if any(x['kind']=='attr' for x in [l,r]):raise Unsupported('Condition uses bag without one-and-only')
    return comparison(fid,l,r,constants),{'kind':'compare','function':fid,'left':l,'right':r}
def target(e,attrs,constants):
    if e is None or not len(e):return True,[]
    groups=[];result=[]
    for anyof in e:
        if local(anyof)!='AnyOf' or not len(anyof):raise Unsupported('Target expects nonempty AnyOf')
        alts=[];alist=[]
        for allof in anyof:
            if local(allof)!='AllOf' or not len(allof):raise Unsupported('AnyOf expects nonempty AllOf')
            atoms=[];matches=[]
            for m in allof:
                if local(m)!='Match' or len(m)!=2:raise Unsupported('AllOf expects Match')
                v=child(m,'AttributeValue');ad=child(m,'AttributeDesignator')
                if v is None or ad is None:raise Unsupported('Match requires value/designator')
                left=scalar(v,attrs,constants);right=scalar(ad,attrs,constants)
                atoms.append(comparison(m.get('MatchId',''),left,right,constants))
                matches.append({'function':m.get('MatchId'),'value':left,'descriptor':right['descriptor']})
            alts.append(AND(*atoms));alist.append(matches)
        result.append(OR(*alts));groups.append(alist)
    return AND(*result),groups
def parse_node(e,attrs,constants,rawrules,path=''):
    tag=local(e)
    if tag not in ['PolicySet','Policy','Rule']:raise Unsupported('Unexpected policy node '+tag)
    allowed={'Description','Target','Condition'} if tag=='Rule' else {'Description','Target','Policy','PolicySet','Rule'}
    for c in e:
        if local(c) not in allowed:raise Unsupported('Unsupported '+local(c)+' in '+tag)
        if tag=='Policy' and local(c) in ['Policy','PolicySet']:raise Unsupported('Nested policy in Policy')
        if tag=='PolicySet' and local(c)=='Rule':raise Unsupported('Rule directly in PolicySet')
    if len(children(e,'Target'))>1 or len(children(e,'Condition'))>1:raise Unsupported('Duplicate Target/Condition')
    if tag!='Rule' and child(e,'Condition') is not None:raise Unsupported('Condition outside Rule')
    if tag!='Rule' and child(e,'Target') is None:raise Unsupported('Required Target missing in '+tag)
    te,traw=target(child(e,'Target'),attrs,constants)
    identifier=e.get('RuleId' if tag=='Rule' else ('PolicyId' if tag=='Policy' else 'PolicySetId'))
    if not identifier:raise Unsupported('Missing identifier')
    node={'kind':tag,'id':identifier,'version':e.get('Version','1.0'),'target':te,'target_ir':traw}
    if tag=='Rule':
        eff=e.get('Effect');cond=child(e,'Condition')
        if eff not in ['Permit','Deny']:raise Unsupported('Invalid effect')
        if cond is not None and len(cond)!=1:raise Unsupported('Condition arity')
        ce,craw=expr(cond[0],attrs,constants) if cond is not None else (True,None)
        node.update(effect=eff,condition=ce,condition_ir=craw)
        rawrules.append({'id':path+'/'+identifier,'effect':eff,'local_condition':AND(te,ce)})
    else:
        alguri=e.get('RuleCombiningAlgId' if tag=='Policy' else 'PolicyCombiningAlgId','');alg=alguri.rsplit(':',1)[-1]
        if alg not in COMBINERS or not valid_combiner(alguri,tag):raise Unsupported('Unsupported combining algorithm URI '+alguri)
        node.update(algorithm=alg,algorithm_uri=alguri,children=[parse_node(c,attrs,constants,rawrules,path+'/'+identifier) for c in e if local(c) in ['PolicySet','Policy','Rule']])
        if not node['children']:raise Unsupported('Empty policy container')
    return node
def make_domains(attrs,constants):
    domains={}
    for a,d in attrs.items():
        vals=constants[a]
        if d['DataType']==XS+'string':
            other='__OTHER__'
            while other in vals:other+='X'
            domains[a]={'type':'enum','values':sorted(vals)+[other]}
        elif d['DataType']==XS+'boolean':domains[a]={'type':'bool'}
        elif d['DataType']==XS+'dateTime':domains[a]=temporal.domain()
        else:domains[a]={'type':'int','min':min(vals)-1 if vals else -2,'max':max(vals)+1 if vals else 3}
    return domains
def compile_node(n):
    t=n['target']
    if n['kind']=='Rule':
        c=AND(t,n['condition']);return (c,False,c) if n['effect']=='Permit' else (False,c,c)
    cs=[compile_node(c) for c in n['children']];alg=n['algorithm'];ap=OR(*(p for p,d,a in cs));ad=OR(*(d for p,d,a in cs));aa=OR(*(a for p,d,a in cs))
    if alg=='first-applicable':
        ps=[];ds=[];before=False
        for p,d,a in cs:ps.append(AND(p,NOT(before)));ds.append(AND(d,NOT(before)));before=OR(before,a)
        p,d=OR(*ps),OR(*ds)
    elif alg in ['deny-overrides','ordered-deny-overrides']:p,d=AND(ap,NOT(ad)),ad
    elif alg in ['permit-overrides','ordered-permit-overrides']:p,d=ap,AND(ad,NOT(ap))
    elif alg=='deny-unless-permit':p,d=ap,NOT(ap);aa=True
    else:p,d=NOT(ad),ad;aa=True
    return AND(t,p),AND(t,d),AND(t,aa)
def parse_file(path,source_id=None):
    path=Path(path);root=ET.parse(path).getroot()
    if root.tag!='{'+NS+'}'+local(root):raise Unsupported('Only XACML3 core namespace supported')
    if any(not e.tag.startswith('{'+NS+'}') for e in root.iter()):raise Unsupported('Foreign element namespace')
    attrs={};constants=defaultdict(set);raw=[];tree=parse_node(root,attrs,constants,raw)
    domains=make_domains(attrs,constants)
    if not domains:domains={'dummy':{'type':'bool'}};attrs['dummy']={'name':'dummy','Category':'urn:research:dummy','AttributeId':'dummy','DataType':XS+'boolean','Issuer':''}
    p,d,a=compile_node(tree);source_id=source_id or 'file:'+path.name
    cpm={'schema_version':'cpm-1','attributes':domains,'sources':{source_id:{'kind':'internal','citation':str(path),'mapping_status':'exact supported total-singleton decision profile; source meaning not human validated'}},'rules':[{'id':tree['id']+'::Permit','source':source_id,'effect':'Permit','condition':p},{'id':tree['id']+'::Deny','source':source_id,'effect':'Deny','condition':d}]}
    cpm=normalize(cpm)
    # A wildcard Issuer and a named Issuer can select the same request values.
    # Reject that unsupported overlap before admitting independent CPM scalars.
    validate_attribute_mapping(cpm,attrs)
    return {'tree':tree,'attributes':attrs,'domains':domains,'cpm':cpm,'source_xml':str(path),'raw_rule_count':len(raw),'raw_rules':raw,'assumptions':['total singleton requests','string equality partition literals plus OTHER','bounded integer domains include literal endpoints +/-1','no missing/bag/Indeterminate/obligation/advice semantics']}

# Independent direct XML interpretation. This does not use CPM expressions or compiler.
def scalar_xml(e,r):
    if local(e)=='AttributeValue':return typed(e.text,e.get('DataType'))
    if local(e)=='AttributeDesignator':return r[key(e)]
    if local(e)=='Apply' and e.get('FunctionId','').endswith('-one-and-only'):return scalar_xml(e[0],r)
    raise Unsupported('Independent evaluator scalar '+local(e))
def direct_cmp(fid,left,right):
    _,op=opid(fid)
    if op=='eq':return left==right
    if op=='ne':return left!=right
    if op=='lt':return left<right
    if op=='le':return left<=right
    if op=='gt':return left>right
    return left>=right
def expr_xml(e,r):
    if local(e)=='AttributeValue':return typed(e.text,e.get('DataType'))
    f=e.get('FunctionId','')
    if f==FN+'and':return all(expr_xml(x,r) for x in e)
    if f==FN+'or':return any(expr_xml(x,r) for x in e)
    if f==FN+'not':return not expr_xml(e[0],r)
    return direct_cmp(f,scalar_xml(e[0],r),scalar_xml(e[1],r))
def target_xml(t,r):
    if t is None:return True
    return all(any(all(direct_cmp(m.get('MatchId'),scalar_xml(child(m,'AttributeValue'),r),scalar_xml(child(m,'AttributeDesignator'),r)) for m in allof) for allof in anyof) for anyof in t)
def decision_xml(e,r):
    if not target_xml(child(e,'Target'),r):return 'NotApplicable'
    tag=local(e)
    if tag=='Rule':
        c=child(e,'Condition');return e.get('Effect') if c is None or expr_xml(c[0],r) else 'NotApplicable'
    alg=e.get('RuleCombiningAlgId' if tag=='Policy' else 'PolicyCombiningAlgId','').rsplit(':',1)[-1]
    vals=[decision_xml(x,r) for x in e if local(x) in ['Rule','Policy','PolicySet']]
    if alg=='first-applicable':return next((x for x in vals if x!='NotApplicable'),'NotApplicable')
    if alg in ['deny-overrides','ordered-deny-overrides']:return 'Deny' if 'Deny' in vals else ('Permit' if 'Permit' in vals else 'NotApplicable')
    if alg in ['permit-overrides','ordered-permit-overrides']:return 'Permit' if 'Permit' in vals else ('Deny' if 'Deny' in vals else 'NotApplicable')
    if alg=='deny-unless-permit':return 'Permit' if 'Permit' in vals else 'Deny'
    if alg=='permit-unless-deny':return 'Deny' if 'Deny' in vals else 'Permit'
    raise Unsupported('Independent evaluator combiner '+alg)

def el(parent,name,attrib=None,text=None):
    x=ET.SubElement(parent,'{'+NS+'}'+name,attrib or {})
    if text is not None:x.text=str(text).lower() if type(text) is bool else str(text)
    return x
def emit_descriptor(parent,d):
    return el(parent,'AttributeDesignator',{k:v for k,v in d.items() if k not in ['name'] and (k!='Issuer' or v)})
def emit_scalar(parent,x):
    if x['kind']=='literal':return el(parent,'AttributeValue',{'DataType':x['datatype']},temporal.from_milliseconds(x['value']) if x['datatype']==XS+'dateTime' else x['value'])
    if x['kind']=='attr':return emit_descriptor(parent,x['descriptor'])
    a=el(parent,'Apply',{'FunctionId':x['function']});emit_scalar(a,x['arg']);return a
def emit_expr_ir(parent,x):
    if x['kind']=='bool':return el(parent,'AttributeValue',{'DataType':XS+'boolean'},x['value'])
    a=el(parent,'Apply',{'FunctionId':x['function']})
    if x['kind']=='compare':emit_scalar(a,x['left']);emit_scalar(a,x['right'])
    else:
        for v in x['args']:emit_expr_ir(a,v)
    return a
def emit_node(parent,n):
    tag=n['kind'];at={('RuleId' if tag=='Rule' else 'PolicyId' if tag=='Policy' else 'PolicySetId'):n['id']}
    if tag=='Rule':at['Effect']=n['effect']
    else:at.update(Version=n['version'],**{('RuleCombiningAlgId' if tag=='Policy' else 'PolicyCombiningAlgId'):n['algorithm_uri']})
    e=el(parent,tag,at);t=el(e,'Target')
    for group in n['target_ir']:
        a=el(t,'AnyOf')
        for matches in group:
            b=el(a,'AllOf')
            for m in matches:
                c=el(b,'Match',{'MatchId':m['function']});emit_scalar(c,m['value']);emit_descriptor(c,m['descriptor'])
    if tag=='Rule':
        if n['condition_ir'] is not None:emit_expr_ir(el(e,'Condition'),n['condition_ir'])
    else:
        for c in n['children']:emit_node(e,c)
    return e
def export_tree(model,path):
    fake=ET.Element('container');emit_node(fake,model['tree']);ET.indent(fake[0]);ET.ElementTree(fake[0]).write(path,encoding='utf-8',xml_declaration=True)
def emit_cpm_expr(parent,e,attrs):
    if type(e) is bool:return el(parent,'AttributeValue',{'DataType':XS+'boolean'},e)
    if e['op'] in ['and','or','not']:
        a=el(parent,'Apply',{'FunctionId':FN+e['op']})
        for v in ([e['arg']] if e['op']=='not' else e['args']):emit_cpm_expr(a,v,attrs)
        return a
    desc=attrs[e['attr']];typ=desc['DataType'].rsplit('#',1)[-1]
    # No XACML not-equal built-in: express inequality through Boolean not(equal).
    if e['op']=='ne':
        a=el(parent,'Apply',{'FunctionId':FN+'not'});return emit_cpm_expr(a,{**e,'op':'eq'},attrs)
    tail=next(k for k,v in OPS.items() if v==e['op'])
    a=el(parent,'Apply',{'FunctionId':FN+typ+'-'+tail});one=el(a,'Apply',{'FunctionId':FN+typ+'-one-and-only'});emit_descriptor(one,{**desc,'MustBePresent':'true'});el(a,'AttributeValue',{'DataType':desc['DataType']},temporal.from_milliseconds(e['value']) if desc['DataType']==XS+'dateTime' else e['value']);return a
def validate_attribute_mapping(p, attrs):
    """Require a complete, typed, nonoverlapping singleton descriptor mapping.

    Issuer omission is a wildcard in a designator, so it must not coexist with a
    named issuer for the same Category/AttributeId/DataType request selector.
    This is an interface guard, not a schema validator or a governance check.
    """
    if not isinstance(attrs, dict) or set(attrs) != set(p['attributes']):
        raise Unsupported('Attribute mapping must cover exactly the CPM attributes')
    selectors = []
    allowed = {'name', 'Category', 'AttributeId', 'DataType', 'Issuer', 'MustBePresent'}
    for name, domain in p['attributes'].items():
        d = attrs[name]
        if not isinstance(d, dict) or set(d) - allowed:
            raise Unsupported('Unsupported attribute descriptor: ' + name)
        if any(type(d.get(k)) is not str or not d[k] for k in ('Category', 'AttributeId', 'DataType')):
            raise Unsupported('Missing/nontext attribute descriptor: ' + name)
        if 'name' in d and d['name'] != name:
            raise Unsupported('Descriptor name differs from CPM attribute: ' + name)
        issuer = d.get('Issuer', '')
        if type(issuer) is not str:
            raise Unsupported('Issuer must be text: ' + name)
        if 'MustBePresent' in d and d['MustBePresent'] not in ('true', 'false', '0', '1'):
            raise Unsupported('Invalid MustBePresent: ' + name)
        datatype = d['DataType']
        expected = {'bool': XS+'boolean', 'enum': XS+'string', 'int': XS+'integer'}[domain['type']]
        temporal_ok = (domain['type'] == 'int' and datatype == XS+'dateTime'
                       and temporal.MIN_MS <= domain['min'] <= domain['max'] <= temporal.MAX_MS)
        if datatype != expected and not temporal_ok:
            raise Unsupported('Descriptor datatype/domain mismatch: ' + name)
        selector = (d['Category'], d['AttributeId'], datatype)
        for previous_name, previous_selector, previous_issuer in selectors:
            if selector == previous_selector and (issuer == previous_issuer or not issuer or not previous_issuer):
                raise Unsupported('Overlapping attribute designators: ' + previous_name + ', ' + name)
        selectors.append((name, selector, issuer))
    return attrs

def export_cpm(p,path,attrs=None):
    from pcproof.verify import Verifier
    p=normalize(p)
    attrs=attrs if attrs is not None else {a:{'name':a,'Category':'urn:research:cpm','AttributeId':a,'DataType':XS+('string' if d['type']=='enum' else 'integer' if d['type']=='int' else 'boolean'),'Issuer':''} for a,d in p['attributes'].items()}
    validate_attribute_mapping(p,attrs)
    ambiguity=Verifier(p,timeout_ms=10000).check(AND(OR(*(r['condition'] for r in p['rules'] if r['effect']=='Permit')),OR(*(r['condition'] for r in p['rules'] if r['effect']=='Deny'))))
    if ambiguity['status']!='UNSAT':raise Unsupported('Standard XACML export rejects possible/unresolved CPM Conflict: '+ambiguity['status'])
    root=ET.Element('{'+NS+'}Policy',{'PolicyId':'urn:research:generated:cpm','RuleCombiningAlgId':'urn:oasis:names:tc:xacml:3.0:rule-combining-algorithm:deny-overrides','Version':'1.0'})
    el(root,'Description',text=json.dumps({'profile':'total-singleton deny-overrides','domains':p['attributes'],'sources':p['sources'],'rules':[{k:v for k,v in r.items() if k!='condition'} for r in p['rules']]},sort_keys=True));el(root,'Target')
    # CPM identifiers are arbitrary strings; XACML IDs must be valid anyURI values.
    # Retain original IDs in the paired model and use deterministic native URNs.
    rule_id_mapping={rule['id']:native_rule_id(rule['id']) for rule in p['rules']}
    if len(set(rule_id_mapping.values()))!=len(rule_id_mapping):raise Unsupported('Native rule identifier collision')
    for rule in p['rules']:
        r=el(root,'Rule',{'RuleId':rule_id_mapping[rule['id']],'Effect':rule['effect']});emit_cpm_expr(el(r,'Condition'),AND(p.get('validity',True),rule['condition']),attrs)
    ET.indent(root);ET.ElementTree(root).write(path,encoding='utf-8',xml_declaration=True)
    sidecar={'profile':'cpm-xacml-paired-1','xml_sha256':hashlib.sha256(Path(path).read_bytes()).hexdigest(),'model_sha256':hashlib.sha256(code(p).encode()).hexdigest(),'model':p,'attribute_mapping':attrs,'rule_id_mapping':rule_id_mapping,'ambiguity_gate':ambiguity,'limitations':['Metadata retained by paired sidecar; ordinary PDP does not execute precedence/invariant approval metadata','Requests must satisfy declared finite domains and validity; equivalence excludes invalid requests']}
    Path(str(path)+'.metadata.json').write_text(json.dumps(sidecar,indent=2),encoding='utf8');return attrs

def canonical_expr(e):
    if type(e) is bool:return e
    op=e['op']
    if op=='ne':return NOT({**e,'op':'eq'})
    if op=='not':return NOT(canonical_expr(e['arg']))
    if op in ['and','or']:return joint(op,*(canonical_expr(v) for v in e['args']))
    return e
def native_rule_id(identifier):return 'urn:research:cpm-rule:'+hashlib.sha256(identifier.encode('utf8')).hexdigest()
def remap_expr(e,mapping):
    if type(e) is bool:return e
    if e['op']=='not':return {'op':'not','arg':remap_expr(e['arg'],mapping)}
    if e['op'] in ['and','or']:return {'op':e['op'],'args':[remap_expr(v,mapping) for v in e['args']]}
    return {**e,'attr':mapping[e['attr']]}
def import_cpm_pair(path):
    path=Path(path);meta=json.loads(Path(str(path)+'.metadata.json').read_text(encoding='utf8'))
    if hashlib.sha256(path.read_bytes()).hexdigest()!=meta['xml_sha256']:raise Unsupported('Sidecar XML hash mismatch')
    p=normalize(meta['model'])
    if hashlib.sha256(code(p).encode()).hexdigest()!=meta['model_sha256']:raise Unsupported('Sidecar model hash mismatch')
    validate_attribute_mapping(p,meta.get('attribute_mapping'))
    parsed=parse_file(path);n=parsed['tree']
    if n['kind']!='Policy' or n['algorithm_uri']!='urn:oasis:names:tc:xacml:3.0:rule-combining-algorithm:deny-overrides' or n['target'] is not True:raise Unsupported('Unexpected generated policy structure')
    amap={sid(d['Category'],d['AttributeId'],d['DataType'],d.get('Issuer','')):a for a,d in meta['attribute_mapping'].items()}
    if len(amap)!=len(meta['attribute_mapping']):raise Unsupported('Aliased attribute mapping')
    if len(n['children'])!=len(p['rules']):raise Unsupported('Rule count changed')
    ids=meta.get('rule_id_mapping',{r['id']:r['id'] for r in p['rules']})
    if 'rule_id_mapping' in meta and ids!={r['id']:native_rule_id(r['id']) for r in p['rules']}:raise Unsupported('Invalid native rule identifier mapping')
    for node,rule in zip(n['children'],p['rules']):
        actual=canonical_expr(remap_expr(AND(node['target'],node['condition']),amap));expected=canonical_expr(AND(p['validity'],rule['condition']))
        if node['id']!=ids[rule['id']] or node['effect']!=rule['effect'] or actual!=expected:raise Unsupported('Parsed XML rule differs from sidecar model: '+rule['id'])
    return p
def request_xml(r,attrs,path=None):
    root=ET.Element('{'+NS+'}Request',{'ReturnPolicyIdList':'false','CombinedDecision':'false'});groups={}
    for a,d in attrs.items():
        cat=d['Category']
        if cat not in groups:groups[cat]=el(root,'Attributes',{'Category':cat})
        aa={'AttributeId':d['AttributeId'],'IncludeInResult':'false'}
        if d.get('Issuer'):aa['Issuer']=d['Issuer']
        att=el(groups[cat],'Attribute',aa);el(att,'AttributeValue',{'DataType':d['DataType']},temporal.from_milliseconds(r[a]) if d['DataType']==XS+'dateTime' else r[a])
    text=ET.tostring(root,encoding='unicode')
    if path:Path(path).write_text(text,encoding='utf8')
    return text
