from typing import Dict
from tvm import relay
from tvm.relay.expr_functor import ExprMutator

class ReplaceParams(ExprMutator):
    def __init__(self, replace_map):
        super().__init__()
        self.replace_map: Dict = replace_map
    
    def visit_call(self, call):
        if call in self.replace_map.keys():
            return super().visit(self.replace_map[call])
        return super().visit_call(call)
    
    def visit_var(self, var):
        if var in self.replace_map.keys():
            return self.replace_map[var]
        return super().visit_var(var)
    
    def visit_constant(self, const):
        if const in self.replace_map.keys():
            return self.replace_map[const]
        return super().visit_constant(const)


def is_scalar(expr: relay.Expr):
    return isinstance(expr, relay.Constant) and expr.data.asnumpy().ndim == 0 and (expr.data.dtype in ["int32", "int64", "float32", "float64", "bool"])
