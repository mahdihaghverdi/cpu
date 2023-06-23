library ieee;
use ieee.std_logic_1164.all;

entity mux8x1_tb is
end mux8x1_tb;

architecture arch of mux8x1_tb is
    signal i0, i1, i2, i3, i4, i5, i6, i7, output : std_logic_vector (7 downto 0);
    signal sel : std_logic_vector (2 downto 0);
begin
    UUT : entity work.mux8x1 port map (
        i0 => i0,
        i1 => i1,
        i2 => i2,
        i3 => i3,
        i4 => i4,
        i5 => i5,
        i6 => i6,
        i7 => i7,
        sel => sel,
        output => output
    );


    -- i3333333 i2222222 i1111111 i0000000 sel   oooooooo
    -- 00001010 00000011 00000101 00000010 00    00000010
    -- 00001010 00000011 00000101 00000010 01    00000101
    -- 00001010 00000011 00000101 00000010 10    00000011
    -- 00001010 00000011 00000101 00000010 11    00001010

    i0 <= "00000000", "00000010" after 20 ns;
    i1 <= "00000000", "00000101" after 20 ns;
    i2 <= "00000000", "00000011" after 20 ns;
    i3 <= "00000000", "00001010" after 20 ns;
    i4 <= "00000000", "00001011" after 20 ns;
    i5 <= "00000000", "00001110" after 20 ns;
    i6 <= "00000000", "00100000" after 20 ns;
    i7 <= "00000000", "00101010" after 20 ns;
    sel <=  "000",
            "000" after 20 ns,
            "001" after 40 ns,
            "010" after 60 ns,
            "011" after 80 ns,
            "100" after 100 ns,
            "101" after 120 ns,
            "110" after 140 ns,
            "111" after 160 ns,
            "111" after 180 ns;

end arch;
