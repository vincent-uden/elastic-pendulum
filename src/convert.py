import re
import os

files = os.listdir(".")

for path in files:
    if path == __file__:
        continue
    contents = ""
    with open(path, "r") as f:
        contents = f.read()
    lines = "\n".join(contents.splitlines()[8::])
    subbed = re.sub(r"\t", ",", lines)
    with open(path[:-3:] + "csv", "w") as f:
        f.write(subbed)