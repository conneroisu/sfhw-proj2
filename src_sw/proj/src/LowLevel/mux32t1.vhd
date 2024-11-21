-- <header>
-- Author(s): Conner Ohnesorge, aidanfoss
-- Name: proj/src/LowLevel/mux32t1.vhd
-- Notes:
--      connero 2024-11-11T09:11:16-06:00 Merge-branch-main-into-component-forward-unit
--      Conner Ohnesorge 2024-11-07T09:51:12-06:00 progress-on-stage-2
--      aidanfoss 2024-11-07T09:37:43-06:00 create-exmem-stage
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.MIPS_types.all;
entity mux32t1 is
    port (
        i_I : in  TwoDArray;            -- Data value input
        i_S : in  std_logic_vector(4 downto 0);  -- Select signal input
        o_O : out std_logic_vector(31 downto 0)  -- Data value output
        );
end entity mux32t1;
-- Architecture Declaration for 32 to 1 Multiplexer
architecture behavior of mux32t1 is
begin
    -- Selects the output based on the input select signal
    with i_S select o_O <=
        i_I(0)                             when "00000",
        i_I(01)                            when "00001",  -- when the input select is "00001" the output is "i_I(1)"
        i_I(02)                            when "00010",  -- when the input select is "00010" the output is "i_I(2)"
        i_I(03)                            when "00011",  -- when the input select is "00011" the output is "i_I(3)"
        i_I(04)                            when "00100",  -- when the input select is "00100" the output is "i_I(4)"
        i_I(05)                            when "00101",  -- when the input select is "00101" the output is "i_I(5)"
        i_I(06)                            when "00110",  -- when the input select is "00110" the output is "i_I(6)"
        i_I(07)                            when "00111",  -- when the input select is "00111" the output is "i_I(7)"
        i_I(08)                            when "01000",  -- when the input select is "01000" the output is "i_I(8)"
        i_I(09)                            when "01001",  -- when the input select is "01001" the output is "i_I(9)"
        i_I(10)                            when "01010",  -- when the input select is "01010" the output is "i_I(10)"
        i_I(11)                            when "01011",  -- when the input select is "01011" the output is "i_I(11)"
        i_I(12)                            when "01100",  -- when the input select is "01100" the output is "i_I(12)"
        i_I(13)                            when "01101",  -- when the input select is "01101" the output is "i_I(13)"
        i_I(14)                            when "01110",  -- when the input select is "01110" the output is "i_I(14)"
        i_I(15)                            when "01111",  -- when the input select is "01111" the output is "i_I(15)"
        i_I(16)                            when "10000",  -- when the input select is "10000" the output is "i_I(16)"
        i_I(17)                            when "10001",  -- when the input select is "10001" the output is "i_I(17)"
        i_I(18)                            when "10010",  -- when the input select is "10010" the output is "i_I(18)"
        i_I(19)                            when "10011",  -- when the input select is "10011" the output is "i_I(19)"
        i_I(20)                            when "10100",  -- when the input select is "10100" the output is "i_I(20)"
        i_I(21)                            when "10101",  -- when the input select is "10101" the output is "i_I(21)"
        i_I(22)                            when "10110",  -- when the input select is "10110" the output is "i_I(22)"
        i_I(23)                            when "10111",  -- when the input select is "10111" the output is "i_I(23)"
        i_I(24)                            when "11000",  -- when the input select is "11000" the output is "i_I(24)"
        i_I(25)                            when "11001",  -- when the input select is "11001" the output is "i_I(25)"
        i_I(26)                            when "11010",  -- when the input select is "11010" the output is "i_I(26)"
        i_I(27)                            when "11011",  -- when the input select is "11011" the output is "i_I(27)"
        i_I(28)                            when "11100",  -- when the input select is "11100" the output is "i_I(28)"
        i_I(29)                            when "11101",  -- when the input select is "11101" the output is "i_I(29)"
        i_I(30)                            when "11110",  -- when the input select is "11110" the output is "i_I(30)"
        i_I(31)                            when "11111",  -- When the input select is "11111" the output is "i_I(31)"
        "00000000000000000000000000000000" when others;
end architecture behavior;

