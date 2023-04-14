import copy
from enum import IntEnum
from typing import DefaultDict, List, Dict
import tvm
from tvm import relay
from tvm.relay import ExprVisitor, Function
from tvm.relay.expr import ExprWithOp
from tvm.relay.expr_functor import MixedModeMutator
from tvm.relay.op.op import OpPattern
from tvm.relay.transform.utils import ReplaceParams, is_scalar
import pdb


def PRINTCall(call):
    try:
        if 'stencil' in call.op.name:
            # print(call.op.name+" "+call.attrs.tag)
            print(call.attrs.tag)
            return
    except:
        pass
    try:
        if 'fuse' in call.op.attrs["tag"]:
            print(call.op.attrs["tag"])
            return
    except:
        pass
    print("ERROR: not stencil node")

def PRINTCallList2D(streamlist):
    print("===list===")
    for i in streamlist:
        for call in i:
            PRINTCall(call)
        print("---")
    print("===list===")

class PrintFuncType(ExprVisitor):
    def visit_call(self, call):
        print(call.op, call.op.get_attr("TOpPattern"))
        print(call.op, get_pattern(call.op))
        print(call.attrs.tag)
        print(get_tag_pattern(call.attrs.tag))
        return super().visit_call(call)

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

class StreamSolver(MixedModeMutator):
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
        self.graph = {}
        
    
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



    def build_graph(self, expr):
        
        call_list = get_call_list(expr)
        # 洗去多余的node，已融合的但是又加进了call_list的
        # 找到每个fusion node
        for call in call_list:
            try:
                if 'fuse' in call.op.attrs["tag"]:
                    #对于fusion node的每一个名字
                    stencil_name_list=call.op.attrs["tag"].split('_')[1:]
                    # 找到对应的stencil,remove
                    for stencil_name in stencil_name_list:
                        for cc in call_list:
                                try:
                                    if stencil_name == cc.attrs.tag.split("_")[-1]:
                                        call_list.remove(cc)
                                except:
                                    pass
            except:
                pass
            
        # call_list = set(call_list)
        # key: call node, value: {input: [node], output: [node]} 嵌套字典
        graph = {}
        for node in call_list:
            graph[node] = {"input": [], "output": []}
        
        # pdb.set_trace()
        for node in call_list:
            for arg in node.args:
                if arg in call_list:
                    # PRINTCall(arg)
                    graph[node]["input"].append(arg)
                    graph[arg]["output"].append(node)
                elif isinstance(arg, relay.TupleGetItem):
                    # PRINTCall(arg.tuple_value)
                    # pdb.set_trace()
                    graph[node]["input"].append(arg.tuple_value)
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
            depence_graph[node] = {"input": {}, "output": {}}
            depence_graph[node]["input"] = set(find_father(node))
            depence_graph[node]["output"] = set(find_child(node))

        return depence_graph

    def get_nodeN_in_list(self, l):
        num=0
        for i in l:
            for j in i:
                num+=1
        return num
    

    def get_nodeN_in_graph(self, graph):
        num=0
        for node in graph.keys():
            num+=1
        return num
    

    def isStencilNode(self, node):
        try:
            if 'stencil' in node.op.name:
                return True
        except:
            pass
        try:
            if 'fuse' in node.op.attrs["tag"]:
                return True
        except:
            pass
        return False

    # 找到最多的无input依赖的callnode，放到list中
    def find_max_for_this_level(self, graph):
        list_result = []
        #遍历graph 
        for node in graph.keys():
            
            if self.isStencilNode(node): 
                #找到input不依赖的stencil CallNode的，加入list
                flag = 1
                for element in graph[node]["input"]:
                    if self.isStencilNode(element):
                        flag = 0
                        break
                if flag == 1:
                    # print(node)
                    list_result.append(node)
        #重写graph，把input是list_result里的node都忽视掉
        graph_result = {}
        for node in graph.keys():
            if node in list_result:
                continue
            graph_result[node] = {"input": [], "output": []}
            for orginal_input in graph[node]["input"]:
                # pdb.set_trace()
                if orginal_input in list_result:
                    continue
                graph_result[node]["input"].append(orginal_input)
               
        
        # for node in graph_result.keys():
        #     PRINTCall(node)

        return list_result, graph_result

    def get_graph(self):
        return self.graph


    def solve(self, expr):
        graph = self.build_graph(expr)
        self.graph = graph
        # pdb.set_trace()
        # print(graph)
        depence_graph = self.build_depence(graph)
        #graph中有几个node
        inputNodeNumebr=self.get_nodeN_in_graph(graph)

        # print(depence_graph)
        streamlist = []
        
        # 得到streamlist
        g = depence_graph
        while self.get_nodeN_in_list(streamlist)!=inputNodeNumebr:
            l, g = self.find_max_for_this_level(g)
            streamlist.append(l)
        
        PRINTCallList2D(streamlist)
        return streamlist
    
    
