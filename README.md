This repository contains optimized assembly code for a cyclic redundancy check (CRC-8) algorithm. The optimization involves replacing the original C source code with inline assembly code, resulting in improved performance.

Compilation:
To compile the code, use the make command: 'make'

This command will compile the assembly code and generate two executables: hw3 and hw4crc.

Execution:
./hw3: Runs the CRC-8 algorithm using the original C source code (crc.c).
./hw4crc: Runs the optimized CRC-8 algorithm using inline assembly code (hw4crc.s).
The hw4crc executable is expected to run faster than hw3 due to the optimization achieved through assembly code.

Cleaning Up:
To clean up the generated files and executables, use the make clean command: 'make clean'

This command will remove all generated object files and executables from the directory.
