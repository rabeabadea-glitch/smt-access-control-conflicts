"""Author and freeze finite repair challenges without importing target code.

This file is a design-only generator.  It imports only the Python standard
library and must not run repair, workflow, importer, SMT, OPA, or Balana code.
"""
from __future__ import annotations
import ast
import copy
import hashlib
import itertools
import json
import sys
import xml.etree.ElementTree as ET
from collections import Counter
from datetime import datetime, timezone
from pathlib import Path

ROOT = Path(__file__).resolve().parent
NS = 'urn:oasis:names:tc:xacml:3.0:core:schema:wd-17'
FN = 'urn:oasis:names:tc:xacml:1.0:function:'
XS = 'http://www.w3.org/2001/XMLSchema#'
CATEGORY = 'urn:thesis:frozen-challenge:request'
ET.register_namespace('', NS)

def write(path, value):
    path = ROOT / path
    path.parent.mkdir(parents=True, exist_ok=True)
    if not isinstance(value, str):
        value = json.dumps(value, indent=2, ensure_ascii=False) + '\n'
    path.write_text(value, encoding='utf8')

def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()

def tree(text):
    return ast.parse(text, mode='eval').body

def evaluate(node, request):
    if isinstance(node, ast.Name): return request[node.id]
    if isinstance(node, ast.Constant) and type(node.value) is bool: return node.value
    if isinstance(node, ast.UnaryOp) and isinstance(node.op, ast.Not): return not evaluate(node.operand, request)
    if isinstance(node, ast.BoolOp):
        vals = [evaluate(x, request) for x in node.values]
        return all(vals) if isinstance(node.op, ast.And) else any(vals)
    raise ValueError('Unsupported design expression: '+ast.dump(node))

def expr(node):
    if isinstance(node, ast.Name): return {'op':'eq', 'attr':node.id, 'value':True}
    if isinstance(node, ast.Constant) and type(node.value) is bool: return node.value
    if isinstance(node, ast.UnaryOp) and isinstance(node.op, ast.Not): return {'op':'not', 'arg':expr(node.operand)}
    if isinstance(node, ast.BoolOp): return {'op':'and' if isinstance(node.op, ast.And) else 'or', 'args':[expr(x) for x in node.values]}
    raise ValueError(ast.dump(node))

def minterm(request):
    terms = [{'op':'eq', 'attr':a, 'value':v} for a,v in request.items()]
    return terms[0] if len(terms)==1 else {'op':'and','args':terms}

def source(identifier, rules, format='cpm', combining='union'):
    return {'source_id':identifier, 'format':format, 'combining':combining,
            'rules':[{'id':identifier+'_r'+str(i+1),'effect':effect,'when':condition} for i,(effect,condition) in enumerate(rules)]}

def source_decision(spec, request):
    effects = [r['effect'] for r in spec['rules'] if evaluate(tree(r['when']),request)]
    if spec['combining']=='first-applicable': return next(iter(effects),'NotApplicable')
    effects=set(effects)
    if spec['combining']=='deny-overrides': return 'Deny' if 'Deny' in effects else ('Permit' if effects else 'NotApplicable')
    if spec['combining']=='permit-overrides': return 'Permit' if 'Permit' in effects else ('Deny' if effects else 'NotApplicable')
    if len(effects)==2: return 'Conflict'
    return next(iter(effects),'NotApplicable')

def all_edges(order):
    return [{'higher':a,'lower':b,'approval_id':'frozen-research-direction-'+a+'-over-'+b} for i,a in enumerate(order) for b in order[i+1:]]

def xel(parent, name, attrib=None, text=None):
    node=ET.SubElement(parent,'{'+NS+'}'+name,attrib or {})
    if text is not None: node.text=text
    return node

def xml_expr(parent, node):
    if isinstance(node,ast.Constant): return xel(parent,'AttributeValue',{'DataType':XS+'boolean'},str(node.value).lower())
    if isinstance(node,ast.Name):
        cmp=xel(parent,'Apply',{'FunctionId':FN+'boolean-equal'})
        one=xel(cmp,'Apply',{'FunctionId':FN+'boolean-one-and-only'})
        xel(one,'AttributeDesignator',{'Category':CATEGORY,'AttributeId':node.id,'DataType':XS+'boolean','MustBePresent':'true'})
        xel(cmp,'AttributeValue',{'DataType':XS+'boolean'},'true')
        return cmp
    if isinstance(node,ast.UnaryOp):
        result=xel(parent,'Apply',{'FunctionId':FN+'not'});xml_expr(result,node.operand);return result
    result=xel(parent,'Apply',{'FunctionId':FN+('and' if isinstance(node.op,ast.And) else 'or')})
    for child in node.values: xml_expr(result,child)
    return result

