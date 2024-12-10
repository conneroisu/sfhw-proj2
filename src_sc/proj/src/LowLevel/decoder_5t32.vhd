-- <header>
-- Author(s): Conner Ohnesorge
-- Name: 
-- Notes:
--      Conner Ohnesorge 2024-11-21T11:05:34-06:00 added-old-single-cycle-processor-and-added-documentation-for-the
-- </header>

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
entity decoder5t32 is
    
    port (
            i_i : in  std_logic_vector(4 downto 0);  -- 5-bit input
            o_o : out std_logic_vector(31 downto 0)  -- 32-bit output
            );
        
end entity decoder5t32;

architecture mixed of decoder5t32 is

begin

    with i_I select o_O <=
        "00000000000000000000000000000001" when "00000",
        "00000000000000000000000000000010" when "00001",
        "00000000000000000000000000000100" when "00010",
        "00000000000000000000000000001000" when "00011",
        "00000000000000000000000000010000" when "00100",
        "00000000000000000000000000100000" when "00101",
        "00000000000000000000000001000000" when "00110",
        "00000000000000000000000010000000" when "00111",
        "00000000000000000000000100000000" when "01000",
        "00000000000000000000001000000000" when "01001",
        "00000000000000000000010000000000" when "01010",
        "00000000000000000000100000000000" when "01011",
        "00000000000000000001000000000000" when "01100",
        "00000000000000000010000000000000" when "01101",
        "00000000000000000100000000000000" when "01110",
        "00000000000000001000000000000000" when "01111",
        "00000000000000010000000000000000" when "10000",
        "00000000000000100000000000000000" when "10001",
        "00000000000001000000000000000000" when "10010",
        "00000000000010000000000000000000" when "10011",
        "00000000000100000000000000000000" when "10100",
        "00000000001000000000000000000000" when "10101",
        "00000000010000000000000000000000" when "10110",
        "00000000100000000000000000000000" when "10111",
        "00000001000000000000000000000000" when "11000",
        "00000010000000000000000000000000" when "11001",
        "00000100000000000000000000000000" when "11010",
        "00001000000000000000000000000000" when "11011",
        "00010000000000000000000000000000" when "11100",
        "00100000000000000000000000000000" when "11101",
        "01000000000000000000000000000000" when "11110",
        "10000000000000000000000000000000" when "11111",
        "00000000000000000000000000000000" when others;

end architecture mixed;

