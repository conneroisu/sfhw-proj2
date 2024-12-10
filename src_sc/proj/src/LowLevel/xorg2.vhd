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

entity xorg2 is

    port (
        i_A : in  std_logic;
        i_B : in  std_logic;
        o_F : out std_logic
        );

end xorg2;

architecture dataflow of xorg2 is
begin
    o_F <= i_A xor i_B;
end dataflow;

