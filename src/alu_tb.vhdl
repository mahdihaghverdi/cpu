library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu_tb is
end alu_tb;

architecture tb of alu_tb is
    signal input_a, input_b : std_logic_vector(7 downto 0);
    signal output           : std_logic_vector(7 downto 0);
    signal carry_borrow     : std_logic;
    signal sel              : std_logic_vector (2 downto 0);

begin
    UUT : entity work.alu port map (
        input_a => input_a,
        input_b => input_b,
        output => output,
        carry_borrow => carry_borrow,
        sel => sel
    );

    input_a <= "00000000", "00000100" after 20 ns;
    input_b <= "00000000", "00000010" after 20 ns;
    sel <= "000",
           "000" after 20 ns,
           "001" after 40 ns,
           "010" after 60 ns,
           "011" after 80 ns,
           "100" after 100 ns,
           "101" after 120 ns,
           "110" after 140 ns,
           "111" after 160 ns,
           "111" after 180 ns;
end tb;
