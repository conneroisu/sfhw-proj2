-- <header>
-- Author(s): Conner Ohnesorge
-- Name: 
-- Notes:
--      Conner Ohnesorge 2024-12-01T16:24:07-06:00 update-barrel_shifter-name
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;

entity barrel_shifter is
    generic (N : integer := 32);

    port (
        i_data             : in  std_logic_vector(N - 1 downto 0);
        i_logic_arithmetic : in  std_logic;  -- 0 for logical, 1 for arithmetic (sign bit)
        i_left_right       : in  std_logic;  --0 for shift left, 1 for shift right
        i_shamt            : in  std_logic_vector(4 downto 0);  --shift amount
        o_Out              : out std_logic_vector(N - 1 downto 0)  --output of the shifter
        );

end barrel_shifter;

architecture structural of barrel_shifter is

    component mux2t1_N is
        port (
            i_S  : in  std_logic;
            i_D0 : in  std_logic_vector(N - 1 downto 0);
            i_D1 : in  std_logic_vector(N - 1 downto 0);
            o_O  : out std_logic_vector(N - 1 downto 0));
    end component;

    signal s_RG0 : std_logic_vector(N - 1 downto 0);  --output of 0 right shift gate
    signal s_RG1 : std_logic_vector(N - 1 downto 0);  --output of 1 right shift gate
    signal s_RG2 : std_logic_vector(N - 1 downto 0);  --output of 2 right shift gate
    signal s_RG3 : std_logic_vector(N - 1 downto 0);  --output of 3 right shift gate
    signal s_RG4 : std_logic_vector(N - 1 downto 0);  --output of 4 right shift gate
    signal s_LG0 : std_logic_vector(N - 1 downto 0);  --output of 0 right left gate
    signal s_LG1 : std_logic_vector(N - 1 downto 0);  --output of 1 right left gate
    signal s_LG2 : std_logic_vector(N - 1 downto 0);  --output of 2 right left gate
    signal s_LG3 : std_logic_vector(N - 1 downto 0);  --output of 3 right left gate
    signal s_LG4 : std_logic_vector(N - 1 downto 0);  --output of 4 right left gate

    signal s_sign : std_logic;          --sign bit used for arithmetic signals

    --Right shifted signals
    signal s_shiftR0 : std_logic_vector(N - 1 downto 0);
    signal s_shiftR1 : std_logic_vector(N - 1 downto 0);
    signal s_shiftR2 : std_logic_vector(N - 1 downto 0);
    signal s_shiftR3 : std_logic_vector(N - 1 downto 0);
    signal s_shiftR4 : std_logic_vector(N - 1 downto 0);

    --Left shifted signals
    signal s_shiftL0 : std_logic_vector(N - 1 downto 0);
    signal s_shiftL1 : std_logic_vector(N - 1 downto 0);
    signal s_shiftL2 : std_logic_vector(N - 1 downto 0);
    signal s_shiftL3 : std_logic_vector(N - 1 downto 0);
    signal s_shiftL4 : std_logic_vector(N - 1 downto 0);
begin

    s_sign <= '0' when (i_logic_arithmetic = '0')else
              i_data(31);

    s_shiftR0 <= s_sign & i_data(31 downto 1);

    --Each right shifter
    right_shifter_0 : mux2t1_N
        port map(
            i_S  => i_shamt(0),
            i_D0 => i_data,
            i_D1 => s_shiftR0,
            o_O  => s_RG0);

    s_shiftR1 <= s_sign & s_sign & s_RG0(31 downto 2);

    right_shifter_1 : mux2t1_N
        port map(
            i_S  => i_shamt(1),
            i_D0 => s_RG0,
            i_D1 => s_shiftR1,
            o_O  => s_RG1);

    s_shiftR2 <= s_sign
                 & s_sign
                 & s_sign
                 & s_sign
                 & s_RG1(31 downto 4);

    right_shifter_2 : mux2t1_N
        port map(
            i_S  => i_shamt(2),
            i_D0 => s_RG1,
            i_D1 => s_shiftR2,
            o_O  => s_RG2);

    s_shiftR3 <= s_sign
                 & s_sign
                 & s_sign
                 & s_sign
                 & s_sign
                 & s_sign
                 & s_sign
                 & s_sign
                 & s_RG2(31 downto 8);

    right_shifter_3 : mux2t1_N
        port map(
            i_S  => i_shamt(3),
            i_D0 => s_RG2,
            i_D1 => s_shiftR3,
            o_O  => s_RG3
            );

    s_shiftR4 <= s_sign
                 & s_sign
                 & s_sign
                 & s_sign
                 & s_sign
                 & s_sign
                 & s_sign
                 & s_sign
                 & s_sign
                 & s_sign
                 & s_sign
                 & s_sign
                 & s_sign
                 & s_sign
                 & s_sign
                 & s_sign
                 & s_RG3(31 downto 16);

    right_shifter_4 : mux2t1_N
        port map(
            i_S  => i_shamt(4),
            i_D0 => s_RG3,
            i_D1 => s_shiftR4,
            o_O  => s_RG4
            );

    s_shiftL0 <= i_data(30 downto 0) & '0';

    left_shifter_0 : mux2t1_N
        port map(
            i_S  => i_shamt(0),
            i_D0 => i_data,
            i_D1 => s_shiftL0,
            o_O  => s_LG0
            );

    s_shiftL1 <= s_LG0(29 downto 0) & b"00";

    left_shifter_1 : mux2t1_N
        port map(
            i_S  => i_shamt(1),
            i_D0 => s_LG0,
            i_D1 => s_shiftL1,
            o_O  => s_LG1);

    s_shiftL2 <= s_LG1(27 downto 0) & b"0000";

    left_shifter_2 : mux2t1_N
        port map(
            i_S  => i_shamt(2),
            i_D0 => s_LG1,
            i_D1 => s_shiftL2,
            o_O  => s_LG2);

    s_shiftL3 <= s_LG2(23 downto 0) & b"00000000";

    left_shifter_3 : mux2t1_N
        port map(
            i_S  => i_shamt(3),
            i_D0 => s_LG2,
            i_D1 => s_shiftL3,
            o_O  => s_LG3
            );

    s_shiftL4 <= s_LG3(15 downto 0) & x"0000";

    left_shifter_4 : mux2t1_N
        port map(
            i_S  => i_shamt(4),
            i_D0 => s_LG3,
            i_D1 => s_shiftL4,
            o_O  => s_LG4);

    final_select : mux2t1_N
        port map(
            i_S  => i_left_right,
            i_D0 => s_LG4,
            i_D1 => s_RG4,
            o_O  => o_Out
            );

end structural;
