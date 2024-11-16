-------------------------------------------------------------------------
-- author(s): Conner Ohnesorge & Levi Wenck
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- MIPS_Processor.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains types that we use in our MIPS 
-- processor -- This file is guarenteed to compile first, so if any 
-- types, constants, functions, etc., etc., are wanted, students should 
-- declare them here.
-------------------------------------------------------------------------

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
  type twodarray is array (31 downto 0) of std_logic_vector(31 downto 0);  --TODO rename this to array_32x32

  type array_16x32 is array (15 downto 0) of std_logic_vector(31 downto 0);

  function bit_reverse(s1 : std_logic_vector) return std_logic_vector;
  --It reverses the bits of std_logic_vector
  --ie LSB becomes MSB and vice-versa
  --Example 01100000 becomes 00000110

end package MIPS_types;

package body MIPS_types is
  -- Probably won't need anything here... function bodies, etc.

  -- bit_reverse is a function that reverses the bits of a std_logic_vector
  function bit_reverse(s1 : std_logic_vector) return std_logic_vector is
    variable rr : std_logic_vector(s1'high downto s1'low);
  begin
    for ii in s1'high downto s1'low loop
      rr(ii) := s1(s1'high-ii);
    end loop;
    return rr;
  end bit_reverse;

  -- clog2 is a function that returns the ceiling of the log base 2 of a number
  function clog2(n : integer) return integer is
    variable res : integer := 0;
    variable tmp : integer := n - 1;
  begin
    while tmp > 0 loop
      tmp := tmp / 2;
      res := res + 1;
    end loop;
    return res;
  end function;
end package body MIPS_types;
