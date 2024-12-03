-- <header>
-- Author(s): Conner Ohnesorge
-- Name: 
-- Notes:
--      Conner Ohnesorge 2024-12-01T17:27:02-06:00 latest
--      Conner Ohnesorge 2024-12-01T16:17:06-06:00 make-dffg_n-fit-styleguide
--      Conner Ohnesorge 2024-12-01T15:20:49-06:00 update-low-level-components
--      Conner Ohnesorge 2024-11-21T09:00:59-06:00 added-start-of-sf-pipeline-folder
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;

entity dffg_n is
    generic(
        N : integer := 32
        );

    port(
        i_CLK : in  std_logic;                       -- Clock input
        i_RST : in  std_logic;                       -- Reset input
        i_WrE : in  std_logic;                       -- Write enable input
        i_D   : in  std_logic_vector(N-1 downto 0);  -- Data input
        o_Q   : out std_logic_vector(N-1 downto 0)   -- Data output
        );

end dffg_n;

architecture structural of dffg_n is

    component dffg is
        port(
            i_CLK : in  std_logic;      -- Clock input
            i_RST : in  std_logic;      -- Reset input
            i_WE  : in  std_logic;      -- Write enable input
            i_D   : in  std_logic;      -- Data input
            o_Q   : out std_logic       -- Data output
            );
    end component;

begin

    G1 : for i in 0 to N-1 generate
    begin
        flipflop : dffg
            port map(
                i_CLK,                  -- Clock input
                i_RST,                  -- Reset input
                i_WrE,                  -- Write enable input
                i_D(i),                 -- Data input
                o_Q(i)                  -- Data output
                );
    end generate;

end structural;

