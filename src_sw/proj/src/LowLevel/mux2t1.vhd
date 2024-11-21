-- <header>
-- Author(s): Conner Ohnesorge
-- Name: src_sw/proj/src/LowLevel/mux2t1.vhd
-- Notes:
--      Conner Ohnesorge 2024-11-21T09:00:59-06:00 added-start-of-sf-pipeline-folder
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.MIPS_types.all;
-- Entity Declaration of mux2t1
entity mux2t1 is
    port (
        i_s  : in  std_logic;           -- Select input
        i_d0 : in  std_logic;           -- Data input 0
        i_d1 : in  std_logic;           -- Data input 1
        o_o  : out std_logic            -- Output
        );
end entity mux2t1;
-- Architecture Declaration of mux2t1
architecture dataflow of mux2t1 is
begin
    o_o <= i_d0 when (i_s = '0') else
           i_d1 when (i_s = '1');  -- Output is i_D0 when i_S is '0' and i_D1 when i_S is '1'
end architecture dataflow;

