-- <header>
-- Author(s): Conner Ohnesorge
-- Name: 
-- Notes:
--      Conner Ohnesorge 2024-12-01T15:13:23-06:00 addded-tests-for-logic_N-and-size_filter-and-fixed-ALU-their
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity logic_N is
    generic (N : integer := 32);
    port (
        i_D0     : in  std_logic_vector(N-1 downto 0);
        i_D1     : in  std_logic_vector(N-1 downto 0);
        i_op     : in  std_logic_vector(1 downto 0);
        o_result : out std_logic_vector(N-1 downto 0)
        );
end logic_N;

architecture dataflow of logic_N is
    signal s_others : std_logic_vector(0 downto 0);
begin
    s_others <= b"0";
    with i_op select
        o_result <= i_D0 and i_D1                                     when b"00",
        i_D0 or i_D1                                                  when b"01",
        i_D0 nor i_D1                                                 when b"10",
        i_D0 xor i_D1                                                 when b"11",
        std_logic_vector(resize(unsigned(s_others), o_result'length)) when others;
end dataflow;

