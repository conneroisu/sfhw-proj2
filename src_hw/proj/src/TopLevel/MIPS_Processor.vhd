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
    -- TODO: use s_DMemWr as the final active high data memory write enable signal
    -- TODO: use s_DMemAddr as the final data memory address input
    -- TODO: use s_DMemData as the final data memory data input
    -- TODO: use s_DMemOut as the data memory output
    -- TODO: use s_RegWr as the final active high write enable input to the register file
    -- TODO: use s_RegWrAddr as the final destination register address input
    -- TODO: use s_RegWrData as the final data memory data input
    -- TODO: use s_NextInstAddr as your intended final instruction memory address input.
    -- TODO: use s_Inst as the instruction signal 
    -- TODO: s_Halt indicates to the simulation that intended program execution has completed. (Opcode: 01 0100)
    -- TODO: s_Ovfl indicates an overflow exception would have been initiated

    -- TODO:Add EXMEM stage
    -- TODO:Add IFID stage
    -- TODO:Add Hazard Unit

    signal s_DMemWr       : std_logic;
    signal s_DMemAddr     : std_logic_vector(N-1 downto 0);
    signal s_DMemData     : std_logic_vector(N-1 downto 0);
    signal s_DMemOut      : std_logic_vector(N-1 downto 0);
    -- Required register file signals 
    signal s_RegWr        : std_logic;
    signal s_RegWrAddr    : std_logic_vector(4 downto 0);
    signal s_RegWrData    : std_logic_vector(N-1 downto 0);
    -- Required instruction memory signals
    signal s_IMemAddr     : std_logic_vector(N-1 downto 0);  -- Do not assign this signal, assign to s_NextInstAddr instead
    signal s_NextInstAddr : std_logic_vector(N-1 downto 0);
    signal s_Inst         : std_logic_vector(N-1 downto 0);
    -- Required halt signal -- for simulation
    signal s_Halt         : std_logic;
    -- Required overflow signal -- for overflow exception detection
    signal s_Ovfl         : std_logic;

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

    component Branch_Unit is
        port(
            i_CLK          : in  std_logic;
            i_RST          : in  std_logic;
            i_WriteEnable  : in  std_logic;
            i_BranchTarget : in  std_logic_vector(31 downto 0);  -- Target address
            i_BranchPC     : in  std_logic_vector(31 downto 0);  -- PC of branch instruction
            i_BranchTaken  : in  std_logic;  -- Actual branch outcome
            i_BranchValid  : in  std_logic;  -- Branch instruction is valid
            o_PredictTaken : out std_logic;  -- Prediction result
            o_BranchTarget : out std_logic_vector(31 downto 0);  -- Predicted target address
            o_Mispredict   : out std_logic   -- Misprediction signal
            );
    end component;

    component ID_EX is
        port (
            i_CLK        : in  std_logic;
            i_RST        : in  std_logic;
            i_WE         : in  std_logic;
            i_PC         : in  std_logic_vector(N-1 downto 0);
            i_RegDst     : in  std_logic;  -- Control Unit Destination Register
            i_ALUOp      : in  std_logic_vector(2 downto 0);  -- ALU operation from control unit.
            i_ALUSrc     : in  std_logic_vector(1 downto 0);  -- ALU source from control unit.
            i_MemRead    : in  std_logic;  -- Memory Read control
            i_MemWrite   : in  std_logic;  -- Memory Write control
            i_MemtoReg   : in  std_logic;  -- Memory to Register control
            i_RegWrite   : in  std_logic;  -- Register Write control
            i_Branch     : in  std_logic;  -- Branch control
            o_ALU        : out std_logic_vector(N-1 downto 0);
            o_ALUSrc     : out std_logic_vector(1 downto 0);
            o_MemRead    : out std_logic;
            o_MemWrite   : out std_logic;
            o_MemtoReg   : out std_logic;
            o_RegWrite   : out std_logic;
            o_Branch     : out std_logic;
            i_Read1      : in  std_logic_vector(N-1 downto 0);
            i_Read2      : in  std_logic_vector(N-1 downto 0);
            o_Read1      : out std_logic_vector(N-1 downto 0);
            o_Read2      : out std_logic_vector(N-1 downto 0);
            i_ForwardA   : in  std_logic_vector(1 downto 0);
            i_ForwardB   : in  std_logic_vector(1 downto 0);
            i_WriteData  : in  std_logic_vector(N-1 downto 0);  -- Data from the end of writeback stage's mux
            i_DMem1      : in  std_logic_vector(N-1 downto 0);  -- Data from the first input to the DMem output of ex/mem
            i_Rs         : in  std_logic_vector(4 downto 0);
            i_Rt         : in  std_logic_vector(4 downto 0);
            i_Rd         : in  std_logic_vector(4 downto 0);
            i_Shamt      : in  std_logic_vector(4 downto 0);
            i_Funct      : in  std_logic_vector(5 downto 0);
            i_Imm        : in  std_logic_vector(15 downto 0);
            i_Extended   : in  std_logic_vector(31 downto 0);
            o_BranchAddr : out std_logic_vector(31 downto 0)
            );
    end component;

    component MEM_WB is
        port (
            clk         : in  std_logic;
            reset       : in  std_logic;
            i_ALUResult : in  std_logic_vector(31 downto 0);  -- ALU result to WB
            i_DataMem   : in  std_logic_vector(31 downto 0);  -- Data from memory
            i_RegDst    : in  std_logic_vector(4 downto 0);  -- Destination register number
            i_RegWrite  : in  std_logic;
            i_MemToReg  : in  std_logic;  -- MUX select signal
            o_regDst    : out std_logic_vector(4 downto 0);  -- Destination register output
            o_regWrite  : out std_logic;  -- Write enable output
            o_wbData    : out std_logic_vector(31 downto 0)  -- Data to write back
            );
    end component;

    component adderSubtractor is
        generic
            (N : integer := 32);
        port (
            nAdd_Sub : in  std_logic;  ------------------------- 0 for add, 1 for subtract
            i_S      : in  std_logic;  ------------------------- signed or unsigned operations
            i_A      : in  std_logic_vector(N - 1 downto 0);  -- input a
            i_B      : in  std_logic_vector(N - 1 downto 0);  -- input b
            o_Y      : out std_logic_vector(N - 1 downto 0);  -- output y
            o_Cout   : out std_logic    ------------------------ carry out
            );
    end component;

    signal s_ALUOp      : std_logic_vector(2 downto 0);
    signal s_ALUSrc     : std_logic_vector(1 downto 0);
    signal s_MemRead    : std_logic;
    signal s_MemWrite   : std_logic;
    signal s_MemtoReg   : std_logic;
    signal s_Branch     : std_logic;
    signal s_ALUOut     : std_logic_vector(N-1 downto 0);
    signal s_RegFile1   : std_logic_vector(N-1 downto 0);
    signal s_RegFile2   : std_logic_vector(N-1 downto 0);
    signal s_ForwardA   : std_logic_vector(1 downto 0);
    signal s_ForwardB   : std_logic_vector(1 downto 0);
    signal s_WriteData  : std_logic_vector(N-1 downto 0);
    signal s_Rs         : std_logic_vector(4 downto 0);
    signal s_Rt         : std_logic_vector(4 downto 0);
    signal s_Rd         : std_logic_vector(4 downto 0);
    signal s_Shamt      : std_logic_vector(4 downto 0);
    signal s_Funct      : std_logic_vector(5 downto 0);
    signal s_Imm        : std_logic_vector(15 downto 0);
    signal s_Extended   : std_logic_vector(31 downto 0);
    signal s_BranchAddr : std_logic_vector(31 downto 0);
    signal s_nilb   : std_logic;