def emit_xacml(spec, attributes):
    root=ET.Element('{'+NS+'}Policy',{'PolicyId':'urn:challenge:'+spec['source_id'], 'Version':'1.0',
        'RuleCombiningAlgId':'urn:oasis:names:tc:xacml:1.0:rule-combining-algorithm:'+spec['combining']})
    xel(root,'Description',text='Manually authored finite challenge source. Not an external real-world policy.')
    xel(root,'Target')
    # This common total-domain tautology makes every declared Boolean field
    # explicit to the importer without adding a substantive access rule.
    total=' and '.join('('+a+' or not '+a+')' for a in attributes)
    for rule in spec['rules']:
        node=xel(root,'Rule',{'RuleId':'urn:challenge:'+rule['id'],'Effect':rule['effect']})
        xml_expr(xel(node,'Condition'),tree('('+total+') and ('+rule['when']+')'))
    ET.indent(root)
    return ET.tostring(root,encoding='unicode',xml_declaration=True)+'\n'

def emit_rego(spec, attributes):
    lines=['package challenge_'+spec['source_id'],'','import rego.v1','']
    serial=[0]
    def emit(node):
        name='condition_'+str(serial[0]);serial[0]+=1
        if isinstance(node,ast.Name): bodies=['input.'+node.id+' == true']
        elif isinstance(node,ast.Constant): bodies=[str(node.value).lower()]
        elif isinstance(node,ast.UnaryOp): bodies=['not '+emit(node.operand)]
        else:
            children=[emit(c) for c in node.values]
            bodies=['; '.join(children)] if isinstance(node.op,ast.And) else children
        lines.extend(name+' if { '+body+' }' for body in bodies)
        return name
    rules=[]
    for rule in spec['rules']:
        entry='entry_'+rule['id'];child=emit(tree(rule['when']))
        lines.append(entry+' if { '+child+' }')
        rules.append({'id':rule['id'],'source':spec['source_id'],'effect':rule['effect'],'entry':entry})
    manifest={'schema_version':'cpm-1','package':'challenge_'+spec['source_id'],
              'attributes':{a:{'type':'bool'} for a in attributes},
              'sources':{spec['source_id']:{'kind':'synthetic','citation':'Frozen manually authored challenge '+spec['source_id'],'mapping_status':'synthetic structured source; no regulatory interpretation'}},'rules':rules}
    return '\n'.join(lines)+'\n',manifest

