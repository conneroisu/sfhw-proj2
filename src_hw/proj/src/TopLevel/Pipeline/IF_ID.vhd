library IEEE;
use IEEE.std_logic_1164.all;

entity IF_ID is

    port (
        i_CLK         : in  std_logic;
        i_RST         : in  std_logic;
        i_stall       : in  std_logic;
        i_PC4         : in  std_logic_vector(31 downto 0);
        i_instruction : in  std_logic_vector(31 downto 0);
        o_PC4         : out std_logic_vector(31 downto 0);
        o_instruction : out std_logic_vector(31 downto 0)
        );

end IF_ID;

architecture structural of IF_ID is

    component dffg_N is
        generic (N : integer := 32);
        port (
            i_CLK : in  std_logic;
            i_RST : in  std_logic;
            i_WE  : in  std_logic;
            i_D   : in  std_logic_vector(N - 1 downto 0);
            o_Q   : out std_logic_vector(N - 1 downto 0));
    end component;

    signal s_stall : std_logic;

begin
    s_stall <= not i_stall;

    instPCPlus4Reg : dffg_N
        generic map(N => 32)
        port map(
            i_CLK => i_CLK,
            i_RST => i_RST,
            i_WE  => s_stall,
            i_D   => i_PC4,
            o_Q   => o_PC4);

    instInstructionReg : dffg_N
        generic map(N => 32)
        port map(
            i_CLK => i_CLK,
            i_RST => i_RST,
            i_WE  => s_stall,
            i_D   => i_instruction,
            o_Q   => o_instruction);

end structural;
