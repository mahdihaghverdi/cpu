# CPU
Computer architecture project of the term.

## Overview
This project was meant to study assembly, ISA, datapath and control unit of a simple CPU.
We were given the ISA and the rest of the project was designed and written with our decisions.
The decisions are written completely in the documentation of the project.

The CPU is written with `VHDL` language and the compilation is done with `GHDL 3.0.0` and simulation is shown by `gtkwave`. Instructions to install the dependencies and run the project are below. 

### CPU
The cpu is the datapath controlled by the control unit of its own.
This was the easy part of the project, the components were ready and we only have to connect the singals to the components

The whole component structure of the project is:

```
CPU
├── ALU
│   └── MUX 8x1
├── ALU Control
└── Control Unit
```

#### ALU
The ALU component of the CPU supports seven operations (because this was only needed by the given ISA)
The simulation of the test bench of the ALU is here:

![](https://github.com/mahdihaghverdi/cpu/blob/main/docs/images/sims-1.png)

(**Note**: The `FF` result in the simulation is because I had to use a 8x1 MUX AND according to the documentation of the encoding of
ISA and ALU select, when the `sel` is `000` the output is decided to be `FF`)

##### MUX 8x1
A very simple 8 to 1 multiplexer.

![](https://github.com/mahdihaghverdi/cpu/blob/main/docs/images/sims-3.png)

#### ALU Control
This component produces the ALU select signal according to the `opcode` and `funct` of the given instruction

![](https://github.com/mahdihaghverdi/cpu/blob/main/docs/images/sims-4.png)


#### Control Unit
Control unit signals are shown in a big table in the documentation and the result is shown here:

![](https://github.com/mahdihaghverdi/cpu/blob/main/docs/images/sims-2.png)


### Instructions
The instructions are 32-bit long, and our cpu has only two types of instruction:

1. `R-type` assembly `add $a3, $l1, $t8` and its instruction:
```
00001000101111100000000000000001
```
which is:
```
--------------------------------------------------------
| opcode |  rs  |  rt  |  rd  |   don't care   | funct |
--------------------------------------------------------
|   000  | 0100 | 0101 | 1111 | 00000000000000 |  001  |
--------------------------------------------------------
```

2. `V-type` assembly `andi $t8, $zero, 1110` and its instruction:
```
10011110000000000000000000001110
```
which is:
```
------------------------------------------------
| opcode |  rs  |  rt  |    immediate value    |
------------------------------------------------
|   100  | 1111 | 0000 | 000000000000000001110 |
------------------------------------------------
```

## Assembler
The assembler of the project is written in a functional style with the API:
```
- assemble
- compile_assembly
- read_assembly
```

the usage of these:
```
assemble(compile_assembly(*(read_assembly(file.asm)))
```

This assembler API is written for internal use and the recommended way for you to use it, is:
```bash
python -m pyasm code.asm
```
and the output:
```
pyasm 0.1.0 [Python 3.10.6] on Linux
Assembling your code...
Successfully Compiled! You can use `machine.bin` file.
```

For any improvements to the assembler (like using `argparse` module and a better API,) please create pull requests :) 

## Documentation
The whole documentation of the project including explanations for:
- Assembly
- ISA
- Registers
- Control Unit
- ALU

is [here](https://github.com/mahdihaghverdi/cpu/blob/main/docs/documentation.pdf).

## How to install and run
In order to run the project (simulate it) You should have:
- `GHDL 3.0.0`
- `gtkwave`

and for the assembler: 
- `Python 3.10` and onwards

Once you have them:
```bash
git clone https://github.com/mahdihaghverdi/cpu
cd cpu/src
ghdl -a mux8x1.vhdl
ghdl -a alu.vhdl
ghdl -a aluctrl.vhdl
ghdl -a cu.vhdl
ghdl -a cpu.vhdl
ghdl -a textbenches/cpu_tb.vhdl
ghdl -r cpu_tb --vcd=cpu.vcd
gtkwave cpu.vcd
```