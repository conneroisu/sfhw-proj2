-- <header>
-- Author(s): Conner Ohnesorge
-- Name: 
-- Notes:
--      Conner Ohnesorge 2024-12-01T16:18:35-06:00 make-andg2-fit-styleguide
--      Conner Ohnesorge 2024-12-01T15:20:49-06:00 update-low-level-components
--      Conner Ohnesorge 2024-11-21T09:00:59-06:00 added-start-of-sf-pipeline-folder
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity andg2 is

    port (
        i_A : in  std_logic;            -- input 1 to the AND gate
        i_B : in  std_logic;            -- input 2 to the AND gate
        o_F : out std_logic);           -- output of the AND gate

end andg2;
architecture dataflow of andg2 is
begin
    o_F <= i_A and i_B;  -- simple dataflow implementation of an AND gate
end dataflow;

