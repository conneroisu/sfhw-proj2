-- <header>
-- Author(s): Conner Ohnesorge
-- Name: src_sc/proj/src/LowLevel/andg32.vhd
-- Notes:
--      Conner Ohnesorge 2024-11-21T11:05:34-06:00 added-old-single-cycle-processor-and-added-documentation-for-the
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;
entity andg32 is
    port
        (
            i_A : in  std_logic_vector(31 downto 0);  -- input A 
            i_B : in  std_logic_vector(31 downto 0);  -- input B
            o_F : out std_logic_vector(31 downto 0)   -- output F
            );
end andg32;
architecture dataflow of andg32 is
begin
    G1 : for i in 0 to 31 generate
        o_F(i) <= i_A(i) and i_B(i);
    end generate;
end dataflow;
