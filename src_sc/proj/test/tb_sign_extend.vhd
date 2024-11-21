-- <header>
-- Author(s): Conner Ohnesorge
-- Name: src_sc/proj/test/tb_sign_extend.vhd
-- Notes:
--      Conner Ohnesorge 2024-11-21T11:05:34-06:00 added-old-single-cycle-processor-and-added-documentation-for-the
-- </header>

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
entity SignExtend_tb is
end SignExtend_tb;
architecture Behavioral of SignExtend_tb is
    -- Declaration of signals to connect to the DUT (Device Under Test)
    signal in_signal_tb  : std_logic_vector(15 downto 0);  -- Input signal to the DUT (16-bit)
    signal out_signal_tb : std_logic_vector(31 downto 0);  -- Output signal from the DUT (32-bit)
    component SignExtend
        port (
            in_signal  : in  std_logic_vector(15 downto 0);  -- 16-bit input to be sign-extended
            out_signal : out std_logic_vector(31 downto 0)  -- 32-bit sign-extended output
            );
    end component;
begin
    UUT : SignExtend
        port map (
            in_signal  => in_signal_tb,  -- Connect the input signal to the DUT
            out_signal => out_signal_tb  -- Connect the output signal to the DUT
            );
    process
    begin
        -- Test Case 1: Small positive number 
        in_signal_tb <= "0000000000000001";  -- 16-bit input: +1
        wait for 10 ns;  -- Wait for 10 ns to allow the circuit to stabilize
        assert out_signal_tb = "00000000000000000000000000000001"  -- Expected 32-bit output: +1
            report "Test case 1 failed: Expected +1 (0001 extended to 32 bits)" severity error;
        -- Test Case 2: Negative number 
        in_signal_tb <= "1000000000000000";  -- 16-bit input: -32768 (MSB = 1)
        wait for 10 ns;
        assert out_signal_tb = "11111111111111111000000000000000"  -- Expected 32-bit output: -32768
            report "Test case 2 failed: Expected -32768 (0x8000 extended to 32 bits)" severity error;
        -- Test Case 3: Largest positive number 
        in_signal_tb <= "0111111111111111";  -- 16-bit input: +32767
        wait for 10 ns;
        assert out_signal_tb = "00000000000000000111111111111111"  -- Expected 32-bit output: +32767
            report "Test case 3 failed: Expected +32767 (0x7FFF extended to 32 bits)" severity error;
        -- Test Case 4: Negative number 
        in_signal_tb <= "1111111111111111";  -- 16-bit input: -1
        wait for 10 ns;
        assert out_signal_tb = "11111111111111111111111111111111"  -- Expected 32-bit output: -1
            report "Test case 4 failed: Expected -1 (0xFFFF extended to 32 bits)" severity error;
        -- Test Case 5: Zero 
        in_signal_tb <= "0000000000000000";  -- 16-bit input: 0
        wait for 10 ns;
        assert out_signal_tb = "00000000000000000000000000000000"  -- Expected 32-bit output: 0
            report "Test case 5 failed: Expected 0 (0x0000 extended to 32 bits)" severity error;
        -- Test Case 6: Another negative number
        in_signal_tb <= "1111111100000000";  -- 16-bit input: -256
        wait for 10 ns;
        assert out_signal_tb = "11111111111111111111111100000000"  -- Expected 32-bit output: -256
            report "Test case 6 failed: Expected -256 (0xFF00 extended to 32 bits)" severity error;
        -- Test Case 7: Small positive number 
        in_signal_tb <= "0000000000001010";
        wait for 10 ns;
        assert out_signal_tb = "00000000000000000000000000001010"  -- Expected 32-bit output: +10
            report "Test case 7 failed: Expected +10 (0x000A extended to 32 bits)" severity error;
        -- Test Case 8: Larger negative number 
        in_signal_tb <= "1111001000110100";  -- 16-bit input: -3564 
        wait for 10 ns;
        assert out_signal_tb = "11111111111111111111001000110100"  -- Expected 32-bit output: -3564
            report "Test case 8 failed: Expected -3564 (0xF234 extended to 32 bits)" severity error;
        -- Test completed: Stop the simulation
        wait;
    end process;
end Behavioral;

