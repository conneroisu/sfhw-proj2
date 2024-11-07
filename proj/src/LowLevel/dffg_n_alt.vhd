library IEEE;
use IEEE.std_logic_1164.all;

entity dffg_n_alt is
    generic(N : integer := 32);
    port(
        i_CLK : in  std_logic;                       -- Clock input
         i_RST : in  std_logic;                       -- Reset input
         i_WrE : in  std_logic;                       -- Write enable input
         i_D   : in  std_logic_vector(N-1 downto 0);  -- Data input
         o_Q   : out std_logic_vector(N-1 downto 0)   -- Data output
         );

end dffg_n_alt;

architecture structural of dffg_n_alt is

    --Original edge-triggered flip-flop
    component dffg is
        port(i_CLK : in  std_logic;     -- Clock input
             i_RST : in  std_logic;     -- Reset input
             i_WE  : in  std_logic;     -- Write enable input
             i_D   : in  std_logic;     -- Data input
             o_Q   : out std_logic      -- Data output
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
