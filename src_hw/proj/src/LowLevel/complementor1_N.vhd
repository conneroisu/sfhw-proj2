-- <header>
-- Author(s): Kariniux, Conner Ohnesorge, aidanfoss
-- Name: proj/src/LowLevel/complementor1_N.vhd
-- Notes:
--      Kariniux 2024-11-21T09:04:48-06:00 pushing-pulling
--      Conner Ohnesorge 2024-11-07T09:51:12-06:00 progress-on-stage-2
--      aidanfoss 2024-11-07T09:37:43-06:00 create-exmem-stage
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
            i_A : in  std_logic;                    -- Input data.
            o_F : out std_logic                     -- Output data.
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
