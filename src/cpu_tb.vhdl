library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cpu_tb is
end cpu_tb;

architecture tb of cpu_tb is
    signal instruction : std_logic_vector (31 downto 0);
    signal output : std_logic_vector (7 downto 0);

begin
    UUT : entity work.cpu port map (
        instruction => instruction,
        output => output
    );

    -- add $r1, $r2, $r3
    --    $r1 = 5 + 4

    -- 000 0101 0100 0001 00000000000000 001
    instruction <= "00001010100000100000000000000001",
                   "00001010100000100000000000000001" after 20 ns,
                   "00001010100000100000000000000001" after 40 ns,
                   "10001010100000100000000000000001" after 60 ns,
                   "10001010100000100000000000000001" after 80 ns;
end tb;
