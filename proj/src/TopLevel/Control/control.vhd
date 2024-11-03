library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity control is
    port (
        i_CLK         : in  std_logic;
        i_OpCode      : in  std_logic_vector(5 downto 0);
        -- o_PCWriteCond is a one bit signal.
        -- 0 = No effect.
        -- 1 = PC PC is written if zero output from the ALU.
        o_PCWriteCond : out std_logic;
        -- o_PCWrite
        -- 0 = No effect.
        -- 1 = PC controlled by PCSource
        o_PCWrite     : out std_logic;
        -- o_lorD
        -- 0 = PC used to supply address to the memory.
        -- 1 = ALUOut is used to supply the address to the memory.
        o_lorD        : out std_logic;
        -- o_MemRead is a one bit signal.
        -- 0 = No effect.
        -- 1 = Content of memory at the location specified by the address input is put on memory data output.
        o_MemRead     : out std_logic;
        -- o_MemWrite is a one bit signal.
        -- 0 = No effect.
        -- 1 = Memory contents at the location specified by the address input is replaced by the value on the write data input.
        o_MemWrite    : out std_logic;
        -- o_MemToReg is a one bit signal.
        -- 0 = Value fed to register file write data input comes from ALUOut
        -- 1 = Value fed to register file write data comes from MDR.
        o_MemToReg    : out std_logic;
        -- o_IRWrite is a one bit signal.
        -- 0 = No effect.
        -- 1 = Write output of memory to IR.
        o_IRWrite     : out std_logic;
        -- o_PCSouce is a two bit signal.
        -- 00 = PC + 4 is sent to PC.
        -- 01 = contents of ALUOut is sent to PC.
        -- 10 = jump address [IR[25:0]] shifted left by 2 bits and concatenated with PC+4[31:28] sent to PC.
        o_PCSouce     : out std_logic_vector(1 downto 0);
        -- o_ALUOP is a two bit signal.
        -- 00 = ADD
        -- 01 = SUB
        -- 10 = {defined by funct field}
        o_ALUOP       : out std_logic_vector(1 downto 0);
        -- o_ALUSrcB is a two bit signal.
        -- 00 = second alu input from B register.
        -- 01 = second alu input from is a constant, 4.
        -- 10 = second alu input is the sign-extended lower 16 bits of the IR.
        -- 11 = second alu input is the sign-extended lower 16 bits of the IR shifted left by 2 bits.
        o_ALUSrcB     : out std_logic;
        -- o_ALUSrcA is a one bit signal.
        -- 0 = first operand given to ALU is PC.
        -- 1 = first operand given to ALU is the A register.
        o_ALUSrcA     : out std_logic;
        -- o_RegWrite is a one bit signal.
        -- 0 = No Effect.
        -- 1 = Write output of memory to IR.
        o_RegWrite    : out std_logic;
        -- o_RegDst is a one bit signal.
        -- 0 = register file destination # for Write Register comes from rt field.
        -- 1 = register file destination # for Write Register comes from rd field.
        o_RegDst      : out std_logic;
        );
end control;

architecture Behavioral of control is

begin
-- TODO: Implement the rest of your control logic here!
end Behavioral;
