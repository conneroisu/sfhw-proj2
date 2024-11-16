-- <header>
-- Author(s): aidanfoss
-- Name: proj/src/LowLevel/invg.vhd
-- Notes:
--      conneroisu 2024-11-14T14:56:19Z Format-and-Header
--      conneroisu 2024-11-11T15:44:17Z Format-and-Header
--      aidanfoss 2024-11-07T09:37:43-06:00 create-exmem-stage
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

