-- <header>
-- Author(s): Conner Ohnesorge
-- Name: 
-- Notes:
--      Conner Ohnesorge 2024-12-04T07:44:46-06:00 updated-the-software-pipeline-to-use-the-simplified-contgrol-flow
--      Conner Ohnesorge 2024-12-01T16:18:09-06:00 remove-comp1_N
--      Conner Ohnesorge 2024-12-01T15:20:49-06:00 update-low-level-components
--      connero 2024-11-29T14:24:35-06:00 Remove-comp1_N.vhd
--      Conner Ohnesorge 2024-11-21T09:00:59-06:00 added-start-of-sf-pipeline-folder
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;
entity comp1_N is
    generic(N : integer := 32);

    port(
        i_D0 : in  std_logic_vector(N-1 downto 0);  -- Input data 0.
        o_O  : out std_logic_vector(N-1 downto 0)   -- Output data.
        );

end comp1_N;

architecture structural of comp1_N is
    component invg is
        port(
            i_A : in  std_logic;        -- Input data.
            o_F : out std_logic         -- Output data.
            );
    end component;
begin
    -- Instantiate N comp instances.
    G_NBit_Comp1 : for i in 0 to N-1 generate
        comp1_I : invg port map(
            -- ith instance's data 0 input hooked up to ith data 0 input.
            i_A => i_D0(i),
            -- ith instance's data output hooked up to ith data output.
            o_F => o_O(i)
            );
    end generate G_NBit_Comp1;
end structural;

