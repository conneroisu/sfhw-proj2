-- <header>
-- Author(s): Conner Ohnesorge
-- Name: 
-- Notes:
--      Conner Ohnesorge 2024-11-21T11:05:34-06:00 added-old-single-cycle-processor-and-added-documentation-for-the
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

