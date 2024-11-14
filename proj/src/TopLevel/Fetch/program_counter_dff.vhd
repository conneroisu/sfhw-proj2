-- <header>
-- Author(s): Conner Ohnesorge
-- Name: proj/src/TopLevel/Fetch/program_counter_dff.vhd
-- Notes:
--      conneroisu 2024-11-14T14:56:19Z Format-and-Header
--      conneroisu 2024-11-11T15:44:17Z Format-and-Header
--      Conner Ohnesorge 2024-11-07T09:51:12-06:00 progress-on-stage-2
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
            s_Q <= i_RST_data;       -- Use "(others => '0')" for N-bit values
        elsif (rising_edge(i_CLK)) then
            s_Q <= i_D;
        end if;
    end process;
end mixed;

