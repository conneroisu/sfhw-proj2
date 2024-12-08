-- <header>
-- Author(s): Conner Ohnesorge, connerohnesorge
-- Name: 
-- Notes:
--      Conner Ohnesorge 2024-12-07T17:08:05-06:00 fixed-messed-up-formatting
--      Conner Ohnesorge 2024-12-06T18:45:55-06:00 latest
--      Conner Ohnesorge 2024-12-06T18:43:09-06:00 putback
--      Conner Ohnesorge 2024-12-06T18:40:53-06:00 remove-shiftType
--      Conner Ohnesorge 2024-12-06T18:39:36-06:00 put-back
--      Conner Ohnesorge 2024-12-06T18:38:05-06:00 latest
--      Conner Ohnesorge 2024-12-06T18:36:46-06:00 latest
--      Conner Ohnesorge 2024-12-06T18:35:45-06:00 fix-missing
--      Conner Ohnesorge 2024-12-06T18:34:10-06:00 latest
--      Conner Ohnesorge 2024-12-06T18:25:58-06:00 latest
--      Conner Ohnesorge 2024-12-06T18:22:08-06:00 removed-unused-signals-and-added-comment-table-for-std_logic-signals
--      Conner Ohnesorge 2024-12-06T17:43:11-06:00 implify-signal-names
--      Conner Ohnesorge 2024-12-06T17:41:17-06:00 latest
--      Conner Ohnesorge 2024-12-06T17:41:01-06:00 remove-unused-signals
--      Conner Ohnesorge 2024-12-06T17:29:46-06:00 finished-32-bit-signals-comment-table
--      Conner Ohnesorge 2024-12-06T16:30:20-06:00 added-even-more-consumed-produced-signals-comments
--      Conner Ohnesorge 2024-12-06T16:26:20-06:00 dded-more-consumed-and-produced-signals-comments
--      Conner Ohnesorge 2024-12-06T11:13:04-06:00 ensure-complience-with-styleguide-for-ControlUnit
--      Conner Ohnesorge 2024-12-06T11:09:43-06:00 remove-unused-signal
--      Conner Ohnesorge 2024-12-06T11:04:08-06:00 ensure-adherence-to-coding-style-in-ALU
--      Conner Ohnesorge 2024-12-06T11:02:18-06:00 ensure-adherence-to-coding-style-for-Pipeline_MEM_WB
--      Conner Ohnesorge 2024-12-06T10:58:38-06:00 ensure-codestyle-adherence
--      connerohnesorge 2024-12-06T08:26:15-06:00 remove-s_j-from-MIPS_Processor-and-o_J-from-ControlUnit
--      connerohnesorge 2024-12-06T08:12:54-06:00 Update-ID_EX-to-be-compatible-with-the-style-guide
--      connerohnesorge 2024-12-06T07:22:29-06:00 update-IFID-stage-to-better-fit-style-guide
--      connerohnesorge 2024-12-06T07:20:56-06:00 Ensure-style-guidelines-are-followed-with-registerfile-and-update-it-s-interface-in-the-processor
--      connerohnesorge 2024-12-06T07:09:52-06:00 remove-doubly-passed-in-signal-to-FetchUnit
--      connerohnesorge 2024-12-06T05:10:07-06:00 better-component-hierarchy
--      connerohnesorge 2024-12-05T22:44:28-06:00 better-name-AluOrMem-signal
--      connerohnesorge 2024-12-05T08:56:15-06:00 rename-true-instruction-signal-name
--      connero 2024-12-05T08:15:06-06:00 Merge-pull-request-89-from-conneroisu-ConnerOhnesorge
--      Conner Ohnesorge 2024-12-05T08:10:41-06:00 update-register-file-instance-name
--      connerohnesorge 2024-12-04T23:20:24-06:00 add-new-line-in-port-map
--      connerohnesorge 2024-12-04T20:56:05-06:00 finish-presentation-of-pipeline-stages-in-both-hardware-and-software-implementations-and-make-sure-adherence-to-styleguide
--      connerohnesorge 2024-12-04T18:19:40-06:00 finish-cleaning-up-signal-names-in-harware-implementation
--      connerohnesorge 2024-12-04T17:45:56-06:00 even-better-instancen-names-for-the-hardware-implementation
--      connerohnesorge 2024-12-04T17:15:31-06:00 Organize-EXMEM-ports
--      Conner Ohnesorge 2024-12-04T07:52:56-06:00 update-register-file-name
--      Conner Ohnesorge 2024-12-04T07:44:46-06:00 updated-the-software-pipeline-to-use-the-simplified-contgrol-flow
--      Conner Ohnesorge 2024-12-04T07:19:40-06:00 more-clear-names-for-outputs-of-rt-and-rd
--      Conner Ohnesorge 2024-12-04T07:10:31-06:00 fix-renamed-barrel-shift-instantiation
--      Conner Ohnesorge 2024-12-04T06:52:09-06:00 fix-cobinational-spikes-from-alu-in-MIPS_Processor
--      Conner Ohnesorge 2024-12-04T05:13:48-06:00 optimizat-control-unit-for-performance
--      Conner Ohnesorge 2024-12-04T05:11:39-06:00 fix-the-captialization-of-s_WBMemOut
--      Conner Ohnesorge 2024-12-04T05:08:52-06:00 remove-unused-signal
--      Conner Ohnesorge 2024-12-04T00:49:07-06:00 latest
--      Conner Ohnesorge 2024-12-03T23:27:02-06:00 fix-register-file-declaration-in-MIPS_Processor.vhd
--      Conner Ohnesorge 2024-12-03T22:44:31-06:00 fix-type-in-extender16t32-ports
--      Conner Ohnesorge 2024-12-03T22:40:49-06:00 fixed-duplicate-mux2t1
--      Conner Ohnesorge 2024-12-03T22:26:29-06:00 better-spacing-as-per-style-guide
--      Conner Ohnesorge 2024-12-03T22:20:11-06:00 minimized-signal-declarations-of-MIPS_Processor
--      Conner Ohnesorge 2024-12-03T22:08:36-06:00 save-progress
--      Conner Ohnesorge 2024-12-02T15:00:49-06:00 added-missing-signals-for-each-stage-of-the-pipeline
--      Conner Ohnesorge 2024-12-01T22:55:31-06:00 add-daniels-changes
--      Conner Ohnesorge 2024-12-01T22:07:38-06:00 remove-forward-unit-todo
--      Conner Ohnesorge 2024-12-01T22:07:21-06:00 add-branch-and-forward-unit
--      Conner Ohnesorge 2024-12-01T21:53:08-06:00 rename-plus-four-adder
--      Conner Ohnesorge 2024-12-01T21:52:12-06:00 congegate-todos
--      Conner Ohnesorge 2024-12-01T21:46:13-06:00 simplify-port-map-of-program-counter
--      Conner Ohnesorge 2024-12-01T21:45:18-06:00 simplify-given-imem-and-dmem-ports
--      Conner Ohnesorge 2024-12-01T21:44:40-06:00 added-program-counter
--      Conner Ohnesorge 2024-12-01T21:42:22-06:00 futher-clean-up
--      Conner Ohnesorge 2024-12-01T21:41:58-06:00 clean-up
--      Conner Ohnesorge 2024-12-01T21:40:05-06:00 add-adderSubtractor-component-and-pc-plus-four-adder
--      Conner Ohnesorge 2024-12-01T21:35:46-06:00 move-todos-to-top-of-file
--      Conner Ohnesorge 2024-12-01T21:31:02-06:00 added-MEM_WB-to-MIPS_Processor
--      Conner Ohnesorge 2024-12-01T21:05:54-06:00 remove-halt-from-ID_EX-declaration
--      Conner Ohnesorge 2024-12-01T21:02:53-06:00 remove-halt-signals-from-id_ex
--      Conner Ohnesorge 2024-12-01T14:49:11-06:00 added-branch-unit-declaration-to-processor
--      Conner Ohnesorge 2024-12-01T12:19:14-06:00 moved-all-files-into-the-hardware-directory
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;

