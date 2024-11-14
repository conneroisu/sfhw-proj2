-- <header>
-- Author(s): Kariniux
-- Name: proj/src/TopLevel/IF_ID_STAGE.vhd
-- Notes:
--      Kariniux 2024-11-14T08:17:43-06:00 IF_ID-stage
-- </header>

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity IF_ID_STAGE is

    generic
        (
            DATA_WIDTH : natural := 32;
            ADDR_WIDTH : natural := 32;
            )
        port
        (
            i_clk   : in  std_logic;
            i_rst   : in  std_logic;
            i_flush : in  std_logic;
            i_stall : in  std_logic;
            i_addr  : in  std_logic_vector(ADDR_WIDTH downto 0);
            i_instr : in  std_logic_vector(DATA_WIDTH downto 0);
            o_instr : out std_logic_vector(DATA_WIDTH downto 0);
            o_addr  : out std_logic_vector(ADDR_WIDTH downto 0);
            --multiple outputs to make it easier to connect them to the next stage
            )

        architecture structural IF_ID_STAGE is

--signals
        signal s_instr : std_logic_vector(31 downto 0);
        signal s_addr  : std_logic_vector(31 downto 0);

        component dffg_n is
            generic (
                n : integer := 32
                );
            port (
                i_clk : in  std_logic;  -- Clock Input
                i_rst : in  std_logic;  -- Reset Input
                i_we  : in  std_logic;  -- Write Enable Input
                i_d   : in  std_logic_vector(n - 1 downto 0);  -- Data Value input
                o_q   : out std_logic_vector(n - 1 downto 0)  -- Data Value output
                );
        end component;


        begin

            CurrentInstruction : dffg_n
                generic map (DATA_WIDTH => 32)
                port map(
                    i_clk => i_clk,
                    i_rst => i_rst,
                    i_we  => not i_stall,
                    i_d   => (others => '0') when i_flush = '1' else i_instr,
                    o_q   => s_instr);

            NextInstruction : dffg_n
                generic map (DATA_WIDTH => 32)
                port map(
                    i_clk => i_clk,
                    i_rst => i_rst,
                    i_we  => not i_stall,
                    i_d   => (others => '0') when i_flush = '1' else i_addr,
                    o_q   => s_addr);

            o_instr <= s_instr;
            o_addr  <= s_addr;
        end structural;

