-- <header>
-- Author(s): connerohnesorge, Conner Ohnesorge
-- Name: 
-- Notes:
--      connerohnesorge 2024-12-13T13:15:36-06:00 updaate-single-cycle-processor-structure
--      connerohnesorge 2024-12-10T09:22:24-06:00 assert-that-all-of-the-single-cycle-implementation-fits-styleguide
--      Conner Ohnesorge 2024-11-21T11:05:34-06:00 added-old-single-cycle-processor-and-added-documentation-for-the
-- </header>

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity SignExtend is

    port (
        in_signal  : in  std_logic_vector(15 downto 0);  -- 16-bit input
        out_signal : out std_logic_vector(31 downto 0)   -- 32-bit output
        );

end SignExtend;

architecture Behavioral of SignExtend is
begin
    process(in_signal)
    begin
        if in_signal(15) = '1' then  -- //Check MSB of the input (in_signal(15))
            out_signal <= (31 downto 16 => '1') & in_signal;  -- //Sign extend with 1 for negative numbers
        else
            out_signal <= (31 downto 16 => '0') & in_signal;  -- //Sign extend with 0 for positive numbers
        end if;
    end process;
end Behavioral;

