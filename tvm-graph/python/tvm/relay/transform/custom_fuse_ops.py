from typing import DefaultDict
from tvm import relay
from tvm.relay.expr import Constant
from tvm.relay import Call, Function, Let, TupleGetItem, Type, Var, Expr
from tvm.ir.tensor_type import TensorType
from tvm.ir.base import structural_equal as attr_equal_
from tvm.relay import ExprVisitor
from tvm.relay.expr_functor import ExpandANormalForm
from tvm.relay.ty import is_data_dependent, is_dynamic
from tvm.relay.expr_functor import MixedModeMutator
from tvm.relay.op import OpPattern
from tvm.ir.op import Op



class IndexedForwardGraph:
    class Node:
        pass

    class Edge:
        """ The forward edge in the dataflow graph. """
        def __init__(self) -> None:
            """ The corresponding node """
            self.node: IndexedForwardGraph.Node = None
            """ The respective pattern of this op """
            self.pattern = OpPattern.OPAQUE

    class Node:
        def __init__(self) -> None:
            """ weak reference to the corresponding edge. """
            self.ref = None
            """ The index of the node in topological order. """
            self.index = 0
            """ Whether this node is referenced by external source """
            self.extern_ref = False
            """ The general pattern in the node """
            self.pattern = OpPattern.OPAQUE
            """ The outputs of the node """
            self.outputs : list[IndexedForwardGraph.Edge] = []
    
    def __init__(self) -> None:
        """ The node map that maps node to graph """
        self.node_map: dict[object, IndexedForwardGraph.Node] = {}
        """ All the nodes in post DFS order """
        self.post_dfs_order: list[IndexedForwardGraph.Node] = []
    
    def DebugDump(self):
        """ Dump the graph into string. """
        ostring = ""
        for i in range(len(self.post_dfs_order)):
            node = self.post_dfs_order[i]
            ostring += f"node[{i}], {str(node.ref)} outputs=["
            for link in node.outputs:
                ostring += f"{link.node.index}, "
            ostring += "]\n"
        print(ostring)

    class Creator(ExprVisitor):
        """ Creator of post dominator tree of the dataflow """
        def __init__(self):
            super().__init__()
            self.graph_ = IndexedForwardGraph()
            self.attr_equal_ = None
        
        def Prepare(self, body):
            self.Update(body, None, OpPattern.OPAQUE)
            self.visit(body)
            return self.graph_
        
        def Update(self, node, parent, pattern):
            if node in self.graph_.node_map.keys():
                current = self.graph_.node_map[node]
            else:
                current = IndexedForwardGraph.Node()
                self.graph_.node_map[node] = current
            if parent != None:
                link = IndexedForwardGraph.Edge()
                link.node = parent
                link.pattern = pattern
                current.outputs.append(link)
            else:
                current.extern_ref = True
        
        def AddNode(self, key):
            assert key in self.graph_.node_map.keys(), f"Cannot find node {key}"
            node = self.graph_.node_map[key]
            assert node.ref == None
            node.ref = key
            node.index = len(self.graph_.post_dfs_order)
            self.graph_.post_dfs_order.append(node)
        
        def visit_function(self, op):
            if op.attrs and "Compiler" in op.attrs:
                return
            for param in op.params:
                self.Update(param, None, OpPattern.OPAQUE)
            self.Update(op.body, None, OpPattern.OPAQUE)
            super().visit_function(op)
        
        def visit_constant(self, op):
            self.AddNode(op)
            node = self.graph_.node_map[op]
            dtype = op.data.dtype
            is_simple_const = dtype in ["int32", "int64", "float32", "float64", "bool"]
            if op.data.asnumpy().ndim == 0 and is_simple_const:
                node.pattern = OpPattern.ELEMWISE
            else:
                node.pattern = OpPattern.OPAQUE

        def visit_call(self, call):
            assert call in self.graph_.node_map.keys()
            node = self.graph_.node_map[call]
            op_pattern = OpPattern.OPAQUE
            if isinstance(call.op, Op):
                op = call.op
                if is_dynamic(call.checked_type) and is_data_dependent(call):
                    op_pattern = OpPattern.OPAQUE
                else:
                    op_pattern = op.get_attr("TOpPattern")
            else:
                self.Update(call.op, node, OpPattern.OPAQUE)
            
            node.pattern = op_pattern
            self.Update(call.op, None, OpPattern.OPAQUE)
            rtype = call.checked_type

            for i in range(len(call.args)):
                arg_type = call.args[i].checked_type
                edge_pattern = op_pattern
                if edge_pattern == OpPattern.BROADCAST and isinstance(arg_type, TensorType) and isinstance(rtype, TensorType) and attr_equal_(arg_type.shape, rtype.shape):
                    edge_pattern = OpPattern.ELEMWISE
                self.Update(call.args[i], node, edge_pattern)
            super().visit_call(call)
            self.AddNode(call)
        
        def visit_tuple(self, op):
            assert op in self.graph_.node_map.keys()
            tuple_node = self.graph_.node_map[op]
            tuple_node.pattern = OpPattern.TUPLE
            for field in op.fields:
                if isinstance(field.checked_type, TensorType):
                    self.Update(field, tuple, OpPattern.INJECTIVE)
                else:
                    self.Update(field, None, OpPattern.OPAQUE)        
            super().visit_tuple(op)
            self.AddNode(op)
        
        def visit_tuple_getitem(self, op):
            tuple_type = op.tuple.checked_type
            assert isinstance(tuple_type, TensorType)
            has_non_tensor = False
            for ty in tuple_type.fields:
                if not isinstance(ty, TensorType):
                    has_non_tensor = True
                    break
            
            if has_non_tensor:
                self.Update(op.tuple, None, OpPattern.OPAQUE)
            else:
                assert op in self.graph_.node_map.keys()
                node = self.graph_.node_map[op]
                node.pattern = OpPattern.INJECTIVE
                self.Update(op.tuple, node, OpPattern.INJECTIVE)

            super().visit_tuple_getitem(op)
            self.AddNode(op)
        
        def visit_var(self, var):
            self.AddNode(var)
        
        def visit_let(self, op):
            def prev_visit(op):
                self.Update(op.var, None, OpPattern.OPAQUE)
                self.Update(op.value, None, OpPattern.OPAQUE)
                self.Update(op.body, None, OpPattern.OPAQUE)
                self.visit(op.var)
                self.visit(op.value)
            
            def post_visit(op):
                self.visit(op.body)
                # self.visit_counter_[op] += 1
                self.AddNode(op)
            ExpandANormalForm(op, prev_visit, post_visit)
        
        def visit_if(self, op):
            self.Update(op.cond, None, OpPattern.OPAQUE)
            self.Update(op.true_branch, None, OpPattern.OPAQUE)
            self.Update(op.false_branch, None, OpPattern.OPAQUE)
            super().visit_if(op)
            self.AddNode(op)
        
        def visit_ref_create(self, op):
            self.Update(op.value, None, OpPattern.OPAQUE)
            super().visit_ref_create(op)
            self.AddNode(op)
        
        def visit_ref_read(self, op):
            self.Update(op.ref, None, OpPattern.OPAQUE)
            super().visit_ref_read(op)
            self.AddNode(op)
        
        def visit_ref_write(self, op):
            self.Update(op.ref, None, OpPattern.OPAQUE)
            self.Update(op.value, None, OpPattern.OPAQUE)
            super().visit_ref_write(op)
            self.AddNode(op)
        
        def visit_match(self, op):
            self.Update(op.data, None, OpPattern.OPAQUE)
            for c in op.clauses:
                self.Update(c.rhs, None, OpPattern.OPAQUE)
            super().visit_match(op)
            self.AddNode(op)
    
    def Create(body):
        return IndexedForwardGraph.Creator().Prepare(body)


