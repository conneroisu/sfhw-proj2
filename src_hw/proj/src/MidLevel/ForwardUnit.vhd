-- <header>
-- Author(s): connerohnesorge, Conner Ohnesorge
-- Name: 
-- Notes:
--      connerohnesorge 2024-12-04T18:07:19-06:00 simplify-forwardunit-comment
--      Conner Ohnesorge 2024-12-04T00:49:07-06:00 latest
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;

entity ForwardUnit is
    generic (N : integer := 32);

    port (
        i_EX_rs     : in  std_logic_vector(4 downto 0);
        i_EX_rt     : in  std_logic_vector(4 downto 0);
        i_MEM_rd    : in  std_logic_vector(4 downto 0);
        i_WB_rd     : in  std_logic_vector(4 downto 0);
        i_MEM_wb    : in  std_logic;
        i_WB_wb     : in  std_logic;
        o_Forward_A : out std_logic_vector(1 downto 0);
        o_Forward_B : out std_logic_vector(1 downto 0)
        );

end ForwardUnit;



architecture mixed of ForwardUnit is

begin
    -- 00: no forward
    -- 10: EX hazard, value from MEM state
    -- 01: MEM hazard, value from WB state

    process(i_MEM_wb, i_WB_wb, i_EX_rs, i_EX_rt, i_MEM_rd, i_WB_rd)
    begin

        o_Forward_A <= "00";
        o_Forward_B <= "00";

        --case 1: 
        if i_WB_wb = '1' and i_WB_rd = i_EX_rs and i_WB_rd /= "00000" then
            o_Forward_A <= "01";
        end if;

        --case 2: 
        if i_WB_wb = '1' and i_WB_rd = i_EX_rt and i_WB_rd /= "00000"then
            o_Forward_B <= "01";
        end if;
        --case 3: 
        if i_MEM_wb = '1' and i_MEM_rd = i_EX_rs and i_MEM_rd /= "00000" then
            o_Forward_A <= "10";
        end if;

        --case 4: 
        if i_MEM_wb = '1' and i_MEM_rd = i_EX_rt and i_MEM_rd /= "00000" then
            o_Forward_B <= "10";
        end if;

    end process;
end mixed;

