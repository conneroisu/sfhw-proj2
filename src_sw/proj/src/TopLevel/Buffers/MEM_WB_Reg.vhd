-- <header>
-- Author(s): Conner Ohnesorge
-- Name: src_sw/proj/src/TopLevel/Buffers/MEM_WB_Reg.vhd
-- Notes:
--      Conner Ohnesorge 2024-11-21T09:20:04-06:00 added-buffers-for-sf-pipeline
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;

entity mem_wb_reg is
    port (
        i_CLK           : in  std_logic;
        i_RST           : in  std_logic;
        i_PCP4          : in  std_logic_vector(31 downto 0);
        i_new_pc        : in  std_logic_vector(31 downto 0);
        i_do_branch     : in  std_logic;
        i_memSel        : in  std_logic_vector(1 downto 0);
        i_CntrlRegWrite : in  std_logic;
        i_RegDst        : in  std_logic_vector(1 downto 0);
        i_jump          : in  std_logic_vector(1 downto 0);
        i_Halt          : in  std_logic;
        i_DMemOut       : in  std_logic_vector(31 downto 0);
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
        o_jump          : out std_logic_vector(1 downto 0);
        o_Halt          : out std_logic;
        o_DMemOut       : out std_logic_vector(31 downto 0);
        o_ALUOut        : out std_logic_vector(31 downto 0);
        o_lui_val       : out std_logic_vector(31 downto 0);
        o_Inst_rt       : out std_logic_vector(4 downto 0);
        o_Inst_rd       : out std_logic_vector(4 downto 0)
        );
end mem_wb_reg;

architecture structural of mem_wb_reg is
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
    Halt_reg       : dffg port map (i_CLK, i_RST, '1', i_Halt, o_Halt);
    DMemOut_reg    : reg port map (i_CLK, i_RST, '1', i_DMemOut, o_DMemOut);
    ALUOut_reg     : reg port map (i_CLK, i_RST, '1', i_ALUOut, o_ALUOut);
    Inst_lui_reg   : reg generic map (32) port map (i_CLK, i_RST, '1', i_lui_val, o_lui_val);
    Inst_rt_reg    : reg generic map (5) port map (i_CLK, i_RST, '1', i_Inst_rt, o_Inst_rt);
    Inst_rd_reg    : reg generic map (5) port map (i_CLK, i_RST, '1', i_Inst_rd, o_Inst_rd);
end structural;

