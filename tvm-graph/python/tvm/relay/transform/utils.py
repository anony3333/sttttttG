from typing import Dict
from tvm import relay
from tvm.relay.expr_functor import ExprMutator, ExprVisitor

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

    def visit_tuple_getitem(self, op):
        if op in self.replace_map.keys():
            return super().visit(self.replace_map[op])
        return super().visit_tuple_getitem(op)


class EmitTuple(ExprMutator):
    def __init__(self):
        super().__init__()

    def visit_tuple_getitem(self, op):
        if isinstance(op.tuple_value, relay.Tuple):
            return super().visit(op.tuple_value.fields[op.index])
        return super().visit_tuple_getitem(op)

class BuildGraph(ExprVisitor):
    def __init__(self):
        super().__init__()
        self.call_list = []

    def visit_call(self, call):
        self.call_list.append(call)
        # 访问 call 的父节点，而不是访问 op 里面的东西
        # return super().visit_call(call)
        for a in call.args:
            self.visit(a)

    def topo_sort(self, graph):
        sorted_list = []
        visit_node = set()
        while len(sorted_list) < len(graph):
            for node, depend in graph.items():
                if node not in sorted_list and len(depend - visit_node) == 0:
                    sorted_list.append(node)
                    visit_node.add(node)
        return sorted_list

    def build_graph(self):
        # 建立 依赖图
        depend_graph = {}
        for call in self.call_list:
            depend_graph[call] = set()
            for a in call.args:
                if isinstance(a, relay.Call):
                    depend_graph[call].add(a)
                elif isinstance(a, relay.TupleGetItem):
                    tuple_value = a.tuple_value
                    while isinstance(tuple_value, relay.TupleGetItem):
                        tuple_value = tuple_value.tuple_value
                    depend_graph[call].add(tuple_value)
        # topo sort
        sorted_list = self.topo_sort(depend_graph)
        return sorted_list


    def get_call_list(self, expr):
        self.visit(expr)
        sorted_list = self.build_graph()
        assert (set(self.call_list) & set(sorted_list)) == (set(self.call_list) | set(sorted_list))
        return sorted_list
        for call in sorted_list:
            print(".........")
            if call.attrs:
                print(call.attrs.tag)
            else:
                print(call.op.attrs)



def is_scalar(expr: relay.Expr):
    return isinstance(expr, relay.Constant) and expr.data.asnumpy().ndim == 0 and (expr.data.dtype in ["int32", "int64", "float32", "float64", "bool"])
