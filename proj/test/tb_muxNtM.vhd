library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Test Bench for N_to_M_Mux with std_logic_vector Sel
-- This test bench exhaustively tests all possible combinations of Data_in and Sel.

entity N_to_M_Mux_tb is
end entity N_to_M_Mux_tb;

architecture Behavioral of N_to_M_Mux_tb is
    -- Component declaration
    component N_to_M_Mux
        generic (
            N         : integer := 2;
            M         : integer := 2;
            Sel_width : integer := 1
        );
        port (
            Data_in  : in  std_logic_vector((N*M)-1 downto 0);
            Sel      : in  std_logic_vector(Sel_width - 1 downto 0);
            Data_out : out std_logic_vector(M - 1 downto 0)
        );
    end component;

    -- Constants for test bench
    constant N_c : integer := 2;  -- Number of input buses
    constant M_c : integer := 2;  -- Width of each input bus

    -- Function to compute Sel_width
    function get_sel_width(N : integer) return integer is
        variable width : integer := 0;
        variable tempN : integer := N - 1;
    begin
        while tempN > 0 loop
            tempN := tempN / 2;
            width := width + 1;
        end loop;
        return width;
    end function;

    -- Constants
    constant Sel_width_c : integer := get_sel_width(N_c);

    -- Signal declarations
    signal Data_in  : std_logic_vector((N_c*M_c)-1 downto 0);
    signal Sel      : std_logic_vector(Sel_width_c - 1 downto 0);
    signal Data_out : std_logic_vector(M_c - 1 downto 0);

    -- Helper function to convert std_logic_vector to string
    function std_logic_vector_to_string(slv : std_logic_vector) return string is
        variable result : string(1 to slv'length);
        variable idx    : integer := 1;
    begin
        for i in slv'range loop
            result(idx) := std_ulogic'IMAGE(slv(i))(2);
            idx := idx + 1;
        end loop;
        return result;
    end function;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: N_to_M_Mux
        generic map (
            N         => N_c,
            M         => M_c,
            Sel_width => Sel_width_c
        )
        port map (
            Data_in  => Data_in,
            Sel      => Sel,
            Data_out => Data_out
        );

    -- Stimulus process
    stim_proc: process
        variable Data_in_v    : std_logic_vector((N_c*M_c)-1 downto 0);
        variable Sel_v        : std_logic_vector(Sel_width_c - 1 downto 0);
        variable Sel_int      : integer range 0 to 2**Sel_width_c - 1;
        variable Expected_out : std_logic_vector(M_c - 1 downto 0);
    begin
        -- Generate all combinations of Data_in
        for Data_in_int in 0 to 2**(N_c*M_c)-1 loop
            Data_in_v := std_logic_vector(to_unsigned(Data_in_int, Data_in'length));
            Data_in <= Data_in_v;
            -- Generate all possible Sel values
            for Sel_int in 0 to 2**Sel_width_c - 1 loop
                Sel_v := std_logic_vector(to_unsigned(Sel_int, Sel_width_c));
                Sel <= Sel_v;
                wait for 10 ns;
                if Sel_int < N_c then
                    -- Compute expected output
                    Expected_out := Data_in_v((Sel_int+1)*M_c -1 downto Sel_int*M_c);
                else
                    -- For out-of-range Sel, expect Data_out to be zeros
                    Expected_out := (others => '0');
                end if;
                -- Check correctness
                assert Data_out = Expected_out
                report "Mismatch at Data_in=" & std_logic_vector_to_string(Data_in_v) &
                       ", Sel=" & std_logic_vector_to_string(Sel_v) &
                       " (" & integer'image(Sel_int) & ")" &
                       ", Expected=" & std_logic_vector_to_string(Expected_out) &
                       ", Got=" & std_logic_vector_to_string(Data_out)
                severity error;
            end loop;
        end loop;
        wait;
    end proc
