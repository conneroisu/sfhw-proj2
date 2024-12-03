-- <header>
-- Author(s): Conner Ohnesorge
-- Name: 
-- Notes:
--      Conner Ohnesorge 2024-11-21T09:20:04-06:00 added-buffers-for-sf-pipeline
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;

entity if_id_reg is
    port (
        i_CLK  : in  std_logic;
        i_RST  : in  std_logic;
        i_PCP4 : in  std_logic_vector(31 downto 0);
        i_Inst : in  std_logic_vector(31 downto 0);
        o_PCP4 : out std_logic_vector(31 downto 0);
        o_Inst : out std_logic_vector(31 downto 0)
        );
end if_id_reg;

architecture structural of if_id_reg is
    component reg is
        generic (N : integer := 32);
        port (
            i_CLK  : in  std_logic;
            i_RST  : in  std_logic;
            i_WEn  : in  std_logic;
            i_Data : in  std_logic_vector(N-1 downto 0);
            o_Data : out std_logic_vector(N-1 downto 0)
            );
    end component;
begin
    PCP4_reg : reg port map (i_CLK, i_RST, '1', i_PCP4, o_PCP4);
    Inst_reg : reg port map (i_CLK, i_RST, '1', i_Inst, o_Inst);

end structural;

