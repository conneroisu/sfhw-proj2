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
    -- Pipeline stage signals
    signal s_IFID_Inst    : std_logic_vector(N-1 downto 0);
    signal s_IFID_PC      : std_logic_vector(N-1 downto 0);
    signal s_IDEX_Inst    : std_logic_vector(N-1 downto 0);
    signal s_IDEX_PC      : std_logic_vector(N-1 downto 0);
    signal s_EXMEM_Inst   : std_logic_vector(N-1 downto 0);
    signal s_EXMEM_PC     : std_logic_vector(N-1 downto 0);
    signal s_MEMWB_Inst   : std_logic_vector(N-1 downto 0);
    signal s_MEMWB_PC     : std_logic_vector(N-1 downto 0);
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

    component IF_ID_STAGE is
        port(
            i_clk  : in std_logic;
            i_rst  : in std_logic;
            i_flush: in std_logic;
            i_stall: in std_logic;
            i_sctrl: in std_logic; --sign control signal
            o_regw : out std_logic; --register write signal
            i_addr : in std_logic_vector(31 downto 0);
            i_instr: in std_logic_vector(31 downto 0);
            o_instr: out std_logic_vector(31 downto 0);
            o_addr : out std_logic_vector(31 downto 0);
            o_d1   : out std_logic_vector(31 downto 0);
            o_d2   : out std_logic_vector(31 downto 0);
            o_sign : out std_logic_vector(31 downto 0)
        );
    end component;

    component ID_EX is
        port (
            i_CLK        : in  std_logic;
            i_RST        : in  std_logic;
            i_WE         : in  std_logic;
            i_PC         : in  std_logic_vector(N-1 downto 0);
            i_RegDst     : in  std_logic;
            i_ALUOp      : in  std_logic_vector(2 downto 0);
            i_ALUSrc     : in  std_logic_vector(1 downto 0);
            i_MemRead    : in  std_logic;
            i_MemWrite   : in  std_logic;
            i_MemtoReg   : in  std_logic;
            i_RegWrite   : in  std_logic;
            i_Branch     : in  std_logic;
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
            i_WriteData  : in  std_logic_vector(N-1 downto 0);
            i_DMem1      : in  std_logic_vector(N-1 downto 0);
            i_Rs         : in  std_logic_vector(4 downto 0);
            i_Rt         : in  std_logic_vector(4 downto 0);
            i_Rd         : in  std_logic_vector(4 downto 0);
            i_Shamt      : in  std_logic_vector(4 downto 0);
            i_Funct      : in  std_logic_vector(5 downto 0);
            i_Imm        : in  std_logic_vector(15 downto 0);
            i_Halt       : in  std_logic_vector(0 downto 0);
            o_Halt       : out std_logic_vector(0 downto 0)
        );
    end component;

    component EX_MEM is
        port (
            clk     : in std_logic;
            reset   : in std_logic;
            WriteEn : in std_logic;
            ALU_result_in : in std_logic_vector(31 downto 0);
            Read_data2_in : in std_logic_vector(31 downto 0);
            RegDst_in     : in std_logic_vector(4 downto 0);
            MemRead_in    : in std_logic;
            MemWrite_in   : in std_logic;
            RegWrite_in   : in std_logic;
            MemToReg_in   : in std_logic;
            ALU_result_out : out std_logic_vector(31 downto 0);
            Read_data2_out : out std_logic_vector(31 downto 0);
            RegDst_out     : out std_logic_vector(4 downto 0);
            MemRead_out    : out std_logic;
            MemWrite_out   : out std_logic;
            RegWrite_out   : out std_logic;
            MemToReg_out   : out std_logic
        );
    end component;

    component MEM_WB is
        port (
            clk        : in std_logic;
            reset      : in std_logic;
            i_ALUResult : in std_logic_vector(31 downto 0);
            i_DataMem   : in std_logic_vector(31 downto 0);
            i_RegDst    : in std_logic_vector(4 downto 0);
            i_RegWrite  : in std_logic;
            i_MemToReg  : in std_logic;
            o_regDst    : out std_logic_vector(4 downto 0);
            o_regWrite  : out std_logic;
            o_wbData    : out std_logic_vector(31 downto 0)
        );
    end component;

begin
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

    IFID : IF_ID_STAGE
        port map(
            i_clk  => iCLK,
            i_rst  => iRST,
            i_flush => '0',
            i_stall => '0',
            i_sctrl => '0',
            o_regw => open,
            i_addr => s_NextInstAddr,
            i_instr => s_Inst,
            o_instr => s_IFID_Inst,
            o_addr => s_IFID_PC,
            o_d1 => open,
            o_d2 => open,
            o_sign => open
        );

    IDEX : ID_EX
        port map(
            i_CLK => iCLK,
            i_RST => iRST,
            i_WE => '1',
            i_PC => s_IFID_PC,
            i_RegDst => '0',
            i_ALUOp => "000",
            i_ALUSrc => "00",
            i_MemRead => '0',
            i_MemWrite => '0',
            i_MemtoReg => '0',
            i_RegWrite => '0',
            i_Branch => '0',
            o_ALU => open,
            o_ALUSrc => open,
            o_MemRead => open,
            o_MemWrite => open,
            o_MemtoReg => open,
            o_RegWrite => open,
            o_Branch => open,
            i_Read1 => open,
            i_Read2 => open,
            o_Read1 => open,
            o_Read2 => open,
            i_ForwardA => "00",
            i_ForwardB => "00",
            i_WriteData => (others => '0'),
            i_DMem1 => (others => '0'),
            i_Rs => (others => '0'),
            i_Rt => (others => '0'),
            i_Rd => (others => '0'),
            i_Shamt => (others => '0'),
            i_Funct => (others => '0'),
            i_Imm => (others => '0'),
            i_Halt => '0',
            o_Halt => open
        );

    EXMEM : EX_MEM
        port map(
            clk => iCLK,
            reset => iRST,
            WriteEn => '1',
            ALU_result_in => open,
            Read_data2_in => open,
            RegDst_in => (others => '0'),
            MemRead_in => '0',
            MemWrite_in => '0',
            RegWrite_in => '0',
            MemToReg_in => '0',
            ALU_result_out => open,
            Read_data2_out => open,
            RegDst_out => open,
            MemRead_out => open,
            MemWrite_out => open,
            RegWrite_out => open,
            MemToReg_out => open
        );

    MEMWB : MEM_WB
        port map(
            clk => iCLK,
            reset => iRST,
            i_ALUResult => open,
            i_DataMem => open,
            i_RegDst => (others => '0'),
            i_RegWrite => '0',
            i_MemToReg => '0',
            o_regDst => open,
            o_regWrite => open,
            o_wbData => open
        );

end structure;
