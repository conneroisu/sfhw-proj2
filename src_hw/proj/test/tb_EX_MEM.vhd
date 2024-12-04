library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity EX_MEM_tb is
end entity;

architecture sim of EX_MEM_tb is

    -- Constants for the test
    constant N : integer := 32; -- Data width
    constant CLK_PERIOD : time := 10 ns;

    -- Signals for DUT inputs
    signal i_CLK        : std_logic := '0';
    signal i_RST        : std_logic := '0';
    signal i_WE         : std_logic := '1';
    signal i_PC         : std_logic_vector(N-1 downto 0) := (others => '0');
    signal i_ALUResult  : std_logic_vector(N-1 downto 0) := (others => '0');
    signal i_ReadData2  : std_logic_vector(N-1 downto 0) := (others => '0');
    signal i_RegDstAddr : std_logic_vector(4 downto 0) := (others => '0');
    signal i_Zero       : std_logic := '0';

    -- Control Signals
    signal i_MemRead    : std_logic := '0';
    signal i_MemWrite   : std_logic := '0';
    signal i_Branch     : std_logic := '0';
    signal i_MemtoReg   : std_logic := '0';
    signal i_RegWrite   : std_logic := '0';

    -- Signals for DUT outputs
    signal o_ALUResult  : std_logic_vector(N-1 downto 0);
    signal o_ReadData2  : std_logic_vector(N-1 downto 0);
    signal o_RegDstAddr : std_logic_vector(4 downto 0);
    signal o_MemtoReg   : std_logic;
    signal o_RegWrite   : std_logic;
    signal o_MemRead    : std_logic;
    signal o_MemWrite   : std_logic;
    signal o_BranchAddr : std_logic_vector(N-1 downto 0);
    signal o_BranchTaken: std_logic;
    signal o_DataOut    : std_logic_vector(N-1 downto 0);

    -- Component declaration for EX_MEM
    component EX_MEM is
        generic (N : integer := 32);
        port (
            -- Clock, Reset, and Write Enable
            i_CLK        : in  std_logic;
            i_RST        : in  std_logic;
            i_WE         : in  std_logic;

            -- Inputs from ID/EX Stage
            i_PC         : in  std_logic_vector(N-1 downto 0);
            i_ALUResult  : in  std_logic_vector(N-1 downto 0);
            i_ReadData2  : in  std_logic_vector(N-1 downto 0);
            i_RegDstAddr : in  std_logic_vector(4 downto 0);
            i_Zero       : in  std_logic;

            -- Control Signals
            i_MemRead    : in  std_logic;
            i_MemWrite   : in  std_logic;
            i_Branch     : in  std_logic;
            i_MemtoReg   : in  std_logic;
            i_RegWrite   : in  std_logic;

            -- Outputs to MEM/WB Stage
            o_ALUResult  : out std_logic_vector(N-1 downto 0);
            o_ReadData2  : out std_logic_vector(N-1 downto 0);
            o_RegDstAddr : out std_logic_vector(4 downto 0);
            o_MemtoReg   : out std_logic;
            o_RegWrite   : out std_logic;

            -- Outputs for Memory Stage
            o_MemRead    : out std_logic;
            o_MemWrite   : out std_logic;
            o_BranchAddr : out std_logic_vector(N-1 downto 0);
            o_BranchTaken: out std_logic;

            -- Data Memory Outputs
            o_DataOut    : out std_logic_vector(N-1 downto 0)
        );
    end component;

begin

    -- Clock generation
    clk_gen : process
    begin
        i_CLK <= '0';
        wait for CLK_PERIOD / 2;
        i_CLK <= '1';
        wait for CLK_PERIOD / 2;
    end process;

    -- DUT instance
    dut : EX_MEM
        generic map (N => 32)
        port map (
            i_CLK        => i_CLK,
            i_RST        => i_RST,
            i_WE         => i_WE,
            i_PC         => i_PC,
            i_ALUResult  => i_ALUResult,
            i_ReadData2  => i_ReadData2,
            i_RegDstAddr => i_RegDstAddr,
            i_Zero       => i_Zero,

            i_MemRead    => i_MemRead,
            i_MemWrite   => i_MemWrite,
            i_Branch     => i_Branch,
            i_MemtoReg   => i_MemtoReg,
            i_RegWrite   => i_RegWrite,

            o_ALUResult  => o_ALUResult,
            o_ReadData2  => o_ReadData2,
            o_RegDstAddr => o_RegDstAddr,
            o_MemtoReg   => o_MemtoReg,
            o_RegWrite   => o_RegWrite,
            o_MemRead    => o_MemRead,
            o_MemWrite   => o_MemWrite,
            o_BranchAddr => o_BranchAddr,
            o_BranchTaken=> o_BranchTaken,
            o_DataOut    => o_DataOut
        );

    -- Test process
    test_proc : process
    begin
        -- Reset
        i_RST <= '1';
        wait for CLK_PERIOD;
        i_RST <= '0';

        -- Test Case 1: ALU Result Pass-Through
        i_ALUResult <= x"12345678";
        wait for CLK_PERIOD;
        assert o_ALUResult = i_ALUResult
            report "Test Case 1 Failed: ALU result mismatch"
            severity error;

        -- Test Case 2: Memory Write and Read Back
        i_MemWrite <= '1';
        i_MemRead <= '0';
        i_ReadData2 <= x"87654321"; -- Data to write
        i_ALUResult <= x"00000010"; -- Memory address
        wait for CLK_PERIOD;

        i_MemWrite <= '0';
        i_MemRead <= '1';
        wait for CLK_PERIOD;

        assert o_DataOut = x"87654321"
            report "Test Case 2 Failed: Memory write and read mismatch"
            severity error;

        -- Test Case 3: Branch Taken
        i_Branch <= '1';
        i_Zero <= '1';
        i_PC <= x"00000008";
        i_ALUResult <= x"00000004";
        wait for CLK_PERIOD;

        assert o_BranchAddr = x"0000000C"
            report "Test Case 3 Failed: Branch address mismatch"
            severity error;

        assert o_BranchTaken = '1'
            report "Test Case 3 Failed: Branch taken mismatch"
            severity error;

        -- End simulation
        wait for CLK_PERIOD;
        assert false report "All Test Cases Passed!" severity note;
        wait;
    end process;

end architecture;

