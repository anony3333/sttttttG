'''约定'''
# 生成对应的 MLIR 代码

# 代码分为以下部分：
# (1). cast and load
# (2). stencil.apply
# (3). store and return

# 目前先将 (1)、(3) 部分用常量字符串固定
# 优先实现 stencil.apply 合并的问题：
#   1. 实现 apply 输入、输出合并
#   2. 实现 apply 计算合并
import sys
import copy
from queue import deque
import tvm
from tvm import relay
from collections import defaultdict
from tvm.ir.module import IRModule
from tvm.relay import ExprVisitor, ExprMutator
from tvm.relay.transform.utils import BuildGraph
from tvm.relay.transform.dnn_fusion import StencilFuseOps
from tvm.relay.transform.node_auto_fusion import NodeAutoFusion
from tvm.relay.transform.streamSolve import StreamSolver
import os
import subprocess
import re
import sys

from tvm.relay.transform.maingen import GenMain, Kernel
from tvm.relay.transform.run import Evaluate


name2relayop = {
    "in1out1": relay.stencil.grid1stencil,
    "in2out1": relay.stencil.grid2stencil,
    "in3out1": relay.stencil.grid3stencil,
    "in4out1": relay.stencil.grid4stencil,
    "in5out1": relay.stencil.grid5stencil,
    "in6out1": relay.stencil.grid6stencil,
    "in2mout": relay.stencil.grid2mostencil,
}

def GET_CALL_TAG(call):
    try:
        if 'stencil' in call.op.name:
            # print(call.op.name+" "+call.attrs.tag)
            return call.attrs.tag
    except:
        pass
    try:
        if 'fuse' in call.op.attrs["tag"]:
            return call.op.attrs["tag"]
    except:
        pass
    return "ERROR CALL TAG"

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
                    depend_graph[call].add(a.tuple_value)
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


class ReplaceCallOp(ExprVisitor):
    def __init__(self, tag2code, variable2name):
        super().__init__()
        self.tag2code = tag2code
        self.variable2name = variable2name
    
    def visit_call(self, call):
        if call.attrs:
            tag = call.attrs.tag.replace("stencil_", "%")
            self.tag2code[tag]["data"] = call
            self.variable2name[call] = tag
        else:
            fuse_tag = call.op.attrs['tag']
            new_tag = fuse_tag.replace("fuse_", "%")
            self.variable2name[call] = new_tag
        self.visit(call.op)
        for a in call.args:
            self.visit(a)
    
    def visit_var(self, var):
        tag = var.name_hint.replace("data_", "%")
        if tag in self.tag2code:
            self.tag2code[tag]["data"] = var
            self.variable2name[var] = tag
        super().visit_var(var)
    
    def transform(self, expr):
        self.visit(expr)


