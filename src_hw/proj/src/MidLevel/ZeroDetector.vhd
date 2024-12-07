-- <header>
-- Author(s): connerohnesorge, Conner Ohnesorge
-- Name: 
-- Notes:
--      connerohnesorge 2024-12-05T22:38:28-06:00 better-readibility-in-BarrelShifter-and-ZeroDetector
--      Conner Ohnesorge 2024-12-04T00:49:07-06:00 latest
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;

entity ZeroDetector is

    port(
        i_F    : in  std_logic_vector(31 downto 0);
        o_zero : out std_logic
        );

end ZeroDetector;

architecture structural of ZeroDetector is

    component org2 is
        port(i_A : in  std_logic;
             i_B : in  std_logic;
             o_F : out std_logic);
    end component;

    signal s_oOR1 : std_logic_vector(15 downto 0);
    signal s_oOR2 : std_logic_vector(7 downto 0);
    signal s_oOR3 : std_logic_vector(3 downto 0);
    signal s_oOR4 : std_logic_vector(1 downto 0);

begin
    -- 16 OR instances. 
    FIRST_OR : for i in 0 to 15 generate
        OR1 : org2 port map(
            i_A => i_F(i*2),
            i_B => i_F(i*2+1),
            o_F => s_oOR1(i)
            );
    end generate FIRST_OR;

    -- 8 OR instances
    SECOND_OR : for i in 0 to 7 generate
        OR2 : org2 port map(
            i_A => s_oOR1(i*2),
            i_B => s_oOR1(i*2+1),
            o_F => s_oOR2(i)
            );
    end generate SECOND_OR;

    -- 4 OR instances
    THIRD_OR : for i in 0 to 3 generate
        OR3 : org2 port map(
            i_A => s_oOR2(i*2),
            i_B => s_oOR2(i*2+1),
            o_F => s_oOR3(i)
            );
    end generate THIRD_OR;

    -- 2 OR instances
    FOURTH_OR : for i in 0 to 1 generate
        OR3 : org2 port map(
            i_A => s_oOR3(i*2),
            i_B => s_oOR3(i*2+1),
            o_F => s_oOR4(i)
            );
    end generate FOURTH_OR;

    ouput_or : org2 port map(
        i_A => s_oOR4(0),               -- i_A goes to 0 bit
        i_B => s_oOR4(1),               -- i_B goes to 1 bit
        o_F => o_zero      -- output is the OR tree of the input i_F
        );

end structural;

