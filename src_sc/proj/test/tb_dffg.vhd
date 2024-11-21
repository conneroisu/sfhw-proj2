-- <header>
-- Author(s): conneroisu
-- Name: proj/test/tb_dffg.vhd
-- Notes:
--      conneroisu  <conneroisu@outlook.com> manually-ran-the-header-update-script
--      conneroisu  <conneroisu@outlook.com> even-better-file-header-program
--      conneroisu  <conneroisu@outlook.com> fixed-and-added-back-the-git-cdocumentor-for-the-vhdl-files-to-have
--      conneroisu  <conneroisu@outlook.com> add-lowlevel-components-and-testbenches
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;
-- Entity declaration of dffg_tb
entity dffg_tb is
    generic (gCLK_HPER : time := 50 ns);
end dffg_tb;
-- Architecture declaration of dffg_tb
architecture behavior of dffg_tb is
    -- Calculate the clock period as twice the half-period
    constant cCLK_PER : time := gCLK_HPER * 2;
    component dffg
        port (
            i_CLK : in  std_logic;      -- Clock input
            i_RST : in  std_logic;      -- Reset input
            i_WE  : in  std_logic;      -- Write enable input
            i_D   : in  std_logic;      -- Data value input
            o_Q   : out std_logic);     -- Data value output
    end component;
    -- Temporary signals to connect to the dff component.
    signal s_CLK, s_RST, s_WE : std_logic;
    signal s_D, s_Q           : std_logic;
begin
    DUT : dffg
        port map(
            i_CLK => s_CLK,
            i_RST => s_RST,
            i_WE  => s_WE,
            i_D   => s_D,
            o_Q   => s_Q);
    -- This process sets the clock value (low for gCLK_HPER, then high
    -- for gCLK_HPER). Absent a "wait" command, processes restart 
    -- at the beginning once they have reached the final statement.
    P_CLK : process
    begin
        s_CLK <= '0';
        wait for gCLK_HPER;
        s_CLK <= '1';
        wait for gCLK_HPER;
    end process;
    -- Testbench process  
    P_TB : process
    begin
        -- Reset the FF
        s_RST <= '1';
        s_WE  <= '0';
        s_D   <= '0';
        wait for cCLK_PER;
        -- Store '1'
        s_RST <= '0';
        s_WE  <= '1';
        s_D   <= '1';
        wait for cCLK_PER;
        -- Keep '1'
        s_RST <= '0';
        s_WE  <= '0';
        s_D   <= '0';
        wait for cCLK_PER;
        -- Store '0'    
        s_RST <= '0';
        s_WE  <= '1';
        s_D   <= '0';
        wait for cCLK_PER;
        -- Keep '0'
        s_RST <= '0';
        s_WE  <= '0';
        s_D   <= '1';
        wait for cCLK_PER;
        wait;
    end process;
end behavior;
