library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity TB_EX_MEM is
end TB_EX_MEM;

architecture Behavioral of TB_EX_MEM is
    component EX_MEM
        Port (
            clk           : in  STD_LOGIC;
            reset         : in  STD_LOGIC;
            WriteEn       : in  STD_LOGIC;
            ALU_result_in : in  STD_LOGIC_VECTOR(31 downto 0);
            Read_data2_in : in  STD_LOGIC_VECTOR(31 downto 0);
            RegDst_in     : in  STD_LOGIC_VECTOR(4 downto 0);
            MemRead_in    : in  STD_LOGIC;
            MemWrite_in   : in  STD_LOGIC;
            RegWrite_in   : in  STD_LOGIC;
            MemToReg_in   : in  STD_LOGIC;
            ALU_result_out : out STD_LOGIC_VECTOR(31 downto 0);
            Read_data2_out : out STD_LOGIC_VECTOR(31 downto 0);
            RegDst_out     : out STD_LOGIC_VECTOR(4 downto 0);
            MemRead_out    : out STD_LOGIC;
            MemWrite_out   : out STD_LOGIC;
            RegWrite_out   : out STD_LOGIC;
            MemToReg_out   : out STD_LOGIC
        );
    end component;

    signal clk           : STD_LOGIC := '0';
    signal reset         : STD_LOGIC := '0';
    signal WriteEn       : STD_LOGIC := '0';
    signal ALU_result_in : STD_LOGIC_VECTOR(31 downto 0);
    signal Read_data2_in : STD_LOGIC_VECTOR(31 downto 0);
    signal RegDst_in     : STD_LOGIC_VECTOR(4 downto 0);
    signal MemRead_in    : STD_LOGIC;
    signal MemWrite_in   : STD_LOGIC;
    signal RegWrite_in   : STD_LOGIC;
    signal MemToReg_in   : STD_LOGIC;
    signal ALU_result_out : STD_LOGIC_VECTOR(31 downto 0);
    signal Read_data2_out : STD_LOGIC_VECTOR(31 downto 0);
    signal RegDst_out     : STD_LOGIC_VECTOR(4 downto 0);
    signal MemRead_out    : STD_LOGIC;
    signal MemWrite_out   : STD_LOGIC;
    signal RegWrite_out   : STD_LOGIC;
    signal MemToReg_out   : STD_LOGIC;

    constant clk_period : time := 50 ns;

begin
    -- Instantiate the EX_MEM pipeline register
    uut: EX_MEM Port map (
        clk           => clk,
        reset         => reset,
        WriteEn       => WriteEn,
        ALU_result_in => ALU_result_in,
        Read_data2_in => Read_data2_in,
        RegDst_in     => RegDst_in,
        MemRead_in    => MemRead_in,
        MemWrite_in   => MemWrite_in,
        RegWrite_in   => RegWrite_in,
        MemToReg_in   => MemToReg_in,
        ALU_result_out => ALU_result_out,
        Read_data2_out => Read_data2_out,
        RegDst_out     => RegDst_out,
        MemRead_out    => MemRead_out,
        MemWrite_out   => MemWrite_out,
        RegWrite_out   => RegWrite_out,
        MemToReg_out   => MemToReg_out
    );

    -- Clock generation process
    clk_process :process
    begin
        clk <= '0';
        wait for clk_period / 2;
        clk <= '1';
        wait for clk_period / 2;
    end process;

    -- Test process with intermediate assertions
    stim_proc: process
    begin
        -- Initialize and assert reset behavior
        reset <= '1';
        wait for clk_period;
        reset <= '0';
        wait for clk_period;

        -- Apply first set of values with WriteEn enabled
        WriteEn <= '1';
        ALU_result_in <= X"00000010";
        Read_data2_in <= X"00000020";
        RegDst_in <= "00001";
        MemRead_in <= '1';
        MemWrite_in <= '0';
        RegWrite_in <= '1';
        MemToReg_in <= '1';
        wait for clk_period;

        -- Assert that the outputs match the expected first set of values
        assert ALU_result_out = X"00000010" report "ALU_result_out mismatch on first test" severity error;
        assert Read_data2_out = X"00000020" report "Read_data2_out mismatch on first test" severity error;
        assert RegDst_out = "00001" report "RegDst_out mismatch on first test" severity error;
        assert MemRead_out = '1' report "MemRead_out mismatch on first test" severity error;
        assert MemWrite_out = '0' report "MemWrite_out mismatch on first test" severity error;
        assert RegWrite_out = '1' report "RegWrite_out mismatch on first test" severity error;
        assert MemToReg_out = '1' report "MemToReg_out mismatch on first test" severity error;

        -- Disable WriteEn and change inputs to verify no change in outputs
        WriteEn <= '0';
        ALU_result_in <= X"00000030";
        Read_data2_in <= X"00000040";
        RegDst_in <= "00010";
        MemRead_in <= '0';
        MemWrite_in <= '1';
        RegWrite_in <= '0';
        MemToReg_in <= '0';
        wait for clk_period;

        -- Assert that outputs remain unchanged with WriteEn disabled
        assert ALU_result_out = X"00000010" report "ALU_result_out changed unexpectedly when WriteEn is disabled" severity error;
        assert Read_data2_out = X"00000020" report "Read_data2_out changed unexpectedly when WriteEn is disabled" severity error;
        assert RegDst_out = "00001" report "RegDst_out changed unexpectedly when WriteEn is disabled" severity error;
        assert MemRead_out = '1' report "MemRead_out changed unexpectedly when WriteEn is disabled" severity error;
        assert MemWrite_out = '0' report "MemWrite_out changed unexpectedly when WriteEn is disabled" severity error;
        assert RegWrite_out = '1' report "RegWrite_out changed unexpectedly when WriteEn is disabled" severity error;
        assert MemToReg_out = '1' report "MemToReg_out changed unexpectedly when WriteEn is disabled" severity error;

        -- Re-enable WriteEn and apply a second set of values
        WriteEn <= '1';
        ALU_result_in <= X"00000050";
        Read_data2_in <= X"00000060";
        RegDst_in <= "00011";
        MemRead_in <= '1';
        MemWrite_in <= '0';
        RegWrite_in <= '1';
        MemToReg_in <= '1';
        wait for clk_period;

        -- Assert that the outputs match the second set of values after WriteEn is re-enabled
        assert ALU_result_out = X"00000050" report "ALU_result_out mismatch on second test after WriteEn re-enabled" severity error;
        assert Read_data2_out = X"00000060" report "Read_data2_out mismatch on second test after WriteEn re-enabled" severity error;
        assert RegDst_out = "00011" report "RegDst_out mismatch on second test after WriteEn re-enabled" severity error;
        assert MemRead_out = '1' report "MemRead_out mismatch on second test after WriteEn re-enabled" severity error;
        assert MemWrite_out = '0' report "MemWrite_out mismatch on second test after WriteEn re-enabled" severity error;
        assert RegWrite_out = '1' report "RegWrite_out mismatch on second test after WriteEn re-enabled" severity error;
        assert MemToReg_out = '1' report "MemToReg_out mismatch on second test after WriteEn re-enabled" severity error;

        -- Finish simulation
        wait;
    end process;

end Behavioral;
