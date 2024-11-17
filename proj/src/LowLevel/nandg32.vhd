-- <header>
-- Author(s): aidanfoss
-- Name: proj/src/LowLevel/nandg32.vhd
-- Notes:
--      aidanfoss 2024-11-07T09:37:43-06:00 create-exmem-stage
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;
entity nandg32 is
    port(i_A : in  std_logic_vector(31 downto 0);
         i_B : in  std_logic_vector(31 downto 0);
         o_F : out std_logic_vector(31 downto 0));
end nandg32;
architecture dataflow of nandg32 is
begin
    G1 : for i in 0 to 31 generate
        o_F(i) <= i_A(i) nand i_B(i);
    end generate;
end dataflow;

