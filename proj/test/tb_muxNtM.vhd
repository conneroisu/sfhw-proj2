library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Test Bench for mux_NtM
-- This test bench exhaustively tests all possible combinations of Data_in and Sel.

entity tb_mux_NtM is
end entity tb_mux_NtM;

architecture Behavioral of tb_mux_NtM is
    -- Component declaration
    component mux_NtM
        generic (
            N : integer := 2;
            M : integer := 2
        );
        port (
            Data_in : in  std_logic_vector((N*M)-1 downto 0);
            Sel     : in  integer range 0 to N - 1;
            Data_out: out std_logic_vector(M - 1 downto 0)
        );
    end component;

    -- Constants for test bench
    constant N_c : integer := 2;  -- Number of input buses
    constant M_c : integer := 2;  -- Width of each input bus

    -- Signal declarations
    signal Data_in  : std_logic_vector((N_c*M_c)-1 downto 0);
    signal Sel      : integer range 0 to N_c - 1;
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
    uut: mux_NtM
        generic map (
            N => N_c,
            M => M_c
        )
        port map (
            Data_in  => Data_in,
            Sel      => Sel,
            Data_out => Data_out
        );

    -- Stimulus process
    stim_proc: process
        variable Data_in_v    : std_logic_vector((N_c*M_c)-1 downto 0);
        variable Sel_v        : integer range 0 to N_c - 1;
        variable Expected_out : std_logic_vector(M_c - 1 downto 0);
    begin
        -- Generate all combinations of Data_in and Sel
        for Data_in_int in 0 to 2**(N_c*M_c)-1 loop
            Data_in_v := std_logic_vector(to_unsigned(Data_in_int, Data_in'length));
            Data_in <= Data_in_v;
            for Sel_v in 0 to N_c - 1 loop
                Sel <= Sel_v;
                wait for 10 ns;
                -- Compute expected output
                Expected_out := Data_in_v((Sel_v+1)*M_c -1 downto Sel_v*M_c);
                -- Check correctness
                assert Data_out = Expected_out
                report "Mismatch at Data_in=" & std_logic_vector_to_string(Data_in_v) & 
                       ", Sel=" & integer'image(Sel_v) &
                       ", Expected=" & std_logic_vector_to_string(Expected_out) &
                       ", Got=" & std_logic_vector_to_string(Data_out)
                severity error;
            end loop;
        end loop;
        wait;
    end process stim_proc;

end architecture Behavioral;
