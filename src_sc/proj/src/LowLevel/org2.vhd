-- <header>
-- Author(s): Conner Ohnesorge
-- Name: 
-- Notes:
--      Conner Ohnesorge 2024-11-21T11:05:34-06:00 added-old-single-cycle-processor-and-added-documentation-for-the
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

