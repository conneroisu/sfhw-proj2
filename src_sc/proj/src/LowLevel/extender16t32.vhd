-- <header>
-- Author(s): Conner Ohnesorge, conneroisu
-- Name: proj/src/LowLevel/extender16t32.vhd
-- Notes:
--      Conner Ohnesorge  <connerohnesorge@localhost.localdomain> fix-all-low-level-components-not-including-all-packages
--      conneroisu  <conneroisu@outlook.com> manually-ran-the-header-update-script
--      conneroisu  <conneroisu@outlook.com> even-better-file-header-program
--      conneroisu  <conneroisu@outlook.com> fixed-and-added-back-the-git-cdocumentor-for-the-vhdl-files-to-have
--      Conner Ohnesorge  <connero@iastate.edu> disable-formatter-and-add-extender16t32
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.MIPS_types.all;
entity extender16t32 is
    port(
        i_I : in  std_logic_vector(15 downto 0);      -- 16 bit immediate
        i_C : in  std_logic;            -- signed extender or unsigned
        o_O : out std_logic_vector(31 downto 0)  -- 32 bit extended immediate
        );
end extender16t32;
architecture dataflow of extender16t32 is
    signal ext_bit  : std_logic;        -- sign extension bit
    signal extended : std_logic_vector(31 downto 0);  -- extended immediate
begin
    o_O(15 downto 0) <= i_I(15 downto 0);        --copy bits we already have
    with i_C select  --determined if signed extension or unsigned
    ext_bit          <= '0' when '0',
               i_I(15) when others;
    G2 : for i in 16 to 31 generate     -- add on our extension
        o_O(i) <= ext_bit;
    end generate;
end dataflow;
