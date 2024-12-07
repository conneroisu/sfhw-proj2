-- <header>
-- Author(s): connerohnesorge, Conner Ohnesorge
-- Name: 
-- Notes:
--      connerohnesorge 2024-12-04T21:39:00-06:00 make-xorg2-fit-styleguide
--      Conner Ohnesorge 2024-12-04T07:44:46-06:00 updated-the-software-pipeline-to-use-the-simplified-contgrol-flow
--      Conner Ohnesorge 2024-12-01T15:20:49-06:00 update-low-level-components
--      Conner Ohnesorge 2024-11-21T09:00:59-06:00 added-start-of-sf-pipeline-folder
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