class DominatorTree:
    """ Dominator tree that represent domination or post domination relation of the node. """

    class Node:
        """ A node in the dominator tree. """

        def __init__(self) -> None:
            self.gnode: IndexedForwardGraph.Node = None
            self.parent: DominatorTree.Node = None
            self.depth = 0
            self.pattern = OpPattern.OPAQUE
    
    def __init__(self) -> None:
        self.nodes: list[DominatorTree.Node] = []

    @classmethod
    def _CombinPattern(cls, lhs, rhs):
        if lhs > rhs:
            return lhs
        else:
            return rhs
    
    @classmethod
    def _LeastCommonAncestor(cls, lhs, rhs, edge_pattern):
        """ Find the least common ancestor of the two nodes. """
        while lhs != rhs:
            if lhs is None:
                return None
            if rhs is None:
                return None
            if lhs.depth < rhs.depth:
                edge_pattern[0] = cls._CombinPattern(edge_pattern[0], rhs.pattern)
                rhs = rhs.parent
            elif rhs.depth < lhs.depth:
                edge_pattern[0] = cls._CombinPattern(edge_pattern[0], lhs.pattern)
                lhs = lhs.parent
            else:
                edge_pattern[0] = cls._CombinPattern(edge_pattern[0], lhs.pattern)
                edge_pattern[0] = cls._CombinPattern(edge_pattern[0], rhs.pattern)
                lhs = lhs.parent
                rhs = rhs.parent
        return lhs
    
    def LeastCommonAncestor_list(self, input_node, edge_pattern):
        """ Find the least common ancestor of a list of nodes. """
        n = len(input_node)
        if n == 0:
            return None
        
        def get_node(edge):
            oindex = edge.node.index
            assert oindex < len(self.nodes)
            onode = self.nodes[oindex]
            assert onode is not None
            return onode
        
        parent = get_node(input_node[0])
        edge_pattern[0] = DominatorTree._CombinPattern(edge_pattern[0], input_node[0].pattern)
        for link_index in range(1, n):
            link = input_node[link_index]
            parent = DominatorTree._LeastCommonAncestor(parent, get_node(link), edge_pattern)
            edge_pattern[0] = DominatorTree._CombinPattern(edge_pattern[0], link.pattern)
        
        return parent
    
    def _GetNode(self, gnode: IndexedForwardGraph.Node):
        tnode = DominatorTree.Node()
        tnode.gnode = gnode
        if gnode.extern_ref:
            tnode.depth = 1
            tnode.parent = None
            tnode.pattern = OpPattern.OPAQUE
        else:
            # find the LCAs of all outputs
            pattern_list = [OpPattern.ELEMWISE]
            parent = self.LeastCommonAncestor_list(gnode.outputs, pattern_list)
            tnode.depth = parent.depth + 1 if parent else 1
            tnode.parent = parent
            tnode.pattern = pattern_list[0]
        return tnode
    
    @classmethod
    def PostDom(cls, graph: IndexedForwardGraph):
        tree = DominatorTree()
        tree.nodes = [None] * len(graph.post_dfs_order)
        # reverse topo order
        i = len(graph.post_dfs_order)
        while i > 0:
            index = i - 1
            tree.nodes[index] = tree._GetNode(graph.post_dfs_order[index])
            i -= 1
        return tree



