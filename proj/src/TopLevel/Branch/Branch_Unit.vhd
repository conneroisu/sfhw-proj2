library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use work.MIPS_types.all;

entity Branch_Unit is

    port (
        i_clk          : in  std_logic;
        i_rst          : in  std_logic;
        i_WriteEnable  : in  std_logic;
        i_Flush        : in  std_logic;
        i_Stall        : in  std_logic;
        i_Extended     : in  std_logic_vector(31 downto 0);
        i_PCplus4      : in  std_logic_vector(31 downto 0);
        i_sctrl        : in  std_logic;  --sign control signal
        o_regw         : out std_logic;  --register write signal
        i_addr         : in  std_logic_vector(31 downto 0);
        o_addr         : out std_logic_vector(31 downto 0);
        o_d1           : out std_logic_vector(31 downto 0);
        o_d2           : out std_logic_vector(31 downto 0);
        o_sign         : out std_logic_vector(31 downto 0);
        o_branch_ctrl  : out std_logic_vector(5 downto 0);
        o_BranchAddr   : out std_logic_vector(31 downto 0);
        o_branch_taken : out std_logic
        );

end entity Branch_Unit;

architecture structural of Branch_Unit is

    component dffg_n is
        generic(N : integer := 32);
        port(
            i_CLK : in  std_logic;
            i_RST : in  std_logic;
            i_WrE : in  std_logic;
            i_D   : in  std_logic_vector(N-1 downto 0);
            o_Q   : out std_logic_vector(N-1 downto 0)
            );
    end component;

    signal s_PCplus4 : std_logic_vector(31 downto 0);
begin

    PCP4_reg : dffg_n                   -- output of adder, output pc+4
        generic map (32)
        port map(i_CLK, i_RST, i_WriteEnable, i_PCplus4, s_PCplus4);

    -- Add 2x shifted extended value to PCplus4
    o_BranchAddr <= std_logic_vector(
        unsigned(std_logic_vector(shift_left(unsigned(i_Extended), 2))) + unsigned(i_PCplus4)
        );

end architecture structural;
