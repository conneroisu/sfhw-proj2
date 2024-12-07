-- <header>
-- Author(s): Conner Ohnesorge
-- Name: 
-- Notes:
--      Conner Ohnesorge 2024-12-03T22:44:14-06:00 better-spacing-and-remove-commented-out-signal-code
--      Conner Ohnesorge 2024-12-03T20:41:30-06:00 make-fit-style-guide
--      Conner Ohnesorge 2024-12-03T20:41:09-06:00 make-extended16t32-fit-style-guide
--      Conner Ohnesorge 2024-12-01T12:19:14-06:00 moved-all-files-into-the-hardware-directory
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

