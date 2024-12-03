-- <header>
-- Author(s): Conner Ohnesorge
-- Name: 
-- Notes:
--      Conner Ohnesorge 2024-12-01T17:28:53-06:00 fix-register_file-generic-declaration
--      Conner Ohnesorge 2024-12-01T17:25:19-06:00 fix-software-register-file
--      Conner Ohnesorge 2024-12-01T15:44:54-06:00 make-register_file-adhere-to-style-guidelines-and-fix-declaration-in
--      Conner Ohnesorge 2024-12-01T12:25:51-06:00 update-register_file-to-midlevel
-- </header>

library ieee;
use ieee.std_logic_1164.all;
use work.mips_types.all;

entity register_file is

    port (
        clk   : in  std_logic;                      -- Clock input
        i_wA  : in  std_logic_vector(4 downto 0);   -- Write address input
        i_wD  : in  std_logic_vector(31 downto 0);  -- Write data input
        i_wC  : in  std_logic;                      -- Write enable input
        i_r1  : in  std_logic_vector(4 downto 0);   -- Read address 1 input
        i_r2  : in  std_logic_vector(4 downto 0);   -- Read address 2 input
        reset : in  std_logic;                      -- Reset input
        o_d1  : out std_logic_vector(31 downto 0);  -- Read data 1 output
        o_d2  : out std_logic_vector(31 downto 0)   -- Read data 2 output
        );

end entity register_file;

architecture structural of register_file is

    component mux32t1 is
        port
            (
                i_i : in  TwoDArray;
                i_s : in  std_logic_vector(4 downto 0);  -- 5-bit input
                o_o : out std_logic_vector(31 downto 0)  -- 32-bit output
                );
    end component;

    component decoder5t32 is
        port
            (
                i_i : in  std_logic_vector(4 downto 0);  -- 5-bit input
                o_o : out std_logic_vector(31 downto 0)  -- 32-bit output
                );
    end component;

    component dffg_n is
        generic(
            N : integer := 32
            );

        port(
            i_CLK : in  std_logic;                       -- Clock input
            i_RST : in  std_logic;                       -- Reset input
            i_WrE : in  std_logic;                       -- Write enable input
            i_D   : in  std_logic_vector(N-1 downto 0);  -- Data input
            o_Q   : out std_logic_vector(N-1 downto 0)   -- Data output
            );

    end component;

    signal s1, s3 : std_logic_vector(31 downto 0);  -- 2 32-bit signals
    signal s2     : TwoDArray;          -- 2d std_logic_vector signal

begin

    writedecoder : component decoder5t32
        port map
        (
            i_wA,
            s1
            );

    -- Set register $0 to 0
    reg0 : component dffg_n
        generic map(N => 32)
        port map(
            clk,                        -- clock
            reset,                      -- reset
            '0',                        -- write enable
            x"00000000",                -- write data
            s2(0)                       -- 2d array
            );

    -- AND gate to enable write using decoder output
    andgate : process (s1, i_wC) is
    begin
        for i in 1 to 31 loop
            s3(i) <= s1(i) and i_wC;
        end loop;

    end process andgate;

    -- Generate 32 registers with 32 bits

    registerlist : for i in 1 to 31 generate

        regi : component dffg_n
            generic map(N => 32)
            port map(
                clk,                    -- clock
                reset,                  -- reset
                s3(i),                  -- write enable
                i_wD,                   -- write data
                s2(i)                   -- 2d array
                );

    end generate registerlist;

    -- Generate 2 Read Ports
    read1 : component mux32t1
        port map(
            s2,                         -- 2d array
            i_r1,                       -- read address 1
            o_d1                        -- read data 1
            );

    -- Generate 2 Read Ports
    read2 : component mux32t1
        port
        map(
            s2,                         -- 2d array
            i_r2,                       -- read address 2
            o_d2                        -- read data 2
            );

end architecture structural;

