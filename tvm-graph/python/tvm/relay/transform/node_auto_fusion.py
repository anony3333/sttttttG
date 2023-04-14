from cmath import e
import functools
from operator import ge
import os
import time
import tvm
from tvm import relay
from tvm.ir.module import IRModule
from tvm.relay.transform.transform import InferType
from tvm.relay.transform.utils import ReplaceParams, BuildGraph
from tvm.relay.transform.dnn_fusion import GroupOp
import copy

def build_depence(call_list):
    graph = {}
    # init
    for call in call_list:
        graph[call] = {"input": set(), "output": set()}
    for call in call_list:
        for arg in call.args:
            if isinstance(arg, relay.Call):
                graph[call]["input"].add(arg)
                graph[arg]["output"].add(call)
            elif isinstance(arg, relay.TupleGetItem):
                graph[call]["input"].add(arg.tuple_value)
                graph[arg.tuple_value]["output"].add(call)

    def find_father(node):
        father = list(graph[node]["input"])
        indirect_node = []
        for f in father:
            indirect_node += find_father(f)
        return father + indirect_node
    
    def find_child(node):
        child = list(graph[node]["output"])
        indirect_node = []
        for c in child:
            indirect_node += find_child(c)
        return child + indirect_node
    
    depence_graph = {}
    for node in graph.keys():
        depence_graph[node] = {"input": find_father(node), "output": find_child(node)}
    return depence_graph


