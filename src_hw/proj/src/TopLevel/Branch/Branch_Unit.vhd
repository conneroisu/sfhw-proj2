library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Branch_Unit is
    port(
        -- Control signals
        i_CLK           : in std_logic;
        i_RST          : in std_logic;
        i_WriteEnable  : in std_logic;
        
        -- Branch information
        i_BranchTarget : in std_logic_vector(31 downto 0);  -- Target address
        i_BranchPC     : in std_logic_vector(31 downto 0);  -- PC of branch instruction
        i_BranchTaken  : in std_logic;                      -- Actual branch outcome
        i_BranchValid  : in std_logic;                      -- Branch instruction is valid
        
        -- Output signals
        o_PredictTaken : out std_logic;                     -- Prediction result
        o_BranchTarget : out std_logic_vector(31 downto 0); -- Predicted target address
        o_Mispredict   : out std_logic                      -- Misprediction signal
    );
end entity Branch_Unit;

architecture structural of Branch_Unit is
    -- 2-bit DFF component
    component dffg_n is
        generic(N : integer := 32);
        port(
            i_CLK : in  std_logic;
            i_RST : in  std_logic;
            i_WrE : in  std_logic;
            i_D   : in  std_logic_vector(N-1 downto 0);
            o_Q   : out std_logic_vector(N-1 downto 0)
        );
    end component;

    -- Branch predictor component
    component branch_predictor is
        port (
            clk          : in  std_logic;
            rst          : in  std_logic;
            branch_taken : in  std_logic;
            prediction   : out std_logic
        );
    end component;

    -- Internal signals
    signal s_PredictionScheme : std_logic_vector(1 downto 0);
    signal s_BranchTarget     : std_logic_vector(31 downto 0);
    signal s_Prediction       : std_logic;
    signal s_LastPrediction   : std_logic_vector(0 downto 0);  -- Changed to vector
    signal s_PredictedTarget  : std_logic_vector(31 downto 0);
    signal s_LastPredIn       : std_logic_vector(0 downto 0);  -- New input signal

begin
    -- Branch Target Register
    BranchTargetReg : dffg_n
        generic map (N => 32)
        port map(
            i_CLK => i_CLK,
            i_RST => i_RST,
            i_WrE => i_WriteEnable,
            i_D   => i_BranchTarget,
            o_Q   => s_BranchTarget
        );

    -- 2-bit Branch Predictor
    Predictor : branch_predictor
        port map(
            clk          => i_CLK,
            rst          => i_RST,
            branch_taken => i_BranchTaken,
            prediction   => s_Prediction
        );

    -- Convert prediction to vector for DFF input
    s_LastPredIn(0) <= s_Prediction;

    -- Last Prediction Register (for misprediction detection)
    LastPredictionReg : dffg_n
        generic map (N => 1)
        port map(
            i_CLK => i_CLK,
            i_RST => i_RST,
            i_WrE => i_BranchValid,
            i_D   => s_LastPredIn,
            o_Q   => s_LastPrediction
        );

    -- Predicted Target Register
    PredictedTargetReg : dffg_n
        generic map (N => 32)
        port map(
            i_CLK => i_CLK,
            i_RST => i_RST,
            i_WrE => i_WriteEnable,
            i_D   => s_PredictedTarget,
            o_Q   => o_BranchTarget
        );

    -- Combinational Logic
    s_PredictedTarget <= i_BranchTarget when s_Prediction = '1' else 
                         std_logic_vector(unsigned(i_BranchPC) + 4);

    -- Output Logic
    o_PredictTaken <= s_Prediction;
    o_Mispredict   <= '1' when (i_BranchValid = '1' and s_LastPrediction(0) /= i_BranchTaken) else '0';

end architecture structural;
