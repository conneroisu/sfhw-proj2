-- <header>
-- Author(s): aidanfoss
-- Name: proj/test/tb_MEM_WB.vhd
-- Notes:
--      aidanfoss 2024-11-21T10:10:56-06:00 working-on-fixing-memwb
--      aidanfoss 2024-11-21T09:45:28-06:00 fixed-all-issue-in-tb
--      aidanfoss 2024-11-21T09:03:40-06:00 finished-up-tb_MEM_WB
--      aidanfoss 2024-11-21T08:54:57-06:00 beginning-tb-for-memWB
-- </header>

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity TB_MEM_WB is
end TB_MEM_WB;

architecture Behavioral of TB_MEM_WB is
    component MEM_WB
    port (
        clk        : in std_logic;
        reset      : in std_logic;
        i_ALUResult : in std_logic_vector(31 downto 0);  -- ALU result to WB
        i_DataMem   : in std_logic_vector(31 downto 0);  -- Data from memory
        i_RegDst    : in std_logic_vector(4 downto 0);   -- Destination register number
        i_RegWrite  : in std_logic;
        i_MemToReg  : in std_logic;                     -- MUX select signal
        o_regDst    : out std_logic_vector(4 downto 0); -- Destination register output
        o_regWrite  : out std_logic;                    -- Write enable output
        o_wbData    : out std_logic_vector(31 downto 0) -- Data to write back
    );
    end component;
    signal clk   : std_logic := '0';
    signal reset : std_logic := '0';

    signal si_ALUResult : std_logic_vector(31 downto 0);  -- ALU result to WB
    signal si_DataMem   : std_logic_vector(31 downto 0);
    signal si_MemToReg  : std_logic;
    signal si_RegDst    : std_logic_vector(4 downto 0);  -- Destination register number to Register File
    signal si_RegWrite  : std_logic;

    signal so_regDst   : std_logic_vector(4 downto 0);  -- Destination reguster number to register file
    signal so_regWrite : std_logic;
    signal so_wbData   : std_logic_vector(31 downto 0);

    constant clk_period : time := 50 ns;

begin
    uut : MEM_WB port map(
        clk         => clk,
        reset       => reset,
        i_ALUResult => si_ALUResult,
        i_DataMem   => si_DataMem,
        i_RegDst    => si_RegDst,
        i_RegWrite  => si_RegWrite,
        i_MemToReg  => si_MemToReg,
        o_regDst    => so_regDst,
        o_regWrite  => so_regWrite,
        o_wbData    => so_wbData
        );

    --clock gen
    clk_process : process
    begin
        clk <= '0';
        wait for clk_period / 2;
        clk <= '1';
        wait for clk_period / 2;
    end process;

    stim_proc : process
    begin
        --reset behavior
        reset <= '1';
        wait for clk_period;
        reset <= '0';
        wait for clk_period;

        --Test 1: Select Data Memory Value (i_MemToReg = 1)
        si_ALUResult <= X"AAAAAAAA";
        si_DataMem   <= X"00000010";
        si_MemToReg  <= '1';
        si_RegDst    <= "00001";
        si_RegWrite  <= '1';
        wait for clk_period;
        --assert values
        assert so_wbData = X"00000010" report "o_wbData    mismatch on test 1";
        assert si_MemToReg = '1' report "i_MemToReg  mismatch on test 1";
        assert si_RegDst = "00001" report "i_RegDst    mismatch on test 1";
        assert si_RegWrite = '1' report "i_RegWrite  mismatch on test 1";



        --Test 2: Select Data Memory Value (i_MemToReg = 0)
        si_ALUResult <= X"00000010";
        si_DataMem   <= X"AAAAAAAA";
        si_MemToReg  <= '0';
        si_RegDst    <= "00010";
        si_RegWrite  <= '1';
        wait for clk_period;
        --assert values
        assert so_wbData = X"00000010" report "o_wbData    mismatch on test 2";
        assert si_MemToReg = '0' report "i_MemToReg  mismatch on test 2";
        assert si_RegDst = "00010" report "i_RegDst    mismatch on test 2";
        assert si_RegWrite = '1' report "i_RegWrite  mismatch on test 2";



        --Test 3: Final Test Passthrough Values (i_RegWrite = 0)
        si_ALUResult <= X"00000000";
        si_DataMem   <= X"00000000";
        si_RegDst    <= "00011";
        si_RegWrite  <= '0';
        wait for clk_period;
        --assert values
        assert si_RegDst = "00011" report "i_RegDst    mismatch on test 3";
        assert si_RegWrite = '0' report "i_RegWrite  mismatch on test 3";
	

	--end test
	wait;
    end process;
end Behavioral;

