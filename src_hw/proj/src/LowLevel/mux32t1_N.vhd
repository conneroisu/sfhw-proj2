-- <header>
-- Author(s): Conner Ohnesorge
-- Name: 
-- Notes:
--      Conner Ohnesorge 2024-12-03T23:27:02-06:00 fix-register-file-declaration-in-MIPS_Processor.vhd
--      Conner Ohnesorge 2024-12-03T22:08:36-06:00 save-progress
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;

entity mux32t1_N is
    generic(N : integer := 32);

    port(
        i_S   : in  std_logic_vector(4 downto 0);
        i_D0  : in  std_logic_vector(N-1 downto 0);
        i_D1  : in  std_logic_vector(N-1 downto 0);
        i_D2  : in  std_logic_vector(N-1 downto 0);
        i_D3  : in  std_logic_vector(N-1 downto 0);
        i_D4  : in  std_logic_vector(N-1 downto 0);
        i_D5  : in  std_logic_vector(N-1 downto 0);
        i_D6  : in  std_logic_vector(N-1 downto 0);
        i_D7  : in  std_logic_vector(N-1 downto 0);
        i_D8  : in  std_logic_vector(N-1 downto 0);
        i_D9  : in  std_logic_vector(N-1 downto 0);
        i_D10 : in  std_logic_vector(N-1 downto 0);
        i_D11 : in  std_logic_vector(N-1 downto 0);
        i_D12 : in  std_logic_vector(N-1 downto 0);
        i_D13 : in  std_logic_vector(N-1 downto 0);
        i_D14 : in  std_logic_vector(N-1 downto 0);
        i_D15 : in  std_logic_vector(N-1 downto 0);
        i_D16 : in  std_logic_vector(N-1 downto 0);
        i_D17 : in  std_logic_vector(N-1 downto 0);
        i_D18 : in  std_logic_vector(N-1 downto 0);
        i_D19 : in  std_logic_vector(N-1 downto 0);
        i_D20 : in  std_logic_vector(N-1 downto 0);
        i_D21 : in  std_logic_vector(N-1 downto 0);
        i_D22 : in  std_logic_vector(N-1 downto 0);
        i_D23 : in  std_logic_vector(N-1 downto 0);
        i_D24 : in  std_logic_vector(N-1 downto 0);
        i_D25 : in  std_logic_vector(N-1 downto 0);
        i_D26 : in  std_logic_vector(N-1 downto 0);
        i_D27 : in  std_logic_vector(N-1 downto 0);
        i_D28 : in  std_logic_vector(N-1 downto 0);
        i_D29 : in  std_logic_vector(N-1 downto 0);
        i_D30 : in  std_logic_vector(N-1 downto 0);
        i_D31 : in  std_logic_vector(N-1 downto 0);
        o_O   : out std_logic_vector(N-1 downto 0)
        );

end mux32t1_N;

architecture behavioral of mux32t1_N is
begin
    o_O <= i_D0 when (i_S = "00000") else
           i_D1  when (i_S = "00001") else
           i_D2  when (i_S = "00010") else
           i_D3  when (i_S = "00011") else
           i_D4  when (i_S = "00100") else
           i_D5  when (i_S = "00101") else
           i_D6  when (i_S = "00110") else
           i_D7  when (i_S = "00111") else
           i_D8  when (i_S = "01000") else
           i_D9  when (i_S = "01001") else
           i_D10 when (i_S = "01010") else
           i_D11 when (i_S = "01011") else
           i_D12 when (i_S = "01100") else
           i_D13 when (i_S = "01101") else
           i_D14 when (i_S = "01110") else
           i_D15 when (i_S = "01111") else
           i_D16 when (i_S = "10000") else
           i_D17 when (i_S = "10001") else
           i_D18 when (i_S = "10010") else
           i_D19 when (i_S = "10011") else
           i_D20 when (i_S = "10100") else
           i_D21 when (i_S = "10101") else
           i_D22 when (i_S = "10110") else
           i_D23 when (i_S = "10111") else
           i_D24 when (i_S = "11000") else
           i_D25 when (i_S = "11001") else
           i_D26 when (i_S = "11010") else
           i_D27 when (i_S = "11011") else
           i_D28 when (i_S = "11100") else
           i_D29 when (i_S = "11101") else
           i_D30 when (i_S = "11110") else
           i_D31 when (i_S = "11111") else
           "00000000000000000000000000000000";

end behavioral;

