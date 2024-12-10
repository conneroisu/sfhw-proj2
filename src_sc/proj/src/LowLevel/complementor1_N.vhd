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

entity complementor1_N is
    generic(N : integer := 32);

    port(
        i_D0 : in  std_logic_vector(N-1 downto 0);  -- Input data 0.
        o_O  : out std_logic_vector(N-1 downto 0)   -- Output data.
        );

end complementor1_N;

architecture structural of complementor1_N is
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

