import copy
from enum import IntEnum
from typing import DefaultDict, List, Dict
import tvm
from tvm import relay
from tvm.relay import ExprVisitor, Function
from tvm.relay.expr import ExprWithOp
from tvm.relay.expr_functor import MixedModeMutator
from tvm.relay.op.op import OpPattern
from .custom_fuse_ops import FuseMutator, IndexedForwardGraph
from .utils import ReplaceParams, is_scalar
import pdb

class MappingType(IntEnum):
    OneToOne = 0
    OneToMany = 1
    ManyToMany = 2
    Reorganize = 3
    Shuffle = 4
    Tuple = 7
    Opaque = 8
    Parallel = 9


def register_pattern(op_name, pattern, level=11):
    return tvm.ir.register_op_attr(op_name, "DFOpPattern", pattern, level)

def get_pattern(op):
    return op.get_attr("DFOpPattern")

register_pattern("nn.conv2d", MappingType.ManyToMany)
register_pattern("multiply", MappingType.OneToMany)
register_pattern("add", MappingType.OneToMany)

class TagFuseMapper:
    def __init__(self) -> None:
        self.tag_map = {}
    
    def __setitem__(self, key: str, value: MappingType):
        self.tag_map[key] = value
    
    def __getitem__(self, key: str):
        if key not in self.tag_map:
            return MappingType.Opaque
        else:
            return self.tag_map[key]

tag2type = TagFuseMapper()

def register_tag_pattern(key, value):
    tag2type[key] = value

def get_tag_pattern(key):
    return tag2type[key]

    

class PrintFuncType(ExprVisitor):
    def visit_call(self, call):
        print(call.op, call.op.get_attr("TOpPattern"))
        print(call.op, get_pattern(call.op))
        print(call.attrs.tag)
        print(get_tag_pattern(call.attrs.tag))
        return super().visit_call(call)


@relay.transform.function_pass(opt_level=0)
class PrintOpType:
    def transform_function(self, func, mod, ctx):
        PrintFuncType().visit(func)
        return func

class GroupOp:
    def __init__(self, group: List[relay.Call]) -> None:
        self.group = group
        self.args = self.init_args(group)
        self.output = []
        self.fused_func = None

    
    def init_args(self, group: List[relay.Call]) -> List[ExprWithOp]:
        args = []
        for node in group:
            for arg in node.args:
                if arg not in args and arg not in group:
                    # check whether is scalar const
                    if is_scalar(arg):
                        continue
                    args.append(arg)
        return args
    
    def add_output(self, node: relay.Call) -> None:
        assert node in self.group
        if node not in self.output:
            self.output.append(node)
    
    def cast_param(self, expr: relay.Expr) -> List[relay.Var]:
        params = {}
        for index, arg in enumerate(self.args):
            params[arg] = relay.Var(f"p{index}", arg.checked_type)
        
        replace_param = ReplaceParams(params)
        ret_expr = replace_param.visit(expr)
        return list(params.values()), ret_expr

    def fuse(self) -> None:
        output = [o.checked_type for o in self.output]
        assert len(output) > 0
        if len(output) == 1:
            ret_type = output[0]
            ret_expr = self.group[-1]
        else:
            output = self.output
            ret_expr = relay.Tuple(output)
            ret_type = relay.transform.InferTypeLocal(ret_expr)
        params, ret_expr = self.cast_param(ret_expr)
        func = Function(params, ret_expr, ret_type, [])
        func = func.with_attr({"tag": "fuse_" + "_".join([op.attrs.tag.split("_")[-1] for op in self.group])})
        fuse = relay.Call(func, self.args)
        self.fused_func = fuse


