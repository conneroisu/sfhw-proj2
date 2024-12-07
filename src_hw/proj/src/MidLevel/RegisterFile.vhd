-- <header>
-- Author(s): connerohnesorge, Conner Ohnesorge
-- Name: 
-- Notes:
--      connerohnesorge 2024-12-06T07:20:56-06:00 Ensure-style-guidelines-are-followed-with-registerfile-and-update-it-s-interface-in-the-processor
--      Conner Ohnesorge 2024-12-04T07:52:56-06:00 update-register-file-name
-- </header>

library ieee;
use ieee.std_logic_1164.all;
use work.mips_types.all;

entity RegisterFile is

    port (
        i_CLK         : in  std_logic;
        i_WriteAddr   : in  std_logic_vector(4 downto 0);
        i_WriteData   : in  std_logic_vector(31 downto 0);
        i_WriteEnable : in  std_logic;
        i_ReadAddr1   : in  std_logic_vector(4 downto 0);
        i_ReadAddr2   : in  std_logic_vector(4 downto 0);
        i_Reset       : in  std_logic;
        o_ReadData1   : out std_logic_vector(31 downto 0);
        o_ReadData2   : out std_logic_vector(31 downto 0)
        );

end entity RegisterFile;

architecture structural of RegisterFile is

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
            i_WE  : in  std_logic;                       -- Write enable input
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
            i_WriteAddr,
            s1
            );

    -- Set register $0 to 0
    reg0 : component dffg_n
        generic map(N => 32)
        port map(
            i_CLK,                      -- clock
            i_Reset,                    -- reset
            '0',                        -- write enable
            x"00000000",                -- write data
            s2(0)                       -- 2d array
            );

    -- AND gate to enable write using decoder output
    andgate : process (s1, i_WriteEnable) is
    begin
        for i in 1 to 31 loop
            s3(i) <= s1(i) and i_WriteEnable;
        end loop;

    end process andgate;

    -- Generate 32 registers with 32 bits

    registerlist : for i in 1 to 31 generate

        regi : component dffg_n
            generic map(N => 32)
            port map(
                i_CLK,                  -- clock
                i_Reset,                -- reset
                s3(i),                  -- write enable
                i_WriteData,            -- write data
                s2(i)                   -- 2d array
                );

    end generate registerlist;

    -- Generate 2 Read Ports
    read1 : component mux32t1
        port map(
            s2,                         -- 2d array
            i_ReadAddr1,                -- read address 1
            o_ReadData1                 -- read data 1
            );

    -- Generate 2 Read Ports
    read2 : component mux32t1
        port
        map(
            s2,                         -- 2d array
            i_ReadAddr2,                -- read address 2
            o_ReadData2                 -- read data 2
            );

end architecture structural;