def design_case(identifier,title,attrs,specs,priority,description,*,edges=None,target=None,contradiction=None,feasibility='finite specification satisfiable; configured repair acceptance unspecified'):
    casepath='cases/'+identifier
    sourceassets=[]
    for sp in specs:
        prefix=casepath+'/sources/'+sp['source_id']
        item={'source_id':sp['source_id'],'format':sp['format'],'rule_count':len(sp['rules']),'combining':sp['combining']}
        if sp['format']=='xacml':
            path=prefix+'.xml';write(path,emit_xacml(sp,attrs));item['path']=path
            item['descriptors']={a:{'name':a,'Category':CATEGORY,'AttributeId':a,'DataType':XS+'boolean','Issuer':''} for a in attrs}
        elif sp['format']=='rego':
            text,manifest=emit_rego(sp,attrs);path=prefix+'.rego';mpath=prefix+'.manifest.json'
            write(path,text);write(mpath,manifest);item.update(path=path,manifest_path=mpath)
        else:
            path=prefix+'.json';write(path,sp);item['path']=path
        sourceassets.append(item)
    records=[];requirements=[];preservation=[];inputcounts=Counter();targetcounts=Counter();conflict_points=[]
    order=priority
    for vals in itertools.product([False,True],repeat=len(attrs)):
        req=dict(zip(attrs,vals));decisions={sp['source_id']:source_decision(sp,req) for sp in specs}
        active={v for v in decisions.values() if v!='NotApplicable'}
        # CPM conflict is the cross-source union of effective source effects.
        inputdecision='Conflict' if ('Conflict'in active or {'Permit','Deny'}<=active) else next(iter(active),'NotApplicable')
        if target is not None:
            expected=target(req)
        else:
            expected=next((decisions[s] for s in order if decisions[s]!='NotApplicable'),'NotApplicable')
            if expected=='Conflict': raise ValueError('Priority target must be explicit for an internally conflicting source')
        required=[expected] if expected in ('Permit','Deny') else []
        if contradiction is not None and all(req[k]==v for k,v in contradiction.items()): required=['Permit','Deny'];expected=None
        row={'request':req,'source_decisions':decisions,'original_union_decision':inputdecision,'expected_final_decision':expected,'required':required}
        records.append(row);inputcounts[inputdecision]+=1;targetcounts[str(expected)]+=1
        if inputdecision=='Conflict':conflict_points.append(req)
        for effect in required:
            requirements.append({'id':identifier+'_request_'+str(len(records)-1)+'_must_'+effect,'when':minterm(req),'required':effect})
        if inputdecision in ('Permit','Deny'):
            preservation.append({'request':req,'original':inputdecision,'required':inputdecision,
                                 'included_in_frozen_target':inputdecision in required})
    authorized=all_edges(priority) if edges is None else [dict(higher=a,lower=b,approval_id='frozen-research-direction-'+a+'-over-'+b) for a,b in edges]
    write(casepath+'/source_specifications.json',specs)
    write(casepath+'/expected_truth_table.json',records)
    write(casepath+'/requirements.json',requirements)
    write(casepath+'/preservation_obligations.json',preservation)
    write(casepath+'/governance.json',{'precedence':authorized,'meaning':'Research specification only: declared permissible automated source directions, not deployment authority.'})
    if all(sp['format']=='cpm' for sp in specs):
        model={'schema_version':'cpm-1','attributes':{a:{'type':'bool'} for a in attrs},
               'sources':{sp['source_id']:{'kind':'synthetic','citation':'Manually authored challenge '+identifier,'mapping_status':'synthetic structured source; no external interpretation'} for sp in specs},
               'rules':[{'id':r['id'],'source':sp['source_id'],'effect':r['effect'],'condition':expr(tree(r['when']))} for sp in specs for r in sp['rules']],
               'precedence':authorized,'invariants':requirements}
        write(casepath+'/input.json',model)
    metadata={'case_id':identifier,'title':title,'role':'substantive finite challenge','attributes':{a:{'type':'bool'} for a in attrs},
              'source_assets':sourceassets,'request_count':len(records),'source_count':len(specs),'source_rule_count':sum(len(sp['rules']) for sp in specs),
              'anticipated_compiled_rule_count':sum(2 if sp['format']=='xacml' else len(sp['rules']) for sp in specs),
              'independent_priority_specification_high_to_low':order,'target_specification':description,
              'feasibility':feasibility,'expected_acceptance':'Not preassigned; acceptance/rejection and specification satisfaction will both be reported.',
              'original_union_decision_counts':dict(inputcounts),'target_decision_counts':dict(targetcounts),'conflict_request_count':len(conflict_points),
              'preserved_original_permit_count':sum(x['original']=='Permit' for x in preservation),
              'preserved_original_deny_count':sum(x['original']=='Deny' for x in preservation),
              'input_path':casepath+'/input.json' if all(sp['format']=='cpm' for sp in specs) else None,
              'requirements_path':casepath+'/requirements.json','truth_table_path':casepath+'/expected_truth_table.json','governance_path':casepath+'/governance.json',
              'origin':'New manually authored challenge, designed retrospectively with knowledge of earlier thesis results. No external corpus or untouched confirmatory claim.'}
    write(casepath+'/case.json',metadata)
    return metadata

