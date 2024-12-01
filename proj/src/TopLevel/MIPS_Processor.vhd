-- <header>
-- Author(s): Kariniux, aidanfoss, Conner Ohnesorge
-- Name: proj/src/TopLevel/MIPS_Processor.vhd
-- Notes:
--      Kariniux 2024-11-21T09:09:28-06:00 Merge-pull-request-63-from-conneroisu-New_IFIDSTAGE
--      Kariniux 2024-11-21T09:04:48-06:00 pushing-pulling
--      aidanfoss 2024-11-21T08:24:27-06:00 MEMWB-stage-work-added-fixed-mux-declaration
--      Conner Ohnesorge 2024-11-07T08:35:18-06:00 run-manual-update-to-header-program-and-run-it
--      Conner Ohnesorge 2024-10-31T09:22:46-05:00 added-initial-new-from-toolflow
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;
library work;
use work.MIPS_types.all;


entity MIPS_Processor is
    generic(N : integer := DATA_WIDTH);
    port(iCLK      : in  std_logic;
         iRST      : in  std_logic;
         iInstLd   : in  std_logic;
         iInstAddr : in  std_logic_vector(N-1 downto 0);
         iInstExt  : in  std_logic_vector(N-1 downto 0);
         oALUOut   : out std_logic_vector(N-1 downto 0));  -- TODO: Hook this up to the output of the ALU. It is important for synthesis that you have this output that can effectively be impacted by all other components so they are not optimized away.
end MIPS_Processor;

architecture structure of MIPS_Processor is
    -- Required data memory signals
    signal s_DMemWr       : std_logic;  -- TODO: use this signal as the final active high data memory write enable signal
    signal s_DMemAddr     : std_logic_vector(N-1 downto 0);  -- TODO: use this signal as the final data memory address input
    signal s_DMemData     : std_logic_vector(N-1 downto 0);  -- TODO: use this signal as the final data memory data input
    signal s_DMemOut      : std_logic_vector(N-1 downto 0);  -- TODO: use this signal as the data memory output
    -- Required register file signals 
    signal s_RegWr        : std_logic;  -- TODO: use this signal as the final active high write enable input to the register file
    signal s_RegWrAddr    : std_logic_vector(4 downto 0);  -- TODO: use this signal as the final destination register address input
    signal s_RegWrData    : std_logic_vector(N-1 downto 0);  -- TODO: use this signal as the final data memory data input
    -- Required instruction memory signals
    signal s_IMemAddr     : std_logic_vector(N-1 downto 0);  -- Do not assign this signal, assign to s_NextInstAddr instead
    signal s_NextInstAddr : std_logic_vector(N-1 downto 0);  -- TODO: use this signal as your intended final instruction memory address input.
    signal s_Inst         : std_logic_vector(N-1 downto 0);  -- TODO: use this signal as the instruction signal 
    -- Required halt signal -- for simulation
    signal s_Halt         : std_logic;  -- TODO: this signal indicates to the simulation that intended program execution has completed. (Opcode: 01 0100)
    -- Required overflow signal -- for overflow exception detection
    signal s_Ovfl         : std_logic;  -- TODO: this signal indicates an overflow exception would have been initiated
    component mem is
        generic(ADDR_WIDTH : integer;
                DATA_WIDTH : integer);
        port(
            clk  : in  std_logic;
            addr : in  std_logic_vector((ADDR_WIDTH-1) downto 0);
            data : in  std_logic_vector((DATA_WIDTH-1) downto 0);
            we   : in  std_logic := '1';
            q    : out std_logic_vector((DATA_WIDTH -1) downto 0));
    end component;

