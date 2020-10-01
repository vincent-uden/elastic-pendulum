import re
import os
import pathlib

dir_name = "L"

files = os.listdir("../Unprocessed Data/" + dir_name)

pathlib.Path("../CSV Data/" + dir_name + "/").mkdir(parents=True, exist_ok=True)

for path in files:
    if path == __file__:
        continue
    contents = ""
    with open("../Unprocessed Data/" + dir_name + "/" + path, "r") as f:
        contents = f.read()
    lines = "\n".join(contents.splitlines()[8::])
    subbed = re.sub(r"\t", ",", lines)
    # print(subbed)
    with open("../CSV Data/" + dir_name + "/" + path[:-3:] + "csv", "w") as f:
        f.write(subbed)
