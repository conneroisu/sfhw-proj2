-- <header>
-- Author(s): Conner Ohnesorge
-- Name: 
-- Notes:
--      Conner Ohnesorge 2024-12-01T16:11:03-06:00 make-org32-fit-styleguide
--      Conner Ohnesorge 2024-12-01T15:20:49-06:00 update-low-level-components
--      Conner Ohnesorge 2024-11-21T09:00:59-06:00 added-start-of-sf-pipeline-folder
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;
entity org32 is

    port (
        i_A : in  std_logic_vector(31 downto 0);
        i_B : in  std_logic_vector(31 downto 0);
        o_F : out std_logic_vector(31 downto 0)
        );

end org32;
architecture dataflow of org32 is
begin
    G1 : for i in 0 to 31 generate
        o_F(i) <= i_A(i) or i_B(i);
    end generate;
end dataflow;

