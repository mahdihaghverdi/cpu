library ieee;
use ieee.std_logic_1164.all;


entity FourBitFullSubberTB is
end FourBitFullSubberTB;

architecture tb of FourBitFullSubberTB is
    signal a, b: std_logic_vector (3 downto 0);  -- inputs
    signal diff : std_logic_vector (3 downto 0);  -- outputs
    signal borrow : std_logic;

begin
    -- connecting testbench signals with 4bitfa.vhdl
    UUT : entity work.FourBitFullSubber port map (
        input_a => a,
        input_b => b,
        diff => diff,
        borrow => borrow
    );

    -- inputs and outs dec

    -- b a bi              d b
    -- 0 0  0 at   0 ns -> 0 0
    -- 0 0  1 at  20 ns -> 1 1
    -- 0 1  0 at  40 ns -> 1 1
    -- 0 1  1 at  60 ns -> 0 1
    -- 1 0  0 at  80 ns -> 1 0
    -- 1 0  1 at 100 ns -> 0 0
    -- 1 1  0 at 120 ns -> 0 0
    -- 1 1  1 at 140 ns -> 1 1

    -- inputs and outs bin
    -- 1000 0100 -> 0 0100
    -- 1100 0100 -> 0 1000
    -- 0110 1000 -> 1 1110

    a <= "0000",
         "1000" after 10 ns,
         "1100" after 20 ns,
         "1100" after 30 ns,
         "0110" after 40 ns,
         "0110" after 50 ns;

    b <= "0000",
         "0100" after 10 ns,
         "0100" after 20 ns,
         "0100" after 30 ns,
         "1000" after 40 ns,
         "1000" after 50 ns;
end tb ;
