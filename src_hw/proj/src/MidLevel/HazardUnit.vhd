-- <header>
-- Author(s): connerohnesorge, Conner Ohnesorge
-- Name: 
-- Notes:
--      connerohnesorge 2024-12-04T18:06:41-06:00 better-spacing-in-hazardunit-and-make-sure-it-follows-styleguide
--      Conner Ohnesorge 2024-12-04T00:49:07-06:00 latest
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;

entity HazardUnit is

    port(
        i_jump_ID   : in  std_logic;
        i_branch_ID : in  std_logic;
        i_rAddrA    : in  std_logic_vector(4 downto 0);
        i_rAddrB    : in  std_logic_vector(4 downto 0);
        i_wAddr_ID  : in  std_logic_vector(4 downto 0);  -- ID Write Address
        i_wAddr_EX  : in  std_logic_vector(4 downto 0);  -- MEM Write Address 
        i_wE_ID     : in  std_logic;                     -- ID Write enable
        i_wE_EX     : in  std_logic;                     -- MEM Write enable
        o_stall     : out std_logic;
        o_flush     : out std_logic
        );

end HazardUnit;

architecture mixed of HazardUnit is
begin
    process(i_jump_ID,
            i_branch_ID,
            i_rAddrA,
            i_rAddrB,
            i_wAddr_ID,
            i_wAddr_EX,
            i_wE_ID,
            i_wE_EX)
    begin
        --case 1
        if((i_wE_ID = '1' and i_rAddrA = i_wAddr_ID and i_rAddrA /= "00000")
           or (i_wE_EX = '1' and i_rAddrA = i_wAddr_EX and i_rAddrA /= "00000"))
        then                            -- Reading Reg A Hazard
            o_stall <= '1';
            o_flush <= '0';


        --case 2
        elsif ((i_wE_ID = '1' and i_rAddrB = i_wAddr_ID and i_rAddrB /= "00000")
               or (i_wE_EX = '1' and i_rAddrB = i_wAddr_EX and i_rAddrB /= "00000"))
        then                            --RegReadB Hazard
            o_stall <= '1';
            o_flush <= '0';

        --case 3
        elsif(
            i_jump_ID = '1' or
            i_branch_ID = '1') then
            o_flush <= '1';             --Control Hazard 
            o_stall <= '0';

        --case 4
        else
            o_stall <= '0';
            o_flush <= '0';

        end if;
    end process;
end mixed;

