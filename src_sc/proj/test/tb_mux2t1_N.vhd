-- <header>
-- Author(s): conneroisu
-- Name: proj/test/tb_mux2t1_N.vhd
-- Notes:
--      conneroisu  <conneroisu@outlook.com> manually-ran-the-header-update-script
--      conneroisu  <conneroisu@outlook.com> even-better-file-header-program
--      conneroisu  <conneroisu@outlook.com> fixed-and-added-back-the-git-cdocumentor-for-the-vhdl-files-to-have
--      conneroisu  <conneroisu@outlook.com> add-lowlevel-components-and-testbenches
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;
-- Entity declaration of the testbench
entity tb_mux2t1_N is
end tb_mux2t1_N;
architecture behavioral of tb_mux2t1_N is
    -- Constants
    constant N : integer := 32;         -- Width of the data buses
    -- Component declaration of mux2t1_N
    component mux2t1_N is
        generic (
            N : integer := 32
            );
        port (
            i_S  : in  std_logic;       -- Select input
            i_D0 : in  std_logic_vector(N - 1 downto 0);  -- Data input 0
            i_D1 : in  std_logic_vector(N - 1 downto 0);  -- Data input 1
            o_O  : out std_logic_vector(N - 1 downto 0)   -- Output data
            );
    end component;
    -- Signals to connect to the mux2t1_N instance
    signal s_S  : std_logic                        := '0';
    signal s_D0 : std_logic_vector(N - 1 downto 0) := (others => '0');
    signal s_D1 : std_logic_vector(N - 1 downto 0) := (others => '0');
    signal s_O  : std_logic_vector(N - 1 downto 0);
begin
    -- Instantiate the mux2t1_N component
    uut : mux2t1_N
        generic map (
            N => N
            )
        port map (
            i_S  => s_S,
            i_D0 => s_D0,
            i_D1 => s_D1,
            o_O  => s_O
            );
    -- Stimulus process
    stim_proc : process
    begin
        -- Test Case 1: Select input '0', both inputs zero
        s_S  <= '0';
        s_D0 <= (others       => '0');
        s_D1 <= (others       => '0');
        wait for 10 ns;
        assert s_O = s_D0 report "Test Case 1 Failed: s_O /= s_D0 when s_S = '0'" severity error;
        -- Test Case 2: Select input '1', both inputs zero
        s_S  <= '1';
        wait for 10 ns;
        assert s_O = s_D1 report "Test Case 2 Failed: s_O /= s_D1 when s_S = '1'" severity error;
        -- Test Case 3: Select input '0', D0 all ones, D1 all zeros
        s_S  <= '0';
        s_D0 <= (others       => '1');
        s_D1 <= (others       => '0');
        wait for 10 ns;
        assert s_O = s_D0 report "Test Case 3 Failed: s_O /= s_D0 when s_S = '0'" severity error;
        -- Test Case 4: Select input '1', D0 all zeros, D1 all ones
        s_S  <= '1';
        s_D0 <= (others       => '0');
        s_D1 <= (others       => '1');
        wait for 10 ns;
        assert s_O = s_D1 report "Test Case 4 Failed: s_O /= s_D1 when s_S = '1'" severity error;
        -- Test Case 5: Select input '0', D0 alternating bits, D1 all ones
        s_S  <= '0';
        s_D0 <= (N-1 downto 0 => '0');
        for i in 0 to N-1 loop
            if i mod 2 = 0 then
                s_D0(i) <= '1';
            end if;
        end loop;
        s_D1 <= (others       => '1');
        wait for 10 ns;
        assert s_O = s_D0 report "Test Case 5 Failed: s_O /= s_D0 when s_S = '0'" severity error;
        -- Test Case 6: Select input '1', D0 all zeros, D1 alternating bits
        s_S  <= '1';
        s_D0 <= (others       => '0');
        s_D1 <= (N-1 downto 0 => '0');
        for i in 0 to N-1 loop
            if i mod 2 = 1 then
                s_D1(i) <= '1';
            end if;
        end loop;
        wait for 10 ns;
        assert s_O = s_D1 report "Test Case 6 Failed: s_O /= s_D1 when s_S = '1'" severity error;
        -- Test Case 7: Random data inputs, select '0'
        s_S  <= '0';
        s_D0 <= x"12345678";
        s_D1 <= x"87654321";
        wait for 10 ns;
        assert s_O = s_D0 report "Test Case 7 Failed: s_O /= s_D0 when s_S = '0'" severity error;
        -- Test Case 8: Random data inputs, select '1'
        s_S  <= '1';
        wait for 10 ns;
        assert s_O = s_D1 report "Test Case 8 Failed: s_O /= s_D1 when s_S = '1'" severity error;
        -- Test Case 9: Change select signal dynamically
        s_S  <= '0';
        s_D0 <= x"FFFFFFFF";
        s_D1 <= x"00000000";
        wait for 10 ns;
        assert s_O = s_D0 report "Test Case 9 Failed at s_S='0'" severity error;
        s_S  <= '1';
        wait for 10 ns;
        assert s_O = s_D1 report "Test Case 9 Failed at s_S='1'" severity error;
        -- Test Case 10: Change inputs while select is constant
        s_S  <= '0';
        s_D0 <= x"AAAAAAAA";
        s_D1 <= x"55555555";
        wait for 10 ns;
        assert s_O = s_D0 report "Test Case 10 Failed at initial input" severity error;
        s_D0 <= x"FFFFFFFF";
        wait for 10 ns;
        assert s_O = s_D0 report "Test Case 10 Failed after changing s_D0" severity error;
        -- Test Case 11: Stress test with all possible select and data combinations (limited by practicality)
        -- Here, we simulate a few random combinations to represent this test
        s_S  <= '1';
        s_D0 <= x"0F0F0F0F";
        s_D1 <= x"F0F0F0F0";
        wait for 10 ns;
        assert s_O = s_D1 report "Test Case 11 Failed at s_S='1'" severity error;
        s_S  <= '0';
        wait for 10 ns;
        assert s_O = s_D0 report "Test Case 11 Failed at s_S='0'" severity error;
        -- End of test
        report "All test cases passed successfully." severity note;
        wait;
    end process stim_proc;
end behavioral;
