-- <header>
-- Author(s): connerohnesorge, Conner Ohnesorge
-- Name: 
-- Notes:
--      connerohnesorge 2024-12-04T19:25:25-06:00 formate-full_adder.vhd
--      Conner Ohnesorge 2024-12-04T00:49:07-06:00 latest
--      Conner Ohnesorge 2024-12-03T22:08:36-06:00 save-progress
--      Conner Ohnesorge 2024-12-03T19:04:36-06:00 make-full-adder-fit-style-guide
--      Conner Ohnesorge 2024-12-03T19:03:40-06:00 fix-name-of-full-adder
-- </header>

library ieee;
use ieee.std_logic_1164.all;

entity full_adder is

    port (
        i_A : in  std_logic;            -- Input 0 to be added.
        i_B : in  std_logic;            -- Input 1 to be added.
        i_C : in  std_logic;            -- Carry in.
        o_S : out std_logic;            -- Sum output.
        o_C : out std_logic             -- Carry out.
        );

end entity full_adder;

architecture structural of full_adder is

    component xorg2 is
        port (
            i_a : in  std_logic;
            i_b : in  std_logic;
            o_f : out std_logic
            );
    end component;

    component andg2 is
        port (
            i_a : in  std_logic;
            i_b : in  std_logic;
            o_f : out std_logic
            );
    end component;

    component org2 is
        port (
            i_a : in  std_logic;
            i_b : in  std_logic;
            o_f : out std_logic
            );
    end component;

    signal s1 : std_logic;
    signal s2 : std_logic;
    signal s3 : std_logic;

begin

    xor1 : component xorg2
        port map (
            i_a => i_A,
            i_b => i_B,
            o_f => s1
            );

    xor2 : component xorg2
        port map (
            i_a => s1,
            i_b => i_C,
            o_f => o_S
            );

    and1 : component andg2
        port map (
            i_a => s1,
            i_b => i_C,
            o_f => s2
            );

    and2 : component andg2
        port map (
            i_a => i_A,
            i_b => i_B,
            o_f => s3
            );

    or1 : component org2
        port map (
            i_a => s2,
            i_b => s3,
            o_f => o_C
            );

end architecture structural;

