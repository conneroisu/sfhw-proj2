-- <header>
-- Author(s): Conner Ohnesorge, aidanfoss
-- Name: proj/src/LowLevel/extender8t32.vhd
-- Notes:
--      connero 2024-11-11T09:11:16-06:00 Merge-branch-main-into-component-forward-unit
--      Conner Ohnesorge 2024-11-07T09:51:12-06:00 progress-on-stage-2
--      aidanfoss 2024-11-07T09:37:43-06:00 create-exmem-stage
-- </header>

library ieee;
use ieee.std_logic_1164.all;

entity extender8t32 is
    port(
        i_I : in  std_logic_vector(7 downto 0);  -- byte value
        i_C : in  std_logic;                     -- signed extender or unsigned
        o_O : out std_logic_vector(31 downto 0)  -- 32 bit extended value
        );
end extender8t32;

architecture dataflow of extender8t32 is
    signal ext_bit  : std_logic;                      -- sign extension bit
    signal extended : std_logic_vector(31 downto 0);  -- extended immediate
begin

    o_O(7 downto 0) <= i_I(7 downto 0);  --copy bits we already have

    with i_C select  --determined if signed extension or unsigned
    ext_bit <= '0' when '0',
               i_I(7) when others;

    G2 : for i in 8 to 31 generate      -- add on our extension
        o_O(i) <= ext_bit;
    end generate;


end dataflow;

