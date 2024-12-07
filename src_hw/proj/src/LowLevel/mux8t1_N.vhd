-- <header>
-- Author(s): Conner Ohnesorge
-- Name: 
-- Notes:
--      Conner Ohnesorge 2024-12-03T22:08:36-06:00 save-progress
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;

entity mux8t1_N is
    generic (N : integer := 32);

    port (
        i_S  : in  std_logic_vector(2 downto 0);
        i_D0 : in  std_logic_vector(N - 1 downto 0);
        i_D1 : in  std_logic_vector(N - 1 downto 0);
        i_D2 : in  std_logic_vector(N - 1 downto 0);
        i_D3 : in  std_logic_vector(N - 1 downto 0);
        i_D4 : in  std_logic_vector(N - 1 downto 0);
        i_D5 : in  std_logic_vector(N - 1 downto 0);
        i_D6 : in  std_logic_vector(N - 1 downto 0);
        i_D7 : in  std_logic_vector(N - 1 downto 0);
        o_O  : out std_logic_vector(N - 1 downto 0)
        );

end mux8t1_N;

architecture structural of mux8t1_N is

    component mux8t1 is
        port (
            i_S  : in  std_logic_vector(2 downto 0);
            i_D0 : in  std_logic;
            i_D1 : in  std_logic;
            i_D2 : in  std_logic;
            i_D3 : in  std_logic;
            i_D4 : in  std_logic;
            i_D5 : in  std_logic;
            i_D6 : in  std_logic;
            i_D7 : in  std_logic;
            o_O  : out std_logic);
    end component;

begin

    G_NBit_MUX : for i in 0 to N - 1 generate
        MUXI : mux8t1 port map(
            i_S  => i_S,
            i_D0 => i_D0(i),
            i_D1 => i_D1(i),
            i_D2 => i_D2(i),
            i_D3 => i_D3(i),
            i_D4 => i_D4(i),
            i_D5 => i_D5(i),
            i_D6 => i_D6(i),
            i_D7 => i_D7(i),
            o_O  => o_O(i));  -- ith instance's data output hooked up to ith data output.
    end generate G_NBit_MUX;

end structural;