class DNNFusion(MixedModeMutator):
    pattern_map = {
        OpPattern.ELEMWISE: MappingType.OneToOne,
        OpPattern.BROADCAST: MappingType.OneToMany,
        OpPattern.INJECTIVE: MappingType.OneToOne,
        OpPattern.COMM_REDUCE: MappingType.ManyToMany,
        OpPattern.OUT_ELEMWISE_FUSABLE: MappingType.ManyToMany,
        OpPattern.TUPLE: MappingType.Tuple,
        OpPattern.OPAQUE: MappingType.Opaque,
    }

    @classmethod
    def fuseable(cls, first_op, second_op):
        if first_op in [MappingType.OneToMany, MappingType.ManyToMany] and second_op in [MappingType.ManyToMany]:
            return False
        return True

    @classmethod
    def fuse_table(cls, first_op, second_op):
        if first_op == MappingType.OneToOne:
            return second_op
        elif first_op in [MappingType.OneToMany, MappingType.ManyToMany]:
            return first_op
        elif second_op in [MappingType.OneToMany, MappingType.ManyToMany]:
            return second_op
        elif second_op == MappingType.Reorganize:
            return MappingType.Reorganize
        else:
            return first_op

    def __init__(self):
        super(DNNFusion, self).__init__()
        self.gmap_ = {}
        self.ginfo_ = DefaultDict(FuseMutator.GroupInfo)
    
    def change_node_pattern(self, graph):
        for node in graph.node_map.values():
            node.pattern = DNNFusion.pattern_map[node.pattern]
        for node in graph.post_dfs_order:
            assert isinstance(node.pattern, MappingType)
    
    def build_depends(self, call_group: List[relay.Call]) -> Dict[relay.Call, List[relay.Call]]:
        depend_relations = {}
        for node in call_group:
            depends = []
            for arg in node.args:
                if arg in call_group:
                    depends.append(arg)
            depend_relations[node] = depends
        return depend_relations
    
    def topo_sort(self, call_group: List[relay.Call]) -> List[relay.Call]:
        depend_relations = self.build_depends(call_group)
        new_call_group = []
        while len(depend_relations) > 0:
            add_nodes = []
            for node, depends in depend_relations.items():
                if len(depends) == 0:
                    add_nodes.append(node)
            for node in add_nodes:
                depend_relations.pop(node)
                for _, depends in depend_relations.items():
                    if node in depends:
                        depends.remove(node)
            new_call_group += add_nodes

        return new_call_group

    def get_call_nodes(self, graph: IndexedForwardGraph) -> List[relay.Call]:
        """ 将其中call的op拿出来分析融合"""
        call_group = []
        for node in graph.post_dfs_order:
            if isinstance(node.ref, relay.Call):
                call_group.append(node.ref)
        return self.topo_sort(call_group)
    
    def get_all_ancestor(self, node: relay.Call, depends_relation: Dict[relay.Call, List[relay.Call]]):
        unvisit_ancestor = [node]
        ancestors = set()
        while len(unvisit_ancestor) > 0:
            node = unvisit_ancestor[0]
            unvisit_ancestor.remove(node)
            ancestors.add(node)
            unvisit_ancestor = unvisit_ancestor + depends_relation[node]
        return ancestors

    def partition(self, graph: IndexedForwardGraph) -> List[List[relay.Call]]:
        """ 将其中call的op拿出来分析融合
        其中 group 要满足如下条件:
            1. 每个 group 可融合为一个op
            2. 不存在一个外部 node, 同时是某一 group 的上下游. 比如其中的某一`op`
                  conv2d
                 /  |  \
                /   |   \
              op    op   op
               \    |    /
                \   |   /
                elemwise add
                    |
        """
        call_group = self.get_call_nodes(graph)
        depends_relation = self.build_depends(call_group)
        def get_last_node(node_list, visit_node):
            for node in node_list[::-1]:
                if node not in visit_node:
                    return node
            raise ValueError("can't get last node")
        # 自底向上fuse（因为只能拿到args，不能拿到output）
        partial_group = []
        while len(call_group) > 0:
            sub_group = [call_group[-1]]
            call_group.remove(sub_group[0])
            pattern = get_pattern(sub_group[0].op)
            # fuse
            cand_nodes = [] + depends_relation[sub_group[0]]
            unfused_nodes = set()
            while len(cand_nodes) > 0:
                node = cand_nodes[0]
                cand_nodes.remove(node)
                if DNNFusion.fuseable(get_pattern(node.op), pattern):
                    if node in unfused_nodes:
                        continue
                    # 更新 pattern， group，待fuse node，全集node
                    pattern = DNNFusion.fuse_table(get_pattern(node.op), pattern)
                    sub_group.append(node)
                    call_group.remove(node)
                    # cand_nodes += depends_relation[node]
                    for cand in depends_relation[node]:
                        if (cand in call_group) and (cand not in cand_nodes):
                            cand_nodes.append(cand)
                else:
                    # 更新unfused_nodes
                    unfused_nodes.update(self.get_all_ancestor(node, depends_relation))
            partial_group.append(self.topo_sort(sub_group))

        return partial_group
    
    def debug_partition_group(self, groups: List[List[relay.Call]]):
        for group in groups:
            print([call.op for call in group])


    def run_fuse(self, groups, body, all_output=[]):
        packed_groups: List[GroupOp] = []
        call_map: Dict[relay.Call, GroupOp] = {}
        # init
        for group in groups:
            packed_groups.append(GroupOp(group))
            call_map.update({k: packed_groups[-1] for k in group})
        # output
        for packed_group in packed_groups:
            for arg in packed_group.args:
                if isinstance(arg, relay.Call) and arg in call_map.keys():
                    call_map[arg].add_output(arg)
        call_map[all_output].add_output(all_output)
        # fuse
        for group_op in packed_groups:
            group_op.fuse()
        # packed into new body
        # TODO:assmue output number = 1, if output > 1, need add `TupleGetItem`
        # relay_call_map = {list(group_op.output)[0]: group_op.fused_func for group_op in packed_groups}
        relay_call_map = {}
        for group_op in packed_groups:
            if len(group_op.output) == 1:
                relay_call_map[list(group_op.output)[0]] = group_op.fused_func
            else:
                for idx, out in enumerate(group_op.output):
                    relay_call_map[out] = relay.TupleGetItem(group_op.fused_func, idx)
        replace_param = ReplaceParams(relay_call_map)
        fuse_body = replace_param.visit(body)
        return fuse_body

    def transform(self, body):
        
        output = body.body
        graph = IndexedForwardGraph.Create(body)
        self.change_node_pattern(graph)
        groups = self.partition(graph)
        # self.debug_partition_group(groups)
        return self.run_fuse(groups, body, output)


