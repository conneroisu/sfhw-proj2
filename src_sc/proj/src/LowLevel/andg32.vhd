-- <header>
-- Author(s): aidanfoss
-- Name: proj/src/LowLevel/andg32.vhd
-- Notes:
--      aidanfoss  <quantumaidan@gmail.com> removing-unnessecary-extra-lowlevel-files-adding-requred-ones-to-lowlevel-location
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
