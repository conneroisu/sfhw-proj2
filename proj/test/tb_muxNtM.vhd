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
use work.MIPS_types.all;

-- Multiplexer Entity and Architecture
entity muxNtM is
    generic (
        DATA_WIDTH : integer := 8;  -- Width of each input
        NUM_INPUTS : integer := 4   -- Number of inputs
    );
    port (
        I : in  std_logic_vector(NUM_INPUTS * DATA_WIDTH - 1 downto 0);  -- Concatenated inputs
        S : in  std_logic_vector(clog2(NUM_INPUTS) - 1 downto 0);        -- Select signal
        Y : out std_logic_vector(DATA_WIDTH - 1 downto 0)                -- Output
    );
end entity muxNtM;

architecture behavioral of muxNtM is
begin
    -- Select the appropriate input based on the select signal
    Y <= I((to_integer(unsigned(S)) + 1) * DATA_WIDTH - 1 downto to_integer(unsigned(S)) * DATA_WIDTH);
end architecture behavioral;

-- Testbench for the multiplexer
entity muxNtM_tb is
end entity muxNtM_tb;

architecture testbench of muxNtM_tb is

    -- Constants for test cases
    constant DATA_WIDTHS : integer_vector := (8, 16, 4);
    constant NUM_INPUTS_LIST : integer_vector := (4, 8, 2);
    constant NUM_TESTS : integer := DATA_WIDTHS'length;

    -- Generate arrays for signals
    type std_logic_vector_array is array (natural range <>) of std_logic_vector;

    -- Signals for each instance
    signal I_signals : std_logic_vector_array(1 to NUM_TESTS);
    signal S_signals : std_logic_vector_array(1 to NUM_TESTS);
    signal Y_signals : std_logic_vector_array(1 to NUM_TESTS);

    -- Helper types
    subtype data_width_range is integer range 1 to NUM_TESTS;
    type integer_array is array (data_width_range) of integer;

    -- Arrays to hold data widths and number of inputs
    constant DATA_WIDTH_ARRAY : integer_array := DATA_WIDTHS;
    constant NUM_INPUTS_ARRAY : integer_array := NUM_INPUTS_LIST;

begin

    -- Generate multiplexer instances
    gen_multiplexers : for idx in data_width_range generate

        -- Constants for this instance
        constant DATA_WIDTH : integer := DATA_WIDTH_ARRAY(idx);
        constant NUM_INPUTS : integer := NUM_INPUTS_ARRAY(idx);
        constant SELECT_WIDTH : integer := clog2(NUM_INPUTS);

        -- Signals for this instance
        signal I : std_logic_vector(NUM_INPUTS * DATA_WIDTH - 1 downto 0);
        signal S : std_logic_vector(SELECT_WIDTH - 1 downto 0);
        signal Y : std_logic_vector(DATA_WIDTH - 1 downto 0);

        -- Assign signals to arrays
        I_signals(idx) <= I;
        S_signals(idx) <= S;
        Y_signals(idx) <= Y;

        -- Instantiate the multiplexer
        mux_inst : entity work.muxNtM
            generic map (
                DATA_WIDTH => DATA_WIDTH,
                NUM_INPUTS => NUM_INPUTS
            )
            port map (
                I => I,
                S => S,
                Y => Y
            );

    end generate;

    -- Test process
    test_process : process
    begin
        -- Iterate over each test case
        for idx in data_width_range loop
            -- Retrieve constants for this test
            variable DATA_WIDTH : integer := DATA_WIDTH_ARRAY(idx);
            variable NUM_INPUTS : integer := NUM_INPUTS_ARRAY(idx);
            variable SELECT_WIDTH : integer := clog2(NUM_INPUTS);

            -- Signals for this test
            variable I_var : std_logic_vector(NUM_INPUTS * DATA_WIDTH - 1 downto 0);
            variable S_var : std_logic_vector(SELECT_WIDTH - 1 downto 0);
            variable Y_expected : std_logic_vector(DATA_WIDTH - 1 downto 0);

            -- Initialize inputs with incremental values
            for i in 0 to NUM_INPUTS - 1 loop
                I_var((i + 1) * DATA_WIDTH - 1 downto i * DATA_WIDTH) := std_logic_vector(to_unsigned(i, DATA_WIDTH));
            end loop;

            -- Assign inputs to the multiplexer
            I_signals(idx) <= I_var;

            -- Test all possible select values
            for s in 0 to NUM_INPUTS - 1 loop
                -- Set select signal
                S_var := std_logic_vector(to_unsigned(s, SELECT_WIDTH));
                S_signals(idx) <= S_var;
                wait for 10 ns;

                -- Expected output
                Y_expected := std_logic_vector(to_unsigned(s, DATA_WIDTH));

                -- Check the output
                assert Y_signals(idx) = Y_expected
                    report "Mismatch in multiplexer " & integer'image(idx) &
                           " at select " & integer'image(s) & ". Expected: " &
                           Y_expected'instance_name & ", Got: " & Y_signals(idx)'instance_name

                    severity error;
            end loop;
        end loop;

        -- Indicate successful completion
        report "Testbench completed successfully." severity note;
        wait;
    end process;

end architecture testbench;