@relay.transform.function_pass(opt_level=1)
class DNNFuseOps:
    def __init__(self) -> None:
        pass

    def transform_function(self, func, mod, ctx):
        return DNNFusion().transform(func)


class GetCallNode(ExprVisitor):
    def __init__(self):
        super().__init__()
        self.call_list = []


    def visit_call(self, call):
        self.call_list.append(call)
        return super().visit_call(call)
    
    def get_call_list(self):
        return self.call_list

def get_call_list(expr):
    visitor = GetCallNode()
    visitor.visit(expr)
    return visitor.get_call_list()


class StencilFusion(MixedModeMutator):
    @classmethod
    def fuseable(cls, first_op, second_op):
        if first_op in [MappingType.Parallel] and second_op in [MappingType.Parallel]:
            return False
        return True

    @classmethod
    def fuse_table(cls, first_op, second_op):
            return first_op


    def __init__(self) -> None:
        super(MixedModeMutator, self).__init__()
        
    
    def check_graph(self, graph):
        return True
        # TODO: 需要加一个检查所有节点是否在同一颗树上的函数
        set_list = []
        node_list = list(graph.keys())
        while node_list:
            node_set = set()
            visit_list = [node_list.pop(0)]
            for node in visit_list:
                node_set.add(node)
                visit_list += graph[node]["input"]
                visit_list += graph[node]["output"]


    def get_pattern(self, call):
        return get_tag_pattern(call.attrs.tag)
    

    def build_graph(self, expr):
        call_list = get_call_list(expr)
        call_list = set(call_list)
        # key: call node, value: {input: [node], output: [node]}
        graph = {}
        for node in call_list:
            graph[node] = {"input": [], "output": []}
        for node in call_list:
            for arg in node.args:
                if arg in call_list:
                    graph[node]["input"].append(arg)
                    graph[arg]["output"].append(node)
                elif isinstance(arg, relay.TupleGetItem):
                    if arg.tuple_value not in graph[node]["input"]:
                        graph[node]["input"].append(arg.tuple_value)
                    if node not in graph[arg.tuple_value]["output"]:
                        graph[arg.tuple_value]["output"].append(node)

        assert self.check_graph(graph)
        return graph
    
    def build_depence(self, graph):
        def find_father(node):
            father = copy.copy(graph[node]["input"])
            indirect_node = []
            for f in father:
                indirect_node += find_father(f)
            return father + indirect_node
        
        def find_child(node):
            child = copy.copy(graph[node]["output"])
            indirect_node = []
            for c in child:
                indirect_node += find_child(c)
            return child + indirect_node
        
        depence_graph = {}
        for node in graph.keys():
            depence_graph[node] = set(find_father(node) + find_child(node))
        return depence_graph
    
    def parallel_merge(self, graph):
        depence_graph = self.build_depence(graph)
        call_list = list(graph.keys())
        parallel_list = [node for node in call_list if self.get_pattern(node) == MappingType.Parallel]
        merged_node = set()
        fused_node: List[GroupOp] = []
        # find fused op
        for node1 in parallel_list:
            for node2 in parallel_list:
                if node1 != node2 and node1 not in merged_node and node2 not in merged_node:
                    if node1 not in depence_graph[node2] and node2 not in depence_graph[node1]:
                        merged_node.add(node1)
                        merged_node.add(node2)
                        fused_node.append(GroupOp([node1, node2]))
        # update group op output
        for node in fused_node:
            for output in node.group:
                node.add_output(output)
            node.fuse()
        # packed into new body
        return fused_node
    
    def serial_merge(self, graph):
        call_list = list(graph.keys())
        serial_list = [node for node in call_list if self.get_pattern(node) == MappingType.OneToOne]
        merged_node = set()
        fused_node: List[GroupOp] = []
        # find fused op
        for node1 in serial_list:
            for node2 in serial_list:
                if node1 != node2 and node1 not in merged_node and node2 not in merged_node:
                    if node1 in graph[node2]["input"]:
                        merged_node.add(node1)
                        merged_node.add(node2)
                        new_node = GroupOp([node1, node2])
                        new_node.add_output(node2)
                        new_node.fuse()
                        fused_node.append(new_node)
        return fused_node

    
    def fuse_op(self, expr, fused_node):
        relay_call_map = {}
        for group_op in fused_node:
            if len(group_op.output) == 1:
                relay_call_map[list(group_op.output)[0]] = group_op.fused_func
            else:
                for idx, out in enumerate(group_op.output):
                    relay_call_map[out] = relay.TupleGetItem(group_op.fused_func, idx)
        replace_param = ReplaceParams(relay_call_map)
        fused_body = replace_param.visit(expr)
        return fused_body


    def transform(self, expr):
        graph = self.build_graph(expr)
        # print(expr)
        # pdb.set_trace()
        fused_node = self.parallel_merge(graph)
        fused_node += self.serial_merge(graph)
        new_expr = self.fuse_op(expr, fused_node)
        return new_expr


@relay.transform.function_pass(opt_level=1)
class StencilFuseOps:
    def transform_function(self, func, mod, ctx):
        # pdb.set_trace()
        return StencilFusion().transform(func)
