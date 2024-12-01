library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use work.MIPS_types.all;

entity Branch_Unit is

    port (
        i_Clk          : in  std_logic;
        i_Reset        : in  std_logic;
        i_WriteEnable  : in  std_logic;
        i_Flush        : in  std_logic;
        i_Stall        : in  std_logic;
        i_PCplus4      : in  std_logic_vector(31 downto 0);
        i_BranchTarget : in  std_logic_vector(31 downto 0);
        i_addr         : in  std_logic_vector(31 downto 0);
        o_addr         : out std_logic_vector(31 downto 0);
        o_Sign         : out std_logic_vector(31 downto 0);
        o_BranchCtrl   : out std_logic_vector(5 downto 0);
        o_BranchAddr   : out std_logic_vector(31 downto 0);
        o_BranchTaken  : out std_logic
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

    signal s_PredictionScheme : std_logic_vector(1 downto 0);
    signal s_BranchTarget     : std_logic_vector(31 downto 0);
begin

    BranchTargetReg : dffg_n
        generic map (2)
        port map(i_Clk, i_Reset, i_WriteEnable, i_BranchTarget, s_BranchTarget);

end architecture structural;
