library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux8x1 is
    port (
        i0,
        i1,
        i2,
        i3,
        i4,
        i5,
        i6,
        i7    : in unsigned (7 downto 0);
        sel   : in std_logic_vector (2 downto 0);
        output: out unsigned (7 downto 0)
    );
end mux8x1;

architecture arch of mux8x1 is
begin
    with sel select output <=
        i0 when "000",
        i1 when "001",
        i2 when "010",
        i3 when "011",
        i4 when "100",
        i5 when "101",
        i6 when "110",
        i7 when others;
end arch;
