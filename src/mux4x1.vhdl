library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux4x1 is
    port (
        i0, i1, i2, i3 : in unsigned (7 downto 0);
        sel : in std_logic_vector (1 downto 0);
        output: out unsigned (7 downto 0)
    );
end mux4x1;

architecture arch of mux4x1 is
begin
    with sel select output <=
        i0 when "00",
        i1 when "01",
        i2 when "10",
        i3 when others;
end arch;
