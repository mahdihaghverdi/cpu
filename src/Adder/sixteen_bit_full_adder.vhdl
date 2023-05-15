library ieee;
use ieee.std_logic_1164.all;

entity SixteenBitFA is
    port (
        input_a, input_b : in std_logic_vector (15 downto 0);
        sum : out std_logic_vector (15 downto 0);
        carry : out std_logic
    );
end SixteenBitFA;

architecture arch of SixteenBitFA is
    component FullAdder
        port (
            a, b, ci : in std_logic;
            s, c : out std_logic
        );
    end component;

    for full_adder_0 : FullAdder use entity work.FullAdder;
    for full_adder_1 : FullAdder use entity work.FullAdder;
    for full_adder_2 : FullAdder use entity work.FullAdder;
    for full_adder_3 : FullAdder use entity work.FullAdder;
    for full_adder_4 : FullAdder use entity work.FullAdder;
    for full_adder_5 : FullAdder use entity work.FullAdder;
    for full_adder_6 : FullAdder use entity work.FullAdder;
    for full_adder_7 : FullAdder use entity work.FullAdder;
    for full_adder_8 : FullAdder use entity work.FullAdder;
    for full_adder_9 : FullAdder use entity work.FullAdder;
    for full_adder_10: FullAdder use entity work.FullAdder;
    for full_adder_11: FullAdder use entity work.FullAdder;
    for full_adder_12: FullAdder use entity work.FullAdder;
    for full_adder_13: FullAdder use entity work.FullAdder;
    for full_adder_14: FullAdder use entity work.FullAdder;
    for full_adder_15: FullAdder use entity work.FullAdder;


    signal carry_0_1,
           carry_1_2,
           carry_2_3,
           carry_3_4,
           carry_4_5,
           carry_5_6,
           carry_6_7,
           carry_7_8,
           carry_8_9,
           carry_9_10,
           carry_10_11,
           carry_11_12,
           carry_12_13,
           carry_13_14,
           carry_14_15 : std_logic;
begin
    full_adder_0: FullAdder port map (
        a => input_a(0),
        b => input_b(0),
        ci => '0',
        s => sum(0),
        c => carry_0_1
    );
    full_adder_1: FullAdder port map (
        a => input_a(1),
        b => input_b(1),
        ci => carry_0_1,
        s => sum(1),
        c => carry_1_2
    );
    full_adder_2: FullAdder port map (
        a => input_a(2),
        b => input_b(2),
        ci => carry_1_2,
        s => sum(2),
        c => carry_2_3
    );
    full_adder_3: FullAdder port map (
        a => input_a(3),
        b => input_b(3),
        ci => carry_2_3,
        s => sum(3),
        c => carry_3_4
    );
    full_adder_4: FullAdder port map (
        a => input_a(4),
        b => input_b(4),
        ci => carry_2_3,
        s => sum(4),
        c => carry_4_5
    );
    full_adder_5: FullAdder port map (
        a => input_a(5),
        b => input_b(5),
        ci => carry_2_3,
        s => sum(5),
        c => carry_5_6
    );
    full_adder_6: FullAdder port map (
        a => input_a(6),
        b => input_b(6),
        ci => carry_2_3,
        s => sum(6),
        c => carry_6_7
    );
    full_adder_7: FullAdder port map (
        a => input_a(7),
        b => input_b(7),
        ci => carry_2_3,
        s => sum(7),
        c => carry_7_8
    );
    full_adder_8: FullAdder port map (
        a => input_a(8),
        b => input_b(8),
        ci => carry_2_3,
        s => sum(8),
        c => carry_8_9
    );
    full_adder_9: FullAdder port map (
        a => input_a(9),
        b => input_b(9),
        ci => carry_2_3,
        s => sum(9),
        c => carry_9_10
    );
    full_adder_10: FullAdder port map (
        a => input_a(10),
        b => input_b(10),
        ci => carry_2_3,
        s => sum(10),
        c => carry_10_11
    );
    full_adder_11: FullAdder port map (
        a => input_a(11),
        b => input_b(11),
        ci => carry_2_3,
        s => sum(11),
        c => carry_11_12
    );
    full_adder_12: FullAdder port map (
        a => input_a(12),
        b => input_b(12),
        ci => carry_2_3,
        s => sum(12),
        c => carry_12_13
    );
    full_adder_13: FullAdder port map (
        a => input_a(13),
        b => input_b(13),
        ci => carry_2_3,
        s => sum(13),
        c => carry_13_14
    );
    full_adder_14: FullAdder port map (
        a => input_a(14),
        b => input_b(14),
        ci => carry_2_3,
        s => sum(14),
        c => carry_14_15
    );
    full_adder_15: FullAdder port map (
        a => input_a(15),
        b => input_b(15),
        ci => carry_2_3,
        s => sum(15),
        c => carry
    );
end arch;
