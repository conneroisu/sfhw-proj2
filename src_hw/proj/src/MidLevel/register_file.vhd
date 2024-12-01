-- <header>
-- Author(s): Conner Ohnesorge
-- Name: src_sc/proj/src/TopLevel/Fetch/register_file.vhd
-- Notes:
--      Conner Ohnesorge 2024-11-21T11:05:34-06:00 added-old-single-cycle-processor-and-added-documentation-for-the
-- </header>

library ieee;
use ieee.std_logic_1164.all;
use work.mips_types.all;

entity register_file is
    port
        (
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
        port
            (
                i_clk : in  std_logic;  -- Clock input
                i_rst : in  std_logic;  -- Reset input
                i_we  : in  std_logic;  -- Write enable input
                i_d   : in  std_logic_vector(31 downto 0);  -- Data input
                o_q   : out std_logic_vector(31 downto 0)   -- Data output
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
        port
        map(
            i_clk => clk,               -- clock
            i_rst => reset,             -- reset
            i_we  => '0',               -- write enable
            i_d   => x"00000000",       -- write data
            o_q   => s2(0)              -- 2d array
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
            port
            map(
                i_clk => clk,           -- clock
                i_rst => reset,         -- reset
                i_we  => s3(i),         -- write enable
                i_d   => i_wD,          -- write data
                o_q   => s2(i)          -- 2d array
                );

    end generate registerlist;

    -- Generate 2 Read Ports
    read1 : component mux32t1
        port
        map(
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

