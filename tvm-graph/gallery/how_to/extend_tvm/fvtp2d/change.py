import re
import os
import sys

CWD = os.path.dirname(__file__)
new_mesh_size = 128

new_halo_width = 8
origin_mesh_size = 64
origin_halo_width = 4
file_path = "fvtp2d.mlir"

if __name__ == '__main__':
    # print(sys.argv[1])
    # mesh_size = 512
    # file_path = sys.argv[1]
    # mesh_size = int(sys.argv[2])
    assert os.path.exists(file_path)
    assert file_path.endswith(".mlir")
    # for file in os.listdir(CWD):
    #     if file.endswith(".mlir"):
            # file_path = os.path.join(CWD, file)
    with open(file_path, "r") as f:
        content = f.read()
        replace_pattern_list = []

        pattern = "{0}, {0}, {0}".format(origin_mesh_size + origin_halo_width)

        content = content.replace(pattern, "{0}, {0}, {0}".format(new_mesh_size + new_halo_width))

        pattern = "{0}, {0}, {0}".format(-origin_halo_width)

        content = content.replace(pattern, "{0}, {0}, {0}".format(-new_halo_width))

        # print(content)
        datepat=re.compile(r"(?<![%,f])" + str(origin_mesh_size))
        datepat1=re.compile(r"(?<![%,f])" + str(origin_mesh_size + 2 * origin_halo_width))
        content = datepat1.sub(str(new_mesh_size + 2 * new_halo_width), content)
        content = datepat.sub(str(new_mesh_size ), content)

    with open("new_" + file_path, "w") as f:
        print(content, file=f)
