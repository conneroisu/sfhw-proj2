-- <header>
-- Author(s): Conner Ohnesorge
-- Name: internal/boilerplate_src/MIPS_types.vhd
-- Notes:
--      conneroisu 2024-11-14T14:56:19Z Format-and-Header
--      conneroisu 2024-11-11T15:44:17Z Format-and-Header
--      Conner Ohnesorge 2024-11-07T08:35:18-06:00 run-manual-update-to-header-program-and-run-it
--      Conner Ohnesorge 2024-10-31T09:22:17-05:00 Added-init-files
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

