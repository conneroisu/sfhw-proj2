-- <header>
-- Author(s): connerohnesorge, Conner Ohnesorge
-- Name: 
-- Notes:
--      connerohnesorge 2024-12-10T09:22:24-06:00 assert-that-all-of-the-single-cycle-implementation-fits-styleguide
--      Conner Ohnesorge 2024-11-21T11:05:34-06:00 added-old-single-cycle-processor-and-added-documentation-for-the
-- </header>

library ieee;
use ieee.std_logic_1164.all;
use work.MIPS_types.all;

entity mux16t1 is

    port (
        i_I : in  array_16x32;                   -- Data value input
        i_S : in  std_logic_vector(3 downto 0);  -- Select signal input
        o_O : out std_logic_vector(31 downto 0)  -- Data value output
        );

end entity mux16t1;

architecture behavior of mux16t1 is

begin

    -- Selects the output based on the input select signal
    with i_S select o_O <=
        i_I(0)                             when "0000",
        i_I(01)                            when "0001",  -- when the input select is "00001" the output is "i_I(1)"
        i_I(02)                            when "0010",  -- when the input select is "00010" the output is "i_I(2)"
        i_I(03)                            when "0011",  -- when the input select is "00011" the output is "i_I(3)"
        i_I(04)                            when "0100",  -- when the input select is "00100" the output is "i_I(4)"
        i_I(05)                            when "0101",  -- when the input select is "00101" the output is "i_I(5)"
        i_I(06)                            when "0110",
        i_I(07)                            when "0111",
        i_I(08)                            when "1000",
        i_I(09)                            when "1001",
        i_I(10)                            when "1010",
        i_I(11)                            when "1011",
        i_I(12)                            when "1100",
        i_I(13)                            when "1101",
        i_I(14)                            when "1110",
        i_I(15)                            when "1111",
        "00000000000000000000000000000000" when others;

end architecture behavior;

