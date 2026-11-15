"""Build the two files of the CI example from the cross-framework corpus.

baseline.xml  the corpus without the seven rules whose translation dropped a legal
              exception; nothing in it conflicts.
changed.xml   the same file after a one-line "simplification": the legal-hold guard
              (GDPR Art. 17(3)(b)) is deleted from the erasure rule.
"""
import copy
import sys
import xml.etree.ElementTree as ET
from pathlib import Path

HERE = Path(__file__).resolve().parent
CORPUS = HERE.parents[1] / 'data' / 'policies' / 'cross_source_corpus.xml'
NS = 'urn:oasis:names:tc:xacml:3.0:core:schema:wd-17'
ET.register_namespace('', NS)
DROPPED = {'GDPR-17-erase-ungoverned', 'GDPR-15-subject-access-ungoverned', 'GDPR-5c-minimisation',
           'GDPR-5e-storage-purge', 'GDPR-6-restrict-transfer-ungoverned', 'AMLD-investigator-full-pan',
           'PCI-8-3-9-rotate-password'}


def tag(e):
    return e.tag.rsplit('}', 1)[-1]


tree = ET.parse(CORPUS)
root = tree.getroot()
for policy in [p for p in root if tag(p) == 'Policy']:
    for rule in [r for r in policy if tag(r) == 'Rule' and r.get('RuleId') in DROPPED]:
        policy.remove(rule)
    if not any(tag(r) == 'Rule' for r in policy):
        root.remove(policy)
tree.write(HERE / 'ci_baseline.xml', encoding='utf-8', xml_declaration=True)

changed = copy.deepcopy(tree)
removed = 0
for rule in changed.getroot().iter('{%s}Rule' % NS):
    if rule.get('RuleId') == 'GDPR-17-erase-governed':
        for allof in rule.iter('{%s}AllOf' % NS):
            for match in list(allof):
                if any('under-legal-hold' in (d.get('AttributeId') or '') for d in match.iter('{%s}AttributeDesignator' % NS)):
                    allof.remove(match)
                    removed += 1
if removed != 1:
    sys.exit('expected exactly one legal-hold guard')
changed.write(HERE / 'ci_changed.xml', encoding='utf-8', xml_declaration=True)
print('wrote ci_baseline.xml and ci_changed.xml')
