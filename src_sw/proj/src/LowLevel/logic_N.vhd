-- <header>
-- Author(s): Conner Ohnesorge
-- Name: 
-- Notes:
--      Conner Ohnesorge 2024-12-04T07:44:46-06:00 updated-the-software-pipeline-to-use-the-simplified-contgrol-flow
--      Conner Ohnesorge 2024-12-01T16:14:56-06:00 make-logic_N-fit-styleguide
--      Conner Ohnesorge 2024-12-01T15:20:49-06:00 update-low-level-components
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;

entity logic_N is
    generic(N : integer := 32);

    port(
        i_A                       : in  std_logic_vector(N-1 downto 0);
        i_B                       : in  std_logic_vector(N-1 downto 0);
        o_OR, o_AND, o_XOR, o_NOR : out std_logic_vector(N-1 downto 0)
        );

end logic_N;

architecture looped of logic_N is
begin
    process(i_A, i_B)
    begin
        for i in 0 to 31 loop
            o_OR(i)  <= i_A(i) or i_B(i);
            o_AND(i) <= i_A(i) and i_B(i);
            o_XOR(i) <= i_A(i) xor i_B(i);
            o_NOR(i) <= i_A(i) nor i_B(i);
        end loop;
    end process;
end looped;

