-- <header>
-- Author(s): aidanfoss
-- Name: proj/src/LowLevel/mux4t1_N.vhd
-- Notes:
--      aidanfoss  <quantumaidan@gmail.com> removing-unnessecary-extra-lowlevel-files-adding-requred-ones-to-lowlevel-location
-- </header>

library ieee;
use ieee.std_logic_1164.all;

entity mux4t1_n is
    generic (
        n : integer := 32  -- Generic of type integer for input/output data width. Default value is 32.
        );
    port (
        i_s  : in  std_logic_vector(1 downto 0);  -- Select input width is 2 (1 bit for each input data width bit
        i_d0 : in  std_logic_vector(n - 1 downto 0);  -- Input data width is N.
        i_d1 : in  std_logic_vector(n - 1 downto 0);  -- Input data width is N.
        i_d2 : in  std_logic_vector(n - 1 downto 0);  -- Input data width is N.
        i_d3 : in  std_logic_vector(n - 1 downto 0);  -- Input data width is N.
        o_o  : out std_logic_vector(n - 1 downto 0)  -- Output data width is N.
        );
end entity mux4t1_n;

architecture structural of mux4t1_n is

    component mux4t1 is
        port (
            i_s  : in  std_logic_vector(1 downto 0);
            i_d0 : in  std_logic;
            i_d1 : in  std_logic;
            i_d2 : in  std_logic;
            i_d3 : in  std_logic;
            o_o  : out std_logic
            );
    end component;

begin
    -- Instantiate N mux instances.
    g_nbit_mux : for i in 0 to n - 1 generate

        muxi : component mux4t1
            port map (
                i_s  => i_s,            -- Select input.
                i_d0 => i_d0(i),        -- Select bit i from input data.
                i_d1 => i_d1(i),        -- Select bit i from input data.
                i_d2 => i_d2(i),        -- Select bit i from input data.
                i_d3 => i_d3(i),        -- Select bit i from input data.
                o_o  => o_o(i)          -- Output bit i.
                );

    end generate g_nbit_mux;
end architecture structural;




