-- <header>
-- Author(s): Conner Ohnesorge
-- Name: proj/src/TopLevel/Fetch/program_counter.vhd
-- Notes:
--      conneroisu 2024-11-14T14:56:19Z Format-and-Header
--      conneroisu 2024-11-11T15:44:17Z Format-and-Header
--      Conner Ohnesorge 2024-11-07T09:51:12-06:00 progress-on-stage-2
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;
entity program_counter is
    generic(
        N : integer := 32
        );
    port(
        i_CLK : in  std_logic;          -- Clock input
        i_RST : in  std_logic;          -- Reset input
        i_D   : in  std_logic_vector(N-1 downto 0);   -- Data value input
        o_Q   : out std_logic_vector(N-1 downto 0));  -- Data value output
end program_counter;
architecture structural of program_counter is
    component program_counter_dff is
        port(
            i_CLK      : in  std_logic;               -- Clock input
            i_RST      : in  std_logic;               -- Reset input
            i_RST_data : in  std_logic;               -- Write enable input
            i_D        : in  std_logic;               -- Data value input
            o_Q        : out std_logic);              -- Data value output
    end component;
    signal s_RST_data : std_logic_vector(31 downto 0) := X"00400000";
begin
    -- Instantiate N dff instances.
    NDFFGS : for i in 0 to (N-1) generate
        ONESCOMPI : program_counter_dff port map(
            i_CLK      => i_CLK,        -- every dff has the same clock
            i_RST      => i_RST,        -- parallel rst
            i_RST_data => s_RST_data(i),              -- parallel write enable
            i_D        => i_D(i),       -- N bit long dff reg input
            o_Q        => o_Q(i));      -- N bit long dff reg output
    end generate NDFFGS;
end structural;

