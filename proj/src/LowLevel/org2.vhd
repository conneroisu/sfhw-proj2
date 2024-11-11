-- <header>
-- Author(s): Conner Ohnesorge, aidanfoss
-- Name: proj/src/LowLevel/org2.vhd
-- Notes:
--      conneroisu 2024-11-11T15:42:29Z Format-and-Header
--      connero 2024-11-11T09:11:16-06:00 Merge-branch-main-into-component-forward-unit
--      Conner Ohnesorge 2024-11-07T09:51:12-06:00 progress-on-stage-2
--      aidanfoss 2024-11-07T09:37:43-06:00 create-exmem-stage
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

