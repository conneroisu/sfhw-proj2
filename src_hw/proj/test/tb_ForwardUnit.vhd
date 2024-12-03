-- <header>
-- Author(s): Conner Ohnesorge
-- Name: 
-- Notes:
--      Conner Ohnesorge 2024-12-01T12:19:14-06:00 moved-all-files-into-the-hardware-directory
-- </header>

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;


entity ForwardUnit is
end ForwardUnit;

architecture Behavioral of ForwardUnit is
    component ForwardUnit
        port (
            i_forwarding  : in  std_logic;
            i_exRs        : in  std_logic_vector (4 downto 0);
            i_exRt        : in  std_logic_vector (4 downto 0);
            i_memRd       : in  std_logic_vector (4 downto 0);
            i_wbRd        : in  std_logic_vector (4 downto 0);
            i_memMemRead  : in  std_logic_vector (4 downto 0);
            i_memMemWrite : in  std_logic_vector (4 downto 0);
            i_memPCSrc    : in  std_logic_vector (1 downto 0);
            i_wbRegWrite  : in  std_logic_vector (4 downto 0);
            o_exForwardA  : out std_logic_vector (1 downto 0);  -- forwarding 1st mux signal to EX stage
            o_exForwardB  : out std_logic_vector (1 downto 0)  -- forwarding 2nd mux signal to EX stage
            );
    end component;
    signal i_forwarding  : std_logic;
    signal i_exRs        : std_logic_vector (4 downto 0);
    signal i_exRt        : std_logic_vector (4 downto 0);
    signal i_memRd       : std_logic_vector (4 downto 0);
    signal i_wbRd        : std_logic_vector (4 downto 0);
    signal i_memMemRead  : std_logic_vector (4 downto 0);
    signal i_memMemWrite : std_logic_vector (4 downto 0);
    signal i_memPCSrc    : std_logic_vector (1 downto 0);
    signal i_wbRegWrite  : std_logic_vector (4 downto 0);
    signal o_exForwardA  : std_logic_vector (1 downto 0);
    signal o_exForwardB  : std_logic_vector (1 downto 0);
    constant clk_period  : time := 50 ns;

begin
    uut : ForwardUnit port map(
        i_forwarding  => i_forwarding,
        i_exRs        => i_exRs,
        i_exRt        => i_exRt,
        i_memRd       => i_memRd,
        i_wbRd        => i_wbRd,
        i_memMemRead  => i_memMemRead,
        i_memMemWrite => i_memMemWrite,
        i_memPCSrc    => i_memPCSrc,
        i_wbRegWrite  => i_wbRegWrite,
        o_exForwardA  => o_exForwardA,
        o_exForwardB  => o_exForwardB
        );

--       clk_process : process (all)
--        begin
--            clk <= '0';
--            wait for clk_period / 2;
--            clk <= '1';
--            wait for clk_period / 2;
--        end process;

    stim_proc : process (all)
    begin
    end process;
end Behavioral;

