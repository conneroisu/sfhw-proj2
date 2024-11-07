-- <header>
-- Author(s): Conner Ohnesorge, conneroisu
-- Name: proj/src/LowLevel/xorg2.vhd
-- Notes:
--      Conner Ohnesorge  <connerohnesorge@localhost.localdomain> remove-mips_types-from-low-level-components
--      Conner Ohnesorge  <connerohnesorge@localhost.localdomain> fix-all-low-level-components-not-including-all-packages
--      conneroisu  <conneroisu@outlook.com> manually-ran-the-header-update-script
--      conneroisu  <conneroisu@outlook.com> even-better-file-header-program
--      conneroisu  <conneroisu@outlook.com> fixed-and-added-back-the-git-cdocumentor-for-the-vhdl-files-to-have
--      conneroisu  <conneroisu@outlook.com> add-lowlevel-components-and-testbenches
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity xorg2 is
    port (
        i_A : in  std_logic;
        i_B : in  std_logic;
        o_F : out std_logic
        );
end xorg2;
architecture dataflow of xorg2 is
begin
    o_F <= i_A xor i_B;
end dataflow;
