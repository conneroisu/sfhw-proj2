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
    signal s_sum   : std_logic_vector(N - 1 downto 0);
begin

    s_carry(0) <= i_C;
    o_C        <= s_carry(N);
    o_S        <= s_sum;
    -- o_Overflow <= s_carry(N) xor s_carry(N - 1);
    o_Overflow <= (not i_A(N-1) and not i_B(N-1) and s_sum(N-1)) or
                  (i_A(N-1) and i_B(N-1) and not s_sum(N-1));


    G_NBit_FullAdder : for j in 0 to N - 1 generate
        FullAdderI : Full_Adder port map(
            i_C => s_carry(j),          -- previous out carry = new in carry
            i_A => i_A(j),  -- ith instance's data 0 input = jth data 0 input.
            i_B => i_B(j),  -- ith instance's data 1 input = jth data 1 input.
            o_S => s_sum(j),  -- ith instance's data output = jth data output.
            o_C => s_carry(j + 1)  -- ith instance's data output = jth data output.
            );
    end generate G_NBit_FullAdder;

end structural;
