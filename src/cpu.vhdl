library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CPU is
    port (
        instruction : in std_logic_vector (31 downto 0);
        output      : out std_logic_vector (7 downto 0);
        a, b : out std_logic_vector(7 downto 0);
        s : out std_logic_vector(2 downto 0)
    );
end CPU;

architecture arch of cpu is
    signal opcode, funct : std_logic_vector(2 downto 0);
    signal rs, rt, rd, imm : std_logic_vector(3 downto 0);
    signal RegDst,
           ALUSrc,
           MemToReg,
           RegWrite,
           MemWrite,
           Branch,
           useless : std_logic;
    signal ALUControlSignal : std_logic_vector(2 downto 0);
    signal tinput_b : std_logic_vector(3 downto 0);
    signal input_a, input_b : std_logic_vector(7 downto 0);

begin
    -- 109 8765 4321 0987    3210
    -- 000 0000 0000 0000 ... 000
    -- 000 0000 0000 00000...0000
    opcode <= instruction(31) & instruction(30) & instruction(29);
    rs     <= instruction(28) & instruction(27) & instruction(26) & instruction(25);
    rt     <= instruction(24) & instruction(23) & instruction(22) & instruction(21);
    rd     <= instruction(20) & instruction(19) & instruction(18) & instruction(17);
    funct  <= instruction(2) & instruction(1) & instruction(0);
    imm    <= instruction(3) & instruction(2) & instruction(1) & instruction(0);

    cu : entity work.ControlUnit port map(
        opcode => opcode,
        RegDst => RegDst,
        ALUSrc => ALUSrc,
        MemToReg => MemToReg,
        RegWrite => RegWrite,
        MemWrite => MemWrite,
        Branch => Branch
    );

    aluctrl : entity work.ALUControl port map (
        opcode => opcode,
        funct => funct,
        output => ALUControlSignal
    );

    with ALUSrc select tinput_b <=
        rt when '0',
        imm when others;

    input_b <= "0000" & tinput_b;
    input_a <= "0000" & rs;

    a <= input_a;
    b <= input_b;
    s <= ALUControlSignal;

    alu : entity work.ALU port map (
        input_a => input_a,
        input_b => input_b,
        carry_borrow => useless,
        output => output,
        sel => ALUControlSignal
    );
end arch;
