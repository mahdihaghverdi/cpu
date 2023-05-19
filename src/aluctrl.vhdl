library ieee;
use ieee.std_logic_1164.all;

entity ALUControl is
    port (
        opcode : in std_logic_vector(2 downto 0);
        funct  : in std_logic_vector(2 downto 0);
        output : out std_logic_vector(2 downto 0)
    );
end ALUControl;

architecture arch of ALUControl is
    signal sel, bnq, lw, sw, andi, ori : std_logic;
    signal other_out : std_logic_vector(2 downto 0);
begin
    sel       <= not(opcode(2)) and not(opcode(1)) and not(opcode(0));
    bnq       <= opcode(2) and opcode(1) and opcode(0);
    lw        <= not(opcode(2)) and not(opcode(1)) and opcode(0);
    sw        <= not(opcode(2)) and opcode(1) and not(opcode(0));
    andi      <= opcode(2) and not(opcode(1)) and not(opcode(0));
    ori       <= opcode(2) and not(opcode(1)) and opcode(0);

    other_out(2) <= ori or andi;
    other_out(1) <= bnq;
    other_out(0) <= lw or sw or ori;

    with sel select output <=
        funct when '1',
        other_out when others;
end arch;
