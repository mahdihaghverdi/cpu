library ieee;
use ieee.std_logic_1164.all;


entity FourBitFullAdderTB is
end FourBitFullAdderTB;

architecture tb of FourBitFullAdderTB is
    signal a, b: std_logic_vector (3 downto 0);  -- inputs
    signal sum : std_logic_vector (3 downto 0);  -- outputs
    signal carry : std_logic;

begin
    -- connecting testbench signals with 4bitfa.vhdl
    UUT : entity work.FourBitFullAdder port map (
        input_a => a,
        input_b => b,
        sum => sum,
        carry => carry
    );

    -- inputs and outs dec

    -- bb aa             c ss
    --  0  0 at  0 ns -> 0  0
    --  4  4 at 20 ns -> 0  8
    -- 12 15 at 40 ns -> 1 11

    -- inputs and outs bin
    -- 0000 0000 -> 0 0000
    -- 0100 0100 -> 0 1000
    -- 1100 1111 -> 1 1011

    a <= "0000", "0100" after 20 ns, "1111" after 40 ns, "1111" after 60 ns;
    b <= "0000", "0100" after 20 ns, "1100" after 40 ns, "1100" after 60 ns;
end tb ;
