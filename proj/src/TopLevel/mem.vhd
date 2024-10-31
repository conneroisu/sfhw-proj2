-- <header>
-- Author(s): conneroisu, Conner Ohnesorge
-- Name: internal/boilerplate_src/TopLevel/mem.vhd
-- Notes:
--      conneroisu  <conneroisu@outlook.com> manually-ran-the-header-update-script
--      conneroisu  <conneroisu@outlook.com> even-better-file-header-program
--      conneroisu  <conneroisu@outlook.com> fixed-and-added-back-the-git-cdocumentor-for-the-vhdl-files-to-have
--      Conner Ohnesorge  <connero@iastate.edu> remove-the-header-comment-from-mem.vhd-so-header-tool-can-work
--      Conner Ohnesorge  <connero@iastate.edu> remove-the-header-comment-from-mem.vhd-so-header-tool-can-work
--      Conner Ohnesorge  <connero@iastate.edu> added-toolflow
-- </header>

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mem is

    generic
        (
            DATA_WIDTH : natural := 32;
            ADDR_WIDTH : natural := 10
            );

    port
        (
            clk  : in  std_logic;
            addr : in  std_logic_vector((ADDR_WIDTH-1) downto 0);
            data : in  std_logic_vector((DATA_WIDTH-1) downto 0);
            we   : in  std_logic := '1';
            q    : out std_logic_vector((DATA_WIDTH -1) downto 0)
            );

end mem;

architecture rtl of mem is

    -- Build a 2-D array type for the RAM
    subtype word_t is std_logic_vector((DATA_WIDTH-1) downto 0);
    type memory_t is array(2**ADDR_WIDTH-1 downto 0) of word_t;

    -- Declare the RAM signal and specify a default value.      Quartus Prime
    -- will load the provided memory initialization file (.mif).
    signal ram : memory_t;

begin

    process(clk)
    begin
        if(rising_edge(clk)) then
            if(we = '1') then
                ram(to_integer(unsigned(addr))) <= data;
            end if;
        end if;
    end process;

    q <= ram(to_integer(unsigned(addr)));

end rtl;
















