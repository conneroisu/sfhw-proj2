-- <header>
-- Author(s): Conner Ohnesorge, conneroisu, awfoss
-- Name: proj/src/MIPS_types.vhd
-- Notes:
--      Conner Ohnesorge  <connerohnesorge@localhost.localdomain> fix-not-using-the-numeric_std-lib-from-ieee
--      conneroisu  <conneroisu@outlook.com> remove-space-at-end-of-file
--      conneroisu  <conneroisu@outlook.com> manually-ran-the-header-update-script
--      awfoss  <awfoss@co2050-01.ece.iastate.edu> debugged-had-to-do-some-weird-declarations-to-avoid-a-static-error-I-think-not-sure-why-I-had-to-make-so-many-signals.-Could-use-some-work-to-improve-perhaps
--      conneroisu  <conneroisu@outlook.com> even-better-file-header-program
--      conneroisu  <conneroisu@outlook.com> fixed-and-added-back-the-git-cdocumentor-for-the-vhdl-files-to-have
--      Conner Ohnesorge  <connero@iastate.edu> update-MIPS_types-in-context-of-the-register_file
--      Conner Ohnesorge  <connero@iastate.edu> update-MIPS_types-in-context-of-the-register_file
--      conneroisu  <conneroisu@outlook.com> added-toolflow-generated-project-layout
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
package MIPS_types is
    -- Example Constants. Declare more as needed
    constant DATA_WIDTH : integer := 32;
    constant ADDR_WIDTH : integer := 10;
    -- Example record type. Declare whatever types you need here
    type control_t is record
        reg_wr     : std_logic;
        reg_to_mem : std_logic;
    end record control_t;
    -- 2D array type. 
    type twodarray is array (31 downto 0) of std_logic_vector(31 downto 0);
    type array_16x32 is array (15 downto 0) of std_logic_vector(31 downto 0);
    function bit_reverse(s1 : std_logic_vector) return std_logic_vector;
end package MIPS_types;
package body MIPS_types is
    -- Probably won't need anything here... function bodies, etc.
    function bit_reverse(s1 : std_logic_vector) return std_logic_vector is
        variable rr : std_logic_vector(s1'high downto s1'low);
    begin
        for ii in s1'high downto s1'low loop
            rr(ii) := s1(s1'high-ii);
        end loop;
        return rr;
    end bit_reverse;
end package body MIPS_types;
