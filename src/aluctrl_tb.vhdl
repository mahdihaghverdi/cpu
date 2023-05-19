library ieee;
use ieee.std_logic_1164.all;

entity ALUCTB is
end ALUCTB;

architecture tb of ALUCTB is
    signal opcode, funct, output : std_logic_vector(2 downto 0);
begin
    UUT : entity work.ALUControl port map (
        opcode => opcode,
        funct => funct,
        output => output
    );

    opcode <= "000", "111" after 60 ns, "001" after 80 ns, "010" after 100 ns, "100" after 120 ns, "101" after 140 ns;
    funct <= "000", "001" after 20 ns, "010" after 40 ns;
end tb;
