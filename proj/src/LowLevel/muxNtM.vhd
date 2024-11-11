library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Generic N-to-M Multiplexer Component
-- This component selects one of N input buses, each M bits wide,
-- based on a selection integer Sel ranging from 0 to N-1.

entity mux_NtM is
    generic (
        N : integer := 2;  -- Number of input buses
        M : integer := 8   -- Width of each input bus
    );
    port (
        Data_in : in  std_logic_vector((N*M)-1 downto 0); -- Concatenated input buses
        Sel     : in  integer range 0 to N - 1;           -- Selection signal
        Data_out: out std_logic_vector(M - 1 downto 0)    -- Output bus
    );
end entity mux_NtM;

architecture Behavioral of mux_NtM is
begin
    -- Assign the selected input bus to the output
    Data_out <= Data_in((Sel+1)*M - 1 downto Sel*M);
end architecture Behavioral;
