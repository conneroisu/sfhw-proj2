-- <header>
-- Author(s): Conner Ohnesorge
-- Name: 
-- Notes:
--      Conner Ohnesorge 2024-12-04T07:44:46-06:00 updated-the-software-pipeline-to-use-the-simplified-contgrol-flow
--      Conner Ohnesorge 2024-12-01T16:16:23-06:00 make-extender16t32-fit-styleguide
--      Conner Ohnesorge 2024-12-01T15:20:49-06:00 update-low-level-components
--      Conner Ohnesorge 2024-11-21T09:00:59-06:00 added-start-of-sf-pipeline-folder
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.MIPS_types.all;

entity extender16t32 is

    port(
        i_I : in  std_logic_vector(15 downto 0);  -- 16 bit immediate
        i_C : in  std_logic;            -- signed extender or unsigned
        o_O : out std_logic_vector(31 downto 0)   -- 32 bit extended immediate
        );

end extender16t32;

architecture dataflow of extender16t32 is
    signal ext_bit : std_logic;         -- sign extension bit
begin

    o_O(15 downto 0) <= i_I(15 downto 0);  --copy bits we already have
    with i_C select  --determined if signed extension or unsigned
    ext_bit          <= '0' when '0',
               i_I(15) when others;
    G2 : for i in 16 to 31 generate     -- add on our extension
        o_O(i) <= ext_bit;
    end generate;
end dataflow;

