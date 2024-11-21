-- <header>
-- Author(s): Conner Ohnesorge
-- Name: src_sc/proj/src/LowLevel/dffg_n.vhd
-- Notes:
--      Conner Ohnesorge 2024-11-21T11:05:34-06:00 added-old-single-cycle-processor-and-added-documentation-for-the
-- </header>

library ieee;
use ieee.std_logic_1164.all;

entity dffg_n is
    generic (
        n : integer := 32
        );
    port (
        i_clk : in  std_logic;                         -- Clock Input
        i_rst : in  std_logic;                         -- Reset Input
        i_we  : in  std_logic;                         -- Write Enable Input
        i_d   : in  std_logic_vector(n - 1 downto 0);  -- Data Value input
        o_q   : out std_logic_vector(n - 1 downto 0)   -- Data Value output
        );
end entity dffg_n;

architecture mixed of dffg_n is
    signal s_d : std_logic_vector(n - 1 downto 0);  -- Multiplexed input to the FF
    signal s_q : std_logic_vector(n - 1 downto 0);  -- Output of the FF
begin
    -- The output of the FF is fixed to s_Q
    o_q <= s_q;

    -- The input to the FF is selected based on the write enable
    with i_WE select s_d <=
        i_D when '1',
        s_q when others;

    process (i_clk, i_rst) is
    begin

        if (i_rst = '1') then            -- if reset is active
            s_q <= (others => '0');      -- reset the output
        elsif (rising_edge(i_clk)) then  -- if clock is rising edge
            s_q <= s_d;                  -- update the output
        end if;

    end process;

end architecture mixed;
