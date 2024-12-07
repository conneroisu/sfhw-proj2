-- <header>
-- Author(s): Conner Ohnesorge, connerohnesorge
-- Name: 
-- Notes:
--      Conner Ohnesorge 2024-12-06T14:34:38-06:00 remove-empty-new-line
--      connerohnesorge 2024-12-06T07:22:29-06:00 update-IFID-stage-to-better-fit-style-guide
--      Conner Ohnesorge 2024-12-04T07:44:46-06:00 updated-the-software-pipeline-to-use-the-simplified-contgrol-flow
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;

entity IF_ID is

    port (
        i_CLK         : in  std_logic;
        i_RST         : in  std_logic;
        i_PC4         : in  std_logic_vector(31 downto 0);
        i_Instruction : in  std_logic_vector(31 downto 0);
        o_PC4         : out std_logic_vector(31 downto 0);
        o_Instruction : out std_logic_vector(31 downto 0)
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

begin

    instPCPlus4Reg : dffg_N
        generic map(N => 32)
        port map(
            i_CLK => i_CLK,
            i_RST => i_RST,
            i_WE  => '1',
            i_D   => i_PC4,
            o_Q   => o_PC4);

    instInstructionReg : dffg_N
        generic map(N => 32)
        port map(
            i_CLK => i_CLK,
            i_RST => i_RST,
            i_WE  => '1',
            i_D   => i_Instruction,
            o_Q   => o_Instruction);

end structural;

