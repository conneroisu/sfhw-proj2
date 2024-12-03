-- <header>
-- Author(s): Conner Ohnesorge
-- Name: 
-- Notes:
--      Conner Ohnesorge 2024-12-01T14:04:08-06:00 add-test-bench-and-refactor-branch-unit-to-fit-style-guide
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity branch_unit_tb is
end branch_unit_tb;

architecture behavior of branch_unit_tb is

    component Branch_Unit is

        port(
            i_CLK          : in  std_logic;
            i_RST          : in  std_logic;
            i_WriteEnable  : in  std_logic;
            i_BranchTarget : in  std_logic_vector(31 downto 0);
            i_BranchPC     : in  std_logic_vector(31 downto 0);
            i_BranchTaken  : in  std_logic;
            i_BranchValid  : in  std_logic;
            o_PredictTaken : out std_logic;
            o_BranchTarget : out std_logic_vector(31 downto 0);
            o_Mispredict   : out std_logic
            );

    end component;

    signal s_CLK             : std_logic                     := '0';
    signal s_RST             : std_logic                     := '0';
    signal s_WriteEnable     : std_logic                     := '0';
    signal s_BranchTarget    : std_logic_vector(31 downto 0) := x"00000000";
    signal s_BranchPC        : std_logic_vector(31 downto 0) := x"00000000";
    signal s_BranchTaken     : std_logic                     := '0';
    signal s_BranchValid     : std_logic                     := '0';
    signal s_PredictTaken    : std_logic;
    signal s_BranchTargetOut : std_logic_vector(31 downto 0);
    signal s_Mispredict      : std_logic;

    -- Clock period definition
    constant c_CLK_PERIOD : time := 10 ns;

    -- Helper procedure for clock cycles
    procedure wait_cycles(n : integer) is
    begin
        for i in 1 to n loop
            wait for c_CLK_PERIOD;
        end loop;
    end procedure;

begin
    -- Instantiate the Unit Under Test (UUT)
    UUT : Branch_Unit port map (
        i_CLK          => s_CLK,
        i_RST          => s_RST,
        i_WriteEnable  => s_WriteEnable,
        i_BranchTarget => s_BranchTarget,
        i_BranchPC     => s_BranchPC,
        i_BranchTaken  => s_BranchTaken,
        i_BranchValid  => s_BranchValid,
        o_PredictTaken => s_PredictTaken,
        o_BranchTarget => s_BranchTargetOut,
        o_Mispredict   => s_Mispredict
        );

    -- Clock process
    CLK_process : process
    begin
        s_CLK <= '0';
        wait for c_CLK_PERIOD/2;
        s_CLK <= '1';
        wait for c_CLK_PERIOD/2;
    end process;

    -- Stimulus process
    STIM_process : process
    begin
        -- Initialize Inputs
        s_RST <= '1';
        wait_cycles(2);
        s_RST <= '0';
        wait_cycles(1);

        -- Test Case 1: Initial prediction (should predict not taken)
        s_WriteEnable  <= '1';
        s_BranchTarget <= x"00000100";  -- Example target address
        s_BranchPC     <= x"00000000";
        s_BranchValid  <= '1';
        s_BranchTaken  <= '0';          -- Actually not taken
        wait_cycles(2);

        -- Test Case 2: Branch taken multiple times (should start predicting taken)
        s_BranchTaken <= '1';
        wait_cycles(1);
        s_BranchTaken <= '1';
        wait_cycles(1);
        s_BranchTaken <= '1';
        wait_cycles(1);

        -- Test Case 3: Misprediction test
        s_BranchTaken <= '0';  -- Actually not taken when predicted taken
        wait_cycles(1);
        assert s_Mispredict = '1'
            report "Misprediction not detected when expected"
            severity error;

        -- Test Case 4: Branch not valid
        s_BranchValid <= '0';
        wait_cycles(1);
        assert s_Mispredict = '0'
            report "Mispredict signal active when branch not valid"
            severity error;

        -- Test Case 5: New branch target
        s_WriteEnable  <= '1';
        s_BranchValid  <= '1';
        s_BranchTarget <= x"00000200";
        wait_cycles(1);
        assert s_BranchTargetOut = x"00000200"
            report "Branch target not updated correctly"
            severity error;

        -- Test Case 6: Write disable
        s_WriteEnable  <= '0';
        s_BranchTarget <= x"00000300";
        wait_cycles(1);
        assert s_BranchTargetOut = x"00000200"
            report "Branch target updated when WriteEnable is 0"
            severity error;

        -- Test Case 7: Reset during operation
        s_RST <= '1';
        wait_cycles(1);
        s_RST <= '0';
        assert s_PredictTaken = '0'
            report "Predictor not reset correctly"
            severity error;

        -- End simulation
        report "Test Complete";
        wait;
    end process;

end behavior;

