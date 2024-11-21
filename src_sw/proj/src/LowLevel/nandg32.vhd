-- <header>
-- Author(s): Conner Ohnesorge
-- Name: src_sw/proj/src/LowLevel/nandg32.vhd
-- Notes:
--      Conner Ohnesorge 2024-11-21T09:00:59-06:00 added-start-of-sf-pipeline-folder
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

