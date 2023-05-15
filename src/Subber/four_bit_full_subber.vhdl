library ieee;
use ieee.std_logic_1164.all;

entity SixteenBitFS is
    port (
        input_a, input_b : in std_logic_vector (15 downto 0);
        diff : out std_logic_vector (15 downto 0);
        borrow : out std_logic
    );
end SixteenBitFS;

architecture arch of SixteenBitFS is
    component FullSubber
        port(
            a, b, borrow_in  : in std_logic;
            diff, borrow_out : out std_logic
        );
    end component;

    for full_subber_0 : FullSubber use entity work.FullSubber;
    for full_subber_1 : FullSubber use entity work.FullSubber;
    for full_subber_2 : FullSubber use entity work.FullSubber;
    for full_subber_3 : FullSubber use entity work.FullSubber;
    for full_subber_4 : FullSubber use entity work.FullSubber;
    for full_subber_5 : FullSubber use entity work.FullSubber;
    for full_subber_6 : FullSubber use entity work.FullSubber;
    for full_subber_7 : FullSubber use entity work.FullSubber;
    for full_subber_8 : FullSubber use entity work.FullSubber;
    for full_subber_9 : FullSubber use entity work.FullSubber;
    for full_subber_10: FullSubber use entity work.FullSubber;
    for full_subber_11: FullSubber use entity work.FullSubber;
    for full_subber_12: FullSubber use entity work.FullSubber;
    for full_subber_13: FullSubber use entity work.FullSubber;
    for full_subber_14: FullSubber use entity work.FullSubber;
    for full_subber_15: FullSubber use entity work.FullSubber;

    signal borrow_0_1,
           borrow_1_2,
           borrow_2_3,
           borrow_3_4,
           borrow_4_5,
           borrow_5_6,
           borrow_6_7,
           borrow_7_8,
           borrow_8_9,
           borrow_9_10,
           borrow_10_11,
           borrow_11_12,
           borrow_12_13,
           borrow_13_14,
           borrow_14_15 : std_logic;

begin
    full_subber_0: FullSubber port map (
        a => input_a(0),
        b => input_b(0),
        borrow_in => '0',
        diff => diff(0),
        borrow_out => borrow_0_1
    );
    full_subber_1: FullSubber port map (
        a => input_a(1),
        b => input_b(1),
        borrow_in => borrow_0_1,
        diff => diff(1),
        borrow_out => borrow_1_2
    );
    full_subber_2: FullSubber port map (
        a => input_a(2),
        b => input_b(2),
        borrow_in => borrow_1_2,
        diff => diff(2),
        borrow_out => borrow_2_3
    );
    full_subber_3: FullSubber port map (
        a => input_a(3),
        b => input_b(3),
        borrow_in => borrow_2_3,
        diff => diff(3),
        borrow_out => borrow_3_4
    );
    full_subber_4: FullSubber port map (
        a => input_a(4),
        b => input_b(4),
        borrow_in => borrow_2_3,
        diff => diff(4),
        borrow_out => borrow_4_5
    );
    full_subber_5: FullSubber port map (
        a => input_a(5),
        b => input_b(5),
        borrow_in => borrow_2_3,
        diff => diff(5),
        borrow_out => borrow_5_6
    );
    full_subber_6: FullSubber port map (
        a => input_a(6),
        b => input_b(6),
        borrow_in => borrow_2_3,
        diff => diff(6),
        borrow_out => borrow_6_7
    );
    full_subber_7: FullSubber port map (
        a => input_a(7),
        b => input_b(7),
        borrow_in => borrow_2_3,
        diff => diff(7),
        borrow_out => borrow_7_8
    );
    full_subber_8: FullSubber port map (
        a => input_a(8),
        b => input_b(8),
        borrow_in => borrow_2_3,
        diff => diff(8),
        borrow_out => borrow_8_9
    );
    full_subber_9: FullSubber port map (
        a => input_a(9),
        b => input_b(9),
        borrow_in => borrow_2_3,
        diff => diff(9),
        borrow_out => borrow_9_10
    );
    full_subber_10: FullSubber port map (
        a => input_a(10),
        b => input_b(10),
        borrow_in => borrow_2_3,
        diff => diff(10),
        borrow_out => borrow_10_11
    );
    full_subber_11: FullSubber port map (
        a => input_a(11),
        b => input_b(11),
        borrow_in => borrow_2_3,
        diff => diff(11),
        borrow_out => borrow_11_12
    );
    full_subber_12: FullSubber port map (
        a => input_a(12),
        b => input_b(12),
        borrow_in => borrow_2_3,
        diff => diff(12),
        borrow_out => borrow_12_13
    );
    full_subber_13: FullSubber port map (
        a => input_a(13),
        b => input_b(13),
        borrow_in => borrow_2_3,
        diff => diff(13),
        borrow_out => borrow_13_14
    );
    full_subber_14: FullSubber port map (
        a => input_a(14),
        b => input_b(14),
        borrow_in => borrow_2_3,
        diff => diff(14),
        borrow_out => borrow_14_15
    );
    full_subber_15: FullSubber port map (
        a => input_a(15),
        b => input_b(15),
        borrow_in => borrow_2_3,
        diff => diff(15),
        borrow_out => borrow
    );
end arch;