--    component MEM_WB is
--        generic(ADDR_WIDTH : integer;
--                DATA_WIDTH : integer);
--        port (
--            clk     : in std_logic;
--            reset   : in std_logic;
--            WriteEn : in std_logic;         -- Write enable signal
--    
--    
--            ALU_result_in : in std_logic_vector(31 downto 0);  -- ALU result to WB
--            DataMem_in    : in std_logic_vector(31 downto 0);
--            RegDst_in     : in std_logic_vector(4 downto 0);  -- Destination register number to Register File
--            RegWrite_in   : in std_logic;
--            MemToReg_in   : in std_logic;
--    
--            -- Outputs to WB stage
--            ALU_result_out: out std_logic_vector(31 downto 0);  -- ALU result to WB
--            DataMem_out   : out std_logic_vector(31 downto 0);
--            RegDst_out    : out std_logic_vector(4 downto 0); -- Destination reguster number to register file
--            RegWrite_out  : out std_logic;
--            MemToReg_out  : out std_logic
--        );
--    end component;

    component ID_EX is

    port (
        -- Common Stage Signals [begin]
        i_CLK       : in  std_logic;
        i_RST       : in  std_logic;
        i_WE        : in  std_logic;
        i_PC        : in  std_logic_vector(N-1 downto 0);
        -- Control Signals (From Control Unit) [begin]
        --= Stage Specific Signals [begin]
        --         RegDst  ALUOp  ALUSrc
        -- R-Type:   1      10      00
        -- lw    :   0      00      01
        -- sw    :   x      00      01
        -- beq   :   x      01      00
        i_RegDst    : in  std_logic;    -- Control Unit Destination Register
        i_ALUOp     : in  std_logic_vector(2 downto 0);  -- ALU operation from control unit.
        i_ALUSrc    : in  std_logic_vector(1 downto 0);  -- ALU source from control unit.
        i_MemRead   : in  std_logic;    -- Memory Read control
        i_MemWrite  : in  std_logic;    -- Memory Write control
        i_MemtoReg  : in  std_logic;    -- Memory to Register control
        i_RegWrite  : in  std_logic;    -- Register Write control
        i_Branch    : in  std_logic;    -- Branch control
        -- Future Stage Signals [begin]
        -- see: https://private-user-images.githubusercontent.com/88785126/384028866-8e8d5e84-ca22-462e-8b85-ea1c00c43e8f.png
        o_ALU       : out std_logic_vector(N-1 downto 0);
        o_ALUSrc    : out std_logic_vector(1 downto 0);
        o_MemRead   : out std_logic;
        o_MemWrite  : out std_logic;
        o_MemtoReg  : out std_logic;
        o_RegWrite  : out std_logic;
        o_Branch    : out std_logic;
        -- Input Signals [begin]
        --= Register File Signals [begin]
        i_Read1     : in  std_logic_vector(N-1 downto 0);
        i_Read2     : in  std_logic_vector(N-1 downto 0);
        o_Read1     : out std_logic_vector(N-1 downto 0);
        o_Read2     : out std_logic_vector(N-1 downto 0);
        -- Forward Unit Signals [begin]
        --= Forwarded Signals (received from Forward Unit) [begin]
        -- ForwardA & ForwardB determine 1st & 2nd alu operands respectively
        -- MuxInputs    -> {Source} -> {Explanation}
        -- ForwardA=00  -> ID/EX    -> operand from registerfile
        -- ForwardA=10  -> EX/MEM   -> operand forwarded from prior alu result
        -- ForwardA=01  -> MEM/WB   -> operand forwarded from dmem or earlier alu result
        -- ForwardB=00  -> ID/EX    -> operand from registerfile
        -- ForwardB=10  -> EX/MEM   -> operand forwarded from prior alu result
        -- ForwardB=01  -> MEM/WB   -> operand forwarded from dmem or earlier alu result
        i_ForwardA  : in  std_logic_vector(1 downto 0);
        i_ForwardB  : in  std_logic_vector(1 downto 0);
        --= Forwarding Signals (sent to Forward Unit) [begin]
        i_WriteData : in  std_logic_vector(N-1 downto 0);  -- Data from the end of writeback stage's mux
        i_DMem1     : in  std_logic_vector(N-1 downto 0);  -- Data from the first input to the DMem output of ex/mem
        --= Instruction Signals [begin]
        i_Rs        : in  std_logic_vector(4 downto 0);
        i_Rt        : in  std_logic_vector(4 downto 0);
        i_Rd        : in  std_logic_vector(4 downto 0);
        i_Shamt     : in  std_logic_vector(4 downto 0);
        i_Funct     : in  std_logic_vector(5 downto 0);
        i_Imm       : in  std_logic_vector(15 downto 0);
        i_Extended     : in  std_logic_vector(31 downto 0);
        o_BranchAddr   : out std_logic_vector(31 downto 0);
        -- Halt signals
        i_Halt      : in  std_logic_vector(0 downto 0);
        o_Halt      : out std_logic_vector(0 downto 0)
        );

    end component;
begin
    -- TODO: This is required to be your final input to your instruction memory. This provides a feasible method to externally load the memory module which means that the synthesis tool must assume it knows nothing about the values stored in the instruction memory. If this is not included, much, if not all of the design is optimized out because the synthesis tool will believe the memory to be all zeros.
    with iInstLd select
        s_IMemAddr <= s_NextInstAddr when '0',
        iInstAddr                    when others;
    IMem : mem
        generic map(ADDR_WIDTH => ADDR_WIDTH,
                    DATA_WIDTH => N)
        port map(clk  => iCLK,
                 addr => s_IMemAddr(11 downto 2),
                 data => iInstExt,
                 we   => iInstLd,
                 q    => s_Inst);
    DMem : mem
        generic map(ADDR_WIDTH => ADDR_WIDTH,
                    DATA_WIDTH => N)
        port map(clk  => iCLK,
                 addr => s_DMemAddr(11 downto 2),
                 data => s_DMemData,
                 we   => s_DMemWr,
                 q    => s_DMemOut);
--MemWB : MEM_WB --I think this entire block is instantiated wrong. Not sure entirely what this definition is doing here. Apologies
--    generic map(ADDR_WIDTH => ADDR_WIDTH,
--                DATA_WIDTH => N)
--    port map(clk => clk,
--             addr =>
--    )
-- TODO: Ensure that s_Halt is connected to an output control signal produced from decoding the Halt instruction (Opcode: 01 0100)
-- TODO: Ensure that s_Ovfl is connected to the overflow output of your ALU
-- TODO: Implement the rest of your processor below this comment! 
end structure;