class MLIRCodeGen:
    def __init__(self, mesh_size=128, halo_width=8, FUSION = True, STREAM = True, INLINE = False, output_on = False) -> None:
        self.ir_module = None
        self.call_sequence = None
        self.dtype = "f64"

        self.args_base = 0
        # tag 2 stencil.apply, load
        self.tag2code = {}
        self.variable2name = {}
        self.dim_size = 72
        # tag to !stencil.temp<xxxxx>
        self.data2shape = {}

        self.args_data = []
        self.ret_data = []
        self.cast_data = []
        self.program_data = []

        self.original_code = []
        self.func_args = []
        self.tag_map = {} #tag_map[原始的名字]=stencil结果的新名字
        self.mlir_name = ""

        self.step = 0


        self.mesh_size = mesh_size
        self.halo_width = halo_width
        # self.run_autofusion = run_autofusion
        # self.run_baseline = run_baseline
        self.output_on = output_on
        self.FUSION = FUSION
        self.STREAM = STREAM
        self.INLINE = INLINE
        # self.run_only_basic = run_only_basic

    def register_code_with_tag(self, tag, code):
        self.tag2code[tag] = code
    
    def format_code(self, code):
        for idx, line in enumerate(code):
            code[idx] = line.strip()
        return code
    
    def parse_shape(self, string):
        if "?" in string:
            return [self.dim_size] * string.count("x")
        else:
            shape = [int(dim) for dim in string.split("x")[:-1]]
            return [max(dim, 1) for dim in shape]
    
    def parse_apply(self, line, code):
        # parse func_tag and ret_number
        mlir_tag = line.split()[0]
        if ":" in mlir_tag:
            func_tag, ret_num = mlir_tag.split(":")
            mlir_tag = func_tag
            func_tag = func_tag.replace("%", "stencil_")
            ret_num = int(ret_num)
        else:
            func_tag, ret_num = mlir_tag.replace("%", "stencil_"), 1
        
        # parse args
        args = line[line.find("(") + 1:line.find(")")].split(", ")
        args_tag = []
        for arg in args:
            var_tag = arg.split()[2]
            args_tag.append(var_tag)
        # get args value
        args_var = []
        for tag in args_tag:
            if "#" in tag:
                tag, index = tag.split("#")
                index = int(index)
                var = self.tag2code[tag]["data"]
                args_var.append(relay.TupleGetItem(var, index))
            else:
                args_var.append(self.tag2code[tag]["data"])
        
        # build relay.stencil
        relay_op = name2relayop[f"in{len(args_var)}out{ret_num}" if ret_num == 1 else f"in{len(args_var)}mout"]
        relay_args = copy.copy(args_var)
        relay_args.append(func_tag)
        if ret_num > 1:
            relay_args.append(ret_num)
        data = relay_op(*relay_args) #Call
        
        # mlir code body
        body = []
        while code:
            line = code.pop(0)
            body.append(line)
            if "stencil.return" in line:
                break

        self.tag2code[mlir_tag] = {
            "type": "func",
            "data": data,
            "mlir_body": body
        }

        return code
    
    def parse_load(self, line):
        mlir_tag = line.split()[0]
        data_tag = mlir_tag.replace("%", "data_")
        shape = self.parse_shape(line[line.find("<") + 1:line.find(">")])
        data = relay.var(data_tag, shape=shape)
        mlir_shape = line.split()[-1]
        self.data2shape[data] = mlir_shape
        self.data2shape[mlir_tag] = mlir_shape
        self.tag2code[mlir_tag] = {
            "type": "var",
            "data": data
        }
        return data

    def parse_store(self, line):
        mlir_tag = line.split()[1]
        return self.tag2code[mlir_tag]['data']

    def parse_program(self, line):
        last_args = line.split(":")[-2].split(", ")[-1]
        self.args_base = int(last_args.replace("%arg", "")) + 1
    
    def from_mlir(self, code, mlir_name=''):
        self.mlir_name = mlir_name
        self.in_code = copy.copy(code)
        code = self.format_code(code)
        self.original_code = code
        args_data = []
        ret_var = []
        ret_data = []
        cast_data = []
        program_data = []
        while code:
            line = code.pop(0)
            if "stencil.apply" in line:
                code = self.parse_apply(line, code)
            elif "stencil.load" in line:
                cast_data.append(line)
                var = self.parse_load(line)
                args_data.append(var)
            elif "stencil.store" in line:
                ret_data.append(line)
                var = self.parse_store(line)
                ret_var.append(var)
            elif "stencil.cast" in line:
                cast_data.append(line)
            elif "stencil.program" in line:
                program_data.append(line)
                self.parse_program(line)
        if len(ret_var) == 1:
            ret_var = ret_var[0]
        else:
            ret_var = relay.Tuple(ret_var)
        
        func = relay.Function(args_data, ret_var) #args_data 输入网格 ret_var Call node
        mod = tvm.IRModule.from_expr(func)
        mod = relay.transform.InferType()(mod)
        self.ir_module = mod

        self.args_data    = args_data
        self.ret_data     = ret_data
        self.cast_data    = cast_data
        self.program_data = program_data


    def build_apply2code(self):
        apply2code = defaultdict(list)
        for call in self.call_sequence:
            if call.attrs:
                call_tag = call.attrs.tag
                mlir_tag = "%" + call_tag.split("_")[1]
                apply2code[call] = copy.copy(self.tag2code[mlir_tag]["mlir_body"])
            else:
                fuse_tag = call.op.attrs['tag']
                stencil_list = ["%" + tag for tag in fuse_tag.split("_")[1:]]
                for tag in stencil_list:
                    apply2code[call] += self.tag2code[tag]["mlir_body"]
        return apply2code
        # for call, code_lines in apply2code.items():
        #     print(call.attrs.tag if call.attrs else call.op.attrs['tag'])
        #     print("\n".join(code_lines))

    def fuse_op(self):
        # self.ir_module = StencilFuseOps()(self.ir_module)
        generator = copy.deepcopy(self)
        self.ir_module = NodeAutoFusion(self.ir_module).fuse(generator)
    
    def reverse_variable_name(self, func):
        for tag, value in self.tag2code.items():
            self.variable2name[value["data"]] = tag
        replace_op = ReplaceCallOp(self.tag2code, self.variable2name)
        replace_op.transform(func)
    
    def add_suffix(self, body_list):
        for idx, body in enumerate(body_list):
            for line_id, line in enumerate(body):
                tokens = line.split()
                tokens = [(token + f"_{idx}") if "%" in token else token for token in tokens]
                tokens = [token.replace(f",_{idx}", f"_{idx},") for token in tokens]
                line = " ".join(tokens)
                body[line_id] = line
    
    def args_replace(self, body_list, call):
        fuse_tag = self.variable2name[call]
        sub_tags = ["%" + tag for tag in fuse_tag[1:].split("_")]
        fuse_args = list(call.op.params)
        sub_op = [self.tag2code[tag]["data"] for tag in sub_tags]
        
        # fuse args map
        args_map = {}
        for op_id, op in enumerate(sub_op):
            for arg_id, arg in enumerate(op.args):
                if arg in fuse_args:
                    args_map[f"%arg{self.args_base + arg_id}_{op_id}"] = f"%arg{self.args_base + fuse_args.index(arg)}"
        # serial op args map
        op_output = {}
        for op_id, op in enumerate(sub_op):
            body = body_list[op_id]
            sub_output = []
            for line in body:
                if "stencil.store_result" in line:
                    sub_output.append((line.split()[3], line.split()[0]))
                elif "stencil.return" in line:
                    order = line[:line.find(":")].replace(",", "").split()[1:]
                    sub_output.sort(key=lambda x: order.index(x[1]))
            op_output[op] = sub_output
            for arg_id, arg in enumerate(op.args):
                if arg in op_output:
                    args_map[f"%arg{self.args_base + arg_id}_{op_id}"] = op_output[arg][0][0]
                elif isinstance(arg, relay.TupleGetItem) and arg.tuple_value in op_output:
                    args_map[f"%arg{self.args_base + arg_id}_{op_id}"] = op_output[arg][arg.index][0]

        # args var replace
        for body in body_list:
            for line_id, line in enumerate(body):
                for key, value in args_map.items():
                    line = line.replace(key + " ", value + " ")
                body[line_id] = line
        
        # output remove, 也许应该把相关的 store 和 return 全部删除，然后重新生成
        for op_id, op in enumerate(op_output):
            body = body_list[op_id]
            new_body = []
            for line in body:
                if "stencil.return" in line or "stencil.store_result" in line:
                    continue
                else:
                    new_body.append(line)
            body_list[op_id] = new_body

        # 寻找整体的 output
        output = call.op.body
        output_var = []
        if isinstance(output, relay.Call):
            output_var += op_output[output]
        elif isinstance(output, relay.Tuple):
            output_call = []
            for sub_out in output.fields:
                while isinstance(sub_out, relay.TupleGetItem):
                    sub_out = sub_out.tuple_value
                if sub_out not in output_call:
                    output_call.append(sub_out)
            for sub_out in output_call:
                if sub_out in op_output:
                    output_var += op_output[sub_out]
                else:
                    if sub_out.attrs:
                        sub_out_tag = sub_out.attrs.tag
                    else:
                        sub_out_tag = sub_out.op.body.attrs.tag
                    for key, value in op_output.items():
                        if key.attrs.tag == sub_out_tag:
                            output_var += value
                            break
        else:
            raise TypeError("output class:" + type(output))

        body = []
        return_var = []
        for var_pair in output_var:
            body.append(f"{var_pair[1]} = stencil.store_result {var_pair[0]} : ({self.dtype}) -> !stencil.result<{self.dtype}>")
            return_var.append(var_pair[1])
        var_list = ", ".join(return_var)
        ret_type = ", ".join([f"!stencil.result<{self.dtype}>"] * len(return_var))
        body.append(f"stencil.return {var_list} : {ret_type}")
        body_list.append(body)

    def repeat_access(self, body_list):
        fuse_body = []
        for body in body_list:
            fuse_body += body
        return self.repeat_access_once(fuse_body)

    def repeat_access_once(self, fuse_body, last_deep_vars=set()):
        # find repeat_access
        wait_repeat_access = []
        for line in fuse_body:
            if "stencil.access" in line and "arg" not in line:
                wait_repeat_access.append(line)
        if len(wait_repeat_access) == 0 and len(last_deep_vars) == 0:
            return fuse_body

        # build var2line
        var_def2line = {}
        var_compute = {}
        for idx, line in enumerate(fuse_body):
            if line and len(line.split()) == 1:
                print(line)
                # import pdb; pdb.set_trace()
            if line.split()[1] != "=":
                continue
            var = line.split()[0]
            var_def2line[var] = (idx, line)
            var_compute[var] = [tmp.replace(",", "") for tmp in line.split()[2:] if tmp[0] == "%"]

        # search related code, in one stencil apply
        def search_related_line(root_var):
            """return: """
            var_list = deque([root_var])
            line_list = []
            while var_list:
                var = var_list.popleft()
                idx_line = var_def2line.get(var, (-1, ""))
                if idx_line[0] == -1:
                    continue
                line_list.append(idx_line)
                body_idx = var.split("_")[1]
                var_list += deque(filter(lambda x:x.split("_")[-1] == body_idx, var_compute.get(var, [])))
            line_list.sort(key=lambda entry: entry[0])
            line_list = sorted(set(line_list), key=line_list.index)
            return line_list

        access_var = {}
        for line in wait_repeat_access:
            var = line.split()[3]
            if var in access_var:
                continue
            access_var[var] = search_related_line(var)

        # 过滤repeat access 的代码，深层次 access 不展开
        def filter_access(repeat_access):
            access_var_depend = {}
            for var, compute_line in access_var.items():
                access_var_depend[var] = []
                for line in compute_line:
                    if "stencil.access" in line[1] and "arg" not in line[1]:
                        access_var_depend[var].append(line[1].split()[3])

            deep_var = set()
            for var, depend_vars in access_var_depend.items():
                for d_var in depend_vars:
                    if d_var in access_var_depend:
                        deep_var.add(d_var)
            shallow_access = []
            for line in repeat_access:
                if line.split()[3] not in deep_var:
                    shallow_access.append(line)
            shallow_var = set(access_var_depend.keys()) - deep_var
            return shallow_access, deep_var

        # add offset
        def add_offset(related_line, offset, deep_vars):
            offseted_line = []
            
            for idx_line in related_line:
                if "stencil.access" in idx_line[1]:
                    line = idx_line[1]
                    origin_offset = list(map(int, line[line.find("[") + 1: line.find("]")].split(", ")))
                    new_offset = [a + b for a, b in zip(origin_offset, offset)]
                    line = line.replace(", ".join(map(str, origin_offset)), ", ".join(map(str, new_offset)))
                else:
                    line = idx_line[1]
                str_offset = "_" + "".join(map(str, offset))
                def format_token(token):
                    if token[0] == "%" and token[1].isdigit() and token not in deep_vars:
                        return token + str_offset if token[-1] != "," else token[:-1] + str_offset + ","
                    return token
                line = " ".join(format_token(token) for token in line.split())
                offseted_line.append((idx_line[0], line))
            return offseted_line

        # get ret var
        ret_line = fuse_body[-1]
        ret_vars = [token for token in ret_line.replace(",", "").split() if token.startswith("%")]
        ret_def_vars = [var_def2line[var][1].split()[3] for var in ret_vars]

        offset_code = {}
        wait_repeat_access, deep_vars = filter_access(wait_repeat_access)
        for line in wait_repeat_access:
            var = line.split()[3]
            offset = list(map(int, line[line.find("[") + 1: line.find("]")].split(", ")))
            offset_code[line] = add_offset(access_var[var], offset, deep_vars)
            if var in ret_def_vars:
                offset_code["ret_var:" + var] = add_offset(access_var[var], [0] * len(offset), deep_vars)

        # replace code
        line_idx_map = {}
        replace_var = {}
        for line, code_list in offset_code.items():
            if "ret_var" not in line:
                use_var = line.split()[0]
            else:
                # 用于replace ret var, ret_var + "_000"
                use_var = code_list[-1][1].split()[0].replace("_000", "")
            for line_idx in code_list:
                idx = line_idx[0]
                if idx in line_idx_map:
                    if line_idx[1] in line_idx_map[idx]:
                        continue
                    line_idx_map[idx].append(line_idx[1])
                else:
                    line_idx_map[idx] = [line_idx[1]]
            if "ret_var" not in line:
                idx = fuse_body.index(line)
                fuse_body[idx] = ""
            try:
                replace_var[use_var] = code_list[-1][1].split()[0]
            except:
                print('ERROR!')
                print(code_list)
        new_body = []
        for idx, line in enumerate(fuse_body):
            if not line:
                continue
            new_body.append(line)
            if idx in line_idx_map:
                new_body.pop(-1)
                if line.split()[0] in ret_vars:
                    new_body.append(line)
                new_body += line_idx_map[idx]
        for idx, line in enumerate(new_body):
            for var, new_var in replace_var.items():
                line = line.replace(var + ",", new_var + ",").replace(var + " ", new_var + " ")
            new_body[idx] = line
        return self.repeat_access_once(new_body, deep_vars)

    def return_fix(self, body_list, call):
        # TODO: 修复 return 相关操作
        pass

    def fuse_body(self, body_list, call):
        if len(body_list) == 1:
            return "\n\t" + "\n\t".join(body_list[0]) + "\n"
        self.add_suffix(body_list)
        self.args_replace(body_list, call)
        fuse_body = self.repeat_access(body_list)
        return "\n\t" + "\n\t".join(fuse_body) + "\n"

    def var_name_in_apply(self, body):
        idx = 1
        var_map = {}
        var_list = [token.replace(",", "") for token in body.split() if token[0] == "%" and token[1].isdigit()]
        for var in var_list:
            if var not in var_map:
                var_map[var] = f"%var_{idx}"
                idx += 1
            new_name = var_map[var]
            body = body.replace(var + ",", new_name + ",")
            body = body.replace(var + " ", new_name + " ")
        return body

    def access_shape_replace(self, body, args_shape):
        for idx, line in enumerate(body):
            if "stenci.access" in line:
                arg_key_name = line.split()[3]
                fake_shape = line[line.find("(") + 1: line.find(")")]
                body[idx] = line.replace(fake_shape, args_shape[arg_key_name])
        return body

    def print_code(self, call, STREAM=0):
        # output
        output = self.variable2name[call]
        output = self.fuse_name_map.get(output, output)
        ret_type = [f"!stencil.temp<?x?x?x{self.dtype}>"]
        if isinstance(call.checked_type, relay.TupleType):
            output = output + ":" + str(len(call.checked_type.fields))
            ret_type = ret_type * len(call.checked_type.fields)
        ret_type = ", ".join(ret_type)
        if isinstance(call.checked_type, relay.TupleType):
            ret_type = "(" + ret_type + ")"

        # arguments
        args = []
        for a in call.args:
            tuple_str = ""
            v = ''
            if isinstance(a, relay.TupleGetItem):
                if STREAM==0:
                    tuple_str = f"#{a.index}"
                else:
                    v = 'v' #防止%31_0的出现，变为%v31_0
                    tuple_str = f"_{a.index}"
                a = a.tuple_value
            name = self.variable2name[a]
            name = self.fuse_name_map.get(name, name)
            args.append(name.replace('%','%'+v) + tuple_str)
        args_list = []
        args_shape = {}
        for idx, arg in enumerate(args):
            arg_key_name = f"%arg{self.args_base + idx}"
            arg_shape = self.data2shape.get(arg, f"!stencil.temp<?x?x?x{self.dtype}>")
            args_list.append(f"{arg_key_name} = {arg} : {arg_shape}")
            args_shape[arg_key_name] = arg_shape
        args_str = ", ".join(args_list)

        tag = self.variable2name[call]
        if tag in self.tag2code:
            body_list = [self.tag2code[tag]["mlir_body"]]
        else:
            body_list = []
            mlir_tags = ["%" + sub_tag for sub_tag in tag.replace("%", "").split("_")[:]]
            for mlir_tag in mlir_tags:
                body_list.append(self.tag2code[mlir_tag]["mlir_body"][:])
        body = self.fuse_body(body_list, call)
        body = self.var_name_in_apply(body)
        body = self.access_shape_replace(body, args_shape)

        return f"{output} = stencil.apply ({args_str}) -> {ret_type} " + "{" + body + "}"


    def print_output(self, func, fd=sys.stdout):
        if len(self.ret_data) == 1:
            fd.write(self.ret_data[0] + "\n")
            return

        tag_map = {}
        for i, line in enumerate(self.ret_data):
            
            tag = line.split()[1]
            var = func.body.fields[i]
            if isinstance(var, relay.TupleGetItem):
                name = self.variable2name[var.tuple_value]
                tag_map[tag] = self.fuse_name_map.get(name, name) + "#" + str(var.index)
                fd.write(line.replace(tag, tag_map[tag]) + "\n")
            else:
                name = self.variable2name[var]
                tag_map[tag] = self.fuse_name_map.get(name, name)
                fd.write(line.replace(tag, tag_map[tag]) + "\n")

    def replace_fuse_output_name(self):
        fuse_idx = 0
        self.fuse_name_map = {}
        for call in self.call_sequence:
            name = self.variable2name[call]
            if name.count("_") > 0:
                fuse_name = f"%fuse_{fuse_idx}"
                fuse_idx += 1
                self.fuse_name_map[name] = fuse_name

    def ORIGIN_CALL_ARGS(self):
        def get_dim(s1):
            dim = re.findall('(.)x(.)x(.)x', s1)
            return len([x for x in dim[0] if x == '?'])

        program_data = self.program_data[0]
        result = re.findall("%(.*?): !stencil.field<(.*?)>", program_data)
        vars = {}
        for ele in result:
            vars[ele[0]] = get_dim(ele[1])

        return vars

    def KERNEL_ARGS(self):
        program_data = self.program_data[0]
        result = re.findall("%(.*?): !stencil.field<(.*?)>", program_data)
        order_args = [] 
        for ele in result:
            order_args.append(ele[0])

        return order_args

    def ORIGIN_INPUT_ARGS(self):
        arg2cast = {}
        cast2arg = {}
        in_arg = []

        for code in self.in_code:
            x = re.findall("(\S.*?) = stencil.cast %(.*?)\(", code)
            if len(x):
                x0 = x[0]
                arg2cast[x0[1]] = x0[0]
                cast2arg[x0[0]] = x0[1]
        for code in self.in_code:
            x = re.findall("(\S.*?) = stencil.load (.*?) :", code)
            if len(x):
                in_arg.append(cast2arg[x[0][1]])
        return in_arg

    def GET_CALL_ARGS(self, call):
        #找到这个call里产生的所有stencil结果(这个call里面所有的输出)
        call_output_list = []
        output = self.variable2name[call]
        output = self.fuse_name_map.get(output, output)
        if isinstance(call.checked_type, relay.TupleType):
            for i in range(0,len(call.checked_type.fields)):
                call_output_list.append("func_" + (output.replace('%','')+'_'+str(i)).replace("#",""))
        else:
            call_output_list.append("func_" + output.replace('%',''))
        
        
        #找到这个call依赖的stencil结果(这个call里面所有的输出)
        call_input_list = []
        for a in call.args:
            v = ''
            if isinstance(a, tvm.relay.expr.Var):
                continue
            tuple_str = ""
            if isinstance(a, relay.TupleGetItem):
                v = ''
                tuple_str = f"_{a.index}"
                a = a.tuple_value
            name = self.variable2name[a]
            name = self.fuse_name_map.get(name, name)
            call_input_list.append("func_" + (v+name.replace('%','') + tuple_str))

        return call_output_list, call_input_list
        


    def PRINT_CALL_MLIR(self, call, MESHSIZE, HALO, MLIR_PATH, call_shape_infer, file=sys.stdout):
        def PRINT_BRA(n1,n2,n3):
            return '['+str(n1)+', '+str(n2)+', '+str(n3)+']'
        def PRINT_ANG(s1,s2,s3,s4):
            return '<'+s1+'x'+s2+'x'+s3+'x'+s4+'>'

        print('-------------------------'+GET_CALL_TAG(call)+'---------------------------')
        print("module {", file=file)
        
        #找到这个call里产生的所有stencil结果(这个call里面所有的输出)
        call_output_list = []
        output = self.variable2name[call]
        output = self.fuse_name_map.get(output, output)
        if isinstance(call.checked_type, relay.TupleType):
            for i in range(0,len(call.checked_type.fields)):
                call_output_list.append((output.replace('%','')+'_'+str(i)).replace("#",""))
        else:
            call_output_list.append(output.replace('%',''))
        
        
        #找到这个call依赖的stencil结果(这个call里面所有的输出)
        call_input_list = []
        for a in call.args:
            v = ''
            if isinstance(a, tvm.relay.expr.Var):
                continue
            tuple_str = ""
            if isinstance(a, relay.TupleGetItem):
                v = 'v'
                tuple_str = f"_{a.index}"
                a = a.tuple_value
            name = self.variable2name[a]
            name = self.fuse_name_map.get(name, name)
            call_input_list.append((v+name.replace('%','') + tuple_str))


        ''' (1) func头部 '''
        # 在原始func后添加input和output，对于每个stencil结果和依赖的输入, func注册名字 
        func_out_string = ''
        for name in call_input_list+call_output_list:
            func_out_string+=', %func_'+name+': !stencil.field<?x?x?xf64>' #TODO:shape未对应，先留着
        program_data = self.program_data[0]
        program_data=program_data.replace('>)','>'+func_out_string+')')
        print('func @kernel_'+GET_CALL_TAG(call)+'('+program_data.split('(')[-1], file=file)


        ''' (2) cast '''
        '''%cast_name  = stencil.cast %func_name([-4, -4, -4] : [124, 124, 124]) : (!stencil.field<?x?x?xf64>) -> !stencil.field<128x128x128xf64> '''
        mycast_list = []
        for name in call_input_list+call_output_list:
            t = '('+PRINT_BRA(-HALO,-HALO,-HALO)+' : ' + PRINT_BRA(MESHSIZE+HALO,MESHSIZE+HALO,MESHSIZE+HALO)+ ')' + ' : (!stencil.field<?x?x?xf64>) -> !stencil.field'+ PRINT_ANG(str(MESHSIZE+2*HALO),str(MESHSIZE+2*HALO),str(MESHSIZE+2*HALO),'f64')
            mycast_list.append('%cast_'+name+' = stencil.cast '+'%func_'+name+t)
        print("\n".join(self.cast_data), file=file)
        print("\n".join(mycast_list), file=file)

        ''' (3) load '''
        '''call的arg名字 = stencil.load %cast名字 : (!stencil.field<128x128x128xf64>) -> !stencil.temp<?x?x?xf64>'''
        myload_list = []
        for name in call_input_list:
            t = ':'+'(!stencil.field'+ PRINT_ANG(str(MESHSIZE+2*HALO),str(MESHSIZE+2*HALO),str(MESHSIZE+2*HALO),'f64') +') -> !stencil.temp<?x?x?xf64>' #TODO:shape未对应，先留着
            myload_list.append('%'+name+' = stencil.load '+ '%cast_'+name + t)
        print("\n".join(myload_list), file=file)

        print("\n", file=file)
        print(self.print_code(call,1), file=file)
        

        ''' (4) 尾部 stencil store ''' #目前不管原来的store、一律store
        ''' stencil.store %stencil_call_name to %cast_name([0, 0, 0] : [120, 120, 120]) : !stencil.temp<?x?x?xf64> to !stencil.field<128x128x128xf64> '''
        mystore_list = []
        for name in call_output_list:
            # t = '('+PRINT_BRA(0,0,0)+' : ' + PRINT_BRA(MESHSIZE-2*HALO,MESHSIZE-2*HALO,MESHSIZE-2*HALO)+ ')'+ ': !stencil.temp<?x?x?xf64> to !stencil.field' + PRINT_ANG(str(MESHSIZE),str(MESHSIZE),str(MESHSIZE),'f64')
            t = call_shape_infer[call]+ ': !stencil.temp<?x?x?xf64> to !stencil.field' + PRINT_ANG(str(MESHSIZE+2*HALO),str(MESHSIZE+2*HALO),str(MESHSIZE+2*HALO),'f64')
            if isinstance(call.checked_type, relay.TupleType):
                name2 = name[::-1].replace('_', '#', 1)[::-1]
                mystore_list.append('stencil.store '+'%'+name2+' to '+'%cast_'+name+t)
            else:
                mystore_list.append('stencil.store '+'%'+name+' to '+'%cast_'+name+t)
        
        
        print("\n".join(mystore_list), file=file)
        print("return", file=file)
        print("}\n}", file=file)

    def shape_infer(self,func,MLIR_PATH):
        #原始的func后的arg信息
        self.func_args = self.program_data[0].split('(')[1].split(')')[0].split(',')
        #得到原始stencil的所有shape
        MLIRNAME = "codegen_"+self.mlir_name + f"-{self.step}-{self.mesh_size}" +"_1func.mlir"
        SHAPENAME = "codegen_"+self.mlir_name+".shape"
        
        #(1)fusion后单func的代码生成
        # f = open("a.out","w+")
        f = open(os.path.join(MLIR_PATH,MLIRNAME),'w+')
        f.write("module {")
        f.write("\n".join(self.program_data)) #mlir func里所有stencil需要的arg，func头
        f.write("\n".join(self.cast_data)) #load输入矩阵
        for call in self.call_sequence:
            f.write(self.print_code(call))
        self.print_output(func,f)
        f.write("return")
        f.write("}\n}")
        f.close()
        #(2)体外调用进行shape inference: MLIR_PATH调用shape.sh写到SHAPENAME
        f = open(os.path.join(MLIR_PATH,SHAPENAME),'w+')
        ret = subprocess.call(["sh shape-inference.sh"+" "+MLIRNAME], shell=True, cwd = MLIR_PATH, stdout=f)
        f.close()

        # print('====shape infer====')
        list = []
        f = open(os.path.join(MLIR_PATH,SHAPENAME),'r')
        shape_code = f.readlines()
        for line in shape_code:
            if '}' in line and 'to' in line:
                list.append(line.split('to')[-1].replace('\n','').replace(' ','',1))
        # print(list)
        return list

    def generate_codengen_streamlist(self,tmp_list,stream_solver,func):
        streamlist = []
        max_stream_number = 1
        for l in tmp_list:
            max_stream_number = max(max_stream_number,len(l))
        max_step = 0
        for i in range(0,max_stream_number):
            list = []
            step=0
            for l in tmp_list:
                if step!=0:
                    list.append('sync_'+str(step))
                if i < len(l):
                    list.append(l[i])
                step+=1
            max_step = step if step>max_step else max_step
            streamlist.append(list)
        # return streamlist
        #消除冗余的sync, 遍历streamlist
        #(b) 如果step间没有依赖关系，可以删除
        tmp_dict = {}
        graph = stream_solver.build_graph(func)
        def IsConsumerProcuce(my_call_list,other_call_list,graph):
            for a in my_call_list:
                for b in other_call_list:
                    if b in graph[a]['input']:
                        return 1
            return 0

        #遍历所有sync_i字符串，找到有这个的list和后面接的call,存在dict[list]={call}.判断这些call两两之间是否存在直接的input-output关系(只可能存在直接的关系)。如果两两均不存在关系，可以删除
        for i in range(1,max_step): 
            tag = 'sync_'+str(i)
            FLAG = 0 # 0可以删，1不能删
            have_tag_list = []
            for l in streamlist:
                if tag in l:
                    have_tag_list.append(l)
            for myl in have_tag_list:
                #我的这个tag后的算子
                my_call_list = []
                index = myl.index(tag)
                for ii in range(index+1,len(myl)):
                    if isinstance(myl[ii],tvm.relay.expr.Call):
                        my_call_list.append(myl[ii])
                    else:
                        break
                for otherl in have_tag_list:
                    if otherl == myl:
                        continue
                    other_call_list = [] #tag前的call
                    index = otherl.index(tag)
                    for ii in range(index-1,-1,-1): #直到找到下一个sync
                        if isinstance(otherl[ii],tvm.relay.expr.Call):
                            other_call_list.append(otherl[ii])
                        else:
                            break
                    FLAG = IsConsumerProcuce(my_call_list,other_call_list,graph)
                    if FLAG == 1:
                        break
                if FLAG == 1:
                    break
            if FLAG == 0: #delet tag
                # print('can delet '+tag)
                for l in streamlist:
                    if tag in l:
                        l.remove(tag)
                pass

        #(a) 如果只有一个stream需要这个同步，可以省略（同stream已保证）
        element_list = []
        for i in range(0,max_stream_number):
            element_list+=streamlist[i]
        for i in range(0,max_step): 
            if element_list.count('sync_'+str(i)) == 1:
                for l in streamlist:
                    try:
                        l.remove('sync_'+str(i))
                    except:
                        pass

        return streamlist
        
    def maingen_v1(self, streamlist, mesh_size, halo_width):
        all_vars = {}
        origin_vars = self.ORIGIN_CALL_ARGS()
        kernel_list = []
        origin_input_vars = set(origin_vars)
        real_input_vars = set(self.ORIGIN_INPUT_ARGS())
        mid_out_vars = set()
        mid_in_vars = set()
        for l in streamlist:
            for ele in l: 
                if isinstance(ele, tvm.relay.expr.Call):
                    out_vars, input_vars = self.GET_CALL_ARGS(ele)
                    kernel_var_list = []
                    kernel_var_list += origin_vars.keys()
                    kernel_var_list += input_vars
                    kernel_var_list += out_vars
                    mid_out_vars = mid_out_vars | set(out_vars)
                    mid_in_vars = mid_in_vars | set(input_vars)
                    kernel_list.append(Kernel("kernel_" + GET_CALL_TAG(ele), kernel_var_list))
        out_put_vars = mid_out_vars - mid_in_vars

        mid_vars = (mid_out_vars | mid_in_vars) - out_put_vars
        # print(out_put_vars)
        # print(mid_vars)
        stream_str_list = []
        for l in streamlist:
            new_list = []
            for ele in l: 
                if isinstance(ele, tvm.relay.expr.Call):
                    new_list.append("kernel_" + GET_CALL_TAG(ele)) 
                else:
                    new_list.append(ele)
            stream_str_list.append(new_list)
        
        all_vars = {**origin_vars}
        for e in mid_vars | out_put_vars:
            all_vars[e] = 3
        # print(all_vars)
        vars = {'all_variables':all_vars, 'in_variables': real_input_vars, 'mid_variables':mid_vars, 'out_variables':out_put_vars, 'useless_variables': origin_input_vars - real_input_vars}
        print(vars)
        gen = GenMain(mesh_size, halo_width, vars, kernel_list, stream_str_list, self.output_on)
        # gen.gen()
        with open(f"{mesh_size}-{halo_width}-{self.mlir_name}-{self.step}.cu", 'w') as f:
            gen.gen(f)

        # for k in kernel_list:
        #     print(k)

    # 使用open-earth运行原有的mlir， 参数为是否inline
    def origin_mlir_run(self, inline = True):
        def get_kernel_name():
            program_data = self.program_data[0]
            result = re.findall("func @(.*)\(", program_data)
            return result[0]
        mesh_size = self.mesh_size
        halo_width = self.halo_width
        all_vars = self.ORIGIN_CALL_ARGS()
        input_vars = set(self.ORIGIN_INPUT_ARGS())
        output_vars = all_vars.keys() - input_vars
        vars = {'all_variables':all_vars, 'in_variables': input_vars, 'mid_variables':set(), 'out_variables':output_vars, 'useless_variables': set()}
        # print(vars)
        kernel_name = get_kernel_name()
        stream_str_list = [[]]
        stream_str_list[0].append(kernel_name)
        kernel_list = [Kernel(kernel_name, self.KERNEL_ARGS())]
        gen = GenMain(mesh_size, halo_width, vars, kernel_list, stream_str_list, self.output_on)
        # gen.gen()
        suffix = "baseline" if not inline else "open-earth"
        if self.mlir_name:
            suffix = self.mlir_name + "-" + suffix
        with open(f"{mesh_size}-{halo_width}-{suffix}.cu", 'w') as f:
            gen.gen(f)
        CWD = os.getcwd()
        with open(kernel_name + f"_{suffix}.mlir", "w") as f:
            print("\n".join(self.in_code), file=f)
        mlir_list = [kernel_name + f"_{suffix}.mlir"]
        evaluate = Evaluate(CWD, f"{mesh_size}-{halo_width}-{suffix}.cu", mlir_list,inline=inline)
        performance = evaluate.evaluate()
        return performance



    def codegen(self):
        func = self.ir_module.functions[self.ir_module.get_global_var("main")] #ir_module:优化后返回的mod，从mod里把唯一一个func拿出来
        self.call_sequence = BuildGraph().get_call_list(func)
        self.reverse_variable_name(func)
        call2code = self.build_apply2code()
        self.replace_fuse_output_name()

        ''' 代码生成参数 '''
        MESHSIZE = self.mesh_size
        HALO = self.halo_width #需要激进一点，mlir输入文件的halo也是
        MLIR_PATH = "/tmp/"
        
        ''' 体外shape inference '''
        list = self.shape_infer(func,MLIR_PATH) #输入fusion后的code，进行shape inference，得到每个call一个shape
        print(list)
        call_shape_infer = {}
        for i in range(0, len(self.call_sequence)):
            call_shape_infer[self.call_sequence[i]] = list[i]

        # print("module {")
        # print("\n".join(self.program_data)) #mlir func里所有stencil需要的arg，func头
        # print("\n".join(self.cast_data)) #load输入矩阵
        # for call in self.call_sequence:
        #     print(self.print_code(call))
        # # self.print_output(func)
        # print("return")
        # print("}\n}")

        ''' stream策略处理 '''
        stream_solver = StreamSolver()
        tmp_list = stream_solver.solve(func)
        #创建代码生成需要的streamlist
        streamlist = self.generate_codengen_streamlist(tmp_list,stream_solver,func)
        
        # for stream in streamlist:
        #     print(stream)
        # 串行的streamlist
        # streamlist = [[]]
        # for call in self.call_sequence:
        #     streamlist[0].append(call)




        # print(streamlist)
        # return 0
        
        # ''' 主函数生成 '''
        self.maingen_v1(streamlist, MESHSIZE, HALO)

        mlir_list = []
        #打印Call到单独的func。func的参数和名字：见PRINT_CALL_MLIR的'''(1) func头部'''
        # 暂时先注释掉， 需要获取每一个kernel对应的输入与输出，以及维数，同时判断出原有kernel定义中无用的变量。
        for l in streamlist:
            for ele in l: 
                if isinstance(ele, tvm.relay.expr.Call):
                    mlir_list.append(GET_CALL_TAG(ele) + ".mlir")
                    with open(GET_CALL_TAG(ele) + ".mlir", "w") as f:
                        self.PRINT_CALL_MLIR(ele, MESHSIZE, HALO, MLIR_PATH, call_shape_infer, file=f)
                else:
                    print('***************'+ele+'***************')


        CWD = os.getcwd()
        # print(CWD)


        evaluate = Evaluate(CWD, f"{MESHSIZE}-{HALO}-{self.mlir_name}-{self.step}.cu", mlir_list)
        performance = evaluate.evaluate()
        return performance, streamlist


        



