-- <header>
-- Author(s): Conner Ohnesorge, aidanfoss
-- Name: proj/src/LowLevel/xorg2.vhd
-- Notes:
--      connero 2024-11-11T09:11:16-06:00 Merge-branch-main-into-component-forward-unit
--      Conner Ohnesorge 2024-11-07T09:51:12-06:00 progress-on-stage-2
--      aidanfoss 2024-11-07T09:37:43-06:00 create-exmem-stage
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity xorg2 is
    port (
        i_A : in  std_logic;
        i_B : in  std_logic;
        o_F : out std_logic
        );
end xorg2;
architecture dataflow of xorg2 is
begin
    o_F <= i_A xor i_B;
end dataflow;

