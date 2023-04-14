import json
import matplotlib.pyplot as plt

csfont = {'family':'Times New Roman', 'size':16}
plt.rc('font', **csfont)

def compute_speedup(data,stencil):
    # data is {"baseline": float, "open-earth": float, "parallel-max": float, "StencilG-step-x": float, ...}
    StencilG_best = min([value for key, value in data.items() if key.startswith("StencilG") or key == "parallel-max"])
    if stencil == 'fastwaves':
        open_earth = data["open-earth"]
        return open_earth / StencilG_best
    else:
        baseline = data["baseline"]
        return baseline / StencilG_best


if __name__ == "__main__":
    filename = "../../realworld_stencil/performance_v100.json"
    with open(filename, "r") as f:
        data = json.load(f)
    # filter stencil
    stencil_list = ["fastwaves", "hori"]
    dict = {"fastwaves":"fastwaves", "hori":"horizontal diffusion"}
    mesh_list = ["64", "128", "256", "512"]
    # fig, ax = plt.subplots(1, 2, sharex="col", sharey="row", figsize=(6, 3))
    fig, ax = plt.subplots(1, 2, figsize=(7.2, 1.8))

    for idx, stencil in enumerate(stencil_list):
        stencil_data = data[stencil]
        speedup_data = []
        sum_spd = 0
        for offset, mesh_size in enumerate(mesh_list):
            pref = stencil_data[mesh_size]
            speedup_data.append(compute_speedup(pref,stencil))
            spd = compute_speedup(pref,stencil)
            sum_spd+=spd
            print(stencil,mesh_size,spd)
        print(sum_spd/4)
        ax[idx].plot(range(4), speedup_data)
        ax[idx].set_xticks(range(4), mesh_list)
        ax[idx].set_title(dict[stencil])
        ax[idx].set_xlabel("MESHSIZE")
        ax[idx].set_ylim(0, 8)
        ax[idx].set_xlim(-0.5, 3.5)
        ax[idx].plot([-10, 10], [1, 1], color="r", linestyle="--")
    ax[0].set_ylabel("speedup")

    plt.subplots_adjust(hspace=1)
    # plt.show()
    plt.savefig("eva-speedup-case-study-V100.pdf",bbox_inches='tight')

