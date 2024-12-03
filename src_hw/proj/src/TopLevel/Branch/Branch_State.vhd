-- <header>
-- Author(s): Conner Ohnesorge
-- Name: 
-- Notes:
--      Conner Ohnesorge 2024-12-01T14:04:08-06:00 add-test-bench-and-refactor-branch-unit-to-fit-style-guide
--      Conner Ohnesorge 2024-12-01T14:01:31-06:00 made-a-better-branch-unit-implementation
-- </header>

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Branch_State is

    port (
        clk          : in  std_logic;
        rst          : in  std_logic;
        branch_taken : in  std_logic;   -- Actual branch outcome
        prediction   : out std_logic  -- Predicted outcome (1 = taken, 0 = not taken)
        );

end Branch_State;

architecture behavioral of Branch_State is
    -- State encoding:
    -- "11" = Strongly Taken (State 3)
    -- "10" = Weakly Taken (State 2)
    -- "01" = Weakly Not Taken (State 1)
    -- "00" = Strongly Not Taken (State 0)

    type state_type is (STRONGLY_TAKEN, WEAKLY_TAKEN, WEAKLY_NOT_TAKEN, STRONGLY_NOT_TAKEN);
    signal current_state, next_state : state_type;

begin
    -- State register process
    process(clk, rst)
    begin
        if rst = '1' then
            current_state <= WEAKLY_NOT_TAKEN;  -- Initialize to weakly not taken
        elsif rising_edge(clk) then
            current_state <= next_state;
        end if;
    end process;

    -- Next state logic process
    process(current_state, branch_taken)
    begin
        case current_state is
            when STRONGLY_TAKEN =>
                if branch_taken = '1' then
                    next_state <= STRONGLY_TAKEN;
                else
                    next_state <= WEAKLY_TAKEN;
                end if;

            when WEAKLY_TAKEN =>
                if branch_taken = '1' then
                    next_state <= STRONGLY_TAKEN;
                else
                    next_state <= WEAKLY_NOT_TAKEN;
                end if;

            when WEAKLY_NOT_TAKEN =>
                if branch_taken = '1' then
                    next_state <= WEAKLY_TAKEN;
                else
                    next_state <= STRONGLY_NOT_TAKEN;
                end if;

            when STRONGLY_NOT_TAKEN =>
                if branch_taken = '1' then
                    next_state <= WEAKLY_NOT_TAKEN;
                else
                    next_state <= STRONGLY_NOT_TAKEN;
                end if;
        end case;
    end process;

    -- Output logic process
    process(current_state)
    begin
        case current_state is
            when STRONGLY_TAKEN | WEAKLY_TAKEN =>
                prediction <= '1';      -- Predict taken
            when STRONGLY_NOT_TAKEN | WEAKLY_NOT_TAKEN =>
                prediction <= '0';      -- Predict not taken
        end case;
    end process;

end behavioral;

