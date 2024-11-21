library IEEE;
use IEEE.std_logic_1164.all;

entity ripple_adder is
  --Default to 32-bit wide
  generic (N : integer := 32);
  port (
        i_A     : in std_logic_vector(N-1 downto 0);
        i_B     : in std_logic_vector(N-1 downto 0);
        i_Cin   : in std_logic;
        o_Sum   : out std_logic_vector(N-1 downto 0);
        o_Cout  : out std_logic
  );
end ripple_adder;

architecture structural of ripple_adder is 
  component full_adder is
    port (
        i_0     : in std_logic;
        i_1     : in std_logic;
        i_Cin   : in std_logic;
        o_Sum   : out std_logic;
        o_Cout  : out std_logic
    );
  end component;

  --N bits because we need to be able to assign the final carry out
  signal s_carry : std_logic_vector(N downto 0);
begin
  --First bit carry vector should be the initial carry in
  --Last bit of carry vector should be the carry out
  s_carry(0) <= i_Cin;
  o_Cout <= s_carry(N-1);

  g_ripple_carry : for i in 0 to N-1 generate
    --Set carry in to be first bit of s_carry which is set before generate loop
    --Set the carry out to the next bit of the carry signal vector so it can be grabbed by next iteration of generate loop
    FULL_ADDER_N : full_adder port map (i_A(i), i_B(i), s_carry(i), o_Sum(i), s_carry(i+1));
  end generate g_ripple_carry;

end structural;
