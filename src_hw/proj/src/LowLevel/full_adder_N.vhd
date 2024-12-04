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

    signal carry : std_logic_vector(N downto 0);
begin

    carry(0)   <= i_C;
    o_C        <= carry(N);
    o_Overflow <= carry(N) xor carry(N - 1);


    G_NBit_FullAdder : for i in 0 to N - 1 generate
        FullAdderI : Full_Adder port map(
            i_C => carry(i),            -- previous out carry = new in carry
            i_A => i_A(i),  -- ith instance's data 0 input = ith data 0 input.
            i_B => i_B(i),  -- ith instance's data 1 input = ith data 1 input.
            o_S => o_S(i),
            o_C => carry(i + 1)  -- ith instance's data output = ith data output.
            );
    end generate G_NBit_FullAdder;

end structural;