class GraphPartitioner:
    """ A partition of the graph marked by union find data structure. """

    class Group:
        """ The parent in the union find data structure. """ 
        def __init__(self) -> None:
            self.parent = None
            self.pattern = None
            self.root_ref = None
            self.anchor_ref = None
            self.num_nodes = 1
        
        def FindRoot(self):
            if self.parent is None:
                return self
            root = self
            while root.parent is not None:
                root = root.parent
            p = self
            while p != root:
                parent = p.parent
                p.parent = root
                p = parent
            return root
        
        def __str__(self) -> str:
            data_members = ["pattern", "root_ref", "anchor_ref", "num_nodes"]
            return ", ".join([f"{member}: {getattr(self, member)}" for member in data_members])
        
        def __repr__(self) -> str:
            return self.__str__()

    def __init__(self, opt_level, max_fuse_depth) -> None:
        self.opt_level_ = opt_level
        self.max_fuse_depth_ = max_fuse_depth
        self.groups_ = []
        self.visited_ = set()
    
    def _CheckPath_(self, src: IndexedForwardGraph.Node, sink: IndexedForwardGraph.Node, fcond):
        if src in self.visited_:
            return True
        self.visited_.add(src)
        gnode = self.groups_[src.index]
        assert gnode is not None
        gnode = gnode.FindRoot()
        if not fcond(gnode.pattern, src == sink):
            return False
        if src == sink:
            return True
        for link in src.outputs:
            if not self._CheckPath_(link.node, sink, fcond):
                return False
        return True
        
    def _CheckPath(self, src: IndexedForwardGraph.Node, sink: IndexedForwardGraph.Node, fcond):
        assert not src.extern_ref
        self.visited_.clear()
        assert src != sink
        for link in src.outputs:
            if not self._CheckPath_(link.node, sink, fcond):
                return False
        return True
    
    @classmethod
    def CombinePattern(cls, lhs: OpPattern, rhs: OpPattern):
        if lhs > OpPattern.BROADCAST and rhs > OpPattern.BROADCAST:
            print("Cannot merge two complex group together")
        if lhs > rhs:
            return lhs
        else:
            return rhs
    
    def MergeFromTo(self, child: Group, parent: Group):
        child = child.FindRoot()
        parent = parent.FindRoot()
        if child == parent:
            return
        parent.num_nodes += child.num_nodes
        child.parent = parent
        if child.anchor_ref is not None:
            assert parent.anchor_ref is None
            parent.anchor_ref = child.anchor_ref
            parent.pattern = GraphPartitioner.CombinePattern(child.pattern, parent.pattern)
    
    def CommitFuse_(self, src: IndexedForwardGraph.Node, sink: IndexedForwardGraph.Node, target: Group):
        if src == sink:
            return
        if src in self.visited_:
            return
        self.visited_.add(src)
        gnode = self.groups_[src.index]
        assert gnode is not None
        self.MergeFromTo(gnode, target)
        for link in src.outputs:
            self.CommitFuse_(link.node, sink, target)

    def CommitFuse(self, src: IndexedForwardGraph.Node, sink: IndexedForwardGraph.Node):
        target = self.groups_[sink.index]
        self.visited_.clear()
        assert src != sink
        self.CommitFuse_(src, sink, target)

    def CountNodesUptoSink_(self, src: IndexedForwardGraph.Node, sink: IndexedForwardGraph.Node):
        if src == sink or src in self.visited_:
            return 0
        self.visited_.add(src)
        gnode = self.groups_[src.index]
        assert gnode is not None
        total = gnode.num_nodes
        for link in src.outputs:
            total += self.CountNodesUptoSink_(link.node, sink)
        return total
    
    def CountFusedNodesWithNewChild(self, child: IndexedForwardGraph.Node, dom_parent: IndexedForwardGraph.Node):
        target = self.groups_[dom_parent.index]
        self.visited_.clear()
        assert child != dom_parent
        return target.FindRoot().num_nodes + self.CountNodesUptoSink_(child, dom_parent)
    
    def InitGroup(self, graph: IndexedForwardGraph):
        if len(self.groups_) >= len(graph.post_dfs_order):
            self.groups_ = self.groups_[:len(graph.post_dfs_order)]
        else:
            self.groups_ += [None] * (len(graph.post_dfs_order) - len(self.groups_))
        for nid in range(len(self.groups_)):
            graph_node = graph.post_dfs_order[nid]
            group_node: GraphPartitioner.Group = GraphPartitioner.Group()
            group_node.pattern = graph_node.pattern
            group_node.root_ref = graph_node.ref
            if group_node.pattern == OpPattern.OUT_ELEMWISE_FUSABLE:
                group_node.anchor_ref = graph_node.ref
            self.groups_[nid] = group_node
    
    def RunFuse(self, graph: IndexedForwardGraph, post_dom_tree: DominatorTree, phase: int):
        for nid in range(len(self.groups_)):
            graph_node = graph.post_dfs_order[nid]
            dom_node = post_dom_tree.nodes[nid]
            group_node: GraphPartitioner.Group = self.groups_[nid]
            assert group_node is not None
            if group_node.pattern == OpPattern.OPAQUE:
                continue
            if dom_node.parent is None:
                continue
            assert not graph_node.extern_ref
            dom_parent_gindex = dom_node.parent.gnode.index
            if self.CountFusedNodesWithNewChild(graph_node, dom_node.parent.gnode) > self.max_fuse_depth_:
                continue
            if phase == 2:
                if group_node.pattern > OpPattern.INJECTIVE:
                    continue
                dom_parent_group: GraphPartitioner.Group = self.groups_[dom_parent_gindex]
                dom_root_group: GraphPartitioner.Group = dom_parent_group.FindRoot()
                if dom_root_group.pattern == OpPattern.TUPLE:
                    continue
                if dom_parent_group.pattern == OpPattern.TUPLE and dom_root_group.pattern <= OpPattern.INJECTIVE:
                    fcond = lambda kind, is_sink: kind <= OpPattern.INJECTIVE
                    if self._CheckPath(graph_node, dom_node.parent.gnode, fcond):
                        self.CommitFuse(graph_node, dom_node.parent.gnode)
                continue

            if self.groups_[dom_parent_gindex] is not None and group_node.FindRoot() == self.groups_[dom_parent_gindex].FindRoot():
                continue
            if self.groups_[dom_parent_gindex].pattern == OpPattern.TUPLE:
                continue
            if group_node.pattern == OpPattern.OUT_ELEMWISE_FUSABLE:
                if phase != 0:
                    continue
                if dom_node.parent is not None and dom_node.pattern == OpPattern.ELEMWISE:
                    assert dom_node.parent.gnode is not None
                    fcond = lambda kind, is_sink: kind <= OpPattern.BROADCAST
                    if self._CheckPath(graph_node, dom_node.parent.gnode, fcond):
                        self.CommitFuse(graph_node, dom_node.parent.gnode)
            elif group_node.pattern <= OpPattern.BROADCAST:
                if dom_node.parent is not None and (dom_node.pattern <=OpPattern.INJECTIVE or dom_node.pattern == OpPattern.COMM_REDUCE):
                    fcond = lambda kind, is_sink: kind <= OpPattern.INJECTIVE if not is_sink else (kind <= OpPattern.BROADCAST or kind in [OpPattern.COMM_REDUCE, OpPattern.INJECTIVE, OpPattern.OUT_ELEMWISE_FUSABLE])

                    if self._CheckPath(graph_node, dom_node.parent.gnode, fcond):
                        self.CommitFuse(graph_node, dom_node.parent.gnode)
            elif group_node.pattern == OpPattern.INJECTIVE or group_node.pattern == OpPattern.TUPLE:
                if phase != 1:
                    continue
                fcond = lambda kind, is_sink: kind <= OpPattern.INJECTIVE
                if self._CheckPath(graph_node, dom_node.parent.gnode, fcond):
                    self.CommitFuse(graph_node, dom_node.parent.gnode)
            else:
                assert group_node.pattern == OpPattern.COMM_REDUCE
    
    def Partition(self, graph: IndexedForwardGraph):
        self.InitGroup(graph)
        if self.opt_level_ == 0:
            return self.groups_
        post_dom_tree = DominatorTree.PostDom(graph)
        for phase in range(3):
            self.RunFuse(graph, post_dom_tree, phase)
        return self.groups_



