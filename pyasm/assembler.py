from pathlib import Path
from typing import TypeAlias

Labels: TypeAlias = dict[str, int]
Instruction: TypeAlias = str
MachineCode: TypeAlias = str


def read_assembly(file: str | Path) -> tuple[Labels, list[Instruction]]:
    """Read the assembly file and remove the labels names from the front of the instruction

    This function will return the labels with their addresses and the label-removed assembly
    Line numbering will start with one.
    The line numbers are saved in decimal here.
    """  # noqa: E501
    labels = {}
    true_assembly = []
    with open(file) as f:
        for num, instruction_line in enumerate(f, start=1):
            # lines with labels:
            # ...
            # bnq $r1, $r2, L1
            # L1: add $r2, $r3, $r1
            # ...
            try:
                # look for labels in the instruction
                label, rest = instruction_line.split(":")
                labels[label] = num
                true_assembly.append(rest.strip().strip("\n"))
            except ValueError:
                # normal instruction
                true_assembly.append(instruction_line.strip("\n"))
    return labels, list(filter(lambda x: x, true_assembly))


def _decode_line(instruction: str) -> str:
    instruction = " ".join(instruction.split())
    return instruction.replace(",", " ").replace("  ", " ").strip().strip("\n")


def compile_assembly(
    labels: Labels, instructions: list[Instruction]
) -> list[Instruction]:
    final: list[Instruction] = []
    for num, instr in enumerate(instructions, start=1):
        instr = _decode_line(instr)
        command, rs, rt, rd_or_imm = instr.split()

        syntax_error = SyntaxError(
            f"Instruction argument must start with `$`, line {num}:\n"
            f"\t--> {command} {rs}, {rt}, {rd_or_imm}"
        )

        if rs[0] != "$" or rt[0] != "$":
            raise syntax_error from None

        if rd_or_imm in labels:
            rd_or_imm = bin(labels[rd_or_imm])[2:]

        final.append(f"{command} {rs}, {rt}, {rd_or_imm}")
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
        "bnq": lambda: (None, "111"),
        "lw": lambda: (None, "001"),
        "sw": lambda: (None, "010"),
        "andi": lambda: (None, "100"),
        "ori": lambda: (None, "101"),
    }
    registers = {
        "$zero": "0000",
        "$at": "0001",
        "$a1": "0010",
        "$a2": "0011",
        "$a3": "0100",
        "$l1": "0101",
        "$l2": "0110",
        "$l3": "0111",
        "$t1": "1000",
        "$t2": "1001",
        "$t3": "1010",
        "$t4": "1011",
        "$t5": "1100",
        "$t6": "1101",
        "$t7": "1110",
        "$t8": "1111",
    }

    for num, inst in enumerate(instructions, 1):
        inst = _decode_line(inst)
        command, rs, rt, rd_or_imm = inst.split()

        syntax_error = SyntaxError(
            f"Register not found, line {num}:\n"
            f"\t--> {command} {rs}, {rt}, {rd_or_imm}"
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
                    f"Confused about your third arg to the instruction, line {num}:\n"
                    f"\t--> {command} {rs}, {rt}, {rd_or_imm}\n"
                    f"The label or register may not exists"
                ) from None
        else:
            try:
                rd_or_imm = registers[rd_or_imm]
            except KeyError:
                raise syntax_error from None

        try:
            what_or_op, op_or_funct = table[command]()
        except KeyError:
            raise SyntaxError(
                f"Instruction not found, line {num}:\n"
                f"\t--> {command} {rs}, {rt}, {rd_or_imm}"
            ) from None

        if what_or_op is None:
            # v type
            if len(rd_or_imm) <= 21:
                final.append(f"{op_or_funct}{rs}{rt}{rd_or_imm:0>21}")
            else:
                raise SyntaxError(
                    f"Immediate value limit exceeded, line {num}:\n"
                    f"\t--> {command} {rs}, {rt}, {rd_or_imm}"
                )
        else:
            final.append(
                f"{what_or_op}{rs}{rt}{rd_or_imm}" + ("0" * 14) + f"{op_or_funct}"
            )
    return final
