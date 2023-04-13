import re
import os
import json
from collections import defaultdict


def return_defaultdict_float():
    return defaultdict(float)


def return_defaultdict_str():
    return defaultdict(str)

def get_performance_dict(folder=""):
    with open(os.path.join(folder, "performance.txt"), "r") as f:
        lines = f.readlines()
        mesh_size = -1
        method = ""
        fuse_step = -1
        performance_dict = defaultdict(return_defaultdict_float)
        streamlist_dict = defaultdict(return_defaultdict_str)
        for line in lines:
            m = re.match(r"mesh_size = (\d+)", line)
            if m:
                mesh_size = int(m.group(1))
            m = re.match("step = (.*)", line)
            if m:
                method = m.group(1)
                if re.match(r"\d+", method):
                    method = f"StencilG-step-{method}"
            if line.startswith('[['):
                if method == "parallel-max":
                    fuse_step = 0
                if method.startswith("StencilG"):
                    fuse_step = int(method.split('-')[-1])
                streamlist_dict[mesh_size][fuse_step] = line.replace('\n', '')
            if line.startswith("performance="):
                performance = float(line.split("=")[1])
                assert mesh_size != -1
                assert method
                performance_dict[mesh_size][method] = performance
    return performance_dict, streamlist_dict


if __name__ == '__main__':
    filename2performance = dict()
    filename2stream = dict()

    for folder in os.listdir():
        if os.path.isdir(folder) and (folder.startswith("s") or folder.startswith("fastwaves")):
            p, stream = get_performance_dict(folder)
            filename2performance[folder] = p
            filename2stream[folder] = stream
    with open("performance_v100.json", 'w') as f:
        json.dump(filename2performance, f)
    with open("streamlist_v100.json", 'w') as f:
        json.dump(filename2stream, f)

    # print(x)
