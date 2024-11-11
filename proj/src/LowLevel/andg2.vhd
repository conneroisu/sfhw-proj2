-- <header>
-- Author(s): Conner Ohnesorge, aidanfoss
-- Name: proj/src/LowLevel/andg2.vhd
-- Notes:
--      conneroisu 2024-11-11T15:42:29Z Format-and-Header
--      Conner Ohnesorge 2024-11-07T09:51:12-06:00 progress-on-stage-2
--      aidanfoss 2024-11-07T09:37:43-06:00 create-exmem-stage
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity andg2 is
    port (
        i_A : in  std_logic;            -- input 1 to the AND gate
        i_B : in  std_logic;            -- input 2 to the AND gate
        o_F : out std_logic);           -- output of the AND gate
end andg2;
architecture dataflow of andg2 is
begin
    o_F <= i_A and i_B;        -- simple dataflow implementation of an AND gate
end dataflow;

