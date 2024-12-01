library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.MIPS_types.all;

entity mux_Nt1 is
    generic (
        bus_width : integer := 32;
        sel_width : integer := 5
        );
    
    port (
        -- BUS 2D array of [2^sel_width][bus_width] size
        i_reg_bus : in  bus_array((2**sel_width)-1 downto 0)(bus_width-1 downto 0);
        i_sel     : in  std_logic_vector(sel_width-1 downto 0);
        o_reg     : out std_logic_vector(bus_width-1 downto 0)
        );

end mux_Nt1;

architecture dataflow of mux_Nt1 is
begin
    o_reg <= i_reg_bus(to_integer(unsigned(i_sel)));
end dataflow;
