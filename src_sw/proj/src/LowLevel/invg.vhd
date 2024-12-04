-- <header>
-- Author(s): Conner Ohnesorge
-- Name: 
-- Notes:
--      Conner Ohnesorge 2024-12-01T12:19:14-06:00 moved-all-files-into-the-hardware-directory
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.MIPS_types.all;

entity invg is
    
    port (
        i_A : in  std_logic;            -- Input to the NOT gate
        o_F : out std_logic             -- Output from the NOT gate
        );
    
end invg;

architecture dataflow of invg is
begin
    o_F <= not i_A;                     -- Output is the inverse of the input
end dataflow;

