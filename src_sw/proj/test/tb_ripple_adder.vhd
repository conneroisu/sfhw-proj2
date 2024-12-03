-- <header>
-- Author(s): Conner Ohnesorge
-- Name: 
-- Notes:
--      Conner Ohnesorge 2024-12-01T12:05:06-06:00 fix-ripple-adder-and-add-tests
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ripple_adder_tb is
end ripple_adder_tb;

architecture behavioral of ripple_adder_tb is
    constant N : integer := 32;

    signal i_A    : std_logic_vector(N-1 downto 0);
    signal i_B    : std_logic_vector(N-1 downto 0);
    signal i_Cin  : std_logic;
    signal o_Sum  : std_logic_vector(N-1 downto 0);
    signal o_Cout : std_logic;

begin

    uut : entity work.ripple_adder
        generic map (N => N)
        port map (
            i_A    => i_A,
            i_B    => i_B,
            i_Cin  => i_Cin,
            o_Sum  => o_Sum,
            o_Cout => o_Cout
            );

    stimulus_proc : process
        variable A_unsigned, B_unsigned : unsigned(N-1 downto 0);
        variable Sum_full               : unsigned(N downto 0);  -- For carry out
        variable Expected_Sum           : std_logic_vector(N-1 downto 0);
        variable Expected_Cout          : std_logic;
    begin
        -- Initialize inputs
        i_A   <= (others => '0');
        i_B   <= (others => '0');
        i_Cin <= '0';
        wait for 10 ns;

        -- Test Case 1: 0 + 0
        A_unsigned := to_unsigned(0, N);
        B_unsigned := to_unsigned(0, N);
        i_A        <= std_logic_vector(A_unsigned);
        i_B        <= std_logic_vector(B_unsigned);
        i_Cin      <= '0';
        wait for 10 ns;

        -- Check result
        Sum_full      := ('0' & A_unsigned) + ('0' & B_unsigned) + to_unsigned(0, N+1);
        Expected_Sum  := std_logic_vector(Sum_full(N-1 downto 0));
        Expected_Cout := Sum_full(N);
        assert o_Sum = Expected_Sum report "Test Case 1 Failed: Sum mismatch" severity error;
        assert o_Cout = Expected_Cout report "Test Case 1 Failed: Cout mismatch" severity error;

        -- Test Case 2: Max + 0
        A_unsigned := to_unsigned(2**N - 1, N);
        B_unsigned := to_unsigned(0, N);
        i_A        <= std_logic_vector(A_unsigned);
        i_B        <= std_logic_vector(B_unsigned);
        i_Cin      <= '0';
        wait for 10 ns;

        Sum_full      := ('0' & A_unsigned) + ('0' & B_unsigned) + to_unsigned(0, N+1);
        Expected_Sum  := std_logic_vector(Sum_full(N-1 downto 0));
        Expected_Cout := Sum_full(N);
        assert o_Sum = Expected_Sum report "Test Case 2 Failed: Sum mismatch" severity error;
        assert o_Cout = Expected_Cout report "Test Case 2 Failed: Cout mismatch" severity error;

        -- Test Case 3: Max + 1
        A_unsigned := to_unsigned(2**N - 1, N);
        B_unsigned := to_unsigned(1, N);
        i_A        <= std_logic_vector(A_unsigned);
        i_B        <= std_logic_vector(B_unsigned);
        i_Cin      <= '0';
        wait for 10 ns;

        Sum_full      := ('0' & A_unsigned) + ('0' & B_unsigned) + to_unsigned(0, N+1);
        Expected_Sum  := std_logic_vector(Sum_full(N-1 downto 0));
        Expected_Cout := Sum_full(N);
        assert o_Sum = Expected_Sum report "Test Case 3 Failed: Sum mismatch" severity error;
        assert o_Cout = Expected_Cout report "Test Case 3 Failed: Cout mismatch" severity error;

        -- Test Case 4: Random Values
        for i in 1 to 10 loop
            -- Generate deterministic pseudo-random numbers
            A_unsigned := to_unsigned((i * 123456789) mod (2**N), N);
            B_unsigned := to_unsigned((i * 987654321) mod (2**N), N);
            i_A        <= std_logic_vector(A_unsigned);
            i_B        <= std_logic_vector(B_unsigned);
            i_Cin      <= '0';
            wait for 10 ns;

            Sum_full      := ('0' & A_unsigned) + ('0' & B_unsigned) + to_unsigned(0, N+1);
            Expected_Sum  := std_logic_vector(Sum_full(N-1 downto 0));
            Expected_Cout := Sum_full(N);

            assert o_Sum = Expected_Sum report "Test Case 4." & integer'image(i) & " Failed: Sum mismatch" severity error;
            assert o_Cout = Expected_Cout report "Test Case 4." & integer'image(i) & " Failed: Cout mismatch" severity error;
        end loop;

        -- Test Case 5: Carry-In Handling
        A_unsigned := to_unsigned(0, N);
        B_unsigned := to_unsigned(0, N);
        i_A        <= std_logic_vector(A_unsigned);
        i_B        <= std_logic_vector(B_unsigned);
        i_Cin      <= '1';
        wait for 10 ns;

        Sum_full      := ('0' & A_unsigned) + ('0' & B_unsigned) + to_unsigned(1, N+1);
        Expected_Sum  := std_logic_vector(Sum_full(N-1 downto 0));
        Expected_Cout := Sum_full(N);
        assert o_Sum = Expected_Sum report "Test Case 5 Failed: Sum mismatch" severity error;
        assert o_Cout = Expected_Cout report "Test Case 5 Failed: Cout mismatch" severity error;

        -- Additional test cases can be added here

        -- End simulation
        wait;
    end process;

end behavioral;

