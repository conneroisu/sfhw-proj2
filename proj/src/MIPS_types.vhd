-- <header>
-- Author(s): conneroisu, Conner Ohnesorge
-- Name: internal/boilerplate_src/MIPS_types.vhd
-- Notes:
--      conneroisu  <conneroisu@outlook.com> manually-ran-the-header-update-script
--      conneroisu  <conneroisu@outlook.com> even-better-file-header-program
--      conneroisu  <conneroisu@outlook.com> fixed-and-added-back-the-git-cdocumentor-for-the-vhdl-files-to-have
--      Conner Ohnesorge  <connero@iastate.edu> added-toolflow
-- </header>

-------------------------------------------------------------------------
-- Author: Braedon Giblin
-- Date: 2022.02.12
-- Files: MIPS_types.vhd
-------------------------------------------------------------------------
-- Description: This file contains a skeleton for some types that 381 students
-- may want to use. This file is guarenteed to compile first, so if any types,
-- constants, functions, etc., etc., are wanted, students should declare them
-- here.
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
package MIPS_types is
    -- Example Constants. Declare more as needed
    constant DATA_WIDTH : integer := 32;
    constant ADDR_WIDTH : integer := 10;
    -- Example record type. Declare whatever types you need here
    type control_t is record
        reg_wr     : std_logic;
        reg_to_mem : std_logic;
    end record control_t;
end package MIPS_types;
package body MIPS_types is
-- Probably won't need anything here... function bodies, etc.
end package body MIPS_types;
