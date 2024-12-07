-- <header>
-- Author(s): Conner Ohnesorge
-- Name: 
-- Notes:
--      Conner Ohnesorge 2024-12-03T22:08:36-06:00 save-progress
--      Conner Ohnesorge 2024-12-01T12:19:14-06:00 moved-all-files-into-the-hardware-directory
-- </header>

library ieee;
use ieee.std_logic_1164.all;

entity mux4t1 is
    port (
        i_s  : in  std_logic_vector(1 downto 0);
        i_d0 : in  std_logic;
        i_d1 : in  std_logic;
        i_d2 : in  std_logic;
        i_d3 : in  std_logic;
        o_o  : out std_logic
        );
end entity mux4t1;

architecture structural of mux4t1 is

    component mux2t1 is
        port (
            i_s  : in  std_logic;
            i_d0 : in  std_logic;
            i_d1 : in  std_logic;
            o_o  : out std_logic
            );
    end component;

    signal s_1 : std_logic;
    signal s_2 : std_logic;

begin
    -- Instantiate a single mux2t1 for the entire data width.
    muxi : mux2t1
        port map (
            i_s  => i_s(0),             -- Select input is 1 bit wide.
            i_d0 => i_d0,
            i_d1 => i_d1,
            o_o  => s_1
            );

    muxii : mux2t1
        port map (
            i_s  => i_s(0),             -- Select input is 1 bit wide.
            i_d0 => i_d2,
            i_d1 => i_d3,
            o_o  => s_2
            );

    muxiii : mux2t1
        port map (
            i_s  => i_s(1),             -- Select input is 1 bit wide.
            i_d0 => s_1,
            i_d1 => s_2,
            o_o  => o_o
            );

end architecture structural;

