-- <header>
-- Author(s): connerohnesorge, Conner Ohnesorge
-- Name: 
-- Notes:
--      connerohnesorge 2024-12-04T17:23:24-06:00 improved-BarrelShifter-concisitity
--      Conner Ohnesorge 2024-12-01T17:22:35-06:00 fix-tb_barrel_shifter.vhd-and-upate-scripts-to-reflect-changes
--      Conner Ohnesorge 2024-12-01T14:46:47-06:00 make-barrelShifter-and-testbench-follow-the-style-guide
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_BarrelShifter is
end tb_BarrelShifter;

architecture behavioral of tb_BarrelShifter is

    constant N      : integer := 32;
    constant PERIOD : time    := 10 ns;

    component BarrelShifter is
        generic (
            N : integer := 32
            );
        port (
            i_data             : in  std_logic_vector(N-1 downto 0);
            i_logic_arithmetic : in  std_logic;
            i_left_right       : in  std_logic;
            i_shamt            : in  std_logic_vector(4 downto 0);
            o_Out              : out std_logic_vector(N-1 downto 0)
            );
    end component;

    -- Test signals
    signal s_data             : std_logic_vector(N-1 downto 0);
    signal s_logic_arithmetic : std_logic;
    signal s_left_right       : std_logic;
    signal s_shamt            : std_logic_vector(4 downto 0);
    signal s_Out              : std_logic_vector(N-1 downto 0);

    -- Helper function to convert integer to std_logic_vector
    function to_slv(val : integer; width : integer) return std_logic_vector is
    begin
        return std_logic_vector(to_unsigned(val, width));
    end function;

    -- Test verification procedure
    procedure verify_shift(
        signal data       : out std_logic_vector(N-1 downto 0);
        signal log_arith  : out std_logic;
        signal left_right : out std_logic;
        signal shamt      : out std_logic_vector(4 downto 0);
        signal result     : in  std_logic_vector(N-1 downto 0);
        expected          :     std_logic_vector(N-1 downto 0);
        test_name         :     string
        ) is
    begin
        wait for PERIOD;
        assert (result = expected)
            report "Test " & test_name & " failed!" &
            " Expected: " & to_hstring(expected) &
            " Got: " & to_hstring(result)
            severity error;
    end procedure;

begin

    DUT : BarrelShifter
        generic map (
            N => N
            )
        port map (
            i_data             => s_data,
            i_logic_arithmetic => s_logic_arithmetic,
            i_left_right       => s_left_right,
            i_shamt            => s_shamt,
            o_Out              => s_Out
            );

    -- Test process
    test_proc : process
        variable test_data : std_logic_vector(N-1 downto 0);
        variable expected  : std_logic_vector(N-1 downto 0);
    begin
        -- Initialize signals
        s_data             <= (others => '0');
        s_logic_arithmetic <= '0';
        s_left_right       <= '0';
        s_shamt            <= (others => '0');
        wait for PERIOD;

        -- Test 1: Logical left shift by 1
        test_data          := x"0000_00FF";
        expected           := x"0000_01FE";
        s_data             <= test_data;
        s_logic_arithmetic <= '0';
        s_left_right       <= '0';
        s_shamt            <= "00001";
        verify_shift(s_data, s_logic_arithmetic, s_left_right, s_shamt, s_Out, expected, "Logical Left Shift 1");

        -- Test 2: Logical right shift by 1
        test_data          := x"8000_0000";
        expected           := x"4000_0000";
        s_data             <= test_data;
        s_logic_arithmetic <= '0';
        s_left_right       <= '1';
        s_shamt            <= "00001";
        verify_shift(s_data, s_logic_arithmetic, s_left_right, s_shamt, s_Out, expected, "Logical Right Shift 1");

        -- Test 3: Arithmetic right shift by 1 (positive number)
        test_data          := x"4000_0000";
        expected           := x"2000_0000";
        s_data             <= test_data;
        s_logic_arithmetic <= '1';
        s_left_right       <= '1';
        s_shamt            <= "00001";
        verify_shift(s_data, s_logic_arithmetic, s_left_right, s_shamt, s_Out, expected, "Arithmetic Right Shift 1 (Positive)");

        -- Test 4: Arithmetic right shift by 1 (negative number)
        test_data          := x"8000_0000";
        expected           := x"C000_0000";
        s_data             <= test_data;
        s_logic_arithmetic <= '1';
        s_left_right       <= '1';
        s_shamt            <= "00001";
        verify_shift(s_data, s_logic_arithmetic, s_left_right, s_shamt, s_Out, expected, "Arithmetic Right Shift 1 (Negative)");

        -- Test 5: Large shift left
        test_data          := x"0000_00FF";
        expected           := x"FF00_0000";
        s_data             <= test_data;
        s_logic_arithmetic <= '0';
        s_left_right       <= '0';
        s_shamt            <= "10000";  -- Shift by 16
        verify_shift(s_data, s_logic_arithmetic, s_left_right, s_shamt, s_Out, expected, "Large Left Shift");

        -- Test 6: Large arithmetic right shift (negative number)
        test_data          := x"8000_0000";
        expected           := x"FFFF_FFFF";
        s_data             <= test_data;
        s_logic_arithmetic <= '1';
        s_left_right       <= '1';
        s_shamt            <= "11111";  -- Shift by 31
        verify_shift(s_data, s_logic_arithmetic, s_left_right, s_shamt, s_Out, expected, "Large Arithmetic Right Shift");

        -- Test 7: Zero shift amount
        test_data          := x"1234_5678";
        expected           := x"1234_5678";
        s_data             <= test_data;
        s_logic_arithmetic <= '0';
        s_left_right       <= '0';
        s_shamt            <= "00000";
        verify_shift(s_data, s_logic_arithmetic, s_left_right, s_shamt, s_Out, expected, "Zero Shift");

        -- Report completion
        wait for PERIOD;
        report "Test completed" severity note;
        wait;
    end process;

end behavioral;

