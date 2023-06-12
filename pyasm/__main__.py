import sys
import os
import platform
import time

from . import assemble, compile_assembly, read_assembly, __version__

print(f"pyasm {__version__} [Python {platform.python_version()}] on {os.uname()[0]}")

wait = 0.09
print('Assembling you code')
for num in range(1, 36):
    print(f'[{"#" * num:<35}]', end='\r')
    time.sleep(wait)
for num in range(35, 0, -1):
    print(f'[{"#" * num:>35}]', end='\r')
    time.sleep(wait)
time.sleep(wait)
# print(f'[{"#" * 35}]')
with open("./machine.bin", "w") as f:
    f.writelines(assemble(compile_assembly(*read_assembly(sys.argv[1]))))

print("Successfully Compiled! You can use `machine.bin` file.")
