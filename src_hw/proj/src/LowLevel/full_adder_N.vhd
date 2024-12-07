-- <header>
-- Author(s): connerohnesorge, Conner Ohnesorge
-- Name: 
-- Notes:
--      connerohnesorge 2024-12-06T05:11:10-06:00 better-commehnt-for-full_adder_N
--      Conner Ohnesorge 2024-12-04T06:03:50-06:00 remove-8t32-extender-and-remove-useless-comment-in-full_adder_N
--      Conner Ohnesorge 2024-12-04T05:44:12-06:00 fully-fit-style-guide-in-full_adder_N
--      Conner Ohnesorge 2024-12-04T05:43:02-06:00 better-spacing-for-the-full-adder-generic-N
--      Conner Ohnesorge 2024-12-03T22:08:36-06:00 save-progress
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;

entity Full_Adder_N is
    generic (N : integer := 32);

    port (
        i_C        : in  std_logic;
        i_A        : in  std_logic_vector(N - 1 downto 0);
        i_B        : in  std_logic_vector(N - 1 downto 0);
        o_S        : out std_logic_vector(N - 1 downto 0);
        o_C        : out std_logic;
        o_Overflow : out std_logic
        );

end Full_Adder_N;

architecture structural of Full_Adder_N is

    component Full_Adder is
        port (
            i_A : in  std_logic;
            i_B : in  std_logic;
            i_C : in  std_logic;
            o_S : out std_logic;
            o_C : out std_logic);
    end component;

    signal s_carry : std_logic_vector(N downto 0);
begin

    s_carry(0) <= i_C;
    o_C        <= s_carry(N);
    o_Overflow <= s_carry(N) xor s_carry(N - 1);


    G_NBit_FullAdder : for j in 0 to N - 1 generate
        FullAdderI : Full_Adder port map(
            i_C => s_carry(j),          -- previous out carry = new in carry
            i_A => i_A(j),  -- ith instance's data 0 input = jth data 0 input.
            i_B => i_B(j),  -- ith instance's data 1 input = jth data 1 input.
            o_S => o_S(j),  -- ith instance's data output = jth data output.
            o_C => s_carry(j + 1)  -- ith instance's data carry = jth data carry.
            );
    end generate G_NBit_FullAdder;

end structural;

