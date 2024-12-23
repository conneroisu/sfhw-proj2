-- <header>
-- Author(s): connerohnesorge, Conner Ohnesorge
-- Name: 
-- Notes:
--      connerohnesorge 2024-12-10T09:22:24-06:00 assert-that-all-of-the-single-cycle-implementation-fits-styleguide
--      Conner Ohnesorge 2024-11-21T11:05:34-06:00 added-old-single-cycle-processor-and-added-documentation-for-the
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

