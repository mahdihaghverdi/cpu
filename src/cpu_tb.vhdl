library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cpu_tb is
end cpu_tb;

architecture tb of cpu_tb is
    signal instruction : std_logic_vector (31 downto 0);
    signal output, a, b : std_logic_vector (7 downto 0);
    signal s : std_logic_vector(2 downto 0);

begin
    UUT : entity work.cpu port map (
        instruction => instruction,
        output => output,
        a => a,
        b => b,
        s => s
    );

    -- 000 0010 0011 0100 00000000000000 001
    instruction <= "00000000000000000000000000000000",
                   "00001000101111100000000000000001" after 20 ns,
                   "00010010001111100000000000000010" after 40 ns,
                   "00000100011111100000000000000011" after 80 ns,
                   "00001011010111100000000000000100" after 100 ns,
                   "00001011010111100000000000000101" after 120 ns,
                   "00001011010111100000000000000110" after 140 ns,
                   "00001011010111100000000000000111" after 160 ns,
                   "10011110000000000000000000001110" after 180 ns,
                   "10111110000000000000000000001001" after 200 ns,
                   "10111110000000000000000000001001" after 220 ns;
end tb;
