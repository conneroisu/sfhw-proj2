-- <header>
-- Author(s): conneroisu
-- Name: proj/test/tb_decoder_5t32.vhd
-- Notes:
--      conneroisu  <conneroisu@outlook.com> manually-ran-the-header-update-script
--      conneroisu  <conneroisu@outlook.com> even-better-file-header-program
--      conneroisu  <conneroisu@outlook.com> fixed-and-added-back-the-git-cdocumentor-for-the-vhdl-files-to-have
--      conneroisu  <conneroisu@outlook.com> add-missing-assembly-files
--      conneroisu  <conneroisu@outlook.com> add-missing-assembly-files
-- </header>

library ieee;
use ieee.std_logic_1164.all;

entity tb_decoder_5to32 is
end entity tb_decoder_5to32;

architecture behavior of tb_decoder_5to32 is
    signal i_input  : std_logic_vector(4 downto 0);
    signal o_output : std_logic_vector(31 downto 0);

    component decoder_5to32
        port (
            i_input  : in  std_logic_vector(4 downto 0);
            o_output : out std_logic_vector(31 downto 0)
            );
    end component;

begin
    uut : decoder_5to32
        port map (
            i_input  => i_input,
            o_output => o_output
            );

    process
    begin
        for i in 0 to 31 loop
            i_input <= std_logic_vector(to_unsigned(i, 5));
            wait for 10 ns;
            assert o_output = ("00000000000000000000000000000001" sll i)
                report "Test failed for input " & integer'image(i)
                severity error;
        end loop;
        wait;
    end process;

end architecture behavior;
















