import json
import matplotlib.pyplot as plt
import numpy as np
import functools

csfont = {'family':'Times New Roman', 'size':14}
plt.rc('font', **csfont)

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
sum_step = 0
highest_step= 0
sum_sl = 0
highest_sl= 0

mesh_list = ["64", "128", "256", "512"]

# stencil_name=['s15-i12-o3-e49']

if __name__ == "__main__":
    filename = "../../test_cases/performance_v100.json"
    outname = "eva-searching-v100.pdf"
    with open(filename, "r") as f:
        data = json.load(f)
    with open("../../test_cases/streamlist_v100.json", "r") as f:
        solution_data = json.load(f)
    # filter stencil

    fig, ax = plt.subplots(len(stencil_list)//4, 4, sharex="col", sharey="row", figsize=(14, 8*(len(stencil_list)/24)+1.8))
    colors = ["#1f78b4", "#fc8d62", "#8da0cb", "#e78ac3", "#a6d854"]

    # stencil_list = list(filter(lambda x: x.count("-") == 3 and x.startswith("s1"), stencil_list))
    for idx, key in enumerate(stencil_list):
        # print(key)
        data_m = []
        data_s = []
        data_n = []
        data_t = []

        for mesh_size in ['64','128','256','512']:
            StencilG_pref = data[key][mesh_size]
            StencilG_pair = [(key, value) for key, value in StencilG_pref.items()]
            StencilG_pair.sort(key=lambda x: x[1])
            StencilG_best = StencilG_pair[0][0]
            if 'open' in StencilG_best:
                # print("****",key,mesh_size,StencilG_best) #比open earth慢的情况
                StencilG_best = StencilG_pair[1][0]
            # name = key.replace("-o3-","").replace("-o4-","")
            # print(StencilG_best)
            if 'max' in StencilG_best:
                step = '0'
            else:
                step = StencilG_best.split('-')[-1]
            solution=solution_data[key][mesh_size][step]
            # print(key,mesh_size,step)
            # print(solution)
            streamlist = []
            for l in solution.split('],'):
                list = l.split(',')
                streamlist.append(list)
            # print(streamlist)
            node_numer=0
            SYN_number=0
            s = len(streamlist)
            m=0
            n=0
            # print(solution)
            for stream in streamlist:
                for e in stream:
                    if 'syn' in e:
                        stream.remove(e)
                m = max(m,len(stream))
                n+=len(stream)
            # print(key,mesh_size,step, m,s,n)
            data_m.append(m)
            data_s.append(s)
            data_n.append(n)
            data_t.append(int(step))
            sum_step+=int(step)
            highest_step = max(highest_step,int(step))
            sum_sl+=s
            highest_sl = max(highest_sl,s)
            if key=="s10-i10-o4-e28":
                print(key,"size=", mesh_size, "m=",m,"SL number=",s,"FN number",n,"search time=",int(step))

        sp_ax = ax[idx // 4, idx % 4]
        new_ax = sp_ax.twinx()
        ln1 = sp_ax.bar(np.array(range(4)) * 4 + 0, data_m, color=colors[0], label="m")
        ln2 = sp_ax.bar(np.array(range(4)) * 4 + 1, data_s, color=colors[1], label="number of SL")
        ln3 = sp_ax.bar(np.array(range(4)) * 4 + 2, data_n, color=colors[2], label="number of FN")
        ln4 = new_ax.scatter([2, 5, 8, 12], data_t, color="red", label="search times",s=20)
        new_ax.yaxis.set_visible(False)
        new_ax.set_ylim(0, 21)
        sp_ax.set_ylim(0, 21)


        sp_ax.set_title(key.replace("-1",""),fontsize=14)
        if idx == 23 and VOERALL==1:
            sp_ax.legend(ncol=3, bbox_to_anchor=(-0.5, 9.5), frameon=False)
            new_ax.legend(bbox_to_anchor=(0.4, 9.5), frameon=False)
        if idx == 11 and VOERALL==0:
            sp_ax.legend(ncol=3, bbox_to_anchor=(-0.5, 4.7), frameon=False)
            new_ax.legend(bbox_to_anchor=(0.4, 4.7), frameon=False)

        ax[idx // 4, idx % 4].set_xticks([1.07, 5, 9, 13], mesh_list)
        ax[idx // 4, idx % 4].set_yticks(np.arange(0,21,5))
        if idx%4 == 0:
            ax[idx // 4, idx % 4].set_ylabel("number")
        if idx//4 == len(stencil_list)//4-1:
            ax[idx // 4, idx % 4].set_xlabel("MESHSIZE")

    # fig.legend([ln1, ln2, ln3, ln4], labels=["m", "s", "n", "t"], loc="upper center", ncol=4)
    # plt.show()
    plt.subplots_adjust(hspace=0.5)
    if VOERALL==1:
        plt.savefig(outname, bbox_inches='tight')
    else:
        plt.savefig(outname.replace(".pdf","-3.pdf"), bbox_inches='tight')


    print("average search times",sum_step/(24*4),"highest", highest_step)
    print("average SL",sum_sl/(24*4),"highest", highest_sl)



