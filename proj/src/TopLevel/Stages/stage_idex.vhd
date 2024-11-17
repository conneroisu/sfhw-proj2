-- <header>
-- Author(s): Conner Ohnesorge
-- Name: proj/src/TopLevel/Stages/stage_idex.vhd
-- Notes:
--      Conner Ohnesorge 2024-11-16T21:01:26-06:00 fix-run-all.sh-script-to-cd-into-the-directory-first
--      Conner Ohnesorge 2024-11-16T18:27:04-06:00 fix-port-widths-and-stage-register-names
--      Conner Ohnesorge 2024-11-16T18:23:26-06:00 fix-new-control-signal-width-for-aluOp
--      Conner Ohnesorge 2024-11-16T17:56:46-06:00 format-stage_idex.vhd-after-adding-generic-mux
--      Conner Ohnesorge 2024-11-16T17:56:24-06:00 update-the-stage_idex.vhd-to-use-the-new-muxNtM-component-structure
--      connero 2024-11-16T17:22:38-06:00 Merge-branch-main-into-component-forward-unit
--      Conner Ohnesorge 2024-11-16T17:13:40-06:00 update-to-latest-implementation-of-muxNtM
--      Conner Ohnesorge 2024-11-13T12:27:08-06:00 removed-unused-vhdl_ls.toml-put-it-in-HOME-and-further-simplified-the-stage_idex.vhd-file-by-removing-the-unnecessary-signals-and-signals-that-were-not-being-used-specifically-the-signals-that-were-being-used-in-the-future-stages
--      Conner Ohnesorge 2024-11-13T12:20:08-06:00 updated-configurations-for-lsp-and-firther-simplified-stage_idex
--      Conner Ohnesorge 2024-11-13T10:12:57-06:00 save-stage-progess
--      Conner Ohnesorge 2024-11-11T14:08:03-06:00 added-generic-mux-muxNtM
--      Conner Ohnesorge 2024-11-11T10:14:52-06:00 added-forwarding-signals-to-stage_idex
--      Conner Ohnesorge 2024-11-11T09:04:24-06:00 remove-extraneous-semicolons-in-initial-declaration
--      Conner Ohnesorge 2024-11-11T09:03:17-06:00 added-stage-guide-and-finished-stage_idex-without-component-instantiations
--      Conner Ohnesorge 2024-11-11T08:29:19-06:00 final-version-of-the-header-program-with-tests-and-worked-on-the-stage_idex.vhd-file
--      Conner Ohnesorge 2024-11-07T09:51:12-06:00 progress-on-stage-2
-- </header>

library ieee;
use IEEE.STD_LOGIC_1164.all;
use IEEE.MATH_REAL.all;
use IEEE.NUMERIC_STD.all;

-- <entity>
-- inputs:
--      i_CLK
--      i_RST
--      i_WE
--      i_PC
--      i_PCplus4
--      i_PCplus4
--      i_Extended
--      i_RegDst
--      i_ALUOp
--      i_ALUSrc
--      i_Shamt
--      i_ForwardA
--      i_ForwardB
--      i_WriteData
--      i_DMem1
-- outputs:
--      o_ALU
--      o_Read1
--      o_Read2
--      o_BranchAddr
-- </entity>
entity stage_idex is
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
        i_RegDst : in std_logic;  -- Destination register from control unit.
        i_ALUOp  : in std_logic_vector(3 downto 0);  -- ALU operation from control unit.
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
        --= Instruction Signals [begin]
        i_Shamt      : in  std_logic_vector(4 downto 0);  -- 5-bit shift amount from instruction[10-6]

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

end entity;

architecture structure of stage_idex is

    component dffg_n is
        generic(N : integer := 32);
        port(i_CLK : in  std_logic;
             i_RST : in  std_logic;
             i_WrE : in  std_logic;
             i_D   : in  std_logic_vector(N-1 downto 0);
             o_Q   : out std_logic_vector(N-1 downto 0));
    end component;

    component mux_NtM is
        generic (
            INPUT_COUNT : integer := 2;
            DATA_WIDTH  : integer := 8
            );
        port (
            inputs : in  std_logic_vector((INPUT_COUNT*DATA_WIDTH)-1 downto 0);  -- Concatenated input buses
            sel    : in  std_logic_vector(integer(ceil(log2(real(INPUT_COUNT)))) - 1 downto 0);
            output : out std_logic_vector(DATA_WIDTH - 1 downto 0)
            );
    end component;

    component alu is
        port (
            CLK        : in  std_logic;                     -- Clock signal
            i_Data1    : in  std_logic_vector(31 downto 0);  -- 32-bit input data 1
            i_Data2    : in  std_logic_vector(31 downto 0);  -- 32-bit input data 2
            i_shamt    : in  std_logic_vector(4 downto 0);  -- 5-bit shift amount
            i_aluOp    : in  std_logic_vector(3 downto 0);  -- 4-bit ALU operation code
            o_F        : out std_logic_vector(31 downto 0);  -- 32-bit ALU result
            o_Overflow : out std_logic;                     -- Overflow flag
            o_Zero     : out std_logic  -- Zero flag
            );
    end component;

    -- see: https://github.com/user-attachments/assets/b31df788-32cf-48a5-a3ac-c44345cac682
    signal s_ALUOp       : std_logic_vector(3 downto 0);
    signal s_ALUOperand1 : std_logic_vector(31 downto 0);
    signal s_ALUOperand2 : std_logic_vector(31 downto 0);
    signal s_ALUSrc      : std_logic_vector(1 downto 0);
    signal s_Overflow    : std_logic;
    signal s_Zero        : std_logic;
    signal s_Rd          : std_logic_vector(4 downto 0);
    signal s_PC          : std_logic_vector(31 downto 0);
    signal s_PCplus4     : std_logic_vector(31 downto 0);
    signal s_Extended    : std_logic_vector(31 downto 0);
    signal s_shamt       : std_logic_vector(4 downto 0);