class NodeAutoFusion:
    def __init__(self, mod) -> None:
        self.step_mod = mod
        self.fuse_steps = 0

    def get_call_list(self, mod):
        func = mod.functions[mod.get_global_var("main")]
        return BuildGraph().get_call_list(func)

    def analysis_exclusion(self, call_list):
        exclusion = set()
        depend_graph = build_depence(call_list)
        for call in call_list:
            exclusion.add((call, call))
            for parent in depend_graph[call]["input"]:
                for child in depend_graph[call]["output"]:
                    exclusion.add((parent, child))
                    exclusion.add((child, parent))
        return exclusion

    def calculate_score(self, call, call_list, exclusion):
        score = {}
        # get call args set
        call_args = set(call.args)
        p_input = 1
        p_stencil = 2

        for other in call_list:
            if (call, other) in exclusion:
                score[other] = -1
                continue
            other_args = set(other.args)
            inter_set = set()
            input_set = set()
            stencil_set=set()

            # input 复用
            input_set = inter_set.union(call_args & other_args)

            # 结果复用
            if call in other_args:
                stencil_set.add(call)
            elif other in call_args:
                stencil_set.add(other)
            else:
                # TupleGetItem
                for arg in call_args:
                    if isinstance(arg, relay.TupleGetItem) and arg.tuple_value is other:
                        stencil_set.add(arg)
                for arg in other_args:
                    if isinstance(arg, relay.TupleGetItem) and arg.tuple_value is call:
                        stencil_set.add(arg)
            
            score_value = 0

            # 计算 score
            if input_set:
                for tensor in input_set:
                    shape = tensor.checked_type.concrete_shape
                    score_value += functools.reduce(lambda x, y: x * y, shape)*p_input
            if stencil_set:
                for tensor in stencil_set:
                    shape = tensor.checked_type.concrete_shape
                    score_value += functools.reduce(lambda x, y: x * y, shape)*p_stencil
            
            score[other] = score_value

        return score

    def find_fuse_pair(self, score_dict, call_list):
        max_score = -1
        fuse_pair = (None, None)
        for call1 in call_list:
            for call2 in call_list:
                if score_dict[call1][call2] > max_score:
                    max_score = score_dict[call1][call2]
                    fuse_pair = (call1, call2)
        return fuse_pair,max_score

    def stop_fused(self):
        return self.fuse_steps >= 30

    def fusion_call2call(self, fuse_pair, mod: IRModule, call_list):
        call1, call2 = fuse_pair
        # 获取整个复杂 stencil 的返回值
        expr = mod.functions[mod.get_global_var("main")]
        ret_calls = expr.body
        if isinstance(ret_calls, relay.Tuple):
            ret_calls = list(ret_calls.fields)
        else:
            ret_calls = [ret_calls]
        # 获取参数
        def get_args(call_expr):
            call_args = {}
            for arg in call_expr.args:
                if isinstance(arg, relay.TupleGetItem):
                    node = arg.tuple_value
                    used_expr = arg
                elif isinstance(arg, relay.Call):
                    node = arg
                    used_expr = arg
                else:
                    continue
                if node not in call_args:
                    call_args[node] = set()
                call_args[node].add(used_expr)
            return call_args
        call1_args = get_args(call1)
        call2_args = get_args(call2)
        other_args = {}
        for call in call_list:
            if call is call1 or call is call2:
                continue
            temp = get_args(call)
            for key, value in temp.items():
                if key in other_args:
                    other_args[key] = other_args[key].union(value)
                else:
                    other_args[key] = value
        # 在other_args中全局返回值
        for ret_var in ret_calls:
            if isinstance(ret_var, relay.TupleGetItem):
                node = ret_var.tuple_value
                used_expr = ret_var
            else:
                node = ret_var
                used_expr = ret_var
            if node not in other_args:
                other_args[node] = set()
            other_args[node].add(used_expr)

        # 确定融合顺序
        outputs = {}
        if call2 in call1_args:
            # call2 -> call1
            fuse_op = GroupOp([call2, call1])
            if call2 in other_args:
                outputs[call2] = other_args[call2]
            outputs[call1] = other_args.get(call1, set())
        elif call1 in call2_args:
            # call1 -> call2
            fuse_op = GroupOp([call1, call2])
            if call1 in other_args:
                outputs[call1] = other_args[call1]
            outputs[call2] = other_args.get(call2, set())
        else:
            # parallel
            fuse_op = GroupOp([call1, call2])
            outputs = {
                call1: other_args.get(call1, set()),
                call2: other_args.get(call2, set()),
            }

        # 确定融合后的输出
        for output in outputs:
            fuse_op.add_output(output)

        fuse_op.fuse()
        if len(fuse_op.output) == 1:
            relay_call_map = {list(fuse_op.output)[0]: fuse_op.fused_func}
        else:
            relay_call_map = {}
            offset = 0
            for out in fuse_op.output:
                if isinstance(out.checked_type, tvm.ir.TensorType):
                    relay_call_map[out] = relay.TupleGetItem(fuse_op.fused_func, offset)
                    offset += 1
                else:
                    used_ret = outputs[out]
                    for var in used_ret:
                        relay_call_map[var] = relay.TupleGetItem(fuse_op.fused_func, offset + var.index)
                    offset += len(out.checked_type.fields)
        fuse_expr = ReplaceParams(relay_call_map).visit(expr)
        mod.update_func(mod.get_global_var("main"), fuse_expr)
        mod = InferType()(mod)

        return mod

    def fuse(self,generator):
        mesh_size = generator.mesh_size
        halo_width = generator.halo_width
        def get_time():
            import time
            # return ""
            return time.strftime("%Y-%m-%d-%X", time.localtime())
        # performance_result_path = f"performance{get_time()}.txt"
        performance_result_path = f"performance.txt"
        CWD = os.getcwd()
        def print_performance(performance, streamlist, step):
            with open(os.path.join(CWD, performance_result_path), "a") as f:
                print(f"step = {step}", file=f)
                print(streamlist, file=f)
                print(f'performance={performance}',file=f)
                print("--------------------------------------",file=f)

        #first, run gen All split kernel
        with open(os.path.join(CWD, performance_result_path), "a") as f:
            print(f'mesh_size = {mesh_size}; halo_width = {halo_width}', file=f)
            print("--------------------------------------",file=f)

        # 不跑任何fusion操作
        if not generator.FUSION:

            # STREAM为假，利用open-earth跑实验，只启动一个pthread
            if generator.STREAM == False:


                if generator.INLINE:
                    performance = generator.origin_mlir_run(inline=True)
                    with open(os.path.join(CWD, performance_result_path), "a") as f:
                        print("step = open-earth", file=f)
                        print(f'performance={performance}',file=f)
                        print("--------------------------------------",file=f)
                else:
                    performance = generator.origin_mlir_run(inline=False)
                    with open(os.path.join(CWD, performance_result_path), "a") as f:
                        print("step = baseline", file=f)
                        print(f'performance={performance}',file=f)
                        print("--------------------------------------",file=f)
            
            # STREAM为真, 但是不进行FUSION， 即最大化并行
            if generator.STREAM == True:
                generator.step = "parallel-max"
                performance, streamlist = generator.codegen()
                print_performance(performance, streamlist, "parallel-max")
            return self.step_mod
        # if generator.FUSION:
        # 能到这里说明FUSION为True
        while True:
            starttime = time.time()
            self.fuse_steps += 1
            score_dict = {}
            call_list = self.get_call_list(self.step_mod)
            exclusions = self.analysis_exclusion(call_list)
            for call in call_list:
                if hasattr(call, "attrs") and call.attrs:
                    tag = call.attrs.tag
                else:
                    tag = None
                if tag:
                    tag = tag.replace("stencil_", "%")
                    # import pdb; pdb.set_trace()
                    body = generator.tag2code[tag]["mlir_body"][:]
                    has_if = False
                    for line in body:
                        if "if" in line:
                            has_if = True
                            break
                else:
                    continue
                if has_if:
                    for other in call_list:
                        exclusions.add((call, other))
                        exclusions.add((other, call))

            # 更新每个节点call对所有节点的分数，填到score[call]里
            for call in call_list:
                score_dict[call] = self.calculate_score(call, call_list, exclusions)
            # 找到最大的分数，把这两个call融合
            fuse_pair,max_score = self.find_fuse_pair(score_dict, call_list)
            # print(step)
            print(call_list)
            print(fuse_pair)
            if max_score<0:
                break

            # fuse, 更新step_mod
            # try:
            # if self.fuse_steps >= 5:
            #     import pdb; pdb.set_trace()
            self.step_mod = self.fusion_call2call(fuse_pair, self.step_mod, call_list)
            # except:
            #     break
            # 往后的流程
            generator.step = f'StencilG-step-{self.fuse_steps}'
            generator.ir_module = self.step_mod


            #
            # if self.fuse_steps<8:
            #     continue
            profile_start = time.time()
            print(generator.step)
            performance, streamlist = generator.codegen()
            profile_end = time.time()
            print('search_time = ', profile_start - starttime, 's')
            print('profile_time = ', profile_end - profile_start,'s')
            print_performance(performance, streamlist, self.fuse_steps)
            # performance = 0

            if self.stop_fused():
                break
        return self.step_mod