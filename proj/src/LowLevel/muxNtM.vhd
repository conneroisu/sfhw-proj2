library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.MIPS_types.all;

entity muxNtM is
    generic (
        DATA_WIDTH : integer := 8;  -- Width of each input
        NUM_INPUTS : integer := 4   -- Number of inputs
    );
    port (
        I : in  std_logic_vector(NUM_INPUTS * DATA_WIDTH - 1 downto 0);  -- Concatenated inputs
        S : in  std_logic_vector(clog2(NUM_INPUTS) - 1 downto 0);        -- Select signal
        Y : out std_logic_vector(DATA_WIDTH - 1 downto 0)                -- Output
    );
end entity muxNtM;

architecture behavioral of muxNtM is
begin
    -- Select the appropriate input based on the select signal
    Y <= I((to_integer(unsigned(S)) + 1) * DATA_WIDTH - 1 downto to_integer(unsigned(S)) * DATA_WIDTH);
end architecture behavioral;
