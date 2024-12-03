-- <header>
-- Author(s): Conner Ohnesorge
-- Name: 
-- Notes:
--      Conner Ohnesorge 2024-12-01T16:11:26-06:00 make-org2-fit-styleguide
--      Conner Ohnesorge 2024-12-01T15:20:49-06:00 update-low-level-components
--      Conner Ohnesorge 2024-11-21T09:00:59-06:00 added-start-of-sf-pipeline-folder
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity org2 is

    port (
        i_a : in  std_logic;
        i_b : in  std_logic;
        o_f : out std_logic
        );

end entity org2;

architecture dataflow of org2 is
begin
    o_f <= i_a or i_b;
end architecture dataflow;

