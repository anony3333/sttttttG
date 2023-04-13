import re
import os
import sys

# CWD = os.path.dirname(__file__)
# new_mesh_size = 128
# origin_mesh_size = 120
# origin_halo_width = 4
# new_halo_width = 8
# file_path = "fastwaves128.mlir"


def gen_mlir_file(file_path, origin_mesh_size, origin_halo_width, new_mesh_size, new_halo_width):
    assert os.path.exists(file_path)
    assert file_path.endswith(".mlir")
    # for file in os.listdir(CWD):
    #     if file.endswith(".mlir"):
            # file_path = os.path.join(CWD, file)
    with open(file_path, "r") as f:
        content = f.read()
        replace_pattern_list = []



        # print(content)
        datepat=re.compile(r"(?<![%,f,\d])" + str(origin_mesh_size))
        datepat1=re.compile(r"(?<![%,f,\d])" + str(origin_mesh_size + 2 * origin_halo_width))
        content = datepat1.sub(str(new_mesh_size + 2 * new_halo_width), content)
        content = datepat.sub(str(new_mesh_size ), content)

        pattern = "{0}, {0}, {0}".format(origin_mesh_size + origin_halo_width)

        content = content.replace(pattern, "{0}, {0}, {0}".format(new_mesh_size + new_halo_width))
        # print(new_mesh_size + new_halo_width)

        pattern = "{0}, {0}, {0}".format(-origin_halo_width)

        content = content.replace(pattern, "{0}, {0}, {0}".format(-new_halo_width))

        origin_kernel_name = file_path[0:-5]
        
        content = content.replace(origin_kernel_name, origin_kernel_name + str(new_mesh_size))
        return content
    
