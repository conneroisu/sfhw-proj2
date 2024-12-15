-- <header>
-- Author(s): connerohnesorge, Conner Ohnesorge
-- Name: 
-- Notes:
--      connerohnesorge 2024-12-13T12:22:36-06:00 added-clock-to-adder-subtractor
--      connerohnesorge 2024-12-13T12:12:48-06:00 styleguide-updates
--      connerohnesorge 2024-12-04T18:04:15-06:00 ensure-AdderSubtractor-fits-styleguide
--      Conner Ohnesorge 2024-12-04T05:35:09-06:00 move-and-rename-addersubtractor-to-midlevel
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

    signal s_NotB   : std_logic_vector(N - 1 downto 0);
    signal s_MuxedB : std_logic_vector(N - 1 downto 0);

begin

    instOnesComps : comp1_N
        generic map(N => 32)
        port map(
            i_D0 => i_B,
            o_O  => s_NotB
            );

    instMux2t1s : mux2t1_N
        generic map(N => 32)
        port map(
            i_S  => nAdd_Sub,
            i_D0 => i_B,
            i_D1 => s_NotB,
            o_O  => s_MuxedB
            );

    instFullAdders : Full_Adder_N
        generic map(N => 32)
        port map(
            i_A        => i_A,
            i_B        => s_MuxedB,
            i_C        => nAdd_Sub,
            o_S        => o_S,
            o_C        => o_C,
            o_Overflow => o_OF
            );

end structural;

