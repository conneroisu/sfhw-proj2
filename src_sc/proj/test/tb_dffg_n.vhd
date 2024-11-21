-- <header>
-- Author(s): conneroisu
-- Name: proj/test/tb_dffg_n.vhd
-- Notes:
--      conneroisu  <conneroisu@outlook.com> manually-ran-the-header-update-script
--      conneroisu  <conneroisu@outlook.com> even-better-file-header-program
--      conneroisu  <conneroisu@outlook.com> fixed-and-added-back-the-git-cdocumentor-for-the-vhdl-files-to-have
--      conneroisu  <conneroisu@outlook.com> add-lowlevel-components-and-testbenches
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;
-- Entity declaration of the testbench
entity tb_dffg_n is
end tb_dffg_n;
architecture behavioral of tb_dffg_n is
    constant N : integer := 8;          -- Width of the register
    -- Component declaration of dffg_n
    component dffg_n is
        generic (
            N : integer := 8
            );
        port (
            i_CLK : in  std_logic;      -- Clock input
            i_RST : in  std_logic;      -- Reset input
            i_WE  : in  std_logic;      -- Write enable input
            i_D   : in  std_logic_vector(N-1 downto 0);  -- Data value input
            o_Q   : out std_logic_vector(N-1 downto 0)   -- Data value output
            );
    end component;
    -- Signals to connect to the dffg_n instance
    signal s_CLK        : std_logic                      := '0';
    signal s_RST        : std_logic                      := '0';
    signal s_WE         : std_logic                      := '0';
    signal s_D          : std_logic_vector(N-1 downto 0) := (others => '0');
    signal s_Q          : std_logic_vector(N-1 downto 0);
    -- Clock period constant
    constant CLK_PERIOD : time                           := 10 ns;
begin
    -- Instantiate the dffg_n register
    uut : dffg_n
        generic map (
            N => N
            )
        port map (
            i_CLK => s_CLK,
            i_RST => s_RST,
            i_WE  => s_WE,
            i_D   => s_D,
            o_Q   => s_Q
            );
    -- Clock generation process
    clk_process : process
    begin
        while true loop
            s_CLK <= '0';
            wait for CLK_PERIOD / 2;
            s_CLK <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
        wait;
    end process clk_process;
    -- Stimulus process
    stim_proc : process
    begin
        -- Initial reset
        s_RST <= '1';
        wait for CLK_PERIOD * 2;
        s_RST <= '0';
        wait for CLK_PERIOD;
        -- Test 1: Write data when WE is '1'
        s_WE  <= '1';
        s_D   <= X"AA";                 -- 10101010
        wait for CLK_PERIOD;
        assert s_Q = X"AA" report "Test 1 failed: o_Q did not match i_D" severity error;
        -- Test 2: Change data with WE '1'
        s_D   <= X"55";                 -- 01010101
        wait for CLK_PERIOD;
        assert s_Q = X"55" report "Test 2 failed: o_Q did not match i_D" severity error;
        -- Test 3: Hold data when WE is '0'
        s_WE  <= '0';
        s_D   <= X"FF";                 -- Change i_D but o_Q should not change
        wait for CLK_PERIOD;
        assert s_Q = X"55" report "Test 3 failed: o_Q changed when WE is '0'" severity error;
        -- Test 4: Apply reset while WE is '0'
        s_RST <= '1';
        wait for CLK_PERIOD;
        s_RST <= '0';
        wait for CLK_PERIOD;
        -- Test 5: Write data after reset
        s_WE  <= '1';
        s_D   <= X"0F";                 -- 00001111
        wait for CLK_PERIOD;
        assert s_Q = X"0F" report "Test 5 failed: o_Q did not update after reset" severity error;
        -- Test 6: Multiple writes
        s_D   <= X"F0";                 -- 11110000
        wait for CLK_PERIOD;
        assert s_Q = X"F0" report "Test 6 failed: o_Q did not update on multiple writes" severity error;
        -- End of tests
        wait;
    end process stim_proc;
end behavioral;
