-- <header>
-- Author(s): Kariniux, Conner Ohnesorge
-- Name: proj/test/tb_muxNtM.vhd
-- Notes:
--      Kariniux 2024-11-21T09:04:48-06:00 pushing-pulling
--      Conner Ohnesorge 2024-11-16T17:45:49-06:00 reset-tests-for-muxNtM
--      Conner Ohnesorge 2024-11-16T17:42:45-06:00 fix-initial-testcases-for-muxNtM
--      Conner Ohnesorge 2024-11-16T17:37:09-06:00 fix-length-of-test-case-names
--      Conner Ohnesorge 2024-11-16T17:36:04-06:00 finish-setup-of-muxNtM-and-test-bench
--      Conner Ohnesorge 2024-11-16T17:29:14-06:00 fix-name-of-component-under-test-in-testbench-for-muxNtM
--      Conner Ohnesorge 2024-11-16T17:28:51-06:00 update-muxNtM-and-test-bench
--      Conner Ohnesorge 2024-11-16T17:25:39-06:00 update-test-for-muxNtM
--      connero 2024-11-16T17:22:38-06:00 Merge-branch-main-into-component-forward-unit
--      Conner Ohnesorge 2024-11-16T17:13:40-06:00 update-to-latest-implementation-of-muxNtM
--      Conner Ohnesorge 2024-11-13T10:12:57-06:00 save-stage-progess
--      Conner Ohnesorge 2024-11-11T10:14:37-06:00 added-generic-mux-muxNtM
-- </header>

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.MATH_REAL.all;

entity tb_muxNtM is
end tb_muxNtM;

architecture Behavioral of tb_muxNtM is
    -- Constants for this specific test configuration
    constant DATA_WIDTH  : positive := 8;
    constant INPUT_COUNT : positive := 4;
    constant SEL_WIDTH   : positive := 2;  -- log2(INPUT_COUNT)

    -- Test signals
    signal inputs : std_logic_vector(INPUT_COUNT * DATA_WIDTH - 1 downto 0);
    signal sel    : std_logic_vector(SEL_WIDTH - 1 downto 0);
    signal output : std_logic_vector(DATA_WIDTH - 1 downto 0);

    -- Record type for test cases
    type test_case_t is record
        inputs    : std_logic_vector(INPUT_COUNT * DATA_WIDTH - 1 downto 0);
        sel       : std_logic_vector(SEL_WIDTH - 1 downto 0);
        expected  : std_logic_vector(DATA_WIDTH - 1 downto 0);
        test_name : string(1 to 40);
    end record;

    -- Array of test cases
    type test_case_array_t is array (natural range <>) of test_case_t;

    -- Helper function to create vector with specific input value at specific position
    function create_input_vector(position : natural; value : std_logic_vector(DATA_WIDTH-1 downto 0))
        return std_logic_vector is
        variable result : std_logic_vector(INPUT_COUNT * DATA_WIDTH - 1 downto 0) := (others => '0');
    begin
        result((position + 1) * DATA_WIDTH - 1 downto position * DATA_WIDTH) := value;
        return result;
    end function;

begin
    -- Test process
    process
        -- Test case array with various scenarios
        constant test_cases : test_case_array_t := (
            -- Test 1: Basic selection test with single '1' in each position
            (create_input_vector(0, X"AA"), "00", X"AA", "Basic selection test - Input 0          "),
            (create_input_vector(1, X"BB"), "01", X"BB", "Basic selection test - Input 1          "),
            (create_input_vector(2, X"CC"), "10", X"CC", "Basic selection test - Input 2          "),
            (create_input_vector(3, X"DD"), "11", X"DD", "Basic selection test - Input 3          "),

            -- Test 2: All inputs active, testing each selection
            (X"AABBCCDD", "00", X"DD", "All inputs active - Select input 0      "),
            (X"AABBCCDD", "01", X"CC", "All inputs active - Select input 1      "),
            (X"AABBCCDD", "10", X"BB", "All inputs active - Select input 2      "),
            (X"AABBCCDD", "11", X"AA", "All inputs active - Select input 3      "),

            -- Test 3: Input bit patterns
            (X"FF000000", "11", X"FF", "All ones pattern - Input 0              "),
            (X"00FF0000", "10", X"FF", "All ones pattern - Input 1              "),
            (X"0000FF00", "01", X"FF", "All ones pattern - Input 2              "),
            (X"000000FF", "00", X"FF", "All ones pattern - Input 3              "),

            -- Test 4: Alternating patterns
            (X"A5A5A5A5", "00", X"A5", "Alternating pattern - Input 0           "),
            (X"5A5A5A5A", "01", X"5A", "Alternating pattern - Input 1           "),

            -- Test 5: Zero input tests
            (X"00000000", "00", X"00", "All zeros - Select input 0              "),
            (X"00000000", "11", X"00", "All zeros - Select input 3              ")
            );

        -- Variables for metavalue tests
        variable metavalue_sel : std_logic_vector(SEL_WIDTH - 1 downto 0);

    begin
        report "Starting multiplexer tests...";

        -- Run through all predefined test cases
        for i in test_cases'range loop
            inputs <= test_cases(i).inputs;
            sel    <= test_cases(i).sel;
            wait for 10 ns;

            -- Check results
            assert output = test_cases(i).expected
                report "Test " & integer'image(i) & " (" & test_cases(i).test_name & ") failed!" &
                " Expected: " & to_hstring(test_cases(i).expected) &
                " Got: " & to_hstring(output)
                severity error;
        end loop;

        report "Starting metavalue tests...";

        -- Test metavalue handling
        inputs <= X"12345678";          -- Known input pattern

        -- Test 'U' (uninitialized)
        sel <= (others                => 'U');
        wait for 10 ns;
        assert output = (output'range => 'X')
            report "Metavalue test (U) failed - Output should be all X's"
            severity error;

        -- Test 'X' (unknown)
        sel <= (others                => 'X');
        wait for 10 ns;
        assert output = (output'range => 'X')
            report "Metavalue test (X) failed - Output should be all X's"
            severity error;

        -- Test 'Z' (high impedance)
        sel <= (others                => 'Z');
        wait for 10 ns;
        assert output = (output'range => 'X')
            report "Metavalue test (Z) failed - Output should be all X's"
            severity error;

        -- Test mixed values
        sel <= "X1";
        wait for 10 ns;
        assert output = (output'range => 'X')
            report "Metavalue test (mixed) failed - Output should be all X's"
            severity error;

        report "All tests completed!";
        wait;
    end process;

    -- DUT instantiation
    DUT : entity work.muxNtM
        generic map (
            DATA_WIDTH  => DATA_WIDTH,
            INPUT_COUNT => INPUT_COUNT
            )
        port map (
            inputs => inputs,
            sel    => sel,
            output => output
            );

end Behavioral;
