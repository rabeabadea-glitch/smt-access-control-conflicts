"""CLI: audit, export, replay, and apply an explicitly supplied authorization."""
import argparse
import json
import pathlib
import sys
from .model import normalize,InputError
from .verify import audit
from .repair import refine
from .export import generate,replay

def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('command',choices=['audit','export','replay','repair'])
    ap.add_argument('policy');ap.add_argument('--out',required=True)
    ap.add_argument('--approval');ap.add_argument('--generated')
    ap.add_argument('--screen',choices=['exhaustive','exact','heuristic'],default='exhaustive')
    ap.add_argument('--timeout-ms',type=int,default=2000);ap.add_argument('--resource-limit',type=int,default=0)
    args=ap.parse_args();out=pathlib.Path(args.out);out.parent.mkdir(parents=True,exist_ok=True)
    try:
        p=normalize(json.loads(pathlib.Path(args.policy).read_text()))
        if args.command=='audit':ans=audit(p,args.screen,args.timeout_ms,args.resource_limit)
        elif args.command=='export':
            out.write_text(generate(p));print(str(out));return 0
        elif args.command=='replay':
            if not args.generated:ap.error('--generated is required for replay')
            ans=replay(p,args.generated)
        else:
            if not args.approval:ap.error('--approval is required for repair')
            ans=refine(p,json.loads(pathlib.Path(args.approval).read_text()),args.timeout_ms)
        out.write_text(json.dumps(ans,indent=2,sort_keys=True)+'\n');print(json.dumps({'output':str(out),'status':ans.get('status',ans.get('label',ans.get('passed')))}))
        return 0
    except (InputError,ValueError,OSError,RuntimeError) as exc:
        ans={'status':getattr(exc,'status','INVALID_INPUT' if isinstance(exc,json.JSONDecodeError) else 'EXECUTION_ERROR'),'reason':str(exc)}
        out.write_text(json.dumps(ans,indent=2)+'\n');print(json.dumps(ans));return 2

if __name__=='__main__':sys.exit(main())
