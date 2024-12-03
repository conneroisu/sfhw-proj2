-- <header>
-- Author(s): Conner Ohnesorge
-- Name: 
-- Notes:
--      Conner Ohnesorge 2024-12-01T16:15:35-06:00 make-inverter_N-fit-styleguide
--      Conner Ohnesorge 2024-12-01T15:20:49-06:00 update-low-level-components
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;

entity inverter_N is

    generic (
        N : integer := 16
        );                              --Input/output data width

    port (
        i_Data : in  std_logic_vector(N-1 downto 0);
        o_Data : out std_logic_vector(N-1 downto 0)
        );

end inverter_N;

architecture structural of inverter_N is
    component invg is
        port(
            i_A : in  std_logic;
            o_F : out std_logic
            );
    end component;

begin
    g_nbit_inverter : for i in 0 to N-1 generate
        INVERTER_N : invg port map (i_Data(i), o_Data(i));
    end generate g_nbit_inverter;

end structural;

