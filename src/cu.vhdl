library ieee;
use ieee.std_logic_1164.all;

entity ControlUnit is
    port (
        opcode     : in std_logic_vector(2 downto 0);
        RegDst,
        ALUSrc,
        MemToReg,
        RegWrite,
        MemWrite,
        Branch     : out std_logic
    );
end ControlUnit;

architecture arch of ControlUnit is
    signal RType, bnq, lw, sw, andi, ori : std_logic;
begin
    RType    <= not(opcode(2)) and not(opcode(1)) and not(opcode(0));
    bnq      <= opcode(2) and opcode(1) and opcode(0);
    lw       <= not(opcode(2)) and not(opcode(1)) and opcode(0);
    sw       <= not(opcode(2)) and opcode(1) and not(opcode(0));
    andi     <= opcode(2) and not(opcode(1)) and not(opcode(0));
    ori      <= opcode(2) and not(opcode(1)) and opcode(0);

    RegDst   <= RType;
    ALUSrc   <= lw or sw or andi or ori;
    MemToReg <= lw;
    RegWrite <= RType or lw or andi or ori;
    MemWrite <= sw;
    Branch   <= bnq;
end arch;
