library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity ALU is
    port (
        input_a, input_b : in unsigned(7 downto 0);
        output           : out unsigned(7 downto 0);
        carry_borrow     : out std_logic;
        sel              : in std_logic_vector (1 downto 0)
    );
end ALU;

architecture arch of ALU is
    component mux4x1 is
        port (
            i0, i1, i2, i3 : in unsigned (7 downto 0);
            sel            : in std_logic_vector (1 downto 0);
            output         : out unsigned (7 downto 0)
        );
    end component;

    signal plus, minus, mul : unsigned(7 downto 0);
begin
    plus <= input_a + input_b;
    minus <= input_a - input_b;

    inner_mux : entity work.mux4x1 port map (
        i0 => plus,
        i1 => minus,
        i2 => mul,
        i3 => "11111111",
        sel => sel,
        output => output
    );
end arch;
