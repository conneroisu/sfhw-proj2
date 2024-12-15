-- <header>
-- Author(s): connerohnesorge, Conner Ohnesorge
-- Name: 
-- Notes:
--      connerohnesorge 2024-12-13T13:15:36-06:00 updaate-single-cycle-processor-structure
--      connerohnesorge 2024-12-10T09:22:24-06:00 assert-that-all-of-the-single-cycle-implementation-fits-styleguide
--      Conner Ohnesorge 2024-12-01T12:27:41-06:00 rename-the-fetch-dir-to-pc
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;

entity program_counter_dff is

    port(
        i_CLK      : in  std_logic;     -- Clock input
        i_RST      : in  std_logic;     -- Reset input
        i_RST_data : in  std_logic;     -- Write enable input
        i_D        : in  std_logic;     -- Data value input
        o_Q        : out std_logic      -- Data value output
        );

end program_counter_dff;

architecture mixed of program_counter_dff is
    signal s_Q : std_logic;             -- Output of the FF
begin
    -- The output of the FF is fixed to s_Q
    o_Q <= s_Q;
    -- This process handles the asyncrhonous reset and
    -- synchronous write. We want to be able to reset 
    -- our processor's registers so that we minimize
    -- glitchy behavior on startup.
    process (i_CLK, i_RST)
    begin
        if (i_RST = '1') then
            s_Q <= i_RST_data;  -- Use "(others => '0')" for N-bit values
        elsif (rising_edge(i_CLK)) then
            s_Q <= i_D;
        end if;
    end process;
end mixed;

