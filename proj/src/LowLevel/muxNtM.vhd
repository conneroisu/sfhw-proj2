-- <header>
-- Author(s): Conner Ohnesorge
-- Name: proj/src/LowLevel/muxNtM.vhd
-- Notes:
--      conneroisu 2024-11-14T14:56:19Z Format-and-Header
--      Conner Ohnesorge 2024-11-13T10:12:57-06:00 save-stage-progess
--      Conner Ohnesorge 2024-11-11T14:08:03-06:00 added-generic-mux-muxNtM
-- </header>

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

-- Generic N-to-M Multiplexer Component with std_logic_vector Sel signal
-- This component selects one of N input buses, each M bits wide,
-- based on a selection signal Sel of type std_logic_vector.

entity N_to_M_Mux is
    generic (
        N         : integer := 2;       -- Number of input buses
        M         : integer := 8;       -- Width of each input bus
        Sel_width : integer := 1        -- Width of Sel signal
        );
    port (
        Data_in  : in  std_logic_vector((N*M)-1 downto 0);  -- Concatenated input buses
        Sel      : in  std_logic_vector(Sel_width - 1 downto 0);  -- Selection signal
        Data_out : out std_logic_vector(M - 1 downto 0)     -- Output bus
        );
end entity N_to_M_Mux;

architecture Behavioral of N_to_M_Mux is
    constant Sel_max : integer := 2**Sel_width - 1;
begin
    -- Ensure that Sel_width is sufficient for N
    assert 2**Sel_width >= N
        report "Sel_width is too small for the number of inputs N"
        severity failure;

    process(Data_in, Sel)
        variable Sel_int : integer range 0 to Sel_max;
    begin
        Sel_int := to_integer(unsigned(Sel));
        if Sel_int < N then
            -- Assign the selected input bus to the output
            Data_out <= Data_in((Sel_int+1)*M - 1 downto Sel_int*M);
        else
            -- Handle out-of-range selection by setting output to zeros
            Data_out <= (others => '0');
            assert false
                report "Sel value out of range: " & integer'image(Sel_int)
                severity error;
        end if;
    end process;
end architecture Behavioral;