def mixed_specs(case):
    X=lambda sid,rs,alg:source(sid,rs,'xacml',alg)
    R=lambda sid,rs:source(sid,rs,'rego')
    if case==1:
        return [
          X('A',[('Permit','not p and not q'),('Deny','not p and q'),('Permit','p and r'),('Deny','p and s')],'first-applicable'),
          X('B',[('Permit','p and t'),('Deny','p and u'),('Permit','p and q and not r'),('Deny','p and not q and not t')],'deny-overrides'),
          X('C',[('Deny','p and r and u'),('Permit','p and not r and t'),('Deny','p and q and not s'),('Permit','p and not q and s')],'permit-overrides'),
          R('D',[('Deny','p and r and q'),('Permit','p and r and not q'),('Permit','p and not r and s'),('Deny','p and not r and not s')]),
          R('E',[('Permit','p and t and q'),('Deny','p and t and not q'),('Deny','p and not t and u'),('Permit','p and not t and not u')]),
          R('F',[('Deny','p and s and u'),('Permit','p and s and not u'),('Permit','p and not s and r'),('Deny','p and not s and not r')])]
    if case==2:
        return [
          X('A',[('Deny','not q and p'),('Permit','not q and not p'),('Deny','q and t'),('Permit','q and r and s')],'deny-overrides'),
          X('B',[('Permit','q and u'),('Deny','q and r'),('Permit','q and p and not t'),('Deny','q and not p and s')],'first-applicable'),
          X('C',[('Permit','q and s'),('Deny','q and not s and u'),('Deny','q and p and t'),('Permit','q and not p and r')],'permit-overrides'),
          R('D',[('Permit','q and p and u'),('Deny','q and p and not u'),('Deny','q and not p and t'),('Permit','q and not p and not t')]),
          R('E',[('Deny','q and r and s'),('Permit','q and r and not s'),('Permit','q and not r and u'),('Deny','q and not r and not u')]),
          R('F',[('Permit','q and t and r'),('Deny','q and t and not r'),('Deny','q and not t and s'),('Permit','q and not t and not s')])]
    if case==3:
        return [
          X('A',[('Permit','not r and p'),('Deny','not r and not p'),('Permit','r and q and u'),('Deny','r and s')],'permit-overrides'),
          X('B',[('Deny','r and t'),('Permit','r and u'),('Deny','r and p and not s'),('Permit','r and not p and q')],'first-applicable'),
          X('C',[('Permit','r and p and s'),('Deny','r and q'),('Permit','r and not q and t'),('Deny','r and not p and u')],'deny-overrides'),
          X('D',[('Permit','r and not u and s'),('Deny','r and t and q'),('Deny','r and not t and p'),('Permit','r and not s and not q')],'first-applicable'),
          R('E',[('Permit','r and p and t'),('Deny','r and p and not t'),('Deny','r and not p and u'),('Permit','r and not p and not u')]),
          R('F',[('Deny','r and q and u'),('Permit','r and q and not u'),('Permit','r and not q and s'),('Deny','r and not q and not s')]),
          R('G',[('Permit','r and t and q'),('Deny','r and t and not q'),('Deny','r and not t and s'),('Permit','r and not t and not s')]),
          R('H',[('Deny','r and u and p'),('Permit','r and u and not p'),('Permit','r and not u and q'),('Deny','r and not u and not q')])]
    return [
          X('A',[('Deny','not s and not u'),('Permit','not s and u'),('Deny','s and p and q'),('Permit','s and r')],'first-applicable'),
          X('B',[('Permit','s and p and t'),('Deny','s and u'),('Deny','s and not q and not t'),('Permit','s and q and not p')],'deny-overrides'),
          X('C',[('Deny','s and q and r'),('Permit','s and not r and u'),('Permit','s and not p and t'),('Deny','s and p and not u')],'first-applicable'),
          X('D',[('Permit','s and p and u'),('Deny','s and r'),('Permit','s and not q and t'),('Deny','s and q and not p')],'permit-overrides'),
          R('E',[('Deny','s and p and r'),('Permit','s and p and not r'),('Permit','s and not p and t'),('Deny','s and not p and not t')]),
          R('F',[('Permit','s and q and t'),('Deny','s and q and not t'),('Deny','s and not q and u'),('Permit','s and not q and not u')]),
          R('G',[('Deny','s and r and u'),('Permit','s and r and not u'),('Permit','s and not r and q'),('Deny','s and not r and not q')]),
          R('H',[('Permit','s and t and p'),('Deny','s and t and not p'),('Deny','s and not t and r'),('Permit','s and not t and not r')])]

