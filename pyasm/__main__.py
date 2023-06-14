import os
import platform
import sys

from . import assemble, compile_assembly, read_assembly, __version__

print(f"pyasm {__version__} [Python {platform.python_version()}] on {os.uname()[0]}")

print("Assembling your code...")

with open("./machine.bin", "w") as f:
    f.writelines("\n".join(assemble(compile_assembly(*(read_assembly(sys.argv[1]))))))

print("Successfully Compiled! You can use `machine.bin` file.")