library work;
use work.MIPS_types.all;

entity MIPS_Processor is
    generic (N : integer := DATA_WIDTH);
    port (
        iCLK      : in  std_logic;
        iRST      : in  std_logic;
        iInstLd   : in  std_logic;
        iInstAddr : in  std_logic_vector(N - 1 downto 0);
        iInstExt  : in  std_logic_vector(N - 1 downto 0);
        oALUOut   : out std_logic_vector(N - 1 downto 0)
        );
end MIPS_Processor;

architecture structure of MIPS_Processor is
    signal s_DMemWr       : std_logic;
    signal s_DMemAddr     : std_logic_vector(N - 1 downto 0);
    signal s_DMemData     : std_logic_vector(N - 1 downto 0);
    signal s_DMemOut      : std_logic_vector(N - 1 downto 0);
    signal s_RegWr        : std_logic;
    signal s_RegWrAddr    : std_logic_vector(4 downto 0);
    signal s_RegWrData    : std_logic_vector(N - 1 downto 0);
    signal s_IMemAddr     : std_logic_vector(N - 1 downto 0);  -- Do not assign this signal, assign to s_NextInstAddr instead
    signal s_NextInstAddr : std_logic_vector(N - 1 downto 0);
    signal s_Inst         : std_logic_vector(N - 1 downto 0);
    signal s_Halt         : std_logic;
    signal s_Ovfl         : std_logic;

    component RegisterFile is
        port (
            i_CLK         : in  std_logic;  -- Clock input
            i_WriteAddr   : in  std_logic_vector(4 downto 0);  -- Write address input
            i_WriteData   : in  std_logic_vector(31 downto 0);  -- Write data input
            i_WriteEnable : in  std_logic;  -- Write enable input
            i_ReadAddr1   : in  std_logic_vector(4 downto 0);  -- Read address 1 input
            i_ReadAddr2   : in  std_logic_vector(4 downto 0);  -- Read address 2 input
            i_Reset       : in  std_logic;  -- Reset input
            o_ReadData1   : out std_logic_vector(31 downto 0);  -- Read data 1 output
            o_ReadData2   : out std_logic_vector(31 downto 0)  -- Read data 2 output
            );
    end component;

    component IF_ID is
        port (
            i_CLK         : in  std_logic;
            i_RST         : in  std_logic;
            i_Stall       : in  std_logic;
            i_PC4         : in  std_logic_vector(31 downto 0);
            i_Instruction : in  std_logic_vector(31 downto 0);
            o_PC4         : out std_logic_vector(31 downto 0);
            o_Instruction : out std_logic_vector(31 downto 0)
            );
    end component;

    component ID_EX is
        port (
            i_CLK               : in  std_logic;
            i_Reset             : in  std_logic;
            i_Stall             : in  std_logic;
            i_PC4               : in  std_logic_vector(31 downto 0);
            i_RegisterFileReadA : in  std_logic_vector(31 downto 0);
            i_RegisterFileReadB : in  std_logic_vector(31 downto 0);
            i_ImmediateExtended : in  std_logic_vector(31 downto 0);
            i_IDRt              : in  std_logic_vector(4 downto 0);
            i_IDRd              : in  std_logic_vector(4 downto 0);
            i_RegDst            : in  std_logic;
            i_RegWrite          : in  std_logic;
            i_MemToReg          : in  std_logic;
            i_MemWrite          : in  std_logic;
            i_ALUSrc            : in  std_logic;
            i_ALUOp             : in  std_logic_vector(3 downto 0);
            i_Jal               : in  std_logic;
            i_Halt              : in  std_logic;
            i_RS                : in  std_logic_vector(4 downto 0);
            i_MEMRd             : in  std_logic;
            o_RS                : out std_logic_vector(4 downto 0);
            o_PC4               : out std_logic_vector(31 downto 0);
            o_RegisterFileReadA : out std_logic_vector(31 downto 0);
            o_RegisterFileReadB : out std_logic_vector(31 downto 0);
            o_ImmediateExtended : out std_logic_vector(31 downto 0);
            o_Rt                : out std_logic_vector(4 downto 0);  -- [20-16]
            o_Rd                : out std_logic_vector(4 downto 0);  -- [15-11]
            o_RegDst            : out std_logic;
            o_RegWrite          : out std_logic;
            o_memToReg          : out std_logic;
            o_MemWrite          : out std_logic;
            o_ALUSrc            : out std_logic;
            o_ALUOp             : out std_logic_vector(3 downto 0);
            o_Jal               : out std_logic;
            o_Halt              : out std_logic;
            o_MEMRd             : out std_logic
            );
    end component;

    component EX_MEM is
        port (
            i_CLK      : in  std_logic;
            i_RST      : in  std_logic;
            i_stall    : in  std_logic;
            i_ALU      : in  std_logic_vector(31 downto 0);
            i_B        : in  std_logic_vector(31 downto 0);
            i_WrAddr   : in  std_logic_vector(4 downto 0);
            i_MemWr    : in  std_logic;
            i_MemtoReg : in  std_logic;
            i_Halt     : in  std_logic;
            i_RegWr    : in  std_logic;
            i_Jal      : in  std_logic;
            i_PC4      : in  std_logic_vector(31 downto 0);
            o_ALU      : out std_logic_vector(31 downto 0);
            o_B        : out std_logic_vector(31 downto 0);
            o_WrAddr   : out std_logic_vector(4 downto 0);
            o_MemWr    : out std_logic;
            o_MemtoReg : out std_logic;
            o_Halt     : out std_logic;
            o_RegWr    : out std_logic;
            o_Jal      : out std_logic;
            o_PC4      : out std_logic_vector(31 downto 0)
            );

    end component;

    component MEM_WB is
        port (
            i_CLK      : in  std_logic;
            i_RST      : in  std_logic;
            i_stall    : in  std_logic;
            i_ALU      : in  std_logic_vector(31 downto 0);
            i_Mem      : in  std_logic_vector(31 downto 0);
            i_WrAddr   : in  std_logic_vector(4 downto 0);
            i_MemtoReg : in  std_logic;
            i_Halt     : in  std_logic;
            i_RegWr    : in  std_logic;
            i_Jal      : in  std_logic;
            i_PC4      : in  std_logic_vector(31 downto 0);
            o_ALU      : out std_logic_vector(31 downto 0);
            o_Mem      : out std_logic_vector(31 downto 0);
            o_WrAddr   : out std_logic_vector(4 downto 0);
            o_MemtoReg : out std_logic;
            o_Halt     : out std_logic;
            o_RegWr    : out std_logic;
            o_Jal      : out std_logic;
            o_PC4      : out std_logic_vector(31 downto 0)
            );
    end component;

    component ALU is
        generic (N : integer := 32);
        port (
            i_A        : in  std_logic_vector(N - 1 downto 0);
            i_B        : in  std_logic_vector(N - 1 downto 0);
            i_ALUOP    : in  std_logic_vector(3 downto 0);
            i_Shamt    : in  std_logic_vector(4 downto 0);
            o_Result   : out std_logic_vector(N - 1 downto 0);
            o_CarryOut : out std_logic;
            o_Overflow : out std_logic;
            o_Zero     : out std_logic
            );
    end component;

    component Full_Adder_N is
        port (
            i_A        : in  std_logic_vector(N - 1 downto 0);
            i_B        : in  std_logic_vector(N - 1 downto 0);
            i_C        : in  std_logic;
            o_S        : out std_logic_vector(N - 1 downto 0);
            o_C        : out std_logic;
            o_Overflow : out std_logic
            );
    end component;

    component FetchUnit is
        port (
            i_PC4          : in  std_logic_vector(N - 1 downto 0);
            i_BranchAddr   : in  std_logic_vector(N - 1 downto 0);
            i_JumpAddr     : in  std_logic_vector(N - 1 downto 0);
            i_A            : in  std_logic_vector(N - 1 downto 0);
            i_B            : in  std_logic_vector(N - 1 downto 0);
            i_Jr           : in  std_logic;
            i_Branch       : in  std_logic;
            i_Bne          : in  std_logic;
            i_Jump         : in  std_logic;
            o_PC           : out std_logic_vector(N - 1 downto 0);
            o_JumpOrBranch : out std_logic
            );
    end component;

    component ControlUnit is
        port (
            i_OpCode    : in  std_logic_vector(5 downto 0);  --MIPS instruction opcode (6 bits wide)
            i_Funct     : in  std_logic_vector(5 downto 0);  --MIPS instruction function code (6 bits wide) used for R-Type instructions
            o_RegDst    : out std_logic;
            o_RegWrite  : out std_logic;
            o_MemToReg  : out std_logic;
            o_MemWrite  : out std_logic;
            o_ALUSrc    : out std_logic;
            o_ALUOp     : out std_logic_vector(3 downto 0);
            o_Signed    : out std_logic;
            o_shiftType : out std_logic;
            o_Bne       : out std_logic;
            o_Beq       : out std_logic;
            o_Jr        : out std_logic;
            o_Jal       : out std_logic;
            o_Branch    : out std_logic;
            o_Jump      : out std_logic;
            o_Lui       : out std_logic;
            o_Halt      : out std_logic
            );
    end component;

    component ForwardUnit is
        port (
            i_EX_rs     : in  std_logic_vector(4 downto 0);
            i_EX_rt     : in  std_logic_vector(4 downto 0);
            i_MEM_rd    : in  std_logic_vector(4 downto 0);
            i_WB_rd     : in  std_logic_vector(4 downto 0);
            i_MEM_wb    : in  std_logic;
            i_WB_wb     : in  std_logic;
            o_Forward_A : out std_logic_vector(1 downto 0);
            o_Forward_B : out std_logic_vector(1 downto 0)
            );
    end component;

    component HazardUnit is
        port (
            i_jump_ID   : in  std_logic;  --Control Hazard
            i_branch_ID : in  std_logic;  --Control Hazard
            i_rAddrA    : in  std_logic_vector(4 downto 0);  --Data Hazard
            i_rAddrB    : in  std_logic_vector(4 downto 0);  --Data Hazard
            i_wAddr_ID  : in  std_logic_vector(4 downto 0);  -- Write Address for ID
            i_wAddr_EX  : in  std_logic_vector(4 downto 0);  -- Write Address for MEM
            i_wE_ID     : in  std_logic;  -- Write enable for ID
            i_wE_EX     : in  std_logic;  -- Write enable for MEM
            o_stall     : out std_logic;
            o_flush     : out std_logic
            );
    end component;

    component mem is
        generic (ADDR_WIDTH, DATA_WIDTH : integer);
        port (
            clk  : in  std_logic;
            addr : in  std_logic_vector((ADDR_WIDTH - 1) downto 0);
            data : in  std_logic_vector((DATA_WIDTH - 1) downto 0);
            we   : in  std_logic := '1';
            q    : out std_logic_vector((DATA_WIDTH - 1) downto 0)
            );
    end component;

    component extender16t32 is
        port(
            i_I : in  std_logic_vector(15 downto 0);  -- 16 bit immediate
            i_C : in  std_logic;        -- signed extender or unsigned
            o_O : out std_logic_vector(31 downto 0)  -- 32 bit extended immediate
            );
    end component;

    component mux2t1_N is
        generic (N : integer);
        port (
            i_S  : in  std_logic;
            i_D0 : in  std_logic_vector(N - 1 downto 0);
            i_D1 : in  std_logic_vector(N - 1 downto 0);
            o_O  : out std_logic_vector(N - 1 downto 0)
            );
    end component;

    component mux2t1 is
        port (
            i_S  : in  std_logic;
            i_D0 : in  std_logic;
            i_D1 : in  std_logic;
            o_O  : out std_logic
            );
    end component;

    component dffg_N is
        port (
            i_CLK : in  std_logic;                      -- Clock input
            i_RST : in  std_logic;                      -- Reset input
            i_WE  : in  std_logic;                      -- Write enable input
            i_D   : in  std_logic_vector(31 downto 0);  -- Data value input
            o_Q   : out std_logic_vector(31 downto 0)
            );
    end component;

    component mux4t1_N is
        generic (N : integer := 32);
        port (
            i_S  : in  std_logic_vector(1 downto 0);
            i_D0 : in  std_logic_vector(N - 1 downto 0);
            i_D1 : in  std_logic_vector(N - 1 downto 0);
            i_D2 : in  std_logic_vector(N - 1 downto 0);
            i_D3 : in  std_logic_vector(N - 1 downto 0);
            o_O  : out std_logic_vector(N - 1 downto 0)
            );
    end component;


    signal s_ForwardA_sel, s_ForwardB_sel : std_logic_vector(1 downto 0);
    signal s_ALUOp, s_EXALUOp             : std_logic_vector(3 downto 0);

    signal s_EX_rs, s_EXrt, s_EXrd, s_EXrtrd : std_logic_vector(4 downto 0);
    signal s_rtrd, s_MEMrtrd, s_WBrtrd       : std_logic_vector(4 downto 0);

    signal /*  --------------|-FROM-------------|-TO----------------------------------------------------------------------------------------| */
        s_RegisterFileA, /* | instRegisterFile | instFetchUnit, instIDEX  ------------------------------------------------------------------| */
        s_RegisterFileB, /* | instRegisterFile | instFetchUnit, instIDEX  ------------------------------------------------------------------| */
        s_IFPC4, /*  --------| instPC4Adder ----| instIFID, instNXTPC ----------------------------------------------------------------------| */
        s_EXPC4, /*  --------| instIDEX --------| instEXMEM, instWBMux ---------------------------------------------------------------------| */
        s_MEMPC4, /*  -------| instEXMEM -------| instMEMWB --------------------------------------------------------------------------------| */
        s_WBPC4, /*  --------| instMEMWB -------| instRegAddrMux ---------------------------------------------------------------------------| */
        s_PC, /*  -----------| instFetchUnit ---| instNXTPC --------------------------------------------------------------------------------| */
        s_PCR, /*  ----------| instRSTPC -------| instPC -----------------------------------------------------------------------------------| */
        s_nextPC, /*  -------| instPC ----------| instRSTPC --------------------------------------------------------------------------------| */
        s_immediate, /*  ----| extender16t32 ---| instIDEX, instFetchUnit ------------------------------------------------------------------| */
        s_ALUB, /*  ---------| instImmMux ------| instALU ----------------------------------------------------------------------------------| */
        s_AluOrMem, /*  -----| instMemToRegMux -| instRegAddrMux ---------------------------------------------------------------------------| */
        s_IDInstruction, /* | instIFID  --------| instRegisterFile, instControlUnit, instFetchUnit, instSignExtend, instIDEX, instHazardUnit| */
        s_IDPC4, /*  --------| instIFID --------| instFetchUnit, instIDEX ------------------------------------------------------------------| */
        s_EXA, /*  ----------| instIDEX --------| instForwardAMux --------------------------------------------------------------------------| */
        s_EXB, /*  ----------| instIDEX --------| instForwardBMux --------------------------------------------------------------------------| */
        s_EXImmediate, /*  --| instIDEX --------| instImmMux, instALU ----------------------------------------------------------------------| */
        s_ALUOut, /*  -------| instALU ---------| oALUOut, instEXMEM -----------------------------------------------------------------------| */
        s_MEMALU, /*  -------| instEXMEM -------| s_DMemAddr, instMEMWB, instForwardAMux, instForwardBMux ----------------------------------| */
        s_WBALU, /*  --------| instMEMWB -------| instMemToRegMux --------------------------------------------------------------------------| */
        s_WBMEMOut, /*  -----| instWBMEM -------| instMemToRegMux --------------------------------------------------------------------------| */
        s_ForwardA, /*  -----| instForwardAMux -| instALU ----------------------------------------------------------------------------------| */
        s_ForwardB, /*  -----| instForwardBMux -| instALU, instEXMEM -----------------------------------------------------------------------| */
        s_BasedInstruction /*| branchjumpMUX  --| instIFID ---------------------------------------------------------------------------------| */
        : std_logic_vector(31 downto 0);

    signal /*  ---------------|-FROM-------------------------------------------------------------------|*/
        s_JumpBranch, /*  ------|-instFetchunit---|-instNXTPC, instHazardUnit----------------------------|*/
        s_RegDst, /*  ----------|-instControlUnit-|-instIDEX---------------------------------------------|*/
        s_memToReg, /*  --------|-instControlUnit-|------------------------------------------------------|*/
        s_ALUSrc, /*  ----------|-instControlUnit-|-instIDEX---------------------------------------------|*/
        s_Jr, /*  --------------|-instControlUnit-|-instFetchUnit----------------------------------------|*/
        s_Jal, /*  -------------|-instControlUnit-|-instIDEX---------------------------------------------|*/
        s_NotClk, /*  ----------|-iCLK------------|-instRegisterFile-------------------------------------|*/
        s_Signed, /*  ----------|-instControlUnit-|-instSignExtend---------------------------------------|*/
        s_Bne, /*  -------------|-instControlUnit-|-instFetchUnit----------------------------------------|*/
        s_Branch, /*  ----------|-instFetchUnit---|-instControlUnit--------------------------------------|*/
        s_Jump, /*  ------------|-instControlUnit-|-instFetchUnit, instHazardUnit------------------------|*/
        s_WE, /*  --------------|-s_Stall---------|-instPC-----------------------------------------------|*/
        s_Stall, /*  -----------|-instHazardUnit--|-instIFID, instWBMux, instMEMRdMUX, s_WE--------------|*/
        s_Flush, /*  -----------|-instHazardUnit--|-s_ToFlush--------------------------------------------|*/
        s_ToFlush, /*  ---------|-----------------|------------------------------------------------------|*/
        s_muxRegWr, /*  --------|-instWBMux-------|-instIDEX---------------------------------------------|*/
        s_MuxMemWr, /*  --------|-instMEMRdMUX----|-instIDEX---------------------------------------------|*/
        s_CarryOut, /*  --------|-instALU---------|------------------------------------------------------|*/
        s_InternalOverflow, /*|  -----------------|------------------------------------------------------|*/
        s_IDhalt, /*  ----------|-----------------|------------------------------------------------------|*/
        s_IDMemWr, /*  ---------|-----------------|------------------------------------------------------|*/
        s_IDRegWr, /*  ---------|-----------------|------------------------------------------------------|*/
        s_ID_memRD, /*  --------|-----------------|------------------------------------------------------|*/
        s_EXRegDst, /*  --------|-----------------|------------------------------------------------------|*/
        s_EXRegWr, /*  ---------|-----------------|------------------------------------------------------|*/
        s_EXmemToReg, /*  ------|-----------------|------------------------------------------------------|*/
        s_EXMemWr, /*  ---------|-----------------|------------------------------------------------------|*/
        s_EXMemRd, /*  ---------|-----------------|------------------------------------------------------|*/
        s_EXALUSrc, /*  --------|-----------------|------------------------------------------------------|*/
        s_EXjal, /*  -----------|-----------------|------------------------------------------------------|*/
        s_EXhalt, /*  ----------|-instIDEX--------|-instEXMEM--------------------------------------------|*/
        s_MEMjal, /*  ----------|-instEXMEM-------|-instMEMWB--------------------------------------------|*/
        s_MEMMemToReg, /*  -----|-instEXMEM-------|-instMEMWB--------------------------------------------|*/
        s_MEMhalt, /*  ---------|-instEXMEM-------|-instMEMWB--------------------------------------------|*/
        s_MEMRegWr, /*  --------|-instEXMEM-------|------------------------------------------------------|*/
        s_WBjal, /*  -----------|-----------------|------------------------------------------------------|*/
        s_WBmemToReg, /*  ------|-instMEMWB-------|-instMemToRegMux--------------------------------------|*/
        s_WBRegWr, /*  ---------|-----------------|-instForwardingUnit-----------------------------------|*/
        s_Zero, /*  ------------|-----------------|------------------------------------------------------|*/
        s_ShiftType, /*  -------|-instControlUnit-|-<optimized-away>-------------------------------------|*/
        s_Lui, /*  -------------|-instControlUnit-|-<optimized-away>-------------------------------------|*/
        s_Beq, /*  -------------|-instControlUnit-|-<optimized-away>-------------------------------------|*/
        s_internal_CarryOut,
        s_internal_Overflow
        : std_logic;