class FuseMutator(MixedModeMutator):

    def __init__(self, fuse_opt_level: int, max_fuse_depth: int, link_params: bool):
        super(FuseMutator, self).__init__()
        self.fuse_opt_level_ = fuse_opt_level
        self.max_fuse_depth_ = max_fuse_depth
        self.link_params_ = link_params
        self.gmap_ = {}
        self.ginfo_ = DefaultDict(FuseMutator.GroupInfo)
    
    def Transform(self, body: Expr):
        """ Run the transform """
        return self.Transform_(body, self.fuse_opt_level_, self.max_fuse_depth_, self.link_params_)
    
    def Transform_(self, body: Expr, fuse_opt_level: int, max_fuse_depth: int, link_params: bool):
        graph = IndexedForwardGraph.Create(body)
        groups = GraphPartitioner(fuse_opt_level, max_fuse_depth).Partition(graph)
        for nid in range(len(graph.post_dfs_order)):
            assert graph.post_dfs_order[nid].ref is not None
            self.gmap_[graph.post_dfs_order[nid].ref] = groups[nid]
        return self.visit(body)
    
    class GroupInfo:
        """ Temporary information from each group. """
        def __init__(self) -> None:
            self.params: list[Var] = []
            self.arguments: list[Expr] = []
        
        def GetOrAllocParam(self, expr: Expr, dtype: Type):
            for i in range(len(self.arguments)):
                if expr.same_as(self.arguments[i]):
                    return self.params[i]
            var = Var(f"p{len(self.params)}", dtype)
            self.params.append(var)
            self.arguments.append(expr)
            return var
    
    def GetNewArguments(self, args, current_group: GraphPartitioner.Group):
        new_args = []
        for arg in args:
            arg_group = self.gmap_[arg].FindRoot()
            dtype = arg.checked_type
            new_arg = self.visit(arg)
            if current_group != arg_group:
                if not self.link_params_ or not isinstance(new_arg, Constant):
                    param: Var = self.ginfo_[current_group].GetOrAllocParam(new_arg, dtype)
                    new_args.append(param)
                else:
                    new_args.append(new_arg)
            else:
                new_args.append(new_arg)
        return new_args
    
    def MakeNewFunction(self, group: GraphPartitioner.Group, ret_type, body: Expr):
        class CheckReshapeOnly(ExprVisitor):
            def __init__(self):
                super().__init__()
                self.reshape_only = True
                self.has_call = False
            
            def visit_call(self, call):
                self.has_call = True
                if call.op.get_attr("TReshapeOp") is None:
                    self.reshape_only = False
                if not self.reshape_only:
                    return
                super().visit_call(call)
            
            def visit_var(self, var: Var):
                if var.type_annotation is None or not isinstance(var.type_annotation, TensorType):
                    self.reshape_only = False
        
        visitor = CheckReshapeOnly()
        visitor.visit(body)
        ginfo: FuseMutator.GroupInfo = self.ginfo_[group]
        func = Function(ginfo.params, body, ret_type, [])
        func = func.with_attr("Primitive", visitor.has_call)
        if visitor.has_call and visitor.reshape_only:
            func = func.with_attr("relay.reshape_only", visitor.reshape_only)
        return Call(func, ginfo.arguments)
    
    def visit_function(self, fn_node):
        if fn_node.attrs and fn_node.attrs.get("Primitive", 0) != 0:
            return fn_node
        return super().visit_function(fn_node)
    
    def rewrite_call(self, call, post):
        if isinstance(call.op, Op):
            if call.op.get_attr("TNonComputational"):
                return super().visit_call(call)
            
            assert call in self.gmap_
            if call.op == Op.get("annotation.stop_fusion"):
                return super().visit_call(call.args[0])
            ret_group = self.gmap_[call].FindRoot()
            new_args = self.GetNewArguments(call.args, ret_group)

            new_call = Call(call.op, new_args, call.attrs, call.type_args, call.span)
            if ret_group.root_ref == call:
                return self.MakeNewFunction(ret_group, call.checked_type, new_call)
            else:
                return new_call
        else:
            return super().visit_call(call)
    
    def rewrite_tuple(self, tuple_node, post):
        ret_group = self.gmap_[tuple_node].FindRoot()
        if ret_group.root_ref == tuple_node:
            return super().visit_tuple(tuple_node)
        new_fields = self.GetNewArguments(tuple_node.fields, ret_group)

        def with_fields(tuple_node, opt_fields):
            fields = opt_fields
            virtual_device = tuple_node.virtual_device()
            span = tuple_node.span

            all_fields_unchanged = True
            if len(fields) ==  len(tuple_node.fields):
                for i in range(len(fields)):
                    all_fields_unchanged = all_fields_unchanged and fields[i].same_as(tuple_node.fields[i])
            else:
                all_fields_unchanged = False
            
            if not all_fields_unchanged:
                cow_tuple_node = tuple_node.CopyOnWrite()
                cow_tuple_node.fields = fields
                cow_tuple_node.virtual_device_ = virtual_device
                cow_tuple_node.span = span
            return tuple_node
        
        return  with_fields(tuple_node, new_fields)
    
    def rewrite_tuple_getitem(self, tuple_get, post):
        ret_group = self.gmap_[tuple_get].FindRoot()
        new_tuple = self.GetNewArguments([tuple_get.tuple], ret_group)[0]
        new_node = TupleGetItem(new_tuple, tuple_get.index)
        if ret_group.root_ref == tuple_get:
            if self.gmap_[tuple_get.tuple].FindRoot() != ret_group:
                return super().visit_tuple_getitem(tuple_get)
            return self.MakeNewFunction(ret_group, tuple_get.checked_type, new_node)
        return new_node
    
    def visit_let(self, op):
        def pre_visit(op):
            self.visit(op.var)
            self.visit(op.value)
        
        def post_visit(op):
            var: Var = self.visit(op.var)
            value: Expr = self.visit(op.value)
            body: Expr = self.visit(op.body)
            expr = op
            if var.same_as(op.var) and value.same_as(op.value) and body.same_as(op.body):
                self.memo_[expr] = expr
            else:
                self.memo_[expr] = Let(var, value, body)
        
        ExpandANormalForm(op, pre_visit, post_visit)
        return self.memo_[op]
    

def FuseOps(expr: Expr, fuse_opt_level, max_fuse_depth, link_params):
    return FuseMutator(fuse_opt_level, max_fuse_depth, link_params).Transform(expr)


@relay.transform.function_pass(opt_level=1)
class CustomFuseOps:
    """Simple test function to replace one argument to another."""

    def __init__(self, fuse_opt_level=0):
        self.fuse_opt_level = fuse_opt_level
        pass

    # This function can define a pass.
    def transform_function(self, func, mod, ctx):
        return FuseOps(func, self.fuse_opt_level, 256, False)