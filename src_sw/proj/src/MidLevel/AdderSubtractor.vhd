-- <header>
-- Author(s): Conner Ohnesorge
-- Name: 
-- Notes:
--      Conner Ohnesorge 2024-12-04T07:44:46-06:00 updated-the-software-pipeline-to-use-the-simplified-contgrol-flow
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;

entity AdderSubtractor is
    generic (N : integer := 32);

    port (
        nAdd_Sub  : in  std_logic;
        i_A       : in  std_logic_vector(N - 1 downto 0);
        i_B       : in  std_logic_vector(N - 1 downto 0);
        o_S       : out std_logic_vector(N - 1 downto 0);
        o_C, o_OF : out std_logic
        );

end AdderSubtractor;

architecture structural of AdderSubtractor is

    component full_adder_N is
        generic (N : integer := 32);
        port (
            i_A        : in  std_logic_vector(N - 1 downto 0);
            i_B        : in  std_logic_vector(N - 1 downto 0);
            i_C        : in  std_logic;
            o_S        : out std_logic_vector(N - 1 downto 0);
            o_C        : out std_logic;
            o_Overflow : out std_logic
            );
    end component;

    component comp1_N is
        generic (N : integer := 32);
        port (
            i_D0 : in  std_logic_vector(N - 1 downto 0);
            o_O  : out std_logic_vector(N - 1 downto 0)
            );
    end component;

    component mux2t1_N is
        generic (N : integer := 32);
        port (
            i_S  : in  std_logic;
            i_D0 : in  std_logic_vector(N - 1 downto 0);
            i_D1 : in  std_logic_vector(N - 1 downto 0);
            o_O  : out std_logic_vector(N - 1 downto 0)
            );
    end component;

    signal s_notB   : std_logic_vector(N - 1 downto 0);
    signal s_muxedB : std_logic_vector(N - 1 downto 0);
begin

    instOnesComps : comp1_N
        generic map(N => 32)
        port map(
            i_D0 => i_B,
            o_O  => s_notB
            );

    instMux2t1s : mux2t1_N
        generic map(N => 32)
        port map(
            i_S  => nAdd_Sub,
            i_D0 => i_B,
            i_D1 => s_notB,
            o_O  => s_muxedB
            );

    instFullAdders : Full_Adder_N
        generic map(N => 32)
        port map(
            i_A        => i_A,
            i_B        => s_muxedB,
            i_C        => nAdd_Sub,
            o_S        => o_S,
            o_C        => o_C,
            o_Overflow => o_OF
            );

end structural;

