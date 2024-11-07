-- <header>
-- Author(s): Conner Ohnesorge, conneroisu
-- Name: proj/src/LowLevel/invg.vhd
-- Notes:
--      Conner Ohnesorge  <connerohnesorge@localhost.localdomain> fix-all-low-level-components-not-including-all-packages
--      conneroisu  <conneroisu@outlook.com> manually-ran-the-header-update-script
--      conneroisu  <conneroisu@outlook.com> added-bit-inverter-not-gate-and-one-bit-complementor-that-is
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.MIPS_types.all;
entity invg is
    port (
        i_A : in  std_logic;            -- Input to the NOT gate
        o_F : out std_logic             -- Output from the NOT gate
        );
end invg;
architecture dataflow of invg is
begin
    o_F <= not i_A;                     -- Output is the inverse of the input
end dataflow;
