library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_MipsProcessor is
end tb_MipsProcessor;

architecture testbench of tb_MipsProcessor is
    -- Component Declarations
    component IF_ID
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

    component ID_EX
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
            o_Rt                : out std_logic_vector(4 downto 0);
            o_Rd                : out std_logic_vector(4 downto 0);
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

    component EX_MEM
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

    component MEM_WB
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

    -- Signals for testing
    signal clk : std_logic := '0';
    signal rst : std_logic := '0';

    -- IF/ID Signals
    signal if_id_stall       : std_logic := '0';
    signal if_id_pc4_in      : std_logic_vector(31 downto 0) := (others => '0');
    signal if_id_inst_in     : std_logic_vector(31 downto 0) := (others => '0');
    signal if_id_pc4_out     : std_logic_vector(31 downto 0);
    signal if_id_inst_out    : std_logic_vector(31 downto 0);

    -- ID/EX Signals
    signal id_ex_stall       : std_logic := '0';
    signal id_ex_reset       : std_logic := '0';
    signal id_ex_pc4_in      : std_logic_vector(31 downto 0) := (others => '0');
    signal id_ex_regA_in     : std_logic_vector(31 downto 0) := (others => '0');
    signal id_ex_regB_in     : std_logic_vector(31 downto 0) := (others => '0');
    signal id_ex_imm_in      : std_logic_vector(31 downto 0) := (others => '0');
    signal id_ex_rt_in       : std_logic_vector(4 downto 0) := (others => '0');
    signal id_ex_rd_in       : std_logic_vector(4 downto 0) := (others => '0');
    signal id_ex_regdst_in   : std_logic := '0';
    signal id_ex_regwr_in    : std_logic := '0';
    signal id_ex_memtoreg_in : std_logic := '0';
    signal id_ex_memwr_in    : std_logic := '0';
    signal id_ex_alusrc_in   : std_logic := '0';
    signal id_ex_aluop_in    : std_logic_vector(3 downto 0) := (others => '0');
    signal id_ex_jal_in      : std_logic := '0';
    signal id_ex_halt_in     : std_logic := '0';
    signal id_ex_rs_in       : std_logic_vector(4 downto 0) := (others => '0');
    signal id_ex_memrd_in    : std_logic := '0';

    -- EX/MEM Signals
    signal ex_mem_stall      : std_logic := '0';
    signal ex_mem_alu_in     : std_logic_vector(31 downto 0) := (others => '0');
    signal ex_mem_b_in       : std_logic_vector(31 downto 0) := (others => '0');
    signal ex_mem_wraddr_in  : std_logic_vector(4 downto 0) := (others => '0');
    signal ex_mem_memwr_in   : std_logic := '0';
    signal ex_mem_memtoreg_in: std_logic := '0';
    signal ex_mem_halt_in    : std_logic := '0';
    signal ex_mem_regwr_in   : std_logic := '0';
    signal ex_mem_jal_in     : std_logic := '0';
    signal ex_mem_pc4_in     : std_logic_vector(31 downto 0) := (others => '0');

    -- MEM/WB Signals
    signal mem_wb_stall      : std_logic := '0';
    signal mem_wb_alu_in     : std_logic_vector(31 downto 0) := (others => '0');
    signal mem_wb_mem_in     : std_logic_vector(31 downto 0) := (others => '0');
    signal mem_wb_wraddr_in  : std_logic_vector(4 downto 0) := (others => '0');
    signal mem_wb_memtoreg_in: std_logic := '0';
    signal mem_wb_halt_in    : std_logic := '0';
    signal mem_wb_regwr_in   : std_logic := '0';
    signal mem_wb_jal_in     : std_logic := '0';
    signal mem_wb_pc4_in     : std_logic_vector(31 downto 0) := (others => '0');

