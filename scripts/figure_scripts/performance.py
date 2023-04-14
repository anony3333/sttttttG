import json
from matplotlib.font_manager import FontProperties
import matplotlib.pyplot as plt
import numpy as np

csfont = {'family':'Times New Roman', 'size':14}
plt.rc('font', **csfont)
sum_Tofuse = 0
highest_Tofuse = 0
sum_Toparallel = 0
highest_Toparallel = 0
sum_ToBaseline = 0

def plot_subfig(data, x, y, ax, x_offset):
    # data is {"baseline": float, "open-earth": float, "parallel-max": float, "StencilG-step-x": float, ...}
    baseline = data["baseline"]
    open_earth = data["open-earth"]
    parallel_max = data["parallel-max"]

    StencilG_best = min([value for key, value in data.items() if key.startswith("StencilG") or key == "parallel-max"])
    StencilG_fuse = sorted([(int(key.split("-")[-1]), value) for key, value in data.items() if key.startswith("StencilG")], key=lambda x:x[0])[-1][1]

    colors = ["#66c2a5", "#fc8d62", "#8da0cb", "#e78ac3", "#a6d854"]
    l1 = ax[x, y].bar(x_offset + 0, baseline / baseline     , color=colors[0], label="baseline")
    # l2 = ax[x, y].bar(x_offset + 1, baseline / open_earth   , color=colors[1], label="open-earth")
    l3 = ax[x, y].bar(x_offset + 1, baseline / StencilG_fuse, color=colors[3], label="fuse-max")
    l4 = ax[x, y].bar(x_offset + 2, baseline / parallel_max , color=colors[2], label="parallel-max")
    l5 = ax[x, y].bar(x_offset + 3, baseline / StencilG_best, color=colors[4], label="StencilG")
    # ax[x, y].plot([0, 24], [1, 1], linestyle="--", color="r")
    # ax[x, y].set_xlim(0, 24)
    return [l1, l3, l4, l5], baseline / StencilG_fuse,baseline / parallel_max,baseline / StencilG_best, baseline/StencilG_best



if __name__ == "__main__":
    
    filename = "../../test_cases/performance_v100.json"
    outname = "eva-overall-performace-v100.pdf"
    with open(filename, "r") as f:
        data = json.load(f)
    # filter stencil
    VOERALL = 0
    stencil_list = [
       's10-i9-o4-e26', 's10-i10-o4-e28', 's10-i10-o4-e29-1','s10-i12-o2-e35',   
        's11-i8-o4-e28','s11-i8-o4-e33','s11-i9-o4-e32','s11-i10-o4-e32',     
        's12-i8-o4-e39','s12-i9-o4-e37','s12-i10-o4-e34', 's12-i10-o4-e40',   
        's13-i9-o4-e38', 's13-i9-o4-e39','s13-i10-o4-e40', 's13-i10-o4-e41',  
        's14-i10-o2-e43', 's14-i10-o3-e41', 's14-i11-o4-e38','s14-i12-o3-e45', 
        's15-i11-o3-e48', 's15-i12-o3-e49', 's15-i12-o3-e50', 's15-i12-o4-e50']
    if VOERALL == 0:
        stencil_list = stencil_list[0:12]
    
    mesh_list = ["64", "128", "256", "512"]

    fig, ax = plt.subplots(len(stencil_list)//4, 4, sharex="col", sharey="row", figsize=(14, 8*(len(stencil_list)/24)+1.8))

    for idx, stencil in enumerate(stencil_list):
        stencil_data = data[stencil]
        for offset, mesh_size in enumerate(mesh_list):
            pref = stencil_data[mesh_size]
            handles, fuse, parallel, best, baseline = plot_subfig(pref, idx // 4, idx % 4, ax, offset * 6)
            to_fuse = best/fuse
            to_parallel = best/parallel
            
            sum_Tofuse+=to_fuse
            sum_Toparallel+=to_parallel
            highest_Tofuse=max(highest_Tofuse,to_fuse)
            highest_Toparallel=max(highest_Toparallel,to_parallel)
            if mesh_size == "512":
                sum_ToBaseline+= baseline


        ax[idx // 4, idx % 4].set_xticks([1.5, 7.67, 13.5, 19.5], mesh_list)
        ax[idx // 4, idx % 4].set_yticks(np.arange(0,11,5))
        ax[idx // 4, idx % 4].set_title(stencil.replace("-1",""), fontsize=14)
        ax[idx // 4, idx % 4].set_ylim(0, 10)
        if idx%4 == 0:
            ax[idx // 4, idx % 4].set_ylabel("speedup")
        if idx//4 == len(stencil_list)//4-1:
            ax[idx // 4, idx % 4].set_xlabel("MESHSIZE")
    fig.legend(handles, labels=["baseline",  "fuse-max","parallel-max", "StencilG"], loc="upper center", ncol=5, frameon=False)
    plt.subplots_adjust(hspace=0.5)
    # plt.show()

    if VOERALL==1:
        plt.savefig(outname, bbox_inches='tight')
    else:
        plt.savefig(outname.replace(".pdf","-part.pdf"), bbox_inches='tight')

    print("average to fuse", sum_Tofuse/(24*4), "max", highest_Tofuse)
    print("average to parallel", sum_Toparallel/(24*4), "max", highest_Toparallel)
    print("average to fuse", sum_ToBaseline/24)
    


