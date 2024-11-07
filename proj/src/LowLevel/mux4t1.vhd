-- <header>
-- Author(s): aidanfoss
-- Name: proj/src/LowLevel/mux4t1.vhd
-- Notes:
--      aidanfoss  <quantumaidan@gmail.com> removing-unnessecary-extra-lowlevel-files-adding-requred-ones-to-lowlevel-location
-- </header>

-------------------------------------------------------------------------
-- Conner Ohnesorge
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- mux4t1.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of an N-bit wide 2:1
-- mux using structural VHDL, generics, and generate statements.
-------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity mux4t1 is
    port (
        i_s  : in  std_logic_vector(1 downto 0);  -- Select input width is 2.
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

    signal temp_o : std_logic;
    signal s_1    : std_logic;
    signal s_2    : std_logic;

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





