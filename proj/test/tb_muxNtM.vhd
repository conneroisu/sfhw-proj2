-- <header>
-- Author(s): Conner Ohnesorge
-- Name: proj/test/tb_muxNtM.vhd
-- Notes:
--      conneroisu 2024-11-14T14:56:19Z Format-and-Header
--      Conner Ohnesorge 2024-11-13T10:12:57-06:00 save-stage-progess
--      Conner Ohnesorge 2024-11-11T10:14:37-06:00 added-generic-mux-muxNtM
-- </header>

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;

entity tb_muxNtM is
end tb_muxNtM;

architecture Behavioral of tb_muxNtM is
    -- Test configuration type and array
    type test_config is record
        data_width  : positive;
        input_count : positive;
    end record;
    
    type test_configs_array is array (natural range <>) of test_config;
    
    -- Define different configurations to test
    constant TEST_CONFIGS : test_configs_array := (
        (data_width => 8,  input_count => 4),   -- Common configuration
        (data_width => 1,  input_count => 2),   -- Minimum configuration
        (data_width => 32, input_count => 8),   -- Wide data
        (data_width => 4,  input_count => 16)   -- Many inputs
    );
    
    -- Maximum values for array sizing
    constant MAX_DATA_WIDTH  : positive := 32;
    constant MAX_INPUT_COUNT : positive := 16;
    
    -- Component signals
    signal inputs : std_logic_vector(MAX_INPUT_COUNT * MAX_DATA_WIDTH - 1 downto 0);
    signal sel    : std_logic_vector(integer(ceil(log2(real(MAX_INPUT_COUNT)))) - 1 downto 0);
    signal output : std_logic_vector(MAX_DATA_WIDTH - 1 downto 0);
    
    -- Test control signals
    signal test_done : boolean := false;
    
    -- Function to create test pattern for inputs
    function create_test_pattern(data_width : positive; input_count : positive) 
        return std_logic_vector is
        variable result : std_logic_vector(input_count * data_width - 1 downto 0);
    begin
        for i in 0 to input_count - 1 loop
            for j in 0 to data_width - 1 loop
                -- Create unique pattern for each input
                result(i * data_width + j) := '1' when (i + j) mod 2 = 0 else '0';
            end loop;
        end loop;
        return result;
    end function;
    
    -- Procedure to check expected output
    procedure check_output(
        data_width  : in positive;
        input_count : in positive;
        test_inputs : in std_logic_vector;
        sel_value   : in std_logic_vector;
        actual_out  : in std_logic_vector;
        test_name   : in string) is
        
        variable expected : std_logic_vector(data_width - 1 downto 0);
        variable sel_int  : integer;
    begin
        sel_int := to_integer(unsigned(sel_value));
        
        if sel_int < input_count then
            expected := test_inputs((sel_int + 1) * data_width - 1 downto sel_int * data_width);
            
            assert actual_out(data_width - 1 downto 0) = expected
                report "Test '" & test_name & "' failed!" & 
                      " Expected: " & to_string(expected) &
                      " Got: " & to_string(actual_out(data_width - 1 downto 0))
                severity error;
        else
            -- Check if output is zero for invalid selection
            assert actual_out(data_width - 1 downto 0) = (data_width - 1 downto 0 => '0')
                report "Test '" & test_name & "' failed! Expected all zeros for invalid selection"
                severity error;
        end if;
    end procedure;

begin
    -- Test process
    process
        variable test_inputs_temp : std_logic_vector(MAX_INPUT_COUNT * MAX_DATA_WIDTH - 1 downto 0);
    begin
        -- Run tests for each configuration
        for config_idx in TEST_CONFIGS'range loop
            report "Testing configuration: " &
                  "Data Width = " & integer'image(TEST_CONFIGS(config_idx).data_width) &
                  ", Input Count = " & integer'image(TEST_CONFIGS(config_idx).input_count);
            
            -- Create test pattern for current configuration
            test_inputs_temp := (others => '0');
            test_inputs_temp(TEST_CONFIGS(config_idx).input_count * 
                           TEST_CONFIGS(config_idx).data_width - 1 downto 0) := 
                create_test_pattern(TEST_CONFIGS(config_idx).data_width,
                                  TEST_CONFIGS(config_idx).input_count);
            inputs <= test_inputs_temp;
            
            -- Test all valid select values
            for i in 0 to TEST_CONFIGS(config_idx).input_count - 1 loop
                sel <= std_logic_vector(to_unsigned(i, sel'length));
                wait for 10 ns;
                
                check_output(
                    TEST_CONFIGS(config_idx).data_width,
                    TEST_CONFIGS(config_idx).input_count,
                    test_inputs_temp,
                    sel,
                    output,
                    "Config " & integer'image(config_idx) & " Select " & integer'image(i)
                );
            end loop;
            
            -- Test invalid select value
            sel <= std_logic_vector(to_unsigned(TEST_CONFIGS(config_idx).input_count, sel'length));
            wait for 10 ns;
            check_output(
                TEST_CONFIGS(config_idx).data_width,
                TEST_CONFIGS(config_idx).input_count,
                test_inputs_temp,
                sel,
                output,
                "Config " & integer'image(config_idx) & " Invalid Select"
            );
            
            -- Add spacing between configurations
            wait for 20 ns;
        end loop;
        
        report "All tests completed!";
        test_done <= true;
        wait;
    end process;
    
    -- DUT instantiation with maximum configuration
    DUT: entity work.generic_mux
        generic map (
            DATA_WIDTH  => MAX_DATA_WIDTH,
            INPUT_COUNT => MAX_INPUT_COUNT
        )
        port map (
            inputs => inputs,
            sel    => sel,
            output => output
        );

end Behavioral;
