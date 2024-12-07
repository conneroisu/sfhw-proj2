-- <header>
-- Author(s): Conner Ohnesorge
-- Name: 
-- Notes:
--      Conner Ohnesorge 2024-12-04T05:46:16-06:00 make-mux2t1_N-fit-style-guide
--      Conner Ohnesorge 2024-12-01T12:19:14-06:00 moved-all-files-into-the-hardware-directory
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.MIPS_types.all;

entity mux2t1_N is
    generic (
        N : integer := 32
        );

    port (
        i_S  : in  std_logic;           -- Select input.
        i_D0 : in  std_logic_vector(N - 1 downto 0);  -- Input data width is N.
        i_D1 : in  std_logic_vector(N - 1 downto 0);  -- Input data width is N.
        o_O  : out std_logic_vector(N - 1 downto 0)  -- Output data width is N.
        );

end mux2t1_N;

architecture structural of mux2t1_N is
    component mux2t1 is
        port (
            i_S  : in  std_logic;       -- Select input.
            i_D0 : in  std_logic;       -- Data 0 input.
            i_D1 : in  std_logic;       -- Data 1 input.
            o_O  : out std_logic        -- Data output.
            );
    end component;
begin
    G_NBit_MUX : for i in 0 to N - 1 generate
        MUXI : mux2t1 port map(
            i_S  => i_S,    -- All instances share the same select input.
            i_D0 => i_D0(i),  -- ith instance's data 0 input bound to ith data 0 input.
            i_D1 => i_D1(i),  -- ith instance's data 1 input bound to ith data 1 input.
            o_O  => o_O(i)  -- ith instance's data output bound to ith data output.
            );
    end generate G_NBit_MUX;
end structural;

