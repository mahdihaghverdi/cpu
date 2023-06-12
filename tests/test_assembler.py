import tempfile

import pytest

from Assembler import read_assembly


@pytest.fixture(scope='function')
def create_tempfile():
    tmp = tempfile.NamedTemporaryFile(mode='r+')
    try:
        yield tmp
    finally:
        tmp.close()


def test_read_assembly(create_tempfile):
    with open(create_tempfile.name, 'a') as f:
        f.writelines(
            [
                'add $r1, $r2, $r3\n',
                'sub $r1, $r2, $r3\n',
                'L2: bnq $r1, $r2, L3\n',
                'L3: mul $r1, $r2, $r3\n',
            ]
        )
    labels, lines = read_assembly(create_tempfile.name)

    assert len(labels) == 2
    assert labels['L2'] == 3
    assert labels['L3'] == 4

    assert len(lines) == 4
    f, s, t, fo = lines
    assert f == 'add $r1, $r2, $r3'
    assert s == 'sub $r1, $r2, $r3'
    assert t == 'bnq $r1, $r2, L3'
    assert fo == 'mul $r1, $r2, $r3'
