-- <header>
-- Author(s): Conner Ohnesorge
-- Name: 
-- Notes:
--      Conner Ohnesorge 2024-12-01T12:19:14-06:00 moved-all-files-into-the-hardware-directory
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;

-- Package Declaration of the MIPS_types package
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

    type bus_array is array (natural range <>) of std_logic_vector;

    function bit_reverse(s1 : std_logic_vector) return std_logic_vector;
    --It reverses the bits of std_logic_vector
    --ie LSB becomes MSB and vice-versa
    --Example 01100000 becomes 00000110

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

