library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;
use IEEE.std_logic_textio.all;

entity logic_N_tb is
end logic_N_tb;

architecture behavior of logic_N_tb is
    constant N : integer := 32;
    constant CLOCK_PERIOD : time := 10 ns;
    constant TEST_CASES : integer := 16; -- Number of test cases
    
    component logic_N
        generic (N : integer := 32);
        port (
            i_D0     : in std_logic_vector(N-1 downto 0);
            i_D1     : in std_logic_vector(N-1 downto 0);
            i_op     : in std_logic_vector(1 downto 0);
            o_result : out std_logic_vector(N-1 downto 0)
        );
    end component;
    
    signal s_D0     : std_logic_vector(N-1 downto 0) := (others => '0');
    signal s_D1     : std_logic_vector(N-1 downto 0) := (others => '0');
    signal s_op     : std_logic_vector(1 downto 0) := "00";
    signal s_result : std_logic_vector(N-1 downto 0);
    
    -- Test verification signals
    signal s_expected_result : std_logic_vector(N-1 downto 0);
    
    -- Function to convert std_logic_vector to string for reporting
    function vec2str(vec : std_logic_vector) return string is
        variable stmp : string(vec'length downto 1);
    begin
        for i in vec'length downto 1 loop
            case vec(i-1) is
                when '1' => stmp(i) := '1';
                when '0' => stmp(i) := '0';
                when others => stmp(i) := 'X';
            end case;
        end loop;
        return stmp;
    end function;

begin
    
    DUT: logic_N 
    generic map (N => N)
    port map (
        i_D0     => s_D0,
        i_D1     => s_D1,
        i_op     => s_op,
        o_result => s_result
    );
    
    -- Test Process
    test_proc: process
        variable errors : integer := 0;
        
        -- Procedure to check results and report
        procedure check_result(test_num : integer) is
        begin
            wait for 1 ns; -- Allow for propagation
            if s_result /= s_expected_result then
                errors := errors + 1;
                report "Test " & integer'image(test_num) & " Failed!" & LF &
                       "D0: " & vec2str(s_D0) & LF &
                       "D1: " & vec2str(s_D1) & LF &
                       "Op: " & vec2str(s_op) & LF &
                       "Expected: " & vec2str(s_expected_result) & LF &
                       "Got: " & vec2str(s_result)
                severity error;
            else
                report "Test " & integer'image(test_num) & " Passed!"
                severity note;
            end if;
        end procedure;
        
    begin
        -- Test Case 1: AND operation with all 1's
        s_D0 <= (others => '1');
        s_D1 <= (others => '1');
        s_op <= "00";
        s_expected_result <= (others => '1');
        wait for 10 ns;
        check_result(1);
        
        -- Test Case 2: AND operation with mixed values
        s_D0 <= x"AAAAAAAA";
        s_D1 <= x"55555555";
        s_op <= "00";
        s_expected_result <= x"00000000";
        wait for 10 ns;
        check_result(2);
        
        -- Test Case 3: OR operation
        s_D0 <= x"AAAAAAAA";
        s_D1 <= x"55555555";
        s_op <= "01";
        s_expected_result <= x"FFFFFFFF";
        wait for 10 ns;
        check_result(3);
        
        -- Test Case 4: NOR operation
        s_D0 <= x"AAAAAAAA";
        s_D1 <= x"55555555";
        s_op <= "10";
        s_expected_result <= x"00000000";
        wait for 10 ns;
        check_result(4);
        
        -- Test Case 5: XOR operation
        s_D0 <= x"AAAAAAAA";
        s_D1 <= x"55555555";
        s_op <= "11";
        s_expected_result <= x"FFFFFFFF";
        wait for 10 ns;
        check_result(5);
        
        -- Test Case 6: All zeros
        s_D0 <= (others => '0');
        s_D1 <= (others => '0');
        s_op <= "00"; -- AND
        s_expected_result <= (others => '0');
        wait for 10 ns;
        check_result(6);
        
        -- Test Case 7: Edge case - alternating bits
        s_D0 <= x"55555555";
        s_D1 <= x"55555555";
        s_op <= "11"; -- XOR
        s_expected_result <= (others => '0');
        wait for 10 ns;
        check_result(7);
        
        -- Report final results
        if errors = 0 then
            report "ALL TESTS PASSED!"
            severity note;
        else
            report "TESTS COMPLETED: " & integer'image(errors) & " ERRORS FOUND!"
            severity failure;
        end if;
        
        wait;
    end process;

end behavior;
