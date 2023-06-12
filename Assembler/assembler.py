import sys
from pathlib import Path
from typing import TypeAlias


Labels: TypeAlias = dict[str, int]
Instruction: TypeAlias = str
MachineCode: TypeAlias = str


def read_assembly(file: str | Path) -> tuple[Labels, list[Instruction]]:
    """Read the assembly file and remove the labels names from the front of the instruction

    This function will return the labels with their addresses and the label-removed assembly
    """
    labels = {}
    true_assembly = []
    with open(file) as f:
        for num, line in enumerate(f, start=1):
            """lines with labels:
            ...
            L1: add $r2, $r3, $r1
            ... 
            """
            try:
                label, rest = line.split(":")
                labels[label] = num
                true_assembly.append(rest.strip())
            except ValueError:
                true_assembly.append(line.strip('\n'))
    return labels, list(filter(lambda x: bool(x), true_assembly))

def _decode_line(instruction: str) -> str:
    return instruction.replace(',', ' ').replace('  ', ' ').strip().strip('\n')


def compile_assembly(
    labels: Labels,
    instructions: list[Instruction]
) -> list[Instruction]:
    final = []
    for num, instr in enumerate(instructions, start=1):
        instr = _decode_line(instr)
        command, rs, rt, rd_or_imm = instr.split()

        syntax_error = SyntaxError(
            f"Instruction argument must start with `$`, line {num}:\n\t--> {command} {rs}, {rt}, {rd_or_imm}"
        )

        if rs[0] != '$' or rt[0] != '$':
            raise syntax_error from None

        if rd_or_imm in labels:
            rd_or_imm = bin(labels[rd_or_imm])[2:]

        final.append(f'{command} {rs}, {rt}, {rd_or_imm}')
    return final


def assemble(instructions: list[Instruction]):
    final = []
    table = {
        "add": lambda: ("000", "001"),
        "sub": lambda: ("000", "010"),
        "mul": lambda: ("000", "011"),
        "and": lambda: ("000", "100"),
        "or": lambda: ("000", "101"),
        "nor": lambda: ("000", "110"),
        "nand": lambda: ("000", "111"),
        "bnq": lambda: (False, "111"),
        "lw": lambda: (False, "001"),
        "sw": lambda: (False, "010"),
        "andi": lambda: (False, "100"),
        "ori": lambda: (False, "101"),
    }
    registers = {
        '$zero': '0000',
        '$at': '0001',
        '$a1': '0010',
        '$a2': '0011',
        '$a3': '0100',
        '$l1': '0101',
        '$l2': '0110',
        '$l3': '0111',
        '$t1': '1000',
        '$t2': '1001',
        '$t3': '1010',
        '$t4': '1011',
        '$t5': '1100',
        '$t6': '1101',
        '$t7': '1110',
        '$t8': '1111',
    }

    for num, inst in enumerate(instructions, 1):
        inst = _decode_line(inst)
        command, rs, rt, rd_or_imm = inst.split()

        syntax_error = SyntaxError(
            f"Register not found, line {num}:\n\t--> {command} {rs}, {rt}, {rd_or_imm}"
        )
        try:
            rs = registers[rs]
        except KeyError:
            raise syntax_error from None

        try:
            rt = registers[rt]
        except KeyError:
            raise syntax_error from None

        if rd_or_imm not in registers:
            try:
                int(rd_or_imm, 2)
            except ValueError:
                raise SyntaxError(
                    f"Confused about your third arg to the instruction, "
                    f"line {num}:\n\t--> {command} {rs}, {rt}, {rd_or_imm}\nThe label or register may not exists") from None
        else:
            try:
                rd_or_imm = registers[rd_or_imm]
            except KeyError:
                raise syntax_error from None

        try:
            what_or_op, op_or_funct = table[command]()
        except KeyError:
            raise SyntaxError(f"Instruction not found, line {num}:\n\t--> {command} {rs}, {rt}, {rd_or_imm}") from None

        if not what_or_op:
            # v type
            if len(rd_or_imm) <= 21:
                final.append(
                    f'{op_or_funct}{rs}{rt}{rd_or_imm:0>21}'
                )
            else:
                raise SystemError(
                    f"Immediate value limit exceeded, , line {num}:\n\t--> {command} {rs}, {rt}, {rd_or_imm}"
                )
        else:
            final.append(
                f'{what_or_op}{rs}{rt}{rd_or_imm}' + ('0' * 14) + f'{op_or_funct}'
            )
    return final


for line in assemble(compile_assembly(*read_assembly(sys.argv[1]))):
    print(line)
