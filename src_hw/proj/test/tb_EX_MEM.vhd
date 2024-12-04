-- <header>
-- Author(s): aidanfoss
-- Name: 
-- Notes:
--      aidanfoss 2024-12-02T18:27:10-06:00 fixing-daniels-TB
--      aidanfoss 2024-12-02T18:15:45-06:00 renaming-tb-to-fix-error
-- </header>

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity tb_EX_MEM is
end entity;

architecture sim of tb_EX_MEM is

    -- Constants for data width
    constant N : integer := 32;

    -- Testbench signals
    signal tb_CLK        : std_logic                      := '0';
    signal tb_RST        : std_logic                      := '0';
    signal tb_WE         : std_logic                      := '0';
    signal tb_PC         : std_logic_vector(N-1 downto 0) := (others => '0');
    signal tb_ALUResult  : std_logic_vector(N-1 downto 0) := (others => '0');
    signal tb_ReadData2  : std_logic_vector(N-1 downto 0) := (others => '0');
    signal tb_RegDstAddr : std_logic_vector(4 downto 0)   := (others => '0');
    signal tb_Zero       : std_logic                      := '0';

    signal tb_MemRead  : std_logic := '0';
    signal tb_MemWrite : std_logic := '0';
    signal tb_Branch   : std_logic := '0';
    signal tb_MemtoReg : std_logic := '0';
    signal tb_RegWrite : std_logic := '0';

    -- Outputs
    signal tb_o_ALUResult   : std_logic_vector(N-1 downto 0);
    signal tb_o_ReadData2   : std_logic_vector(N-1 downto 0);
    signal tb_o_RegDstAddr  : std_logic_vector(4 downto 0);
    signal tb_o_MemtoReg    : std_logic;
    signal tb_o_RegWrite    : std_logic;
    signal tb_o_MemRead     : std_logic;
    signal tb_o_MemWrite    : std_logic;
    signal tb_o_BranchAddr  : std_logic_vector(N-1 downto 0);
    signal tb_o_BranchTaken : std_logic;

    -- Clock generation process
    constant CLK_PERIOD : time := 10 ns;

begin
    -- Instantiate EX_MEM
    uut : entity work.EX_MEM
        port map (
            i_CLK         => tb_CLK,
            i_RST         => tb_RST,
            i_WE          => tb_WE,
            i_PC          => tb_PC,
            i_ALUResult   => tb_ALUResult,
            i_ReadData2   => tb_ReadData2,
            i_RegDstAddr  => tb_RegDstAddr,
            i_Zero        => tb_Zero,
            i_MemRead     => tb_MemRead,
            i_MemWrite    => tb_MemWrite,
            i_Branch      => tb_Branch,
            i_MemtoReg    => tb_MemtoReg,
            i_RegWrite    => tb_RegWrite,
            o_ALUResult   => tb_o_ALUResult,
            o_ReadData2   => tb_o_ReadData2,
            o_RegDstAddr  => tb_o_RegDstAddr,
            o_MemtoReg    => tb_o_MemtoReg,
            o_RegWrite    => tb_o_RegWrite,
            o_MemRead     => tb_o_MemRead,
            o_MemWrite    => tb_o_MemWrite,
            o_BranchAddr  => tb_o_BranchAddr,
            o_BranchTaken => tb_o_BranchTaken
            );

    -- Clock generation
    clk_gen : process
    begin
        tb_CLK <= '0';
        wait for CLK_PERIOD / 2;
        tb_CLK <= '1';
        wait for CLK_PERIOD / 2;
    end process;

    -- Stimulus process
    stimulus : process
    begin
        -- Test Case 1: Basic operation
        tb_RST <= '1';                  -- Apply reset
        tb_WE  <= '0';
        wait for CLK_PERIOD;

        tb_RST <= '0';                  -- Deassert reset
        tb_WE  <= '1';                  -- Enable writing

        -- Set inputs
        tb_PC         <= x"00000004";
        tb_ALUResult  <= x"00000010";
        tb_ReadData2  <= x"00000020";
        tb_RegDstAddr <= "00011";
        tb_Zero       <= '1';
        tb_MemRead    <= '1';
        tb_MemWrite   <= '0';
        tb_Branch     <= '1';
        tb_MemtoReg   <= '1';
        tb_RegWrite   <= '1';

        wait for CLK_PERIOD;            -- Wait for clock edge

        --assert Inputs, establish at least those work
        assert tb_PC = x"00000004"
            report "Test Case 1 Failed: Incorrect Inputs"
            severity error;

        assert tb_PC = x"00000005"
            report "Test Case 1 Passed: Correct Inputs (probably)---------------------------------------------"
            severity note;

        -- Assert outputs
        assert tb_o_ALUResult = x"00000010"
            report "Test Case 1 Failed: Incorrect ALU Result"
            severity error;

        assert tb_o_BranchAddr = x"00000014"  -- PC + ALUResult
            report "Test Case 1 Failed: Incorrect Branch Address"
            severity error;

        assert tb_o_BranchTaken = '1'   -- Branch is taken (Branch AND Zero)
            report "Test Case 1 Failed: Incorrect Branch Taken Signal"
            severity error;

        assert tb_o_RegDstAddr = "00011"
            report "Test Case 1 Failed: Incorrect Destination Register Address"
            severity error;

        -- Test Case 2: Branch not taken
        tb_Zero <= '0';
        wait for CLK_PERIOD;

        assert tb_o_BranchTaken = '0'
            report "Test Case 2 Failed: Branch Taken Signal Should Be '0'"
            severity error;

        -- Test Case 3: Disable write enable
        tb_WE        <= '0';            -- Disable write enable
        tb_PC        <= x"00000008";    -- Change inputs
        tb_ALUResult <= x"00000020";
        tb_ReadData2 <= x"00000040";

        wait for CLK_PERIOD;

        -- Outputs should not change
        assert tb_o_ALUResult = x"00000010"  -- Should retain old value
            report "Test Case 3 Failed: ALU Result Changed Despite WE='0'"
            severity error;

        -- Finish simulation
        wait for CLK_PERIOD;
        report "All Test Cases Passed!" severity note;
        wait;
    end process;

end architecture;

