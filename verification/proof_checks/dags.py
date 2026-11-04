"""Uniqueness of the closed form in Equation 4.10 for every acyclic choice relation on n rules.
For each relation, two families A and B that both satisfy D*(l) = D(l) minus the union of D*(w)
over (w, l) in Auth must be equal at every request. One incremental SMT-LIB script per n."""
import itertools

def dags(n):
    edges = [(i, j) for i in range(n) for j in range(n) if i != j]
    for mask in range(1 << len(edges)):
        es = [edges[k] for k in range(len(edges)) if mask >> k & 1]
        # acyclic check
        indeg = {i: 0 for i in range(n)}
        for _, j in es: indeg[j] += 1
        q = [i for i in range(n) if indeg[i] == 0]; seen = 0
        adj = {i: [] for i in range(n)}
        for i, j in es: adj[i].append(j)
        while q:
            u = q.pop(); seen += 1
            for v in adj[u]:
                indeg[v] -= 1
                if indeg[v] == 0: q.append(v)
        if seen == n:
            yield es

def script(n):
    out = ["(set-logic ALL)", "(declare-sort Req 0)"]
    for i in range(n):
        out += [f"(declare-fun D{i} (Req) Bool)", f"(declare-fun A{i} (Req) Bool)", f"(declare-fun B{i} (Req) Bool)"]
    count = 0
    for es in dags(n):
        count += 1
        out.append("(push 1)")
        for fam in 'AB':
            for l in range(n):
                ws = [w for w, t in es if t == l]
                rhs = f"(D{l} x)" if not ws else f"(and (D{l} x) (not (or false {' '.join(f'({fam}{w} x)' for w in ws)})))"
                out.append(f"(assert (forall ((x Req)) (= ({fam}{l} x) {rhs})))")
        out.append("(assert (exists ((x Req)) (or " + ' '.join(f"(not (= (A{i} x) (B{i} x)))" for i in range(n)) + ")))")
        out.append("(check-sat)")
        out.append("(pop 1)")
    return '\n'.join(out) + '\n', count
