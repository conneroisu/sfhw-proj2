-- <header>
-- Author(s): Conner Ohnesorge
-- Name: 
-- Notes:
--      Conner Ohnesorge 2024-12-01T12:19:14-06:00 moved-all-files-into-the-hardware-directory
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity org2 is
    port (
        i_a : in  std_logic;
        i_b : in  std_logic;
        o_f : out std_logic
        );
end entity org2;
architecture dataflow of org2 is
begin
    o_f <= i_a or i_b;
end architecture dataflow;