begin

    ----------------------------------------------------------------------state
    -- Common Stage Signals [begin]
    PC_reg : dffg_n
        generic map (N => 32)
        port map(
            i_CLK => i_CLK,             -- Clock input
            i_RST => i_RST,             -- Reset input
            i_WrE => i_WE,              -- Write enable input
            i_D   => i_PC,              -- Data value input
            o_Q   => s_PC               -- Data value output
            );

    PCplus4_reg : dffg_n
        generic map (N => 32)
        port map(
            i_CLK => i_CLK,
            i_RST => i_RST,
            i_WrE => i_WE,
            i_D   => i_PCplus4,
            o_Q   => s_PCplus4
            );

    WrAddr_reg : dffg_n  -- Destination write address for register file (rd)
        generic map (N => 5)
        port map(
            i_CLK => i_CLK,
            i_RST => i_RST,
            i_WrE => i_WE,
            i_D   => i_Read1(15 downto 11),  -- RD is bits[11-15] of I-bits
            o_Q   => s_Rd
            );

    Reg1_reg : dffg_n                   -- output of register file, output 1
        generic map (N => 32)
        port map(
            i_CLK => i_CLK,
            i_RST => i_RST,
            i_WrE => i_WE,
            i_D   => i_Read1,
            o_Q   => o_Read1
            );

    Reg2_reg : dffg_n                   -- output of register file, output 2
        generic map (N => 32)
        port map(
            i_CLK => i_CLK,
            i_RST => i_RST,
            i_WrE => i_WE,
            i_D   => i_Read2,
            o_Q   => o_Read2
            );

    ALUOperation_reg : dffg_n
        generic map (N => 4)
        port map(
            i_CLK => i_CLK,
            i_RST => i_RST,
            i_WrE => i_WE,
            i_D   => i_ALUOp,
            o_Q   => s_ALUOp
            );

    ALUSrc_reg : dffg_n
        generic map (N => 2)
        port map(
            i_CLK => i_CLK,             -- Clock input
            i_RST => i_RST,             -- Reset input
            i_WrE => i_WE,              -- Write enable input
            i_D   => i_ALUSrc,          -- Data value input
            o_Q   => s_ALUSrc           -- Data value output
            );

    ALUResult_reg : dffg_n
        generic map (N => 32)
        port map(
            i_CLK => i_CLK,
            i_RST => i_RST,
            i_WrE => i_WE,
            i_D   => o_ALU,
            o_Q   => o_ALU
            );

    SignExtend_reg : dffg_n
        generic map (N => 32)
        port map(
            i_CLK => i_CLK,
            i_RST => i_RST,
            i_WrE => i_WE,
            i_D   => i_Extended,
            o_Q   => s_Extended);

    Shamt_reg : dffg_n
        generic map (N => 5)
        port map(
            i_CLK => i_CLK,
            i_RST => i_RST,
            i_WrE => i_WE,
            i_D   => i_Shamt,
            o_Q   => s_shamt
            );

    ----------------------------------------------------------------------logic


    -- ForwardA & ForwardB determine 1st & 2nd alu operands respectively
    -- MuxInputs    -> {Source} -> {Explanation}
    -- ForwardA=00  -> ID/EX    -> operand from registerfile
    -- ForwardA=10  -> EX/MEM   -> operand is forwarded from prior alu result
    -- ForwardA=01  -> MEM/WB   -> operand is forwarded from dmem or earlier alu result
    -- ForwardB=00  -> ID/EX    -> operand from registerfile
    -- ForwardB=10  -> EX/MEM   -> operand is forwarded from prior alu result
    -- ForwardB=01  -> MEM/WB   -> operand is forwarded from dmem or earlier alu result
    ALU1Mux : mux_NtM
        generic map (
            INPUT_COUNT => 3,
            DATA_WIDTH  => 32
            )
        port map (
            inputs => i_Read1 & i_WriteData & i_DMem1,
            Sel    => i_ForwardA,
            output => s_ALUOperand1
            );

    ALU2Mux : mux_NtM
        generic map (
            INPUT_COUNT => 3,
            DATA_WIDTH  => 32
            )
        port map (
            inputs => i_Read2 & i_WriteData & i_DMem1,
            Sel    => i_ForwardB,
            output => s_ALUOperand2
            );

    -- RT & RD mux w/ i_RegDst selector
    IDEX_RegisterRd : mux_NtM
        generic map (
            INPUT_COUNT => 2,
            DATA_WIDTH  => 5
            )
        port map (
            -- inputs => i_Read1 & i_Read2 & i_WriteData & i_DMem1,
            inputs => i_Read1(20 downto 16) & i_Read1(15 downto 11),
            Sel(0) => i_RegDst,
            output => s_Rd
            );

    instALU : alu
        port map (
            CLK        => i_CLK,
            i_Data1    => s_ALUOperand1,
            i_Data2    => s_ALUOperand2,
            i_shamt    => s_shamt,
            i_aluOp    => s_ALUOp,
            o_F        => o_ALU,
            o_Overflow => s_Overflow,
            o_Zero     => s_Zero
            );

    -- Add 2x shifted extended value to PCplus4
    o_BranchAddr <= std_logic_vector(
        unsigned(std_logic_vector(shift_left(unsigned(i_Extended), 2))) + unsigned(i_PCplus4)
        );

end structure;
