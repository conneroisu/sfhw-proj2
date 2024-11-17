-- <header>
-- Author(s): Conner Ohnesorge
-- Name: proj/test/tb_stage_idex.vhd
-- Notes:
--      Conner Ohnesorge 2024-11-14T07:46:05-06:00 add-control-signals-summary-and-update-test-bench-ports
--      Conner Ohnesorge 2024-11-11T14:46:34-06:00 added-do-file-examples-and-start-of-testbench-for-stage_idex
-- </header>

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity tb_stage_idex is
end entity tb_stage_idex;

architecture Behavioral of tb_stage_idex is

    component stage_idex is
        generic(N : integer := 32);
        port (
            -- Common Stage Signals [begin]
            i_CLK     : in std_logic;
            i_RST     : in std_logic;
            i_WE      : in std_logic;
            i_PC      : in std_logic_vector(N-1 downto 0);
            i_PCplus4 : in std_logic_vector(N-1 downto 0);

            -- Control Signals (From Control Unit) [begin]
            --= Stage Specific Signals [begin]
            --         RegDst  ALUOp  ALUSrc
            -- R-Type:   1      10      00
            -- lw    :   0      00      01
            -- sw    :   x      00      01
            -- beq   :   x      01      00
            i_RegDst : in std_logic_vector(4 downto 0);  -- Destination register from control unit.
            i_ALUOp  : in std_logic_vector(1 downto 0);  -- ALU operation from control unit.
            i_ALUSrc : in std_logic_vector(1 downto 0);  -- ALU source from control unit.

            -- Future Stage Signals [begin]
            -- see: https://private-user-images.githubusercontent.com/88785126/384028866-8e8d5e84-ca22-462e-8b85-ea1c00c43e8f.png
            o_ALU : out std_logic_vector(N-1 downto 0);

            -- Input Signals [begin]
            --= Sign Extend Signals [begin]
            i_Extended   : in  std_logic_vector(N-1 downto 0);
            o_BranchAddr : out std_logic_vector(N-1 downto 0);
            --= Register File Signals [begin]
            i_Read1      : in  std_logic_vector(N-1 downto 0);
            i_Read2      : in  std_logic_vector(N-1 downto 0);
            o_Read1      : out std_logic_vector(N-1 downto 0);
            o_Read2      : out std_logic_vector(N-1 downto 0);

            -- Forward Unit Signals [begin]
            --= Forwarded Signals (received from Forward Unit) [begin]
            -- ForwardA & ForwardB determine 1st & 2nd alu operands respectively
            -- MuxInputs    -> {Source} -> {Explanation}
            -- ForwardA=00  -> ID/EX    -> operand from registerfile
            -- ForwardA=10  -> EX/MEM   -> operand is forwarded from prior alu result
            -- ForwardA=01  -> MEM/WB   -> operand is forwarded from dmem or earlier alu result
            -- ForwardB=00  -> ID/EX    -> operand from registerfile
            -- ForwardB=10  -> EX/MEM   -> operand is forwarded from prior alu result
            -- ForwardB=01  -> MEM/WB   -> operand is forwarded from dmem or earlier alu result
            i_ForwardA  : in std_logic_vector(1 downto 0);
            i_ForwardB  : in std_logic_vector(1 downto 0);
            --= Forwarding Signals (sent to Forward Unit) [begin]
            i_WriteData : in std_logic_vector(N-1 downto 0);  -- Data from the end of writeback stage's mux
            i_DMem1     : in std_logic_vector(N-1 downto 0)  -- Data from the first input to the DMem output of ex/mem
            );
    end component;
begin


end architecture Behavioral;

