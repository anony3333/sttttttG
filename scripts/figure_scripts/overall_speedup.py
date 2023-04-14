import json
import matplotlib.pyplot as plt
import numpy as np

csfont = {'family':'Times New Roman', 'size':16}
plt.rc('font', **csfont)


def compute_speedup(data):
    # data is {"baseline": float, "open-earth": float, "parallel-max": float, "StencilG-step-x": float, ...}
    open_earth = data["open-earth"]
    StencilG_best = min([value for key, value in data.items() if key.startswith("StencilG") or key == "parallel-max"])

    return open_earth / StencilG_best

sum = {"64":0, "128":0, "256":0, "512":0}

if __name__ == "__main__":
    filename = "../../test_cases/performance_v100.json"
    with open(filename, "r") as f:
        data = json.load(f)
    # filter stencil
    stencil_list = [
       's10-i9-o4-e26', 's10-i10-o4-e28', 's10-i10-o4-e29-1','s10-i12-o2-e35',   
        's11-i8-o4-e28','s11-i8-o4-e33','s11-i9-o4-e32','s11-i10-o4-e32',     
        's12-i8-o4-e39','s12-i9-o4-e37','s12-i10-o4-e34', 's12-i10-o4-e40',   
        's13-i9-o4-e38', 's13-i9-o4-e39','s13-i10-o4-e40', 's13-i10-o4-e41',  
        's14-i10-o2-e43', 's14-i10-o3-e41', 's14-i11-o4-e38','s14-i12-o3-e45', 
        's15-i11-o3-e48', 's15-i12-o3-e49', 's15-i12-o3-e50', 's15-i12-o4-e50']
    
    
    mesh_list = ["64", "128", "256", "512"]

    bins = 10

    # fig, ax = plt.subplots(1, 4, sharex="col", sharey="row", figsize=(12, 2))
    fig, ax= plt.subplots(2, 2, figsize=(6, 4))
    plt.rc('font', **csfont)

    speedup_data = {key: [] for key in mesh_list}

    for idx, stencil in enumerate(stencil_list):
        stencil_data = data[stencil]
        for offset, mesh_size in enumerate(mesh_list):
            pref = stencil_data[mesh_size]
            temp = compute_speedup(pref)
            if temp >10:
                print(stencil, mesh_size, temp)
            speedup_data[mesh_size].append(compute_speedup(pref))
            sum[mesh_size]+=temp
            
    
    for idx, mesh_size in enumerate(mesh_list):
        ax[idx//2, idx%2].hist(speedup_data[mesh_size], bins=bins)
        ax[idx//2, idx%2].plot([1, 1], [0, 24], color="r", linestyle="--")
        ax[idx//2, idx%2].set_ylim(0, 24)
        ax[idx//2, idx%2].set_yticks(np.arange(0,24,4))
        ax[idx//2, idx%2].set_title("MESHSIZE="+mesh_size,fontsize=14)
        if idx//2==1:
            ax[idx//2, idx%2].set_xlabel("speedup")
        if idx%2==0:
            ax[idx//2, idx%2].set_ylabel("# stencils")
    plt.subplots_adjust(hspace=0.7)
    
    # plt.show()
    plt.savefig("eva-overall-speedup-v100.pdf", bbox_inches='tight')
    
    print(sum["64"]/24, sum["128"]/24,sum["256"]/24, sum["512"]/24)

