-- <header>
-- Author(s): Conner Ohnesorge
-- Name: 
-- Notes:
--      Conner Ohnesorge 2024-11-21T11:05:34-06:00 added-old-single-cycle-processor-and-added-documentation-for-the
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity tb_alu is
end tb_alu;
architecture test of tb_alu is
    -- Component declaration of the ALU
    component alu
        port
            (
                CLK        : in  std_logic;
                i_Data1    : in  std_logic_vector(31 downto 0);
                i_Data2    : in  std_logic_vector(31 downto 0);
                i_shamt    : in  std_logic_vector(4 downto 0);
                i_aluOp    : in  std_logic_vector(3 downto 0);
                o_F        : out std_logic_vector(31 downto 0);
                o_Overflow : out std_logic;
                o_Zero     : out std_logic
                );
    end component;
    -- Signals to connect to the ALU
    signal CLK          : std_logic := '0';
    signal i_Data1      : std_logic_vector(31 downto 0);
    signal i_Data2      : std_logic_vector(31 downto 0);
    signal i_shamt      : std_logic_vector(4 downto 0);
    signal i_aluOp      : std_logic_vector(3 downto 0);
    signal o_F          : std_logic_vector(31 downto 0);
    signal o_Overflow   : std_logic;
    signal o_Zero       : std_logic;
    -- Clock period constant
    constant CLK_PERIOD : time      := 50 ns;
begin
    -- Instantiate the ALU
    uut : alu
        port map (
            CLK        => CLK,
            i_Data1    => i_Data1,
            i_Data2    => i_Data2,
            i_shamt    => i_shamt,
            i_aluOp    => i_aluOp,
            o_F        => o_F,
            o_Overflow => o_Overflow,
            o_Zero     => o_Zero
            );
    -- Clock process
    clk_process : process
    begin
        CLK <= '0';
        wait for CLK_PERIOD / 2;
        CLK <= '1';
        wait for CLK_PERIOD / 2;
    end process;
    -- Stimulus process
    stim_proc : process
    begin
        -- Test case 1: Addition (unsigned)
        i_Data1 <= x"0000000A";         -- 10
        i_Data2 <= x"00000005";         -- 5
        i_aluOp <= "0000";              -- ALU op for unsigned addition
        wait for CLK_PERIOD;
        assert o_F = x"0000000F" report "Addition test failed" severity error;
        -- Test case 2: Subtraction (unsigned)
        i_Data1 <= x"0000000A";         -- 10
        i_Data2 <= x"00000003";         -- 3
        i_aluOp <= "0001";              -- ALU op for unsigned subtraction
        wait for CLK_PERIOD;
        assert o_F = x"00000007" report "Subtraction test failed" severity error;
        -- Test case 3: Logical AND
        i_Data1 <= x"0000000F";         -- 15 (binary: 0000...1111)
        i_Data2 <= x"00000003";         -- 3 (binary: 0000...0011)
        i_aluOp <= "0101";              -- ALU op for AND
        wait for CLK_PERIOD;
        assert o_F = x"00000003" report "AND test failed" severity error;
        -- Test case 4: Logical OR
        i_Data1 <= x"0000000F";         -- 15 (binary: 0000...1111)
        i_Data2 <= x"00000003";         -- 3 (binary: 0000...0011)
        i_aluOp <= "1001";              -- ALU op for OR
        wait for CLK_PERIOD;
        assert o_F = x"0000000F" report "OR test failed" severity error;
        -- Test case 5: Logical Shift Left
        i_Data2 <= x"00000001";         -- 1 (binary: 0000...0001)
        i_shamt <= "00010";             -- shift amount = 2
        i_aluOp <= "0100";              -- ALU op for shift left
        wait for CLK_PERIOD;
        assert o_F = x"00000004" report "Shift Left test failed" severity error;
        -- Test case 6: Logical Shift Right
        i_Data2 <= x"00000004";         -- 4 (binary: 0000...0100)
        i_shamt <= "00010";             -- shift amount = 2
        i_aluOp <= "1100";              -- ALU op for shift right (logical)
        wait for CLK_PERIOD;
        assert o_F = x"00000001" report "Shift Right test failed" severity error;
        -- Test case 7: Arithmetic Shift Right
        i_Data2 <= x"80000000";  -- Negative number (binary: 1000...0000)
        i_shamt <= "00001";             -- shift amount = 1
        i_aluOp <= "1110";              -- ALU op for shift right (arithmetic)
        wait for CLK_PERIOD;
        assert o_F = x"C0000000" report "Arithmetic Shift Right test failed" severity error;
        -- Test case 8: Set on Less Than (SLT)
        i_Data1 <= x"00000003";         -- 3
        i_Data2 <= x"00000005";         -- 5
        i_aluOp <= "0111";              -- ALU op for SLT (signed)
        wait for CLK_PERIOD;
        assert o_F = x"00000001" report "SLT test failed" severity error;
        -- Test case 9: Set on Less Than Unsigned (SLTU)
        i_Data1 <= x"00000003";         -- 3
        i_Data2 <= x"00000005";         -- 5
        i_aluOp <= "1101";              -- ALU op for SLTU (unsigned)
        wait for CLK_PERIOD;
        assert o_F = x"00000001" report "SLTU test failed" severity error;
        -- Test case 10: Overflow Detection (Addition)
        i_Data1 <= x"7FFFFFFF";         -- Max positive 32-bit integer
        i_Data2 <= x"00000001";         -- 1
        i_aluOp <= "0010";              -- ALU op for signed addition
        wait for CLK_PERIOD;
        assert o_Overflow = '1' report "Overflow detection test failed" severity error;
        -- Stop the simulation
        wait;
    end process;
end test;

