"""Run one frozen challenge case and print what happened. Writes nothing.

Meant for practice and for showing a result live, for example at the defense.

Usage (from the package root):
  python studies/try_case.py C05 settled          # frozen rule order
  python studies/try_case.py C04 listed 3         # permutation number 3 of the order study
  python studies/try_case.py C08 settled

The second argument is the pair-selection rule: listed (original transaction)
or settled (settled-winner selection). The optional third argument picks one of
the 20 seeded permutations used in the order study (0 to 19).
"""
import sys

from order_study import job


def main():
    if len(sys.argv) < 3 or sys.argv[2] not in ('listed', 'settled'):
        raise SystemExit(__doc__)
    case_id, mode = sys.argv[1].upper(), sys.argv[2]
    k = int(sys.argv[3]) if len(sys.argv) > 3 else -1
    row = job((case_id, k, mode))
    trace = row.pop('trace', None) or []
    row.pop('output_model', None)
    print(f"case {case_id}, rule order {'frozen' if k < 0 else 'permutation ' + str(k)}, selection {mode}")
    print(f"  status:              {row['status']}")
    print(f"  reason:              {row['reason']}")
    print(f"  edits attempted:     {row['steps']}")
    print(f"  output committed:    {row['committed']}")
    print(f"  target mismatches:   {row['target_mismatches']} (requests whose decision differs from the frozen target)")
    print(f"  requirement breaks:  {row['contract_violations']}")
    print(f"  Conflict requests:   {row['conflict_requests']}")
    print(f"  rules retired:       {len(row['retired_rules'])} {row['retired_rules'] or ''}")
    print(f"  time:                {row['elapsed_seconds_diagnostic']} s")
    if trace:
        print('  edits (winner -> loser):')
        for step in trace:
            choice = step['choice']
            if isinstance(choice, dict):
                choice = f"{choice.get('winner')} -> {choice.get('loser')}"
            print(f"    {step['iteration']:>3}: {choice}")


if __name__ == '__main__':
    main()
