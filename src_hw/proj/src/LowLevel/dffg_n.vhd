-- <header>
-- Author(s): Kariniux, Conner Ohnesorge, aidanfoss
-- Name: proj/src/LowLevel/dffg_n.vhd
-- Notes:
--      Kariniux 2024-11-21T09:04:48-06:00 pushing-pulling
--      Conner Ohnesorge 2024-11-11T08:50:02-06:00 merge-d-flip-flop-into-the-structural-definition
--      Conner Ohnesorge 2024-11-07T09:51:12-06:00 progress-on-stage-2
--      aidanfoss 2024-11-07T09:37:43-06:00 create-exmem-stage
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;

entity dffg_n is
    generic(N : integer := 32);
    port(
        i_CLK : in  std_logic;                       -- Clock input
        i_RST : in  std_logic;                       -- Reset input
        i_WrE : in  std_logic;                       -- Write enable input
        i_D   : in  std_logic_vector(N-1 downto 0);  -- Data input
        o_Q   : out std_logic_vector(N-1 downto 0)   -- Data output
        );

end dffg_n;

architecture structural of dffg_n is

    --Original edge-triggered flip-flop
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
            port map(i_CLK => i_CLK,    -- Clock input
                     i_RST => i_RST,    -- Reset input
                     i_WE  => i_WrE,    -- Write enable input
                     i_D   => i_D(i),   -- Data input
                     o_Q   => o_Q(i)    -- Data output
                     );
    end generate;

end structural;

