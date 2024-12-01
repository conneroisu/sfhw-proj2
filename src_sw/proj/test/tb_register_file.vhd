-- <header>
-- Author(s): Conner Ohnesorge
-- Name: src_sw/proj/test/tb_regFile.vhd
-- Notes:
--      Conner Ohnesorge 2024-11-21T10:43:43-06:00 added-do-file-and-sh-file-for-forward-unit-test-and-added-regfile-test
-- </header>

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity tb_register_file is
    generic (
        gclk_hper : time := 50 ns
        );
end entity tb_register_file;

-- Testbench Architecture
architecture behavior of tb_register_file is

    function to_string (a : std_logic_vector) return string is
        variable b    : string (1 to a'length) := (others => NUL);
        variable stri : integer                := 1;
    begin
        for i in a'range loop
            b(stri) := std_logic'image(a((i)))(2);
            stri    := stri+1;
        end loop;
        return b;
    end function;
    -- Calculate Clock Period
    constant cclk_per : time := gclk_hper * 2;

    component register_file is
        port
            (
                clk   : in  std_logic;
                i_wA  : in  std_logic_vector(4 downto 0);
                i_wD  : in  std_logic_vector(31 downto 0);
                i_wC  : in  std_logic;
                i_r1  : in  std_logic_vector(4 downto 0);
                i_r2  : in  std_logic_vector(4 downto 0);
                reset : in  std_logic;
                o_d1  : out std_logic_vector(31 downto 0);
                o_d2  : out std_logic_vector(31 downto 0)
                );
    end component;

    -- Temporary Testbench Signals
    signal s_clk       : std_logic;
    signal s_reset     : std_logic;
    signal s_wc        : std_logic;
    signal s_wd        : std_logic_vector(31 downto 0);
    signal s_d1        : std_logic_vector(31 downto 0);
    signal s_d2        : std_logic_vector(31 downto 0);
    signal s_wa        : std_logic_vector(4 downto 0);
    signal s_r1        : std_logic_vector(4 downto 0);
    signal s_r2        : std_logic_vector(4 downto 0);
    signal expected_d1 : std_logic_vector(31 downto 0);
    signal expected_d2 : std_logic_vector(31 downto 0);

begin

    dut : component register_file
        port map
        (
            s_clk,
            s_wa,
            s_wd,
            s_wc,
            s_r1,
            s_r2,
            s_reset,
            s_d1,
            s_d2
            );

    p_clk : process is
    begin
        s_clk <= '0';
        wait for gclk_hper;
        s_clk <= '1';
        wait for gclk_hper;
    end process p_clk;

    -- Testbench Process
    p_tb : process is
    begin

        -- Reset the Register
        s_reset     <= '1';
        s_wc        <= '0';
        s_wa        <= "00000";
        s_r1        <= "00000";
        s_r2        <= "00000";
        s_wd        <= x"00000000";
        -- Expect d1 and d2 to both read the zero register (0x00000000)
        expected_d1 <= x"00000000";
        expected_d2 <= x"00000000";
        assert s_d1 = expected_d1 and s_d2 = expected_d2 report "Test 1 Failed" severity failure;
        report "Test 1 Passed" severity note;
        wait for cclk_per;

        s_reset     <= '0';
        s_wc        <= '1';
        s_wa        <= "00001";
        s_r1        <= "00001";
        s_r2        <= "00000";
        s_wd        <= x"00001d1E";
        -- Expect d1 to read $1 (0x0001d1E) and
        -- d2 to read the zero register (0x00000000)
        expected_d1 <= x"00001d1E";
        expected_d2 <= x"00000000";
        assert s_d1 = expected_d1 and s_d2 = expected_d2 report "Test 2 Failed" severity failure;
        report "Test 2 Passed" severity note;
        wait for cclk_per;

        s_wc        <= '1';
        s_wa        <= "00010";
        s_r1        <= "00001";
        s_r2        <= "00010";
        s_wd        <= x"000BA5ED";
        -- Expect d1 to read $1 (0x1d1E) and
        -- d2 to read $2 (0xBA5ED)
        expected_d1 <= x"00001d1E";
        expected_d2 <= x"000BA5ED";
        assert s_d1 = expected_d1 and s_d2 = expected_d2 report "Test 3 Failed" severity failure;
        report "Test 3 Passed" severity note;
        wait for cclk_per;

        s_wc        <= '0';
        s_wa        <= "00011";
        s_r1        <= "00001";
        s_r2        <= "00011";
        s_wd        <= x"00FAC000";
        -- Expect No Write to Occur
        -- d1 to read $1 (0x1d1E) and
        -- d2 to read register 3 (0x00000000) still null, no write
        expected_d1 <= x"00001d1E";
        expected_d2 <= x"00000000";
        assert s_d1 = expected_d1 and s_d2 = expected_d2 report "Test 4 Failed" severity failure;
        report "Test 4 Passed" severity note;
        wait for cclk_per;

        s_wc        <= '1';
        s_wa        <= "00100";
        s_r1        <= "00100";
        s_r2        <= "00010";
        s_wd        <= x"44444444";
        -- Expect d1 to read $4 (0x44444444) and
        -- d2 to read $2 should still be (0xBA5ED)
        expected_d1 <= x"00000000";
        expected_d2 <= x"000BA5ED";
        assert s_d1 = expected_d1 and s_d2 = expected_d2 report "Test 5 Failed" severity failure;
        wait for cclk_per;

        -- zero register should still be zero
        s_wc        <= '0';
        s_wa        <= "00000";
        s_r1        <= "00000";
        s_r2        <= "00000";
        s_wd        <= x"00000000";
        -- Expect d1 and d2 to both read the zero register (0x00000000)
        expected_d1 <= x"00000000";
        expected_d2 <= x"00000000";
        wait for cclk_per;
        assert s_d1 = expected_d1 and s_d2 = expected_d2 report "Test 6 Failed" severity failure;

        s_wc        <= '1';
        s_wa        <= "11111";         -- Write to register 31
        s_r1        <= "11111";         -- Read from register 31
        s_r2        <= "00000";         -- Read from zero register
        s_wd        <= x"FFFFFFFF";
        -- Expect d1 to read $31 (0xFFFFFFFF) and
        -- d2 to read the zero register (0x00000000)
        expected_d1 <= x"FFFFFFFF";
        expected_d2 <= x"00000000";
        assert s_d1 = expected_d1 and s_d2 = expected_d2 report "Test 7 Failed" severity failure;
        report "Test 7 Passed" severity note;
        wait for cclk_per;

        -- the zero register should still be zero
        s_wc        <= '0';
        s_wa        <= "00000";
        s_r1        <= "00000";
        s_r2        <= "00000";
        s_wd        <= x"00000000";
        -- Expect d1 and d2 to both read the zero register (0x00000000)
        expected_d1 <= x"00000000";
        expected_d2 <= x"00000000";
        assert s_d1 = expected_d1 and s_d2 = expected_d2 report "Test 8 Failed" severity failure;
        report "Test 8 Passed" severity note;
        wait for cclk_per;

        -- NOW test that the zero register is still zero under all conditions

        s_wc        <= '0';
        s_wa        <= "00000";
        s_r1        <= "00000";
        s_r2        <= "00000";
        s_wd        <= x"00000000";
        -- Expect d1 and d2 to both read the zero register (0x00000000)
        expected_d1 <= x"00000000";
        expected_d2 <= x"00000000";
        assert s_d1 = expected_d1 and s_d2 = expected_d2 report "Test 9 Failed" severity failure;
        report "Test 9 Passed" severity note;
        wait for cclk_per;

        s_wc        <= '1';
        s_wa        <= "00000";
        s_r1        <= "00000";
        s_r2        <= "00000";
        s_wd        <= x"00000000";
        -- Expect d1 and d2 to both read the zero register (0x00000000)
        expected_d1 <= x"00000000";
        expected_d2 <= x"00000000";
        assert s_d1 = expected_d1 and s_d2 = expected_d2 report "Test 10 Failed" severity failure;
        report "Test 10 Passed" severity note;
        wait for cclk_per;

        -- Test write to zero register and ensure it remains zero
        s_reset     <= '0';
        s_wc        <= '1';             -- Enable write
        s_wa        <= "00000";         -- Attempt to write to register 0
        s_r1        <= "00000";         -- Read from register 0
        s_r2        <= "00001";         -- Read from register 1 for comparison
        s_wd        <= x"DEADBEEF";  -- Data attempted to write to zero register
        -- Expected: zero register remains zero, register 1 unchanged
        expected_d1 <= x"00000000";     -- Zero register should still be 0
        expected_d2 <= x"00001d1E";     -- Previous value, assuming no change
        assert s_d1 = expected_d1 and s_d2 = expected_d2 report "Test 11 Failed" severity failure;
        report "Test 11 Passed" severity note;
        wait for cclk_per;

        s_wc        <= '0';             -- Ensure write is disabled
        s_wa        <= "00000";         -- Address not relevant
        s_r1        <= "00000";         -- Final check on zero register
        s_r2        <= "00001";      -- Check another register for comparison
        -- Expected: zero register should still be zero, regardless of operations performed
        expected_d1 <= x"00000000";     -- Confirm zero register is indeed zero
        expected_d2 <= x"00001d1E";  -- Assuming value for comparison, unchanged
        assert s_d1 = expected_d1 and s_d2 = expected_d2 report "Test 13 Failed" severity failure;
        report "Test 13 Passed" severity note;
        wait for cclk_per;

        s_wc        <= '1';             -- Enable write
        s_wa        <= "00001";         -- Write to register 1
        s_r1        <= "00000";         -- Read from zero register
        s_r2        <= "00001";         -- Read from register 1
        s_wd        <= x"12345678";     -- Write data to register 1
        -- Expected: zero register should still be zero, register 1 should be updated
        expected_d1 <= x"00000000";     -- Confirm zero register is still zero
        expected_d2 <= x"12345678";     -- Confirm register 1 has been updated
        assert s_d1 = expected_d1 and s_d2 = expected_d2 report "Test 14 Failed" severity failure;
        report "Test 14 Passed" severity note;
        wait for cclk_per;

        s_wc        <= '1';             -- Enable write
        s_wa        <= "00010";         -- Write to register 2
        s_r1        <= "00000";         -- Read from zero register
        s_r2        <= "00010";         -- Read from register 2
        s_wd        <= x"87654321";     -- Write data to register 2
        -- Expected: zero register should still be zero, register 2 should be updated
        expected_d1 <= x"00000000";     -- Confirm zero register is still zero
        expected_d2 <= x"87654321";     -- Confirm register 2 has been updated
        assert s_d1 = expected_d1 and s_d2 = expected_d2 report "Test 15 Failed" severity failure;
        report "Test 15 Passed" severity note;
        wait for cclk_per;

        s_wc        <= '1';             -- Enable write
        s_wa        <= "00011";         -- Write to register 3
        s_r1        <= "00000";         -- Read from zero register
        s_r2        <= "00011";         -- Read from register 3
        s_wd        <= x"00000000";     -- Write data to register 3
        -- Expected: zero register should still be zero, register 3 should be updated
        expected_d1 <= x"00000000";     -- Confirm zero register is still zero
        expected_d2 <= x"00000000";     -- Confirm register 3 has been updated
        assert s_d1 = expected_d1 and s_d2 = expected_d2 report "Test 16 Failed" severity failure;
        report "Test 16 Passed" severity note;
        wait for cclk_per;

        -- Test that the zero register remains zero after all operations
        s_wc        <= '0';             -- Disable write
        s_wa        <= "00000";         -- Read from zero register
        s_r1        <= "00000";         -- Read from zero register
        s_r2        <= "00000";         -- Read from register 1 for comparison
        -- Expected: zero register should still be zero, regardless of operations performed
        expected_d1 <= x"00000000";     -- Confirm zero register is still zero
        expected_d2 <= x"00000000";     -- Confirm zero register is still zero
        assert s_d1 = expected_d1 and s_d2 = expected_d2 report "Test 17 Failed" severity failure;
        report "Test 17 Passed" severity note;
        wait for cclk_per;


        s_wc        <= '1';             -- Enable write
        s_wa        <= "00100";         -- Write to register 4
        s_r1        <= "00000";         -- Read from zero register
        s_r2        <= "00100";         -- Read from register 4
        s_wd        <= x"FFFFFFFF";     -- Write data to register 4
        -- Expected: zero register should still be zero, register 4 should be updated
        expected_d1 <= x"00000000";     -- Confirm zero register is still zero
        expected_d2 <= x"FFFFFFFF";     -- Confirm register 4 has been updated
        assert s_d1 = expected_d1 and s_d2 = expected_d2 report "Test 17 Failed" severity failure;
        report "Test 17 Passed" severity note;
        wait for cclk_per;

        s_wc        <= '1';             -- Enable write
        s_wa        <= "11111";         -- Write to register 31
        s_r1        <= "00000";         -- Read from zero register
        s_r2        <= "11111";         -- Read from register 31
        s_wd        <= x"00000000";     -- Write data to register 31
        -- Expected: zero register should still be zero, register 31 should be updated
        expected_d1 <= x"00000000";     -- Confirm zero register is still zero
        expected_d2 <= x"00000000";     -- Confirm register 31 has been updated
        report "Test 18 Passed" severity note;
        assert s_d1 = expected_d1 and s_d2 = expected_d2 report "Test 18 Failed" severity failure;
        wait for cclk_per;

        -- Test that the zero register remains zero after all operations
        s_wc        <= '0';             -- Disable write
        s_wa        <= "00000";         -- Read from zero register
        s_r1        <= "00000";         -- Read from zero register
        s_r2        <= "00001";         -- Read from register 1 for comparison
        -- Expected: zero register should still be zero, regardless of operations performed
        expected_d1 <= x"00000000";     -- Confirm zero register is still zero
        expected_d2 <= x"00000000";     -- Confirm zero register is still zero
        assert s_d1 = expected_d1 and s_d2 = expected_d2 report "Test 19 Failed" severity failure;
        report "Test 19 Passed" severity note;
        wait for cclk_per;

        s_reset     <= '1';             -- Reset the register
        s_wc        <= '0';             -- Disable write
        s_wa        <= "00101";         -- Read from register 5
        s_r1        <= "00000";         -- Read from zero register
        s_r2        <= "00101";         -- Read from register 5 for comparison
        -- Expected: zero register should still be zero, regardless of operations performed
        expected_d1 <= x"00000000";     -- Confirm zero register is still zero
        expected_d2 <= x"00000000";     -- Confirm register 5 is unchanged
        assert s_d1 = expected_d1 and s_d2 = expected_d2 report "Test 25 Failed";
        report "Test 25 Passed" severity note;
        wait for cclk_per;

        -- write 55555555 to register 5
        s_wc        <= '1';             -- Enable write
        s_wa        <= "00101";         -- Write to register 5
        s_r1        <= "00000";         -- Read from zero register
        s_r2        <= "00101";         -- Read from register 5
        s_wd        <= x"55555555";     -- Write data to register 5
        -- Expected: zero register should still be zero, register 5 should be updated
        expected_d1 <= x"00000000";     -- Confirm zero register is still zero
        expected_d2 <= x"55555555";     -- Confirm register 5 has been updated
        assert s_d1 = expected_d1 and s_d2 = expected_d2 report "Test 26 Failed" severity failure;
        report "Test 26 Passed" severity note;
        wait for cclk_per;

        s_wc        <= '1';             -- tru writing to the zero register
        s_wa        <= "00000";         -- Write to zero register
        s_r1        <= "00000";         -- Read from zero register
        s_r2        <= "00101";         -- Read from register 5 for comparison
        s_wd        <= x"55555555";     -- Write data to zero register
        -- Expected: zero register should still be zero, register 5 should be unchanged
        expected_d1 <= x"00000000";     -- Confirm zero register is still zero
        assert s_d1 = expected_d1 report "Test 27 Failed" severity failure;
        report "Test 27 Passed" severity note;
        wait for cclk_per;

        s_wc        <= '0';             -- Disable write
        s_wa        <= "00000";         -- Read from zero register
        s_r1        <= "00000";         -- Read from zero register
        s_r2        <= "00101";         -- Read from register 5 for comparison
        -- Expected: zero register should still be zero, regardless of operations performed
        expected_d1 <= x"00000000";     -- Confirm zero register is still zero
        assert s_d1 = expected_d1 report "Test 28 Failed expected_d1: " & to_string(expected_d1) & " s_d1: " & to_string(s_d1) & " expected_d2: " & to_string(expected_d2) & " s_d2: " & to_string(s_d2) severity failure;
        report "Test 28 Passed" severity note;
        wait for cclk_per;


        -- Write to register 7
        s_wc        <= '1';             -- Enable write
        s_wa        <= "00111";         -- Write to register 7
        s_r1        <= "00000";         -- Read from zero register
        s_r2        <= "00111";         -- Read from register 7
        s_wd        <= x"12345678";     -- Write data to register 7
        -- Expected: zero register should still be zero, register 7 should be updated
        expected_d1 <= x"00000000";     -- Confirm zero register is still zero
        expected_d2 <= x"12345678";     -- Confirm register 7 has been updated
        wait for cclk_per;
        s_wc        <= '0';             -- Disable write
        s_wa        <= "00000";         -- Read from zero register
        s_r1        <= "00000";         -- Read from zero register
        s_r2        <= "00111";         -- Read from register 7 for comparison
        -- Expected: zero register should still be zero, regardless of operations performed
        expected_d1 <= x"00000000";     -- Confirm zero register is still zero
        expected_d2 <= x"12345678";     -- Confirm register 7 is unchanged
        assert s_d1 = expected_d1 and s_d2 = expected_d2 report "Test 30 Failed expected_d1: " & to_string(expected_d1) & " s_d1: " & to_string(s_d1) & " expected_d2: " & to_string(expected_d2) & " s_d2: " & to_string(s_d2) severity failure;
        report "Test 30 Passed" severity note;

        s_wc        <= '0';             -- Disable write
        s_wa        <= "00000";         -- Read from zero register
        s_r1        <= "00000";         -- Read from zero register
        s_r2        <= "00111";         -- Read from register 7 for comparison
        -- Expected: zero register should still be zero, regardless of operations performed
        expected_d1 <= x"00000000";     -- Confirm zero register is still zero
        expected_d2 <= x"00000000";     -- Confirm register 7 is unchanged
        assert s_d1 = expected_d1 and s_d2 = expected_d2 report "Test 31 Failed" severity failure;
        report "Test 31 Passed" severity note;
        wait for cclk_per;

        -- Write to register 8
        s_wc        <= '1';             -- Enable write
        s_wa        <= "01000";         -- Write to register 8
        s_r1        <= "00000";         -- Read from zero register
        s_r2        <= "01000";         -- Read from register 8
        s_wd        <= x"87654321";     -- Write data to register 8
        -- Expected: zero register should still be zero, register 8 should be updated
        expected_d1 <= x"00000000";     -- Confirm zero register is still zero
        expected_d2 <= x"87654321";     -- Confirm register 8 has been updated
        assert s_d1 = expected_d1 and s_d2 = expected_d2 report "Test 32 Failed" severity failure;
        report "Test 32 Passed" severity note;
        wait for cclk_per;

        -- write to register 0
        s_wc        <= '1';             -- Enable write
        s_wa        <= "00000";         -- Write to register 0
        s_r1        <= "00000";         -- Read from zero register
        s_r2        <= "00000";         -- Read from register 0
        s_wd        <= x"00000000";     -- Write data to register 0
        -- Expected: zero register should still be zero, register 0 should be updated
        expected_d1 <= x"00000000";     -- Confirm zero register is still zero
        expected_d2 <= x"00000000";     -- Confirm register 0 has been updated
        assert s_d1 = expected_d1 and s_d2 = expected_d2 report "Test 33 Failed" severity failure;
        report "Test 33 Passed" severity note;
        wait for cclk_per;

        s_wc        <= '0';             -- Enable write
        s_wa        <= "00000";
        s_r1        <= "00000";
        s_r2        <= "00000";
        s_wd        <= x"00000000";
        -- Expected: zero register should still be zero, regardless of operations performed
        expected_d1 <= x"00000000";     -- Confirm zero register is still zero
        expected_d2 <= x"00000000";     -- Confirm register 0 has been updated
        assert s_d1 = expected_d1 and s_d2 = expected_d2 report "Test 34 Failed" severity failure;
        report "Test 34 Passed" severity note;

        -- Write to register 9
        s_wc        <= '1';             -- Enable write
        s_wa        <= "01001";         -- Write to register 9
        s_r1        <= "00000";         -- Read from zero register
        s_r2        <= "01001";         -- Read from register 9
        s_wd        <= x"00000000";     -- Write data to register 9
        -- Expected: zero register should still be zero, register 9 should be updated
        expected_d1 <= x"00000000";     -- Confirm zero register is still zero
        expected_d2 <= x"00000000";     -- Confirm register 9 has been updated
        assert s_d1 = expected_d1 and s_d2 = expected_d2 report "Test 34 Failed" severity failure;
        report "Test 34 Passed" severity note;
        wait for cclk_per;

        -- Write to register 30
        s_wc        <= '1';             -- Enable write
        s_wa        <= "11110";         -- Write to register 30
        s_r1        <= "00000";         -- Read from zero register
        s_r2        <= "11110";         -- Read from register 30
        s_wd        <= x"00000000";     -- Write data to register 30
        -- Expected: zero register should still be zero, register 30 should be updated
        expected_d1 <= x"00000000";     -- Confirm zero register is still zero
        expected_d2 <= x"00000000";     -- Confirm register 30 has been updated
        assert s_d1 = expected_d1 and s_d2 = expected_d2 report "Test 35 Failed" severity failure;
        report "Test 35 Passed" severity note;
        wait for cclk_per;

        -- Write to register 30
        s_wc        <= '1';             -- Enable write
        s_wa        <= "11110";         -- Write to register 30
        s_r1        <= "00000";         -- Read from zero register
        s_r2        <= "11110";         -- Read from register 30
        s_wd        <= x"11111111";     -- Write data to register 30
        -- Expected: zero register should still be zero, register 30 should be updated
        expected_d1 <= x"00000000";     -- Confirm zero register is still zero
        expected_d2 <= x"11111111";     -- Confirm register 30 has been updated
        assert s_d1 = expected_d1 and s_d2 = expected_d2 report "Test 36 Failed" severity failure;
        report "Test 36 Passed" severity note;
        wait for cclk_per;

        -- Read from register zero
        s_wc        <= '0';             -- Disable write
        s_wa        <= "00000";         -- Read from zero register
        s_r1        <= "00000";         -- Read from zero register
        s_r2        <= "00000";         -- Read from zero register
        -- Expected: zero register should still be zero, regardless of operations performed
        expected_d1 <= x"00000000";     -- Confirm zero register is still zero
        expected_d2 <= x"00000000";     -- Confirm zero register is still zero
        assert s_d1 = expected_d1 and s_d2 = expected_d2 report "Test 37 Failed" severity failure;
        report "Test 37 Passed" severity note;
        wait for cclk_per;
        wait;

        wait for cclk_per;
    end process p_tb;

end architecture behavior;

