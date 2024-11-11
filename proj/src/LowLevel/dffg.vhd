-- <header>
-- Author(s): Conner Ohnesorge, aidanfoss
-- Name: proj/src/LowLevel/dffg.vhd
-- Notes:
--      conneroisu 2024-11-11T15:42:29Z Format-and-Header
--      Conner Ohnesorge 2024-11-07T09:51:12-06:00 progress-on-stage-2
--      aidanfoss 2024-11-07T09:37:43-06:00 create-exmem-stage
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity dffg is
    port (
        i_CLK : in  std_logic;          -- Clock input
        i_RST : in  std_logic;          -- Reset input
        i_WE  : in  std_logic;          -- Write enable input
        i_D   : in  std_logic;          -- Data value input
        o_Q   : out std_logic           -- Data value output
        );
end dffg;
architecture mixed of dffg is
    signal s_D : std_logic;             -- Multiplexed input to the FF
    signal s_Q : std_logic;             -- Output of the FF
begin
    -- The output of the FF is fixed to s_Q
    o_Q <= s_Q;
    -- Create a multiplexed input to the FF based on i_WE
    with i_WE select
        s_D <= i_D when '1',
        s_Q        when others;
    -- This process handles the asyncrhonous reset and
    -- synchronous write. We want to reset our processor's registers so that we minimize
    -- glitchy behavior on startup.
    process (i_CLK, i_RST)
    begin
        if (i_RST = '1') then           -- if the reset is active
            s_Q <= '0';  -- Use "(others => '0')" for N-bit values
        elsif (rising_edge(i_CLK)) then  -- else if the clock is rising edge
            s_Q <= s_D;                 -- then set the output to the input
        end if;
    end process;
end mixed;