begin
    with iInstLd select
        s_IMemAddr <= s_NextInstAddr when '0',
        iInstAddr                    when others;
    IMem : mem
        generic map(ADDR_WIDTH => ADDR_WIDTH, DATA_WIDTH => N)
        port map(iCLK, s_IMemAddr(11 downto 2), iInstExt, iInstLd, s_Inst);
    DMem : mem
        generic map(ADDR_WIDTH => ADDR_WIDTH, DATA_WIDTH => N)
        port map(iCLK, s_DMemAddr(11 downto 2), s_DMemData, s_DMemWr, s_DMemOut);

    s_DMemAddr  <= s_MEMALU;
    s_RegWr     <= s_WBRegWr;
    s_RegWrAddr <= s_WBrtrd;
    s_NotClk    <= not iCLK;

    instRegisterFile : RegisterFile
        port map(
            i_WriteData   => s_RegWrData,
            i_WriteAddr   => s_RegWrAddr,
            i_WriteEnable => s_RegWr,
            i_CLK         => s_NotClk,
            i_Reset       => iRST,
            i_ReadAddr1   => s_IDInstruction(25 downto 21),
            i_ReadAddr2   => s_IDInstruction(20 downto 16),
            o_ReadData1   => s_RegisterFileA,
            o_ReadData2   => s_RegisterFileB
            );

    instRtRdMux2t1_5 : mux2t1_N
        generic map(N => 5)
        port map(
            i_S  => s_EXRegDst,
            i_D0 => s_EXrt,
            i_D1 => s_EXrd,
            o_O  => s_rtrd
            );

    instExWriteMux2t1_5 : mux2t1_N
        generic map(N => 5)
        port map(
            i_S  => s_EXjal,
            i_D0 => s_rtrd,
            i_D1 => "11111",
            o_O  => s_EXrtrd
            );

    instControlUnit : ControlUnit
        port map(
            i_opCode    => s_IDInstruction(31 downto 26),
            i_funct     => s_IDInstruction(5 downto 0),
            o_RegDst    => s_RegDst,
            o_RegWrite  => s_IDRegWr,
            o_memToReg  => s_memToReg,
            o_memWrite  => s_IDMemWr,
            o_ALUSrc    => s_ALUSrc,
            o_ALUOp     => s_ALUOp,
            o_signed    => s_Signed,
            o_shiftType => s_ShiftType,
            o_bne       => s_Bne,
            o_beq       => s_Beq,
            o_jr        => s_Jr,
            o_jal       => s_Jal,
            o_branch    => s_Branch,
            o_jump      => s_Jump,
            o_lui       => s_Lui,
            o_halt      => s_IDhalt
            );

    instPC : dffg_N
        port map(
            i_CLK => iCLK,
            i_RST => '0',
            i_WE  => s_WE,
            i_D   => s_PCR,
            o_Q   => s_NextInstAddr
            );

    instRSTPC : mux2t1_N
        generic map(N => 32)
        port map(
            i_S  => iRST,
            i_D0 => s_nextPC,
            i_D1 => x"00400000",
            o_O  => s_PCR
            );

    instNXTPC : mux2t1_N
        generic map(N => 32)
        port map(
            i_S  => s_JumpBranch,
            i_D0 => s_IFPC4,
            i_D1 => s_PC,
            o_O  => s_nextPC
            );

    instFetchUnit : FetchUnit
        port map(
            i_PC4          => s_IDPC4,
            i_BranchAddr   => s_immediate,
            i_JumpAddr     => s_IDInstruction,
            i_Jr           => s_Jr,
            i_Branch       => s_Branch,
            i_Bne          => s_Bne,
            i_A            => s_RegisterFileA,
            i_B            => s_RegisterFileB,
            i_Jump         => s_Jump,
            o_PC           => s_PC,
            o_JumpOrBranch => s_JumpBranch
            );

    instSignExtend : extender16t32
        port map(
            i_C => s_Signed,
            i_I => s_IDInstruction(15 downto 0),
            o_O => s_immediate
            );

    instImmMux : mux2t1_N
        generic map(N => 32)
        port map(
            i_S  => s_EXALUSrc,
            i_D0 => s_ForwardB,
            i_D1 => s_EXImmediate,
            o_O  => s_ALUB
            );

    instALU : ALU
        generic map(N => 32)
        port map(
            i_A        => s_ForwardA,
            i_B        => s_ALUB,
            i_ALUOP    => s_EXALUOp,
            i_Shamt    => s_EXImmediate(10 downto 6),
            o_Result   => s_ALUOut,
            o_CarryOut => s_internal_CarryOut,
            o_Overflow => s_internal_Overflow,
            o_Zero     => s_Zero
            );

    instCarrFlowProc : process(iclk, irst, s_internal_CarryOut, s_internal_Overflow, s_CarryOut, s_Ovfl)
    begin
        if irst = '1' then
            s_CarryOut <= '0';
            s_Ovfl     <= '0';
        elsif rising_edge(iclk) then
            if s_internal_CarryOut = '1' then
                s_CarryOut <= '1';
            else
                s_CarryOut <= s_CarryOut;
            end if;
            if s_internal_Overflow = '1' then
                s_Ovfl <= '1';
            else
                s_Ovfl <= s_Ovfl;
            end if;
        end if;
    end process;

    oALUOut <= s_ALUOut;

    instMemToRegMux : mux2t1_N
        generic map(N => 32)
        port map(
            i_S  => s_WBmemToReg,
            i_D0 => s_WBALU,
            i_D1 => s_WBMEMOut,
            o_O  => s_AluOrMem
            );

    instRegAddrMux : mux2t1_N
        generic map(N => 32)
        port map(
            i_S  => s_WBjal,
            i_D0 => s_AluOrMem,
            i_D1 => s_WBPC4,
            o_O  => s_RegWrData
            );

    instPC4Adder : Full_Adder_N
        port map(
            i_A => s_NextInstAddr,
            i_B => x"00000004",
            i_C => '0',
            o_S => s_IFPC4
            );

    branchjumpMUX : mux2t1_N
        generic map(N => 32)
        port map(
            i_S  => s_Flush,
            i_D0 => s_Inst,
            i_D1 => x"00000000",
            o_O  => s_BasedInstruction
            );

    instIFID : IF_ID
        port map(
            i_CLK         => iCLK,
            i_RST         => iRST,
            i_Stall       => s_Stall,
            i_PC4         => s_IFPC4,
            i_Instruction => s_BasedInstruction,
            o_PC4         => s_IDPC4,
            o_Instruction => s_IDInstruction
            );

    s_ID_memRD <= s_memToReg and not s_IDMemWr;

    instWBMux : mux2t1
        port map(
            i_S  => s_Stall,
            i_D0 => s_IDRegWr,
            i_D1 => '0',
            o_O  => s_muxRegWr
            );

    instMEMRdMUX : mux2t1
        port map(
            i_S  => s_Stall,
            i_D0 => s_IDMemWr,
            i_D1 => '0',
            o_O  => s_muxMemWr
            );

    instIDEX : ID_EX
        port map(
            i_CLK               => iCLK,
            i_Reset             => '0',
            i_stall             => '0',
            i_PC4               => s_IDPC4,
            i_RegisterFileReadA => s_RegisterFileA,
            i_RegisterFileReadB => s_RegisterFileB,
            i_ImmediateExtended => s_immediate,
            i_IDRt              => s_IDInstruction(20 downto 16),
            i_IDRd              => s_IDInstruction(15 downto 11),
            i_RegDst            => s_RegDst,
            i_RegWrite          => s_muxRegWr,
            i_MemToReg          => s_memToReg,
            i_MemWrite          => s_muxMemWr,
            i_ALUSrc            => s_ALUSrc,
            i_ALUOp             => s_ALUOp,
            i_Jal               => s_Jal,
            i_Halt              => s_IDhalt,
            i_RS                => s_IDInstruction(25 downto 21),
            i_MEMRd             => s_ID_memRD,
            o_RS                => s_EX_rs,
            o_PC4               => s_EXPC4,
            o_RegisterFileReadA => s_EXA,
            o_RegisterFileReadB => s_EXB,
            o_ImmediateExtended => s_EXImmediate,
            o_Rt                => s_EXrt,
            o_Rd                => s_EXrd,
            o_RegDst            => s_EXRegDst,
            o_RegWrite          => s_EXRegWr,
            o_MemToReg          => s_EXmemToReg,
            o_MemWrite          => s_EXMemWr,
            o_ALUSrc            => s_EXALUSrc,
            o_ALUOp             => s_EXALUOp,
            o_Jal               => s_EXjal,
            o_Halt              => s_EXhalt,
            o_MEMRd             => s_EXMemRd
            );

    instEXMEM : EX_MEM
        port map(
            i_CLK      => iCLK,
            i_RST      => iRST,
            i_stall    => '0',
            i_ALU      => s_ALUOut,
            i_B        => s_ForwardB,
            i_WrAddr   => s_EXrtrd,
            i_MemWr    => s_EXMemWr,
            i_MemtoReg => s_EXmemToReg,
            i_Halt     => s_EXhalt,
            i_RegWr    => s_EXRegWr,
            i_Jal      => s_EXjal,
            i_PC4      => s_EXPC4,
            o_ALU      => s_MEMALU,
            o_B        => s_DMemData,
            o_WrAddr   => s_MEMrtrd,
            o_MemWr    => s_DMemWr,
            o_MemtoReg => s_MEMmemToReg,
            o_Halt     => s_MEMhalt,
            o_RegWr    => s_MemRegWr,
            o_Jal      => s_MEMjal,
            o_PC4      => s_MEMPC4
            );

    instMEMWB : MEM_WB
        port map(
            i_CLK      => iCLK,
            i_RST      => iRST,
            i_stall    => '0',
            i_ALU      => s_MEMALU,
            i_Mem      => s_DMemOut,
            i_WrAddr   => s_MEMrtrd,
            i_MemtoReg => s_MEMmemToReg,
            i_Halt     => s_MEMHalt,
            i_RegWr    => s_MEMRegWr,
            i_Jal      => s_MEMjal,
            i_PC4      => s_MEMPC4,
            o_ALU      => s_WBALU,
            o_Mem      => s_WBMEMOut,
            o_WrAddr   => s_WBrtrd,
            o_MemtoReg => s_WBmemToReg,
            o_Halt     => s_Halt,
            o_RegWr    => s_WBRegWr,
            o_Jal      => s_WBjal,
            o_PC4      => s_WBPC4
            );

    instForwardingUnit : ForwardUnit
        port map(
            i_EX_rs     => s_EX_rs,
            i_EX_rt     => s_EXrt,
            i_MEM_rd    => s_MEMrtrd,
            i_WB_rd     => s_WBrtrd,
            i_MEM_wb    => s_MemRegWr,
            i_WB_wb     => s_WBRegWr,
            o_Forward_A => s_ForwardA_sel,
            o_Forward_B => s_ForwardB_sel
            );

    instForwardAMux : mux4t1_N
        generic map(N => 32)
        port map(
            i_S  => s_ForwardA_sel,
            i_D0 => s_EXA,
            i_D1 => s_RegWrData,
            i_D2 => s_MEMALU,
            i_D3 => x"00000000",        -- Never Used
            o_O  => s_ForwardA
            );

    instForwardBMux : mux4t1_N
        generic map(N => 32)
        port map(
            i_S  => s_ForwardB_sel,
            i_D0 => s_EXB,
            i_D1 => s_RegWrData,
            i_D2 => s_MEMALU,
            i_D3 => x"00000000",        -- Never used
            o_O  => s_ForwardB
            );

    instHazardUnit : HazardUnit
        port map(
            i_jump_ID   => s_Jump,
            i_branch_ID => s_JumpBranch,
            i_rAddrA    => s_IDInstruction(25 downto 21),
            i_rAddrB    => s_IDInstruction(20 downto 16),
            i_wAddr_ID  => s_EXrtrd,
            i_wAddr_EX  => s_MEMrtrd,
            i_wE_ID     => s_EXRegWr,
            i_wE_EX     => s_MemRegWr,
            o_stall     => s_Stall,
            o_flush     => s_Flush
            );

    s_WE      <= not s_Stall;
    s_ToFlush <= s_Flush or iRST;

end structure;

