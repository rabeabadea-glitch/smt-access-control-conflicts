"""Small, explicit binding to the installed Z3 C API; no Python z3 dependency.
Only generated SMT-LIB is accepted by this internal module. Never pass user SMT.
"""
from __future__ import annotations
import ctypes as C
import ctypes.util
import os
import time
from dataclasses import dataclass, asdict

P = C.c_void_p
S = C.c_char_p
I = C.c_int
U = C.c_uint

@dataclass
class Answer:
    status: str
    values: dict[str, int] | None = None
    reason: str = ""
    elapsed_ms: float = 0.0
    def to_dict(self):
        return asdict(self)

class NativeZ3:
    def __init__(self, library: str | None = None):
        path = library or os.environ.get('Z3_LIBRARY') or ctypes.util.find_library('z3')
        if not path:
            raise RuntimeError('Z3 shared library unavailable. Set Z3_LIBRARY; see README.')
        self.library = path
        self.lib = C.CDLL(path)
        signatures = {
            'Z3_mk_config': (P, []), 'Z3_del_config': (None, [P]),
            'Z3_mk_context': (P, [P]), 'Z3_del_context': (None, [P]),
            'Z3_mk_solver': (P, [P]), 'Z3_solver_inc_ref': (None,[P,P]),
            'Z3_solver_dec_ref': (None,[P,P]),
            'Z3_solver_from_string': (None,[P,P,S]),
            'Z3_solver_check': (I,[P,P]),
            'Z3_solver_get_model': (P,[P,P]),
            'Z3_solver_get_reason_unknown': (S,[P,P]),
            'Z3_mk_string_symbol': (P,[P,S]), 'Z3_mk_int_sort': (P,[P]),
            'Z3_mk_const': (P,[P,P,P]),
            'Z3_model_eval': (C.c_bool,[P,P,P,C.c_bool,C.POINTER(P)]),
            'Z3_get_numeral_string': (S,[P,P]),
            'Z3_get_error_code': (U,[P]), 'Z3_get_error_msg': (S,[P,U]),
            'Z3_mk_params': (P,[P]), 'Z3_params_inc_ref': (None,[P,P]),
            'Z3_params_dec_ref': (None,[P,P]),
            'Z3_params_set_uint': (None,[P,P,P,U]),
            'Z3_solver_set_params': (None,[P,P,P]),
            'Z3_get_full_version': (S,[]),
        }
        for name,(ret,args) in signatures.items():
            fun = getattr(self.lib,name); fun.restype=ret; fun.argtypes=args
        self.version = self.lib.Z3_get_full_version().decode()
        self._errtype=C.CFUNCTYPE(None,P,U)
        self._errhandler=self._errtype(lambda ctx,err: None)
        self.lib.Z3_set_error_handler.argtypes=[P,self._errtype]
        self.lib.Z3_set_error_handler.restype=None

    @staticmethod
    def unknown_status(reason: str) -> str:
        return 'TIMEOUT' if 'timeout' in reason.lower() else 'UNKNOWN'

    def solve(self, text: str, variables: list[str], *, timeout_ms: int=2000,
              resource_limit: int=0) -> Answer:
        for name,value in [('timeout_ms',timeout_ms),('resource_limit',resource_limit)]:
            if type(value) is not int or not 0 <= value <= 2**32-1:
                raise ValueError(name+' must be an integer in [0, 4294967295]')
        t=time.perf_counter(); z=self.lib
        cfg=z.Z3_mk_config(); ctx=z.Z3_mk_context(cfg); z.Z3_del_config(cfg)
        z.Z3_set_error_handler(ctx,self._errhandler)
        solver=z.Z3_mk_solver(ctx); z.Z3_solver_inc_ref(ctx,solver)
        try:
            params=z.Z3_mk_params(ctx); z.Z3_params_inc_ref(ctx,params)
            for key,val in [('timeout',timeout_ms),('rlimit',resource_limit)]:
                z.Z3_params_set_uint(ctx,params,z.Z3_mk_string_symbol(ctx,key.encode()),val)
            z.Z3_solver_set_params(ctx,solver,params); z.Z3_params_dec_ref(ctx,params)
            z.Z3_solver_from_string(ctx,solver,text.encode('ascii'))
            err=z.Z3_get_error_code(ctx)
            if err:
                return Answer('ENCODING_ERROR',reason=z.Z3_get_error_msg(ctx,err).decode(),elapsed_ms=(time.perf_counter()-t)*1000)
            status=z.Z3_solver_check(ctx,solver)
            if status == 1:
                model=z.Z3_solver_get_model(ctx,solver); vals={}
                for name in variables:
                    ast=z.Z3_mk_const(ctx,z.Z3_mk_string_symbol(ctx,name.encode()),z.Z3_mk_int_sort(ctx))
                    out=P()
                    if not z.Z3_model_eval(ctx,model,ast,True,C.byref(out)):
                        return Answer('ENCODING_ERROR',reason='Model evaluation failed')
                    numeral=z.Z3_get_numeral_string(ctx,out)
                    vals[name]=int(numeral.decode())
                answer=Answer('SAT',values=vals)
            elif status == -1:
                answer=Answer('UNSAT')
            else:
                reason=z.Z3_solver_get_reason_unknown(ctx,solver).decode()
                answer=Answer(self.unknown_status(reason),reason=reason)
            answer.elapsed_ms=(time.perf_counter()-t)*1000
            return answer
        finally:
            z.Z3_solver_dec_ref(ctx,solver); z.Z3_del_context(ctx)
