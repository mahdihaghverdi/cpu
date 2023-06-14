library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux4x1_tb is
end mux4x1_tb;

architecture arch of mux4x1_tb is
    signal i0, i1, i2, i3, output : unsigned (7 downto 0);
    signal sel : std_logic_vector (1 downto 0);
begin
    UUT : entity work.mux4x1 port map (
        i0 => i0,
        i1 => i1,
        i2 => i2,
        i3 => i3,
        sel => sel,
        output => output
    );


    -- i3333333 i2222222 i1111111 i0000000 sel   oooooooo
    -- 00001010 00000011 00000101 00000010 00    00000010
    -- 00001010 00000011 00000101 00000010 01    00000101
    -- 00001010 00000011 00000101 00000010 10    00000011
    -- 00001010 00000011 00000101 00000010 11    00001010

    i0 <= "00000000", "00000010" after 20 ns, "00000010" after 40 ns, "00000010" after 60 ns, "00000010" after 80 ns;
    i1 <= "00000000", "00000101" after 20 ns, "00000101" after 40 ns, "00000101" after 60 ns, "00000101" after 80 ns;
    i2 <= "00000000", "00000011" after 20 ns, "00000011" after 40 ns, "00000011" after 60 ns, "00000011" after 80 ns;
    i3 <= "00000000", "00001010" after 20 ns, "00001010" after 40 ns, "00001010" after 60 ns, "00001010" after 80 ns;
    sel <=  "00", "00" after 20 ns, "01" after 40 ns, "10" after 60 ns, "11" after 80 ns, "11" after 100 ns;

end arch;
