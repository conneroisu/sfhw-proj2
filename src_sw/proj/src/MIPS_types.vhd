-- <header>
-- Author(s): Conner Ohnesorge
-- Name: src_sw/proj/src/MIPS_types.vhd
-- Notes:
--      Conner Ohnesorge 2024-11-21T09:00:59-06:00 added-start-of-sf-pipeline-folder
-- </header>

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

