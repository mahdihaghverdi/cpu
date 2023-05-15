library ieee;
use ieee.std_logic_1164.all;

entity ControlUnitTB is
end ControlUnitTB;

architecture tb of ControlUnitTB is
    signal opcode     : std_logic_vector(2 downto 0);
    signal RegDst,
           ALUSrc,
           MemToReg,
           RegWrite,
           MemWrite,
           Branch     : std_logic;
begin
    UUT : entity work.ControlUnit port map (
        opcode => opcode,
        RegDst => RegDst,
        ALUSrc => ALUSrc,
        MemToReg => MemToReg,
        RegWrite => RegWrite,
        MemWrite => MemWrite,
        Branch => Branch
    );

    opcode <= "000",
              "111" after 20 ns,
              "001" after 40 ns,
              "010" after 60 ns,
              "100" after 80 ns,
              "101" after 100 ns;
end tb;
