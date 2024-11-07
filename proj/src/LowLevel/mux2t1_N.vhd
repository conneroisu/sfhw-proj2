-- <header>
-- Author(s): dmvp01, Conner Ohnesorge, conneroisu
-- Name: proj/src/LowLevel/mux2t1_N.vhd
-- Notes:
--      dmvp01  <dmvp01@linuxvdi-23.ece.iastate.edu> adding-mux2t1_n-file-causing-issues-when-mergin
--      Conner Ohnesorge  <connerohnesorge@localhost.localdomain> fix-all-low-level-components-not-including-all-packages
--      dmvp01  <dmvp01@linuxvdi-11.ece.iastate.edu> adding-fixes-for-ALU-and-other-low-level-components
--      conneroisu  <conneroisu@outlook.com> manually-ran-the-header-update-script
--      conneroisu  <conneroisu@outlook.com> even-better-file-header-program
--      conneroisu  <conneroisu@outlook.com> fixed-and-added-back-the-git-cdocumentor-for-the-vhdl-files-to-have
--      conneroisu  <conneroisu@outlook.com> add-lowlevel-components-and-testbenches
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.MIPS_types.all;
entity mux2t1_N is
    generic (
        N : integer := 32
        );
    port (
        i_S  : in  std_logic;           -- Select input.
        i_D0 : in  std_logic_vector(N - 1 downto 0);  -- Input data width is N.
        i_D1 : in  std_logic_vector(N - 1 downto 0);  -- Input data width is N.
        o_O  : out std_logic_vector(N - 1 downto 0)  -- Output data width is N.
        );
end mux2t1_N;
-- Architecture Declaration.
architecture structural of mux2t1_N is
    component mux2t1 is
        port (
            i_S  : in  std_logic;       -- Select input.
            i_D0 : in  std_logic;       -- Data 0 input.
            i_D1 : in  std_logic;       -- Data 1 input.
            o_O  : out std_logic        -- Data output.
            );
    end component;
begin
    -- Instantiate N mux instances.
    G_NBit_MUX : for i in 0 to N - 1 generate
        MUXI : mux2t1 port map(
            i_S  => i_S,    -- All instances share the same select input.
            i_D0 => i_D0(i),  -- ith instance's data 0 input bound to ith data 0 input.
            i_D1 => i_D1(i),  -- ith instance's data 1 input bound to ith data 1 input.
            o_O  => o_O(i)  -- ith instance's data output bound to ith data output.
            );
    end generate G_NBit_MUX;
end structural;
