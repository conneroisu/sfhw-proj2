library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity EX_MEM_tb is
end entity;

architecture sim of EX_MEM_tb is

    -- Constants for the testbench
    constant N : integer := 32;

    -- Signals for inputs to the DUT
    signal i_CLK        : std_logic := '0';
    signal i_RST        : std_logic := '0';
    signal i_WE         : std_logic := '1'; -- Write enable

    signal i_PC         : std_logic_vector(N-1 downto 0) := (others => '0');
    signal i_ALUResult  : std_logic_vector(N-1 downto 0) := (others => '0');
    signal i_ReadData2  : std_logic_vector(N-1 downto 0) := (others => '0');
    signal i_RegDstAddr : std_logic_vector(4 downto 0) := (others => '0');
    signal i_Zero       : std_logic := '0';

    signal i_MemRead    : std_logic := '0';
    signal i_MemWrite   : std_logic := '0';
    signal i_Branch     : std_logic := '0';
    signal i_MemtoReg   : std_logic := '0';
    signal i_RegWrite   : std_logic := '0';

    -- Signals for outputs from the DUT
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

    -- Clock period constant
    constant CLK_PERIOD : time := 10 ns;

    -- DUT instantiation
    component EX_MEM is
        generic (N : integer := 32);
        port (
            -- Inputs
            i_CLK        : in  std_logic;
            i_RST        : in  std_logic;
            i_WE         : in  std_logic;
            i_PC         : in  std_logic_vector(N-1 downto 0);
            i_ALUResult  : in  std_logic_vector(N-1 downto 0);
            i_ReadData2  : in  std_logic_vector(N-1 downto 0);
            i_RegDstAddr : in  std_logic_vector(4 downto 0);
            i_Zero       : in  std_logic;

            i_MemRead    : in  std_logic;
            i_MemWrite   : in  std_logic;
            i_Branch     : in  std_logic;
            i_MemtoReg   : in  std_logic;
            i_RegWrite   : in  std_logic;

            -- Outputs
            o_ALUResult  : out std_logic_vector(N-1 downto 0);
            o_ReadData2  : out std_logic_vector(N-1 downto 0);
            o_RegDstAddr : out std_logic_vector(4 downto 0);
            o_MemtoReg   : out std_logic;
            o_RegWrite   : out std_logic;
            o_MemRead    : out std_logic;
            o_MemWrite   : out std_logic;
            o_BranchAddr : out std_logic_vector(N-1 downto 0);
            o_BranchTaken: out std_logic;
            o_DataOut    : out std_logic_vector(N-1 downto 0)
        );
    end component;

begin

    -- Clock generation
    clk_process : process
    begin
        i_CLK <= '0';
        wait for CLK_PERIOD / 2;
        i_CLK <= '1';
        wait for CLK_PERIOD / 2;
    end process;

    -- DUT instantiation
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
    test_process : process
    begin
        -- Reset the DUT
        i_RST <= '1';
        wait for CLK_PERIOD;
        i_RST <= '0';

        -- Test Case 1: Simple ALU result propagation
        i_PC <= x"00000004";
        i_ALUResult <= x"0000000A";
        i_ReadData2 <= x"00000005";
        i_RegDstAddr <= "10101";
        i_MemRead <= '0';
        i_MemWrite <= '0';
        i_Branch <= '0';
        i_Zero <= '0';
        wait for CLK_PERIOD;

        assert o_ALUResult = x"0000000A"
            report "Test Case 1 Failed: ALUResult mismatch" severity error;
        assert o_RegDstAddr = "10101"
            report "Test Case 1 Failed: RegDstAddr mismatch" severity error;

        -- Test Case 2: Branch Taken
        i_Branch <= '1';
        i_Zero <= '1';
        wait for CLK_PERIOD;

        assert o_BranchTaken = '1'
            report "Test Case 2 Failed: BranchTaken mismatch" severity error;
        assert o_BranchAddr = std_logic_vector(unsigned(i_PC) + unsigned(i_ALUResult))
            report "Test Case 2 Failed: BranchAddr mismatch" severity error;

        -- Test Case 3: Memory Read
        i_MemRead <= '1';
        wait for CLK_PERIOD;

        assert o_MemRead = '1'
            report "Test Case 3 Failed: MemRead mismatch" severity error;

        -- Test Case 4: Memory Write
        i_MemWrite <= '1';
        wait for CLK_PERIOD;

        assert o_MemWrite = '1'
            report "Test Case 4 Failed: MemWrite mismatch" severity error;

        -- Test Case 5: Data Memory Operations
        i_ALUResult <= x"00001000"; -- Address
        i_ReadData2 <= x"12345678"; -- Data to write
        i_MemWrite <= '1';
        wait for CLK_PERIOD;
        i_MemWrite <= '0';
        i_MemRead <= '1';
        wait for CLK_PERIOD;

        assert o_DataOut = x"12345678"
            report "Test Case 5 Failed: DataOut mismatch" severity error;

        -- Test Case 6: Reset Behavior
        i_RST <= '1';
        wait for CLK_PERIOD;

        assert o_ALUResult = (o_ALUResult'range => '0')
            report "Test Case 6 Failed: ALUResult not reset" severity error;

        i_RST <= '0';

        -- End of simulation
        wait for CLK_PERIOD;
        assert false report "All Test Cases Passed!" severity note;
        wait;
    end process;

end architecture;

