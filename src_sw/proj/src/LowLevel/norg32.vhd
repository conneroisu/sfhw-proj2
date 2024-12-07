-- <header>
-- Author(s): connerohnesorge, Conner Ohnesorge
-- Name: 
-- Notes:
--      connerohnesorge 2024-12-04T23:28:14-06:00 make-norg32-better-fit-styleguide
--      connerohnesorge 2024-12-04T21:38:13-06:00 make-norg32-fit-styleguide
--      Conner Ohnesorge 2024-12-04T07:44:46-06:00 updated-the-software-pipeline-to-use-the-simplified-contgrol-flow
--      Conner Ohnesorge 2024-12-01T16:11:43-06:00 make-norg32-fit-styleguide
--      Conner Ohnesorge 2024-12-01T15:20:49-06:00 update-low-level-components
--      Conner Ohnesorge 2024-11-21T09:00:59-06:00 added-start-of-sf-pipeline-folder
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;

entity norg32 is

    port (
        i_A : in  std_logic_vector(31 downto 0);
        i_B : in  std_logic_vector(31 downto 0);
        o_F : out std_logic_vector(31 downto 0)
        );

end norg32;

architecture dataflow of norg32 is
begin
    G1 : for i in 0 to 31 generate
        o_F(i) <= i_A(i) nor i_B(i);
    end generate;
end dataflow;