def main():
    if (ROOT/'FREEZE.json').exists(): raise SystemExit('Already frozen: do not overwrite.')
    cases=[]
    for i in range(1,5):
        specs=mixed_specs(i);order=[sp['source_id'] for sp in specs]
        cases.append(design_case('C'+str(i).zfill(2),'Mixed six-attribute multi-source priority case '+str(i),list('pqrstu'),specs,order,
          'At each complete Boolean request, take the first non-NotApplicable source decision in the listed high-to-low order. This is an independent source-priority specification, not a repair-region formula.'))
    S=lambda sid,rules:source(sid,rules)
    base=[S('A',[('Permit','p and q'),('Deny','p and not q')]),S('B',[('Permit','p and r'),('Deny','not p and r')]),S('C',[('Permit','not p and q'),('Deny','not p and not q')])]
    cases.append(design_case('C05','Three-source intersecting conflicts',list('pqr'),base,['A','B','C'],'First applicable source in A > B > C order; preserve every originally pure Permit and Deny point.'))
    permission=[S('A',[('Deny','p')]),S('B',[('Permit','p or not q')]),S('C',[('Deny','not p and q')])]
    cases.append(design_case('C06','Permission specification incompatible with authorized direction',list('pqr'),permission,['A','B','C'],
      'Deny exactly when not p and q; Permit otherwise. This deliberately requires Permit at p despite authorized A(Deny) over B(Permit).',target=lambda r:'Deny' if not r['p'] and r['q'] else 'Permit',feasibility='Truth-table policy exists, but declared direction at p conflicts with the must-Permit specification; conservative governed repair is expected to reject rather than violate requirements.'))
    denial=[S('A',[('Permit','p')]),S('B',[('Deny','p or not q')]),S('C',[('Permit','not p and q')])]
    cases.append(design_case('C07','Denial specification incompatible with authorized direction',list('pqr'),denial,['A','B','C'],
      'Permit exactly when not p and q; Deny otherwise. This deliberately requires Deny at p despite authorized A(Permit) over B(Deny).',target=lambda r:'Permit' if not r['p'] and r['q'] else 'Deny',feasibility='Truth-table policy exists, but declared direction at p conflicts with the must-Deny specification; conservative governed repair is expected to reject rather than violate requirements.'))
    ungoverned=[S('A',[('Permit','p')]),S('B',[('Deny','q')]),S('C',[('Permit','not p and not q')])]
    cases.append(design_case('C08','Missing direction on a real overlap',list('pqr'),ungoverned,['B','A','C'],
      'Deny at q and Permit otherwise; no A/B precedence is authorized.',edges=[('A','C'),('B','C')],feasibility='Truth-table policy exists, but resolving the A/B overlap would require an undeclared direction; automated rejection is acceptable and expected.'))
    cases.append(design_case('C09','Contradictory preservation requirements',list('pqr'),base,['A','B','C'],
      'Use A > B > C except the all-false request is simultaneously required to Permit and Deny. No single-decision policy satisfies both.',contradiction={'p':False,'q':False,'r':False},feasibility='Logically infeasible: one complete request has simultaneous must-Permit and must-Deny requirements. Acceptance as satisfying all requirements would be a bug.'))
    disjoint=[S('A',[('Permit','p and q')]),S('B',[('Deny','p and not q')]),S('C',[('Permit','not p and r')]),S('D',[('Deny','not p and not r')])]
    cases.append(design_case('C10','Already consistent decision partition',list('pqr'),disjoint,['A','B','C','D'],
      'Four disjoint source regions already provide the complete required table; a correct result preserves both effects without inventing conflicts.',edges=[]))
    diamond=[S('A',[('Permit','p and q'),('Deny','p and not q')]),S('B',[('Permit','p and r'),('Deny','not p and r')]),S('C',[('Permit','p and s'),('Deny','not p and s')]),S('D',[('Permit','p and not r and not s'),('Deny','not p and not r and not s')])]
    cases.append(design_case('C11','Four-source diamond precedence',list('pqrs'),diamond,['A','B','C','D'],
      'A dominates B and C, both dominate D. B and C are intentionally incomparable but agree on their intersection.',edges=[('A','B'),('A','C'),('B','D'),('C','D')]))
    internal=[S('A',[('Permit','p'),('Deny','q')]),S('B',[('Permit','not p and not q'),('Deny','not p and q')])]
    cases.append(design_case('C12','Unresolved conflict inside one source',list('pqr'),internal,['A','B'],
      'Deny exactly at q and Permit otherwise. The p-and-q overlap is inside source A; an A/B edge supplies no authority to rank A against itself.',target=lambda r:'Deny' if r['q'] else 'Permit',feasibility='Truth-table policy exists, but same-source opposing rules have no valid source-precedence direction; conservative governed repair is expected to reject.'))

    # Negative controls are deliberately outside the substantive case denominator.
    write('controls/U01_unsupported.rego','package challenge_unsupported\n\nimport rego.v1\n\nallow if { input.score + 1 >= 2 }\n')
    write('controls/U01_manifest.json',{'schema_version':'cpm-1','package':'challenge_unsupported','attributes':{'score':{'type':'int','min':0,'max':3}},'sources':{'U':{'kind':'synthetic','citation':'Frozen unsupported syntax control','mapping_status':'synthetic'}},'rules':[{'id':'U_allow','source':'U','effect':'Permit','entry':'allow'}]})
    write('controls/G01_cyclic_input.json',{**json.loads((ROOT/'cases/C05/input.json').read_text()),'precedence':[{'higher':'A','lower':'B','approval_id':'cycle-ab'},{'higher':'B','lower':'A','approval_id':'cycle-ba'}]})
    controls=[{'control_id':'U01','kind':'unsupported mapping','input':'controls/U01_unsupported.rego','manifest':'controls/U01_manifest.json','required_behavior':'Explicit unsupported rejection; do not silently drop arithmetic or claim mapped equivalence.'},
      {'control_id':'S01','kind':'stale binding','base_case':'C05','procedure':'Bind approval/configuration to the exact original C05 input hash; change A_r1 effect from Permit to Deny after binding; invoke the implementation stale-binding guard. Keep original binding unchanged.','frozen_original_file_sha256':sha(ROOT/'cases/C05/input.json'),'required_behavior':'Reject the stale binding before presenting an approved repaired result. Record the actual implementation canonical fingerprint separately from file SHA; they are not interchangeable.'},
      {'control_id':'I01','kind':'iteration budget','base_case':'C01','procedure':'Assemble the unchanged frozen input and requirements; set maximum repair iterations to zero.','required_behavior':'Report an explicit unfinished/rejected result or retain unresolved status; must not claim a conflict-free accepted output while known conflicts remain.'},
      {'control_id':'G01','kind':'cyclic direction metadata','input':'controls/G01_cyclic_input.json','required_behavior':'Explicit invalid-input rejection; a precedence cycle must not confer repair authority.'}]
    write('controls/controls.json',controls)
    protocol={'study':'Frozen finite multi-source policy-repair challenge','version':'1.0','frozen_utc':datetime.now(timezone.utc).isoformat(),
      'status':'FROZEN BEFORE TARGET EXECUTION','origin':'Manually authored synthetic challenge; no independently originated external case is claimed.',
      'why_not_external':'The supported previously examined external whole-policy snapshot is dominated by one-rule policies. No untouched supported external multi-source repair requirement specification is available to this designer. Combining those policies and inventing priorities would still be synthetic, so these cases are labelled synthetic directly.',
      'retrospective_disclosure':'Designer knows prior thesis findings and model/input-interface code. Designer did not read repair.py or workflow.py or earlier successful repair-driver fixtures, and did not import or execute target repair code. This is a fresh frozen regression/challenge study, not untouched confirmatory evidence.',
      'substantive_case_count':12,'negative_control_count':4,'mixed_full_path_case_count':4,'finite_request_limit':256,
      'counts_are_not_independent':'Requests within a case, source motifs across cases, repeats, and language exports are dependent. No population accuracy or confidence interval is inferred from their sum.',
      'independent_oracle':'The design-only standard-library evaluator interprets manually authored source predicates and local combiners, then the declared high-to-low source specification. Full expected tables and requirement minterms are frozen before target execution. No subtraction region, target export, SMT result, or successful repair trace is used as an expected answer.',
      'primary_endpoint':'For every accepted output, compare its complete finite decision table with frozen expected_final_decision, check every must-Permit/must-Deny requirement, verify conflict freedom, and verify actual source import and target export on all in-domain requests.',
      'rejection_reporting':'Report all 12 substantive cases and all four controls; retain every rejection and error. A conservative rejection is not a wrong accepted policy. Report correct acceptance, wrong acceptance, conservative rejection, justified rejection, unsupported/error separately. Do not turn unknown acceptance into a presumed success.',
      'infeasible_case':'C09 is logically impossible. C06/C07 conflict with declared priority requirements; C08 lacks a required direction; C12 has an internal same-source conflict. These test safe refusal, not repair completeness.',
      'input_paths':'For CPM cases use the frozen input.json. For mixed cases import each actual source asset, map descriptor hashes to declared aliases, retain two effective rules for each XACML source and four source rules for each Rego source, then add the frozen precedence and invariants. Do not substitute the expected table for actual source imports.',
      'source_import_endpoint':'Compare each actual imported source decision with source_decisions at every complete request, before repair.',
      'not_applicable':'NotApplicable rows, if present, must also match in the external decision-table comparison; CPM invariant syntax itself only expresses Permit/Deny.',
      'native_engine_endpoint':'Evaluate generated accepted target policies in actual OPA/Balana where supported, against the full frozen table. Native execution, import/export, and repair are separate endpoints.',
      'performance':'Any duration/memory measurement is descriptive of these cases on this workstation only. Record phases and failed/rejected runs. This is not a scalability population claim.',
      'immutability':'Do not edit any frozen file after execution starts. Implementation fixes belong outside design. Record protocol deviations and runner decisions in a separate execution directory.'}
    write('protocol.json',protocol)
    write('cases.json',cases)
    write('design_rationale.json',{'manual_families':4,'large_mixed_cases':[{'case':x['case_id'],'sources':x['source_count'],'source_rules':x['source_rule_count'],'compiled_rules':x['anticipated_compiled_rule_count'],'requests':x['request_count'],'original_counts':x['original_union_decision_counts']} for x in cases[:4]],
      'coverage':['intersecting multi-rule/multi-source conflicts','local XACML first-applicable/deny-overrides/permit-overrides semantics','mixed XACML and Rego source imports','positive and negative preservation regions','partial-order diamond','missing authorization','opposing preservation constraints','internally conflicting source','already consistent input','unsupported/stale/iteration/cyclic controls separated'],
      'manual_checks':['Each large case has 16 originally pure Permit and 16 originally pure Deny requests by its explicit non-contested half-domain.','Each large case has 32 requests in the contested half-domain, within which different rule effects may intersect.','C09 all-false request is explicitly required to Permit and Deny, so no ordinary single-decision policy can satisfy it.'],
      'limitation':'This strengthens adversarial finite workflow coverage. It does not establish novelty, completeness over all feasible repairs, real-world representativeness, broad language conformance, or large-scale performance.'})
    write('README.txt', 'FROZEN DESIGN ONLY\nRead protocol.json, cases.json, then cases/Cxx/case.json.\nAll inputs, source-level and final truth tables, requirements, and authorized directions are materialized.\nThe designer used only standard-library code and did not run the target implementation.\nMixed cases must use actual source imports, not truth-table substitution.\nKeep all execution results outside this design directory.\nNo human/expert validation or real-world regulatory authority is claimed.\n')
    # Freeze every exact input/oracle/design file, including this authoring source.
    inventory={str(p.relative_to(ROOT)).replace('\\','/'):sha(p) for p in sorted(ROOT.rglob('*')) if p.is_file() and p.name not in ('manifest.json','FREEZE.json')}
    write('manifest.json',{'algorithm':'sha256','files':inventory})
    write('FREEZE.json',{'frozen_utc':protocol['frozen_utc'],'manifest_sha256':sha(ROOT/'manifest.json'),'file_count':len(inventory),'target_execution_performed':False,'instruction':'Read-only frozen design; record execution and deviations elsewhere.'})
    print(json.dumps({'frozen':str(ROOT),'cases':len(cases),'controls':len(controls),'files':len(inventory),'large_cases':[(c['case_id'],c['source_count'],c['anticipated_compiled_rule_count'],c['conflict_request_count']) for c in cases[:4]],'manifest_sha256':sha(ROOT/'manifest.json')},indent=2))

if __name__=='__main__': main()
