library IEEE;
use IEEE.std_logic_1164.all;

entity id_ex_reg is
    port (
        i_CLK           : in  std_logic;
        i_RST           : in  std_logic;
        i_PCP4          : in  std_logic_vector(31 downto 0);
        i_new_pc        : in  std_logic_vector(31 downto 0);
        i_do_branch     : in  std_logic;
        i_CntrlRegWrite : in  std_logic;
        i_RegDst        : in  std_logic_vector(1 downto 0);
        i_jump          : in  std_logic_vector(1 downto 0);
        i_memSel        : in  std_logic_vector(1 downto 0);
        i_ALUSrc        : in  std_logic;
        i_ALUOp         : in  std_logic_vector(2 downto 0);
        i_DMemWr        : in  std_logic;
        i_Halt          : in  std_logic;
        i_dsrc1         : in  std_logic_vector(31 downto 0);
        i_dsrc2         : in  std_logic_vector(31 downto 0);
        i_sign_ext_imm  : in  std_logic_vector(31 downto 0);
        i_Inst_rt       : in  std_logic_vector(4 downto 0);
        i_Inst_rd       : in  std_logic_vector(4 downto 0);
        i_Inst_funct    : in  std_logic_vector(5 downto 0);
        i_Inst_lui      : in  std_logic_vector(15 downto 0);
        i_Inst_shamt    : in  std_logic_vector(4 downto 0);
        o_PCP4          : out std_logic_vector(31 downto 0);
        o_new_pc        : out std_logic_vector(31 downto 0);
        o_do_branch     : out std_logic;
        o_CntrlRegWrite : out std_logic;
        o_RegDst        : out std_logic_vector(1 downto 0);
        o_jump          : out std_logic_vector(1 downto 0);
        o_memSel        : out std_logic_vector(1 downto 0);
        o_ALUSrc        : out std_logic;
        o_ALUOp         : out std_logic_vector(2 downto 0);
        o_DMemWr        : out std_logic;
        o_Halt          : out std_logic;
        o_dsrc1         : out std_logic_vector(31 downto 0);
        o_dsrc2         : out std_logic_vector(31 downto 0);
        o_sign_ext_imm  : out std_logic_vector(31 downto 0);
        o_Inst_rt       : out std_logic_vector(4 downto 0);
        o_Inst_rd       : out std_logic_vector(4 downto 0);
        o_Inst_funct    : out std_logic_vector(5 downto 0);
        o_Inst_lui      : out std_logic_vector(15 downto 0);
        o_Inst_shamt    : out std_logic_vector(4 downto 0)
        );
end id_ex_reg;

architecture structural of id_ex_reg is
    component reg is
        generic (N : integer := 32);
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
    ALUSrc_reg     : dffg port map (i_CLK, i_RST, '1', i_ALUSrc, o_ALUSrc);
    ALUOp_reg      : reg generic map (3) port map (i_CLK, i_RST, '1', i_ALUOp, o_ALUOp);
    DMemWr_reg     : dffg port map (i_CLK, i_RST, '1', i_DMemWr, o_DMemWr);
    Halt_reg       : dffg port map (i_CLK, i_RST, '1', i_Halt, o_Halt);
    dsrc1_reg      : reg port map (i_CLK, i_RST, '1', i_dsrc1, o_dsrc1);
    dsrc2_reg      : reg port map (i_CLK, i_RST, '1', i_dsrc2, o_dsrc2);
    sign_ext_reg   : reg port map (i_CLK, i_RST, '1', i_sign_ext_imm, o_sign_ext_imm);
    Inst_rt_reg    : reg generic map (5) port map (i_CLK, i_RST, '1', i_Inst_rt, o_Inst_rt);
    Inst_rd_reg    : reg generic map (5) port map (i_CLK, i_RST, '1', i_Inst_rd, o_Inst_rd);
    Inst_funct_reg : reg generic map (6) port map (i_CLK, i_RST, '1', i_Inst_funct, o_Inst_funct);
    Inst_lui_reg   : reg generic map (16) port map (i_CLK, i_RST, '1', i_Inst_lui, o_Inst_lui);
    Inst_shamt_reg : reg generic map (5) port map (i_CLK, i_RST, '1', i_Inst_shamt, o_Inst_shamt);

end structural;
