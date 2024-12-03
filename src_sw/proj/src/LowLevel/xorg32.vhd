-- <header>
-- Author(s): Conner Ohnesorge
-- Name: 
-- Notes:
--      Conner Ohnesorge 2024-12-01T19:12:34-06:00 fix-port-spacing
--      Conner Ohnesorge 2024-12-01T19:12:15-06:00 make-xorg32-adhere-to-style-guide
--      Conner Ohnesorge 2024-12-01T15:20:49-06:00 update-low-level-components
--      Conner Ohnesorge 2024-11-21T09:00:59-06:00 added-start-of-sf-pipeline-folder
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

