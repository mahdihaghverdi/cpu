library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity ALU is
    port (
        input_a, input_b : in std_logic_vector(7 downto 0);
        output           : out std_logic_vector(7 downto 0);
        carry_borrow     : out std_logic;
        sel              : in std_logic_vector (2 downto 0)
    );
end ALU;

architecture arch of ALU is
    component mux8x1 is
        port (
            i0, i1, i2, i3,
            i4, i5, i6, i7 : in std_logic_vector (7 downto 0);
            sel            : in std_logic_vector (2 downto 0);
            output         : out std_logic_vector (7 downto 0)
        );
    end component;

    signal plus, minus, mul, mand, mor, mnor, mnand : std_logic_vector(7 downto 0);
begin
    plus  <= std_logic_vector(unsigned(input_a) + unsigned(input_b));
    minus <= std_logic_vector(unsigned(input_a) - unsigned(input_b));
    mul   <= std_logic_vector((unsigned(input_a(3 downto 0))) * (unsigned(input_b(3 downto 0))));
    mand  <= input_a and input_b;
    mor   <= input_a or input_b;
    mnor  <= input_a nor input_b;
    mnand <= input_a nand input_b;

    inner_mux : entity work.mux8x1 port map (
        i0 => plus,
        i1 => minus,
        i2 => mul,
        i3 => mand,
        i4 => mor,
        i5 => mnor,
        i6 => mnand,
        i7 => "11111111",
        sel => sel,
        output => output
    );
end arch;
