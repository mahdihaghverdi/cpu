import tempfile

import pytest

from pyasm import _decode_line, compile_assembly, read_assembly, assemble


@pytest.fixture(scope="function")
def create_tempfile():
    tmp = tempfile.NamedTemporaryFile(mode="r+")
    try:
        yield tmp
    finally:
        tmp.close()


def test_read_assembly(create_tempfile):
    with open(create_tempfile.name, "a") as f:
        f.writelines(
            [
                "add $r1, $r2, $r3\n",
                "sub $r1, $r2, $r3\n",
                "L2: bnq $r1, $r2, L3\n",
                "L3: mul $r1, $r2, $r3\n",
            ]
        )
    labels, lines = read_assembly(create_tempfile.name)

    assert len(labels) == 2
    assert labels["L2"] == 3
    assert labels["L3"] == 4

    assert len(lines) == 4
    f, s, t, fo = lines
    assert f == "add $r1, $r2, $r3"
    assert s == "sub $r1, $r2, $r3"
    assert t == "bnq $r1, $r2, L3"
    assert fo == "mul $r1, $r2, $r3"


def test_decode_line():
    true = "add $r1 $r2 $r3"
    assert _decode_line("add $r1,$r2,$r3") == true
    assert _decode_line("add $r1, $r2,     $r3") == true
    assert _decode_line("add $r1,$r2,      $r3") == true


def test_compile_assembly(create_tempfile):
    with open(create_tempfile.name, "w") as f:
        f.write("add r1, $r2, $r3\n")

    with pytest.raises(SyntaxError):
        compile_assembly(*read_assembly(create_tempfile.name))

    with open(create_tempfile.name, "w") as f:
        f.write("add $r1, r2, $r3\n")

    with pytest.raises(SyntaxError):
        compile_assembly(*read_assembly(create_tempfile.name))

    with open(create_tempfile.name, "w") as f:
        f.writelines(
            [
                "add $r1, $r2, $r3\n",
                "sub $r1, $r2, $r3\n",
                "L2: bnq $r1, $r2, L3\n",
                "L3: mul $r1, $r2, $r3\n",
            ]
        )

    instructions = compile_assembly(*read_assembly(create_tempfile.name))

    assert all(instructions)
    assert len(instructions) == 4
    assert all(":" not in instruction for instruction in instructions)
    assert all(instruction.count(",") == 2 for instruction in instructions)
    f, s, t, fo = instructions
    assert f == "add $r1, $r2, $r3"
    assert s == "sub $r1, $r2, $r3"
    assert t == "bnq $r1, $r2, 100"
    assert fo == "mul $r1, $r2, $r3"


def test_assemble(create_tempfile):
    with open(create_tempfile.name, "w") as f:
        f.write("add $zero, $at, $t9\n")
    with pytest.raises(SyntaxError) as error:
        assemble(compile_assembly(*read_assembly(create_tempfile.name)))
    assert "Confused" in error.value.__str__()

    with open(create_tempfile.name, "w") as f:
        f.write("add $zero, $t9, $at\n")
    with pytest.raises(SyntaxError) as error:
        assemble(compile_assembly(*read_assembly(create_tempfile.name)))
    assert "Register not found" in error.value.__str__()

    with open(create_tempfile.name, "w") as f:
        f.write("add $t8, $at, 2\n")
    with pytest.raises(SyntaxError) as error:
        assemble(compile_assembly(*read_assembly(create_tempfile.name)))
    assert "Confused" in error.value.__str__()

    with open(create_tempfile.name, "w") as f:
        f.write("add $t9, $at, $zero\n")
    with pytest.raises(SyntaxError) as error:
        assemble(compile_assembly(*read_assembly(create_tempfile.name)))
    assert "Register not found" in error.value.__str__()

    with open(create_tempfile.name, "w") as f:
        f.write("hello $t8, $at, $zero\n")
    with pytest.raises(SyntaxError) as error:
        assemble(compile_assembly(*read_assembly(create_tempfile.name)))
    assert "Instruction not found" in error.value.__str__()

    with open(create_tempfile.name, "w") as f:
        f.write("lw $t8, $at, 0000000000000000000001\n")
    with pytest.raises(SyntaxError) as error:
        assemble(compile_assembly(*read_assembly(create_tempfile.name)))
    assert "Immediate value" in error.value.__str__()

    with open(create_tempfile.name, "w") as f:
        f.writelines(
            [
                "add $a1, $a2, $a3\n",
                "sub $l1, $l2, $l3\n",
                "L2: bnq $zero, $at, L3\n",
                "L3: mul $t1, $t2, $t3\n",
            ]
        )

    instructions = assemble(compile_assembly(*read_assembly(create_tempfile.name)))
    f, s, t, fo = instructions
    assert f == "00000100011010000000000000000001"
    assert s == "00001010110011100000000000000010"
    assert t == "11100000001000000000000000000100"
    assert fo == "00010001001101000000000000000011"
