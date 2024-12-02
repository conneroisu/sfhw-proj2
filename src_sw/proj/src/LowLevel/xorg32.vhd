-- <header>
-- Author(s): Kariniux, Conner Ohnesorge, aidanfoss
-- Name: proj/src/LowLevel/xorg32.vhd
-- Notes:
--      Kariniux 2024-11-21T09:04:48-06:00 pushing-pulling
--      connero 2024-11-11T09:11:16-06:00 Merge-branch-main-into-component-forward-unit
--      Conner Ohnesorge 2024-11-07T09:51:12-06:00 progress-on-stage-2
--      aidanfoss 2024-11-07T09:37:43-06:00 create-exmem-stage
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity xorg32 is
    port (
        i_A : in  std_logic_vector(31 downto 0);  -- input A
        i_B : in  std_logic_vector(31 downto 0);  -- input B
        o_F : out std_logic_vector(31 downto 0)   -- output F
        );
end xorg32;

architecture dataflow of xorg32 is
begin
    G1 : for i in 0 to 31 generate
        o_F(i) <= i_A(i) xor i_B(i);
    end generate;
end dataflow;

