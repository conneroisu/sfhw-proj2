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

    component RegisterFile is
        port (
            clk   : in  std_logic;                      -- Clock input
            i_wA  : in  std_logic_vector(4 downto 0);   -- Write address input
            i_wD  : in  std_logic_vector(31 downto 0);  -- Write data input
            i_wC  : in  std_logic;                      -- Write enable input
            i_r1  : in  std_logic_vector(4 downto 0);   -- Read address 1 input
            i_r2  : in  std_logic_vector(4 downto 0);   -- Read address 2 input
            reset : in  std_logic;                      -- Reset input
            o_d1  : out std_logic_vector(31 downto 0);  -- Read data 1 output
            o_d2  : out std_logic_vector(31 downto 0)   -- Read data 2 output
            );
    end component;

    component IF_ID is
        port (
            i_CLK         : in  std_logic;
            i_RST         : in  std_logic;
            i_stall       : in  std_logic;
            i_PC4         : in  std_logic_vector(31 downto 0);
            i_instruction : in  std_logic_vector(31 downto 0);
            o_PC4         : out std_logic_vector(31 downto 0);
            o_instruction : out std_logic_vector(31 downto 0)
            );
    end component;

    component ID_EX is
        port (
            i_CLK          : in  std_logic;
            i_RST          : in  std_logic;
            i_stall        : in  std_logic;
            i_PC4          : in  std_logic_vector(31 downto 0);
            i_readA        : in  std_logic_vector(31 downto 0);
            i_readB        : in  std_logic_vector(31 downto 0);
            i_signExtImmed : in  std_logic_vector(31 downto 0);
            i_IDRt         : in  std_logic_vector(4 downto 0);
            i_IDRD         : in  std_logic_vector(4 downto 0);
            i_RegDst       : in  std_logic;
            i_RegWrite     : in  std_logic;
            i_memToReg     : in  std_logic;
            i_MemWrite     : in  std_logic;
            i_ALUSrc       : in  std_logic;
            i_ALUOp        : in  std_logic_vector(3 downto 0);
            i_jal          : in  std_logic;
            i_halt         : in  std_logic;
            i_RS           : in  std_logic_vector(4 downto 0);
            i_memRd        : in  std_logic;
            o_RS           : out std_logic_vector(4 downto 0);
            o_PC4          : out std_logic_vector(31 downto 0);
            o_readA        : out std_logic_vector(31 downto 0);
            o_readB        : out std_logic_vector(31 downto 0);
            o_signExtImmed : out std_logic_vector(31 downto 0);
            o_Rt           : out std_logic_vector(4 downto 0);  -- inst20_16
            o_Rd           : out std_logic_vector(4 downto 0);  -- inst15_11
            o_RegDst       : out std_logic;
            o_RegWrite     : out std_logic;
            o_memToReg     : out std_logic;
            o_MemWrite     : out std_logic;
            o_ALUSrc       : out std_logic;
            o_ALUOp        : out std_logic_vector(3 downto 0);
            o_jal          : out std_logic;
            o_halt         : out std_logic;
            o_memRd        : out std_logic
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
            i_CLK      : in  std_logic;  -- Clock input
            i_RST      : in  std_logic;  -- Reset input
            i_stall    : in  std_logic;  -- Write enable input
            i_ALU      : in  std_logic_vector(31 downto 0);  -- ALU value input
            o_ALU      : out std_logic_vector(31 downto 0);  -- ALU value output
            i_Mem      : in  std_logic_vector(31 downto 0);  --Mem value
            o_Mem      : out std_logic_vector(31 downto 0);  --Mem value
            i_WrAddr   : in  std_logic_vector(4 downto 0);  --write address to register file
            o_WrAddr   : out std_logic_vector(4 downto 0);
            i_MemtoReg : in  std_logic;  --memory vs alu signal
            o_MemtoReg : out std_logic;
            i_Halt     : in  std_logic;  --halt signal
            o_Halt     : out std_logic;
            i_RegWr    : in  std_logic;  --write enable for reg file
            o_RegWr    : out std_logic;
            i_jal      : in  std_logic;
            o_jal      : out std_logic;
            i_PC4      : in  std_logic_vector(31 downto 0);  --pc+4
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
            i_PC4         : in  std_logic_vector(31 downto 0);  --Program counter
            i_branch_addr : in  std_logic_vector(31 downto 0);  --potential branch address
            i_jump_addr   : in  std_logic_vector(31 downto 0);  --potential jump address
            i_jr          : in  std_logic_vector(31 downto 0);  --potential jump register address
            i_jr_select   : in  std_logic;  --selector for jump register
            i_branch      : in  std_logic;  --selects if a branch instruction is active
            i_bne         : in  std_logic;
            i_A           : in  std_logic_vector(31 downto 0);
            i_B           : in  std_logic_vector(31 downto 0);
            i_jump        : in  std_logic;  --selector for j or jal
            o_PC          : out std_logic_vector(31 downto 0);
            o_jump_branch : out std_logic   --signals if PC must change
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

    component ControlUnit is
        port (
            i_opCode    : in  std_logic_vector(5 downto 0);  --MIPS instruction opcode (6 bits wide)
            i_funct     : in  std_logic_vector(5 downto 0);  --MIPS instruction function code (6 bits wide) used for R-Type instructions
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
            o_j         : out std_logic;
            o_jr        : out std_logic;
            o_jal       : out std_logic;
            o_branch    : out std_logic;
            o_jump      : out std_logic;
            o_lui       : out std_logic;
            o_halt      : out std_logic
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

    signal s_ForwardA_sel, s_ForwardB_sel : std_logic_vector(1 downto 0);
    signal s_ALUOp, s_EXALUOp             : std_logic_vector(3 downto 0);

    signal s_EX_rs, s_EXrt, s_EXrd, s_EXrtrd : std_logic_vector(4 downto 0);
    signal s_rtrd, s_MEMrtrd, s_WBrtrd       : std_logic_vector(4 downto 0);

    signal s_RegA, s_RegB,
        s_IF_PC4, s_EX_PC4, s_MEM_PC4, s_WB_PC4,
        s_PC, s_PCR, s_nextPC, s_immediate, s_ALUB, s_aluORmem,
        s_ID_Inst, s_ID_PC4,
        s_EXA, s_EXB, s_EXImmediate,
        s_ALUOut, s_MEMALU, s_WBALU,
        s_WBMEMOut,
        s_Forward_A, s_Forward_B,
        s_trueINST : std_logic_vector(31 downto 0);

    signal
        s_jump_branch, s_RegDst, s_memToReg, s_ALUSrc, s_j, s_jr, s_jal,
        s_not_clk, s_signed, s_lui, s_addSub, s_shiftType, s_shiftDir, s_bne, s_beq,
        s_branch, s_jump, s_zero, s_CarryOut, s_stall, s_we, s_flush, s_toFlush,
        s_muxRegWr, s_muxMemWr, s_internal_CarryOut, s_internal_Overflow,
        s_IDhalt, s_IDMemWr, s_IDRegWr, s_ID_memRD,
        s_EXRegDst, s_EXRegWr, s_EXmemToReg, s_EXMemWr, s_EXMemRd, s_EXALUSrc, s_EXjal, s_EXhalt,
        s_MEMjal, s_MEMmemtoReg, s_MEMhalt, s_MEMRegWr,
        s_WBjal, s_WBmemToReg, s_WBRegWr : std_logic;

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
    s_not_clk   <= not iCLK;

    instRegFile : RegisterFile
        port map(
            i_wD  => s_RegWrData,
            i_wA  => s_RegWrAddr,
            i_wC  => s_RegWr,
            clk   => s_not_clk,
            reset => iRST,
            i_r1  => s_ID_Inst(25 downto 21),
            i_r2  => s_ID_Inst(20 downto 16),
            o_d1  => s_RegA,
            o_d2  => s_RegB
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
            o_signed    => s_signed,
            o_addSub    => s_addSub,
            o_shiftType => s_shiftType,
            o_shiftDir  => s_shiftDir,
            o_bne       => s_bne,
            o_beq       => s_beq,
            o_j         => s_j,
            o_jr        => s_jr,
            o_jal       => s_jal,
            o_branch    => s_branch,
            o_jump      => s_jump,
            o_lui       => s_lui,
            o_halt      => s_IDhalt
            );

    instPC : dffg_N
        port map(
            i_CLK => iCLK,
            i_RST => '0',
            i_WE  => s_we,
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
            i_S  => s_jump_branch,
            i_D0 => s_IF_PC4,
            i_D1 => s_PC,
            o_O  => s_nextPC
            );

    Fetch : FetchUnit
        port map(
            i_PC4         => s_ID_PC4,
            i_branch_addr => s_immediate,
            i_jump_addr   => s_ID_Inst,
            i_jr          => s_RegA,
            i_jr_select   => s_jr,
            i_branch      => s_branch,
            i_bne         => s_bne,
            i_A           => s_RegA,
            i_B           => s_RegB,
            i_jump        => s_jump,
            o_PC          => s_PC,
            o_jump_branch => s_jump_branch
            );

    instSignExtend : extender16t32
        port map(
            i_C => s_signed,
            i_I => s_ID_Inst(15 downto 0),
            o_O => s_immediate
            );

    immediateMUX : mux2t1_N
        generic map(N => 32)
        port map(
            i_S  => s_EXALUSrc,
            i_D0 => s_Forward_B,
            i_D1 => s_EXImmediate,
            o_O  => s_ALUB
            );

    instALU : ALU
        generic map(N => 32)
        port map(
            i_A        => s_Forward_A,
            i_B        => s_ALUB,
            i_ALUOP    => s_EXALUOp,
            i_shamt    => s_EXImmediate(10 downto 6),
            o_resultF  => s_ALUOut,
            o_CarryOut => s_internal_CarryOut,
            o_Overflow => s_internal_Overflow,
            o_zero     => s_zero
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
            o_O  => s_aluORmem
            );

    instRegAddrMux : mux2t1_N
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

    branchjumpMUX : mux2t1_N
        generic map(N => 32)
        port map(
            i_S  => s_flush,
            i_D0 => s_Inst,
            i_D1 => x"00000000",
            o_O  => s_trueINST
            );

    instIFID : IF_ID
        port map(
            i_CLK         => iCLK,
            i_RST         => iRST,
            i_stall       => s_stall,
            i_PC4         => s_IF_PC4,
            i_instruction => s_trueINST,
            o_PC4         => s_ID_PC4,
            o_instruction => s_ID_Inst
            );

    s_ID_memRD <= s_memToReg and not s_IDMemWr;

    instWBMux : mux2t1
        port map(
            i_S  => s_stall,
            i_D0 => s_IDRegWr,
            i_D1 => '0',
            o_O  => s_muxRegWr
            );

    instMEMRdMUX : mux2t1
        port map(
            i_S  => s_stall,
            i_D0 => s_IDMemWr,
            i_D1 => '0',
            o_O  => s_muxMemWr
            );

    instIDEX : ID_EX
        port map(
            i_CLK          => iCLK,
            i_RST          => '0',
            i_stall        => '0',
            i_PC4          => s_ID_PC4,
            i_readA        => s_RegA,
            i_readB        => s_RegB,
            i_signExtImmed => s_immediate,
            i_IDRt         => s_ID_Inst(20 downto 16),
            i_IDRD         => s_ID_Inst(15 downto 11),
            i_RegDst       => s_RegDst,
            i_RegWrite     => s_muxRegWr,
            i_memToReg     => s_memToReg,
            i_MemWrite     => s_muxMemWr,
            i_ALUSrc       => s_ALUSrc,
            i_ALUOp        => s_ALUOp,
            i_jal          => s_jal,
            i_halt         => s_IDhalt,
            i_RS           => s_ID_Inst(25 downto 21),
            i_memRd        => s_ID_memRD,
            o_RS           => s_EX_rs,
            o_PC4          => s_EX_PC4,
            o_readA        => s_EXA,
            o_readB        => s_EXB,
            o_signExtImmed => s_EXImmediate,
            o_Rt           => s_EXrt,
            o_Rd           => s_EXrd,
            o_RegDst       => s_EXRegDst,
            o_RegWrite     => s_EXRegWr,
            o_memToReg     => s_EXmemToReg,
            o_MemWrite     => s_EXMemWr,
            o_ALUSrc       => s_EXALUSrc,
            o_ALUOp        => s_EXALUOp,
            o_jal          => s_EXjal,
            o_halt         => s_EXhalt,
            o_memRd        => s_EXMemRd
            );

    instEXMEM : EX_MEM
        port map(
            i_CLK      => iCLK,
            i_RST      => iRST,
            i_stall    => '0',
            i_ALU      => s_ALUOut,
            o_ALU      => s_MEMALU,
            i_B        => s_Forward_B,
            o_B        => s_DMemData,
            i_WrAddr   => s_EXrtrd,
            o_WrAddr   => s_MEMrtrd,
            i_MemWr    => s_EXMemWr,
            o_MemWr    => s_DMemWr,
            i_MemtoReg => s_EXmemToReg,
            o_MemtoReg => s_MEMmemToReg,
            i_Halt     => s_EXhalt,
            o_Halt     => s_MEMhalt,
            i_RegWr    => s_EXRegWr,
            o_RegWr    => s_MemRegWr,
            i_jal      => s_EXjal,
            o_jal      => s_MEMjal,
            i_PC4      => s_EX_PC4,
            o_PC4      => s_MEM_PC4
            );

    instMEMWB : MEM_WB
        port map(
            i_CLK      => iCLK,
            i_RST      => iRST,
            i_stall    => '0',
            i_ALU      => s_MEMALU,
            o_ALU      => s_WBALU,
            i_Mem      => s_DMemOut,
            o_Mem      => s_WBMEMOut,
            i_WrAddr   => s_MEMrtrd,
            o_WrAddr   => s_WBrtrd,
            i_MemtoReg => s_MEMmemToReg,
            o_MemtoReg => s_WBmemToReg,
            i_Halt     => s_MEMHalt,
            o_Halt     => s_Halt,
            i_RegWr    => s_MEMRegWr,
            o_RegWr    => s_WBRegWr,
            i_jal      => s_MEMjal,
            o_jal      => s_WBjal,
            i_PC4      => s_MEM_PC4,
            o_PC4      => s_WB_PC4
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
            o_O  => s_Forward_A
            );

    instForwardBMux : mux4t1_N
        generic map(N => 32)
        port map(
            i_S  => s_ForwardB_sel,
            i_D0 => s_EXB,
            i_D1 => s_RegWrData,
            i_D2 => s_MEMALU,
            i_D3 => x"00000000",        -- Never used
            o_O  => s_Forward_B
            );

    instHazardUnit : HazardUnit
        port map(
            i_jump_ID   => s_jump,
            i_branch_ID => s_jump_branch,
            i_rAddrA    => s_ID_Inst(25 downto 21),
            i_rAddrB    => s_ID_Inst(20 downto 16),
            i_wAddr_ID  => s_EXrtrd,
            i_wAddr_EX  => s_MEMrtrd,
            i_wE_ID     => s_EXRegWr,
            i_wE_EX     => s_MemRegWr,
            o_stall     => s_stall,
            o_flush     => s_flush
            );

    s_we      <= not s_stall;
    s_toFlush <= s_flush or iRST;

end structure;
