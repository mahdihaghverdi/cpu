library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu_tb is
end alu_tb;

architecture tb of alu_tb is
    signal input_a, input_b : unsigned(7 downto 0);
    signal output           : unsigned(7 downto 0);
    signal carry_borrow     : std_logic;
    signal sel              : std_logic_vector (1 downto 0);

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
    sel <= "00", "00" after 20 ns, "01" after 40 ns, "10" after 60 ns, "11" after 80 ns, "11" after 100 ns;
end tb;