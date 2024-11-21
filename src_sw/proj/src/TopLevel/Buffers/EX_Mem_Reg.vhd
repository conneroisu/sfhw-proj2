library ieee;
use IEEE.std_logic_1164.all;

entity ex_mem_reg is
    port (
        i_CLK           : in  std_logic;
        i_RST           : in  std_logic;
        i_PCP4          : in  std_logic_vector(31 downto 0);
        i_new_pc        : in  std_logic_vector(31 downto 0);
        i_do_branch     : in  std_logic;
        i_memSel        : in  std_logic_vector(1 downto 0);
        i_CntrlRegWrite : in  std_logic;
        i_RegDst        : in  std_logic_vector(1 downto 0);
        i_DMemWr        : in  std_logic;
        i_jump          : in  std_logic_vector(1 downto 0);
        i_dsrc2         : in  std_logic_vector(31 downto 0);
        i_Halt          : in  std_logic;
        i_ALUOut        : in  std_logic_vector(31 downto 0);
        i_lui_val       : in  std_logic_vector(31 downto 0);
        i_Inst_rt       : in  std_logic_vector(4 downto 0);
        i_Inst_rd       : in  std_logic_vector(4 downto 0);
        o_PCP4          : out std_logic_vector(31 downto 0);
        o_new_pc        : out std_logic_vector(31 downto 0);
        o_do_branch     : out std_logic;
        o_memSel        : out std_logic_vector(1 downto 0);
        o_CntrlRegWrite : out std_logic;
        o_RegDst        : out std_logic_vector(1 downto 0);
        o_DMemWr        : out std_logic;
        o_jump          : out std_logic_vector(1 downto 0);
        o_dsrc2         : out std_logic_vector(31 downto 0);
        o_Halt          : out std_logic;
        o_ALUOut        : out std_logic_vector(31 downto 0);
        o_Inst_lui      : out std_logic_vector(31 downto 0);
        o_Inst_rt       : out std_logic_vector(4 downto 0);
        o_Inst_rd       : out std_logic_vector(4 downto 0)
        );
end ex_mem_reg;

architecture structural of ex_mem_reg is
    component reg is
        generic (N : integer := 32);    --Default 32 bit register
        port (i_CLK  : in  std_logic;
              i_RST  : in  std_logic;
              i_WEn  : in  std_logic;
              i_Data : in  std_logic_vector(N-1 downto 0);
              o_Data : out std_logic_vector(N-1 downto 0)
              );
    end component;
    component dffg is
        port(i_CLK : in  std_logic;     -- Clock input
             i_RST : in  std_logic;     -- Reset input
             i_WE  : in  std_logic;     -- Write enable input
             i_D   : in  std_logic;     -- Data value input
             o_Q   : out std_logic);    -- Data value output
    end component;

begin
    PCP4_reg       : reg port map (i_CLK, i_RST, '1', i_PCP4, o_PCP4);
    new_pc_reg     : reg port map (i_CLK, i_RST, '1', i_new_pc, o_new_pc);
    do_branch_reg  : dffg port map (i_CLK, i_RST, '1', i_do_branch, o_do_branch);
    CntrlRegWr_reg : dffg port map (i_CLK, i_RST, '1', i_CntrlRegWrite, o_CntrlRegWrite);
    RegDst_reg     : reg generic map (2) port map (i_CLK, i_RST, '1', i_RegDst, o_RegDst);
    jump_reg       : reg generic map (2) port map (i_CLK, i_RST, '1', i_jump, o_jump);
    memSel_reg     : reg generic map (2) port map (i_CLK, i_RST, '1', i_memSel, o_memSel);
    DMemWr_reg     : dffg port map (i_CLK, i_RST, '1', i_DMemWr, o_DMemWr);
    Halt_reg       : dffg port map (i_CLK, i_RST, '1', i_Halt, o_Halt);
    dsrc2_reg      : reg port map (i_CLK, i_RST, '1', i_dsrc2, o_dsrc2);
    ALUOut_reg     : reg port map (i_CLK, i_RST, '1', i_ALUOut, o_ALUOut);
    Inst_lui_reg   : reg port map (i_CLK, i_RST, '1', i_lui_val, o_Inst_lui);
    Inst_rt_reg    : reg generic map (5) port map (i_CLK, i_RST, '1', i_Inst_rt, o_Inst_rt);
    Inst_rd_reg    : reg generic map (5) port map (i_CLK, i_RST, '1', i_Inst_rd, o_Inst_rd);
end structural;