begin
    -- Instantiate pipeline registers
    uut_if_id : IF_ID port map (
        i_CLK         => clk,
        i_RST         => rst,
        i_Stall       => if_id_stall,
        i_PC4         => if_id_pc4_in,
        i_Instruction => if_id_inst_in,
        o_PC4         => if_id_pc4_out,
        o_Instruction => if_id_inst_out
    );

    uut_id_ex : ID_EX port map (
        i_CLK               => clk,
        i_Reset             => id_ex_reset,
        i_Stall             => id_ex_stall,
        i_PC4               => id_ex_pc4_in,
        i_RegisterFileReadA => id_ex_regA_in,
        i_RegisterFileReadB => id_ex_regB_in,
        i_ImmediateExtended => id_ex_imm_in,
        i_IDRt              => id_ex_rt_in,
        i_IDRd              => id_ex_rd_in,
        i_RegDst            => id_ex_regdst_in,
        i_RegWrite          => id_ex_regwr_in,
        i_MemToReg          => id_ex_memtoreg_in,
        i_MemWrite          => id_ex_memwr_in,
        i_ALUSrc            => id_ex_alusrc_in,
        i_ALUOp             => id_ex_aluop_in,
        i_Jal               => id_ex_jal_in,
        i_Halt              => id_ex_halt_in,
        i_RS                => id_ex_rs_in,
        i_MEMRd             => id_ex_memrd_in
    );

    uut_ex_mem : EX_MEM port map (
        i_CLK      => clk,
        i_RST      => rst,
        i_stall    => ex_mem_stall,
        i_ALU      => ex_mem_alu_in,
        i_B        => ex_mem_b_in,
        i_WrAddr   => ex_mem_wraddr_in,
        i_MemWr    => ex_mem_memwr_in,
        i_MemtoReg => ex_mem_memtoreg_in,
        i_Halt     => ex_mem_halt_in,
        i_RegWr    => ex_mem_regwr_in,
        i_jal      => ex_mem_jal_in,
        i_PC4      => ex_mem_pc4_in
    );

    uut_mem_wb : MEM_WB port map (
        i_CLK      => clk,
        i_RST      => rst,
        i_stall    => mem_wb_stall,
        i_ALU      => mem_wb_alu_in,
        i_Mem      => mem_wb_mem_in,
        i_WrAddr   => mem_wb_wraddr_in,
        i_MemtoReg => mem_wb_memtoreg_in,
        i_Halt     => mem_wb_halt_in,
        i_RegWr    => mem_wb_regwr_in,
        i_jal      => mem_wb_jal_in,
        i_PC4      => mem_wb_pc4_in
    );

    -- Clock generation
    clk_process: process
    begin
        while now < 200 ns loop
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
        end loop;
        wait;
    end process;

    -- Stimulus process
    stim_process: process
    begin
        -- Initial reset
        rst <= '1';
        wait for 10 ns;
        rst <= '0';

        -- Test 1: Normal pipeline operation
        -- Inject values into IF/ID register
        if_id_pc4_in  <= x"00400000";
        if_id_inst_in <= x"8C010004"; -- lw $1, 4($0)
        wait for 10 ns;

        -- Values should propagate through pipeline
        assert if_id_pc4_out = x"00400000" 
            report "IF/ID PC4 not propagated correctly" 
            severity failure;
        assert if_id_inst_out = x"8C010004" 
            report "IF/ID Instruction not propagated correctly" 
            severity failure;

        -- Test 2: Stalling IF/ID Register
        if_id_stall <= '1';
        if_id_pc4_in <= x"00400004";
        if_id_inst_in <= x"20020005"; -- addi $2, $0, 5
        wait for 10 ns;

        -- Verify that outputs remain unchanged due to stall
        assert if_id_pc4_out = x"00400000"
            report "IF/ID PC4 changed during stall"
            severity failure;
        assert if_id_inst_out = x"8C010004"
            report "IF/ID Instruction changed during stall"
            severity failure;

        -- Remove stall
        if_id_stall <= '0';
        wait for 10 ns;

        -- Verify outputs update
        assert if_id_pc4_out = x"00400004"
            report "IF/ID PC4 not updated after stall removal"
            severity failure;
        assert if_id_inst_out = x"20020005"
            report "IF/ID Instruction not updated after stall removal"
            severity failure;

        -- Additional tests for ID/EX, EX/MEM, and MEM/WB registers
        -- Test initialization of ID/EX register
        id_ex_reset <= '1';
        wait for 10 ns;
        id_ex_reset <= '0';

        -- Test normal operation of ID/EX register
        id_ex_pc4_in <= x"00400008";
        id_ex_regA_in <= x"0000000A";
        id_ex_regB_in <= x"00000014";
        id_ex_imm_in <= x"00000028";
        id_ex_rt_in <= "00010";
        id_ex_rd_in <= "00011";
        id_ex_regdst_in <= '1';
        id_ex_regwr_in <= '1';
        id_ex_memtoreg_in <= '1';
        id_ex_memwr_in <= '0';
        id_ex_alusrc_in <= '1';
        id_ex_aluop_in <= "0010";
        id_ex_jal_in <= '0';
        id_ex_halt_in <= '0';
        id_ex_rs_in <= "00001";
        id_ex_memrd_in <= '1';

        wait for 10 ns;

        -- Verify outputs of ID/EX register
        assert id_ex_pc4_in = x"00400008"
            report "ID/EX PC4 not propagated correctly"
            severity failure;

        -- Continue similarly for EX/MEM and MEM/WB registers as needed
        -- Add specific scenarios for stalling, reset, or special cases

        wait;
    end process;
end testbench;
