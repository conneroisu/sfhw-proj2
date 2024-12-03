-- <header>
-- Author(s): Conner Ohnesorge
-- Name: 
-- Notes:
--      Conner Ohnesorge 2024-12-01T15:20:49-06:00 update-low-level-components
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity size_filter is
    generic (N : integer := 32);

    port (
        i_D0     : in  std_logic_vector(N-1 downto 0);
        i_D1     : in  std_logic_vector(N-1 downto 0);
        o_result : out std_logic_vector(N-1 downto 0)
        );

end size_filter;

architecture behavioral of size_filter is
    signal s_0 : std_logic_vector(0 downto 0);
    signal s_1 : std_logic_vector(0 downto 0);
begin
    s_0 <= b"0";
    s_1 <= b"1";
    process (i_D0, i_D1)
    begin
        if (signed(i_D0) < signed(i_D1)) then
            --Output a 1 if d0 is less than d1, otherwise output 0
            o_result <= std_logic_vector(resize(unsigned(s_1), o_result'length));
        else
            o_result <= std_logic_vector(resize(unsigned(s_0), o_result'length));
        end if;
    end process;
end behavioral;

