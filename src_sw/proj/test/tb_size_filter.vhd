-- <header>
-- Author(s): Conner Ohnesorge
-- Name: 
-- Notes:
--      Conner Ohnesorge 2024-12-01T17:20:49-06:00 copy-files-from-hw-to-sw
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity size_filter_tb is
end size_filter_tb;

architecture behavioral of size_filter_tb is
    -- Constants
    constant N            : integer := 32;
    constant CLOCK_PERIOD : time    := 10 ns;

    -- Signals
    signal i_D0     : std_logic_vector(N-1 downto 0);
    signal i_D1     : std_logic_vector(N-1 downto 0);
    signal o_result : std_logic_vector(N-1 downto 0);

    -- Expected output for verification
    signal expected_result : std_logic_vector(N-1 downto 0);

    -- Test tracking
    signal test_num     : integer := 0;
    signal tests_passed : integer := 0;
    signal tests_failed : integer := 0;

begin

    UUT : entity work.size_filter
        generic map (
            N => N
            )
        port map (
            i_D0     => i_D0,
            i_D1     => i_D1,
            o_result => o_result
            );

    -- Stimulus process
    stimulus : process
        -- Procedure to check results and update test counters
        procedure check_result(test_case : string) is
        begin
            wait for 1 ns;              -- Allow for signal propagation
            test_num <= test_num + 1;

            if (o_result = expected_result) then
                report "Test " & integer'image(test_num) & " PASSED: " & test_case
                    severity note;
                tests_passed <= tests_passed + 1;
            else
                report "Test " & integer'image(test_num) & " FAILED: " & test_case &
                    LF & "Expected: " & integer'image(to_integer(unsigned(expected_result))) &
                    LF & "Got: " & integer'image(to_integer(unsigned(o_result)))
                    severity error;
                tests_failed <= tests_failed + 1;
            end if;
            wait for 1 ns;
        end procedure;

    begin
        -- Initialize signals
        i_D0 <= (others => '0');
        i_D1 <= (others => '0');
        wait for 100 ns;

        -- Test Case 1: D0 < D1 (Positive numbers)
        i_D0            <= std_logic_vector(to_signed(5, N));
        i_D1            <= std_logic_vector(to_signed(10, N));
        expected_result <= (0 => '1', others => '0');  -- Should output 1
        wait for 10 ns;
        check_result("D0(5) < D1(10)");

        -- Test Case 2: D0 > D1 (Positive numbers)
        i_D0            <= std_logic_vector(to_signed(15, N));
        i_D1            <= std_logic_vector(to_signed(10, N));
        expected_result <= (others => '0');  -- Should output 0
        wait for 10 ns;
        check_result("D0(15) > D1(10)");

        -- Test Case 3: D0 = D1
        i_D0            <= std_logic_vector(to_signed(10, N));
        i_D1            <= std_logic_vector(to_signed(10, N));
        expected_result <= (others => '0');  -- Should output 0
        wait for 10 ns;
        check_result("D0(10) = D1(10)");

        -- Test Case 4: Negative numbers
        i_D0            <= std_logic_vector(to_signed(-5, N));
        i_D1            <= std_logic_vector(to_signed(5, N));
        expected_result <= (0 => '1', others => '0');  -- Should output 1
        wait for 10 ns;
        check_result("D0(-5) < D1(5)");

        -- Test Case 5: Both negative numbers
        i_D0            <= std_logic_vector(to_signed(-10, N));
        i_D1            <= std_logic_vector(to_signed(-5, N));
        expected_result <= (0 => '1', others => '0');  -- Should output 1
        wait for 10 ns;
        check_result("D0(-10) < D1(-5)");

        -- Test Case 6: Maximum positive vs minimum negative
        i_D0            <= std_logic_vector(to_signed(2147483647, N));  -- MAX_INT
        i_D1            <= std_logic_vector(to_signed(-2147483648, N));  -- MIN_INT
        expected_result <= (others => '0');  -- Should output 0
        wait for 10 ns;
        check_result("D0(MAX_INT) > D1(MIN_INT)");

        -- Report final results
        wait for 10 ns;
        report "=== Test Summary ===" severity note;
        report "Total Tests: " & integer'image(test_num) severity note;
        report "Tests Passed: " & integer'image(tests_passed) severity note;
        report "Tests Failed: " & integer'image(tests_failed) severity note;

        wait;
    end process;

end behavioral;

