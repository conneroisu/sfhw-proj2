-- <header>
-- Author(s): Conner Ohnesorge
-- Name: 
-- Notes:
--      Conner Ohnesorge 2024-12-01T12:19:14-06:00 moved-all-files-into-the-hardware-directory
-- </header>

library ieee;
use ieee.std_logic_1164.all;


entity full_adder is
    
    port (
        i_x0   : in  std_logic;         -- Input 0 to be added.
        i_x1   : in  std_logic;         -- Input 1 to be added.
        i_cin  : in  std_logic;         -- Carry in.
        o_y    : out std_logic;         -- Sum output.
        o_cout : out std_logic          -- Carry out.
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
            i_a => i_x0,
            i_b => i_x1,
            o_f => s1
            );

    xor2 : component xorg2
        port map (
            i_a => s1,
            i_b => i_cin,
            o_f => o_y
            );

    and1 : component andg2
        port map (
            i_a => s1,
            i_b => i_cin,
            o_f => s2
            );

    and2 : component andg2
        port map (
            i_a => i_x0,
            i_b => i_x1,
            o_f => s3
            );

    or1 : component org2
        port map (
            i_a => s2,
            i_b => s3,
            o_f => o_cout
            );

    -- Instantiate N mux instances.
    -- G_OnesComp: for i in 0 to N-1 generate
    -- idk: invg port map(
    --  i_A    =>    i_I(i),
    --  o_F    =>    o_O(i));
    -- end generate G_OnesComp;

end architecture structural;

