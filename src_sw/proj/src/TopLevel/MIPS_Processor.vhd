-- <header>
-- Author(s): connerohnesorge, Conner Ohnesorge
-- Name: 
-- Notes:
--      connerohnesorge 2024-12-06T08:29:51-06:00 fix-bug-type-remove-j-from-coontol
--      connerohnesorge 2024-12-06T08:26:15-06:00 remove-s_j-from-MIPS_Processor-and-o_J-from-ControlUnit
--      connerohnesorge 2024-12-06T08:18:53-06:00 Rename-instance-of-Fetch-Unit-and-add-comment-for-first-signal
--      connerohnesorge 2024-12-06T08:15:04-06:00 format
--      connerohnesorge 2024-12-06T08:12:54-06:00 Update-ID_EX-to-be-compatible-with-the-style-guide
--      connerohnesorge 2024-12-06T07:22:29-06:00 update-IFID-stage-to-better-fit-style-guide
--      connerohnesorge 2024-12-06T07:20:56-06:00 Ensure-style-guidelines-are-followed-with-registerfile-and-update-it-s-interface-in-the-processor
--      connerohnesorge 2024-12-05T14:43:05-06:00 fix-signal-capitalization
--      connerohnesorge 2024-12-05T14:41:21-06:00 fix-typo-in-signal-name
--      connerohnesorge 2024-12-05T14:07:26-06:00 latest
--      connerohnesorge 2024-12-05T13:58:41-06:00 latest
--      connerohnesorge 2024-12-05T13:40:34-06:00 removed-unused-signal
--      connerohnesorge 2024-12-05T09:18:15-06:00 fix-alu-op-signal-feeding-through-stages
--      connerohnesorge 2024-12-05T09:05:45-06:00 fix-missing-mixed-up-signals-for-stages
--      connerohnesorge 2024-12-05T08:58:27-06:00 fix-type-in-instr-signal
--      connerohnesorge 2024-12-05T08:51:46-06:00 fix-unused-signals
--      Conner Ohnesorge 2024-12-05T08:36:22-06:00 expand-signals-in-softare-implementation
--      connero 2024-12-05T08:29:28-06:00 Merge-pull-request-90-from-conneroisu-ConnerOhnesorge
--      Conner Ohnesorge 2024-12-05T08:27:11-06:00 fixed-EXB-signal
--      Conner Ohnesorge 2024-12-05T08:22:49-06:00 fix-bug-with-accidentically-removed-immediate-mux-before-alu
--      Conner Ohnesorge 2024-12-05T08:20:43-06:00 fix-unassigned-value-to-s_EXA-to-alu
--      connerohnesorge 2024-12-04T23:19:07-06:00 make-sure-to-align-with-styleguided
--      connerohnesorge 2024-12-04T23:18:16-06:00 clean-up-signals-for-debugging-of-the-software-pipeline
--      connerohnesorge 2024-12-04T20:58:27-06:00 fix-no-signal-to-rt-and-rd-for-id_ex
--      connerohnesorge 2024-12-04T20:56:05-06:00 finish-presentation-of-pipeline-stages-in-both-hardware-and-software-implementations-and-make-sure-adherence-to-styleguide
--      connerohnesorge 2024-12-04T19:43:18-06:00 remove-more-unused-components
--      connerohnesorge 2024-12-04T19:42:50-06:00 remove-unused-components-from-software-implementation
--      connerohnesorge 2024-12-04T17:49:24-06:00 remove-testing-bash-files
--      connerohnesorge 2024-12-04T17:36:32-06:00 better-naming-for-instances
--      Conner Ohnesorge 2024-12-04T07:52:01-06:00 update-register-file-name
--      Conner Ohnesorge 2024-12-04T07:50:05-06:00 removed-unnessary-comments-in-MIPS_Processor.vhd-for-the-software
--      Conner Ohnesorge 2024-12-04T07:44:46-06:00 updated-the-software-pipeline-to-use-the-simplified-contgrol-flow
--      Conner Ohnesorge 2024-12-01T20:51:19-06:00 fix-s_EX_lui_val-length
--      Conner Ohnesorge 2024-12-01T20:42:11-06:00 test-others-0-on-s_ex_lui_val-length-assignment
--      Conner Ohnesorge 2024-12-01T20:39:31-06:00 remove-src_sf-and-update-.gitignore
--      Conner Ohnesorge 2024-12-01T19:50:46-06:00 latest
--      Conner Ohnesorge 2024-12-01T19:44:01-06:00 latest
--      Conner Ohnesorge 2024-12-01T19:34:36-06:00 latest
--      Conner Ohnesorge 2024-12-01T19:30:32-06:00 fix-name-of-alu_control
--      Conner Ohnesorge 2024-12-01T19:28:10-06:00 test
--      Conner Ohnesorge 2024-12-01T19:26:22-06:00 fix-spacing
--      Conner Ohnesorge 2024-12-01T19:22:45-06:00 fix-signal-lui-s-width
--      Conner Ohnesorge 2024-12-01T19:21:02-06:00 add-missing-signals
--      Conner Ohnesorge 2024-12-01T19:20:09-06:00 latest
--      Conner Ohnesorge 2024-12-01T19:18:16-06:00 fix-register-file-instantiation
--      Conner Ohnesorge 2024-12-01T19:10:17-06:00 fix-signal-name
--      Conner Ohnesorge 2024-12-01T17:41:03-06:00 fix-signal-lenght-for-lui
--      Conner Ohnesorge 2024-12-01T17:40:00-06:00 fix-undeclared-signal
--      Conner Ohnesorge 2024-12-01T16:35:33-06:00 fix-program-counter-declaration-and-style-guide-adhereance
--      Conner Ohnesorge 2024-12-01T16:08:37-06:00 fix-formatting-and-some-logic-of-software-MIPS_Processor
--      Conner Ohnesorge 2024-12-01T15:44:54-06:00 make-register_file-adhere-to-style-guidelines-and-fix-declaration-in
--      Conner Ohnesorge 2024-12-01T15:41:34-06:00 move-barrelShifter-to-MidLevel-in-software-processor
--      Conner Ohnesorge 2024-11-29T14:46:12-06:00 pdate-control-unit-ports-to-better-fit-style-guide
--      Conner Ohnesorge 2024-11-21T09:00:59-06:00 added-start-of-sf-pipeline-folder
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
        oALUOut   : out std_logic_vector(N - 1 downto 0));
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
            i_CLK         : in  std_logic;
            i_WriteAddr   : in  std_logic_vector(4 downto 0);
            i_WriteData   : in  std_logic_vector(31 downto 0);
            i_WriteEnable : in  std_logic;
            i_ReadAddr1   : in  std_logic_vector(4 downto 0);
            i_ReadAddr2   : in  std_logic_vector(4 downto 0);
            i_Reset       : in  std_logic;
            o_ReadData1   : out std_logic_vector(31 downto 0);
            o_ReadData2   : out std_logic_vector(31 downto 0)
            );
    end component;

    component IF_ID is
        port (
            i_CLK         : in  std_logic;
            i_RST         : in  std_logic;
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
            i_PC4               : in  std_logic_vector(31 downto 0);
            i_RegisterFileReadA : in  std_logic_vector(31 downto 0);
            i_RegisterFileReadB : in  std_logic_vector(31 downto 0);
            i_ImmediateExtended : in  std_logic_vector(31 downto 0);
            i_Rt                : in  std_logic_vector(4 downto 0);  -- 20-16
            i_Rd                : in  std_logic_vector(4 downto 0);  -- 15-11
            i_RegDst            : in  std_logic;
            i_RegWrite          : in  std_logic;
            i_MemToReg          : in  std_logic;
            i_MemWrite          : in  std_logic;
            i_ALUSrc            : in  std_logic;
            i_ALUOp             : in  std_logic_vector(3 downto 0);
            i_Jal               : in  std_logic;
            i_Halt              : in  std_logic;
            o_PC4               : out std_logic_vector(31 downto 0);
            o_RegisterFileReadA : out std_logic_vector(31 downto 0);
            o_RegisterFileReadB : out std_logic_vector(31 downto 0);
            o_ImmediateExtended : out std_logic_vector(31 downto 0);
            o_Rt                : out std_logic_vector(4 downto 0);  -- 20-16
            o_Rd                : out std_logic_vector(4 downto 0);  -- 15-11
            o_RegDst            : out std_logic;
            o_RegWrite          : out std_logic;
            o_MemToReg          : out std_logic;
            o_MemWrite          : out std_logic;
            o_ALUSrc            : out std_logic;
            o_ALUOp             : out std_logic_vector(3 downto 0);
            o_Jal               : out std_logic;
            o_Halt              : out std_logic
            );
    end component;

    component EX_MEM is
        port (
            i_CLK      : in  std_logic;
            i_RST      : in  std_logic;
            i_ALU      : in  std_logic_vector(31 downto 0);
            i_B        : in  std_logic_vector(31 downto 0);
            i_WrAddr   : in  std_logic_vector(4 downto 0);
            i_MemWr    : in  std_logic;
            i_MemtoReg : in  std_logic;
            i_Halt     : in  std_logic;
            i_RegWr    : in  std_logic;
            i_jal      : in  std_logic;
            i_PC4      : in  std_logic_vector(31 downto 0);
            o_ALU      : out std_logic_vector(31 downto 0);
            o_B        : out std_logic_vector(31 downto 0);
            o_WrAddr   : out std_logic_vector(4 downto 0);
            o_MemWr    : out std_logic;
            o_MemtoReg : out std_logic;
            o_Halt     : out std_logic;
            o_RegWr    : out std_logic;
            o_jal      : out std_logic;
            o_PC4      : out std_logic_vector(31 downto 0)
            );
    end component;

    component MEM_WB is
        port (
            i_CLK      : in  std_logic;
            i_RST      : in  std_logic;
            i_ALU      : in  std_logic_vector(31 downto 0);
            i_Mem      : in  std_logic_vector(31 downto 0);
            i_WrAddr   : in  std_logic_vector(4 downto 0);
            i_MemtoReg : in  std_logic;
            i_Halt     : in  std_logic;
            i_RegWr    : in  std_logic;
            i_jal      : in  std_logic;
            i_PC4      : in  std_logic_vector(31 downto 0);
            o_ALU      : out std_logic_vector(31 downto 0);
            o_Mem      : out std_logic_vector(31 downto 0);
            o_WrAddr   : out std_logic_vector(4 downto 0);
            o_MemtoReg : out std_logic;
            o_Halt     : out std_logic;
            o_RegWr    : out std_logic;
            o_jal      : out std_logic;
            o_PC4      : out std_logic_vector(31 downto 0)
            );
    end component;

    component ALU is
        generic (N : integer := 32);
        port (
            i_A        : in  std_logic_vector(N - 1 downto 0);
            i_B        : in  std_logic_vector(N - 1 downto 0);
            i_ALUOP    : in  std_logic_vector(3 downto 0);
            i_shamt    : in  std_logic_vector(4 downto 0);
            o_resultF  : out std_logic_vector(N - 1 downto 0);
            o_CarryOut : out std_logic;
            o_Overflow : out std_logic;
            o_zero     : out std_logic
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
            i_PC4         : in  std_logic_vector(31 downto 0);
            i_branch_addr : in  std_logic_vector(31 downto 0);
            i_jump_addr   : in  std_logic_vector(31 downto 0);
            i_jr          : in  std_logic_vector(31 downto 0);
            i_jr_select   : in  std_logic;
            i_branch      : in  std_logic;
            i_bne         : in  std_logic;
            i_A           : in  std_logic_vector(31 downto 0);
            i_B           : in  std_logic_vector(31 downto 0);
            i_jump        : in  std_logic;
            o_PC          : out std_logic_vector(31 downto 0);
            o_jump_branch : out std_logic
            );
    end component;

    component ControlUnit is
        port (
            i_opCode    : in  std_logic_vector(5 downto 0);
            i_funct     : in  std_logic_vector(5 downto 0);
            o_RegDst    : out std_logic;
            o_RegWrite  : out std_logic;
            o_memToReg  : out std_logic;
            o_memWrite  : out std_logic;
            o_ALUSrc    : out std_logic;
            o_ALUOp     : out std_logic_vector(3 downto 0);
            o_signed    : out std_logic;
            o_addSub    : out std_logic;
            o_shiftType : out std_logic;
            o_shiftDir  : out std_logic;
            o_bne       : out std_logic;
            o_beq       : out std_logic;
            o_jr        : out std_logic;
            o_jal       : out std_logic;
            o_branch    : out std_logic;
            o_jump      : out std_logic;
            o_lui       : out std_logic;
            o_halt      : out std_logic
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
            i_I : in  std_logic_vector(15 downto 0);
            i_C : in  std_logic;
            o_O : out std_logic_vector(31 downto 0)
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

    component dffg_N is
        port (
            i_CLK : in  std_logic;
            i_RST : in  std_logic;
            i_WE  : in  std_logic;
            i_D   : in  std_logic_vector(31 downto 0);
            o_Q   : out std_logic_vector(31 downto 0)
            );
    end component;

    signal s_ALUOp, s_EXALUOp : std_logic_vector(3 downto 0);

    signal
        s_EXrt, s_EXrd, s_EXrtrd,
        s_rtrd, s_MEMrtrd, s_WBrtrd : std_logic_vector(4 downto 0);

    signal
        s_JumpBranch,                   -- from: instNXTPC; to: instFetchUnit
        s_RegDst,                       -- from: instControlUnit; to instIDEX
        s_memToReg,                     -- from: instControlUnit; to instIDEX
        s_ALUSrc,                       -- from: instControlUnit; to instIDEX
        s_J,
        s_jr,
        s_Jal,
        s_Signed,
        s_Lui,
        s_Operator,
        s_ShiftType,
        s_ShiftDir,
        s_Bne,
        s_Beq,
        s_Branch,
        s_Jump,
        s_Zero,
        s_CarryOut,
        s_InternalCarryOut,
        s_InternalOverflow,
        s_IDhalt,
        s_IDMemWr,
        s_IDRegWr,
        s_EXRegDst,
        s_EXRegWr,
        s_EXMemToReg,
        s_EXMemWr,
        s_EXALUSrc,
        s_EXjal,
        s_EXhalt,
        s_MEMjal,
        s_MEMMemToReg,
        s_MEMHalt,
        s_MEMRegWr,
        s_WBjal,
        s_WBMemToReg,
        s_WBRegWr : std_logic;

    signal s_RegA,
        s_RegB,
        s_IF_PC4,
        s_EX_PC4,
        s_MEM_PC4,
        s_WB_PC4,
        s_PC,
        s_PCR,
        s_nextPC,
        s_Imm,
        s_ALUB,
        s_aluORmem,
        s_ID_Inst,
        s_ID_PC4,
        s_EXA,
        s_EXB,
        s_EXImmediate,
        s_ALUOut,
        s_MEMALU,
        s_WBALU,
        s_WBMEMOut : std_logic_vector(31 downto 0);

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

    instRegisterFile : RegisterFile
        port map(
            i_WriteData   => s_RegWrData,
            i_WriteAddr   => s_RegWrAddr,
            i_WriteEnable => s_RegWr,
            i_CLK         => iCLK,
            i_Reset       => iRST,
            i_ReadAddr1   => s_ID_Inst(25 downto 21),
            i_ReadAddr2   => s_ID_Inst(20 downto 16),
            o_ReadData1   => s_RegA,
            o_ReadData2   => s_RegB
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
            i_opCode    => s_ID_Inst(31 downto 26),
            i_funct     => s_ID_Inst(5 downto 0),
            o_RegDst    => s_RegDst,
            o_RegWrite  => s_IDRegWr,
            o_memToReg  => s_memToReg,
            o_memWrite  => s_IDMemWr,
            o_ALUSrc    => s_ALUSrc,
            o_ALUOp     => s_ALUOp,
            o_signed    => s_Signed,
            o_addSub    => s_Operator,
            o_shiftType => s_ShiftType,
            o_shiftDir  => s_ShiftDir,
            o_bne       => s_Bne,
            o_beq       => s_Beq,
            o_jr        => s_jr,
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
            i_WE  => '1',
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
            i_D0 => s_IF_PC4,
            i_D1 => s_PC,
            o_O  => s_nextPC
            );

    instFetchUnit : FetchUnit
        port map(
            i_PC4         => s_ID_PC4,
            i_branch_addr => s_Imm,
            i_jump_addr   => s_ID_Inst,
            i_jr          => s_RegA,
            i_jr_select   => s_jr,
            i_branch      => s_Branch,
            i_bne         => s_Bne,
            i_A           => s_RegA,
            i_B           => s_RegB,
            i_jump        => s_Jump,
            o_PC          => s_PC,
            o_jump_branch => s_JumpBranch
            );

    instSignExtender : extender16t32
        port map(
            i_C => s_Signed,
            i_I => s_ID_Inst(15 downto 0),
            o_O => s_Imm
            );

    immMux : mux2t1_N
        generic map(N => 32)
        port map(
            i_S  => s_EXALUSrc,
            i_D0 => s_EXB,
            i_D1 => s_EXImmediate,
            o_O  => s_ALUB
            );

    instALU : ALU
        generic map(N => 32)
        port map(
            i_A        => s_EXA,
            i_B        => s_ALUB,
            i_ALUOP    => s_EXALUOp,
            i_shamt    => s_EXImmediate(10 downto 6),
            o_resultF  => s_ALUOut,
            o_CarryOut => s_InternalCarryOut,
            o_Overflow => s_InternalOverflow,
            o_zero     => s_Zero
            );

    instCarrFlowProc : process(iCLK, iRST, s_InternalCarryOut, s_InternalOverflow, s_CarryOut, s_Ovfl)
    begin
        if iRST = '1' then
            s_CarryOut <= '0';
            s_Ovfl     <= '0';
        elsif rising_edge(iCLK) then
            if s_InternalCarryOut = '1' then
                s_CarryOut <= '1';
            else
                s_CarryOut <= s_CarryOut;
            end if;
            if s_InternalOverflow = '1' then
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
            i_S  => s_WBMemToReg,
            i_D0 => s_WBALU,
            i_D1 => s_WBMEMOut,
            o_O  => s_aluORmem
            );

    instReAddrMux : mux2t1_N            -- ra
        generic map(N => 32)
        port map(
            i_S  => s_WBjal,
            i_D0 => s_aluORmem,
            i_D1 => s_WB_PC4,
            o_O  => s_RegWrData
            );

    instPC4Adder : Full_Adder_N
        port map(
            i_A => s_NextInstAddr,
            i_B => x"00000004",
            i_C => '0',
            o_S => s_IF_PC4
            );

    instIFID : IF_ID
        port map(
            i_CLK         => iCLK,
            i_RST         => iRST,
            i_PC4         => s_IF_PC4,
            i_Instruction => s_Inst,
            o_PC4         => s_ID_PC4,
            o_Instruction => s_ID_Inst
            );

    instIDEX : ID_EX
        port map(
            i_CLK               => iCLK,
            i_Reset             => iRST,
            i_PC4               => s_ID_PC4,
            i_RegisterFileReadA => s_RegA,
            i_RegisterFileReadB => s_RegB,
            i_ImmediateExtended => s_Imm,
            i_RegDst            => s_RegDst,
            i_Rt                => s_ID_Inst(20 downto 16),
            i_Rd                => s_ID_Inst(15 downto 11),
            i_RegWrite          => s_IDRegWr,
            i_MemToReg          => s_memToReg,
            i_MemWrite          => s_IDMemWr,
            i_ALUSrc            => s_ALUSrc,
            i_ALUOp             => s_ALUOp,
            i_Jal               => s_Jal,
            i_Halt              => s_IDhalt,
            o_PC4               => s_EX_PC4,
            o_RegisterFileReadA => s_EXA,
            o_RegisterFileReadB => s_EXB,
            o_ImmediateExtended => s_EXImmediate,
            o_Rt                => s_EXrt,
            o_Rd                => s_EXrd,
            o_RegDst            => s_EXRegDst,
            o_RegWrite          => s_EXRegWr,
            o_MemToReg          => s_EXMemToReg,
            o_MemWrite          => s_EXMemWr,
            o_ALUSrc            => s_EXALUSrc,
            o_ALUOp             => s_EXALUOp,
            o_Jal               => s_EXjal,
            o_Halt              => s_EXhalt
            );

    instEXMEM : EX_MEM
        port map(
            i_CLK      => iCLK,
            i_RST      => iRST,
            i_ALU      => s_ALUOut,
            i_B        => s_EXB,
            i_WrAddr   => s_EXrtrd,
            i_MemWr    => s_EXMemWr,
            i_MemtoReg => s_EXMemToReg,
            i_Halt     => s_EXhalt,
            i_RegWr    => s_EXRegWr,
            i_jal      => s_EXjal,
            i_PC4      => s_EX_PC4,
            o_ALU      => s_MEMALU,
            o_B        => s_DMemData,
            o_WrAddr   => s_MEMrtrd,
            o_MemWr    => s_DMemWr,
            o_MemtoReg => s_MEMMemToReg,
            o_Halt     => s_MEMHalt,
            o_RegWr    => s_MEMRegWr,
            o_jal      => s_MEMjal,
            o_PC4      => s_MEM_PC4
            );

    instMEMWB : MEM_WB
        port map(
            i_CLK      => iCLK,
            i_RST      => iRST,
            i_ALU      => s_MEMALU,
            o_ALU      => s_WBALU,
            i_Mem      => s_DMemOut,
            o_Mem      => s_WBMEMOut,
            i_WrAddr   => s_MEMrtrd,
            o_WrAddr   => s_WBrtrd,
            i_MemtoReg => s_MEMMemToReg,
            o_MemtoReg => s_WBMemToReg,
            i_Halt     => s_MEMHalt,
            o_Halt     => s_Halt,
            i_RegWr    => s_MEMRegWr,
            o_RegWr    => s_WBRegWr,
            i_jal      => s_MEMjal,
            o_jal      => s_WBjal,
            i_PC4      => s_MEM_PC4,
            o_PC4      => s_WB_PC4
            );

end structure;