begin
    with iInstLd select
        s_IMemAddr <= s_NextInstAddr when '0',
        iInstAddr                    when others;
    IMem : mem
        generic map(ADDR_WIDTH => 32,
                    DATA_WIDTH => N)
        port map(clk  => iCLK,
                 addr => s_IMemAddr(11 downto 2),
                 data => iInstExt,
                 we   => iInstLd,
                 q    => s_Inst);
    DMem : mem
        generic map(ADDR_WIDTH => 32,
                    DATA_WIDTH => N)
        port map(clk  => iCLK,
                 addr => s_DMemAddr(11 downto 2),
                 data => s_DMemData,
                 we   => s_DMemWr,
                 q    => s_DMemOut);

    instPCPlus4 : adderSubtractor
        generic map(N => 32)
        port map('1', '0', s_IMemAddr, x"00000004", s_PCPlusFour, s_nilb);

    instIDEX : ID_EX
        port map(
            i_CLK        => iCLK,
            i_RST        => iRST,
            i_WE         => iInstLd,
            i_PC         => s_NextInstAddr,
            i_RegDst     => s_RegWrAddr(4),
            i_ALUOp      => s_ALUOp,
            i_ALUSrc     => s_ALUSrc,
            i_MemRead    => s_MemRead,
            i_MemWrite   => s_MemWrite,
            i_MemtoReg   => s_MemtoReg,
            i_RegWrite   => s_RegWr,
            i_Branch     => s_Branch,
            o_ALU        => s_ALUOut,
            o_ALUSrc     => s_ALUSrc,
            o_MemRead    => s_MemRead,
            o_MemWrite   => s_MemWrite,
            o_MemtoReg   => s_MemtoReg,
            o_RegWrite   => s_RegWr,
            o_Branch     => s_Branch,
            i_Read1      => s_RegFile1,
            i_Read2      => s_RegFile2,
            o_Read1      => s_RegFile1,
            o_Read2      => s_RegFile2,
            i_ForwardA   => s_ForwardA,
            i_ForwardB   => s_ForwardB,
            i_WriteData  => s_WriteData,
            i_DMem1      => s_DMemOut,
            i_Rs         => s_Rs,
            i_Rt         => s_Rt,
            i_Rd         => s_Rd,
            i_Shamt      => s_Shamt,
            i_Funct      => s_Funct,
            i_Imm        => s_Imm,
            i_Extended   => s_Extended,
            o_BranchAddr => s_BranchAddr
            );

    instMemWB : MEM_WB
        port map(
            clk         => iCLK,
            reset       => iRST,
            i_ALUResult => s_ALUOut,
            i_DataMem   => s_DMemOut,
            i_RegDst    => s_RegFile1,
            i_RegWrite  => s_RegWr,
            i_MemToReg  => s_MemtoReg,
            o_regDst    => s_RegFile2,
            o_regWrite  => s_RegWr,
            o_wbData    => s_WriteData
            );


-- TODO: Ensure that s_Halt is connected to an output control signal produced from decoding the Halt instruction (Opcode: 01 0100)
-- TODO: Ensure that s_Ovfl is connected to the overflow output of your ALU
-- TODO: Implement the rest of your processor below this comment! 
end structure;
