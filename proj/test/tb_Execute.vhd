library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity tb_Execute is
    generic(
        gclk_hper : time := 50 ns
        );
end entity tb_Execute;

architecture Behavioral of tb_Execute is

    constant cclk_per : time := gclk_hper * 2;

    component Execute is
        generic(N : integer := 32);

        port (
            i_CLK        : in  std_logic;
            i_RST        : in  std_logic;
            i_WE         : in  std_logic;
            i_PC         : in  std_logic_vector(N-1 downto 0);
            i_PCplus4    : in  std_logic_vector(N-1 downto 0);
            i_RegDst     : in  std_logic;  -- Control Unit Destination Register
            i_ALUOp      : in  std_logic_vector(3 downto 0);  -- ALU operation from control unit.
            i_ALUSrc     : in  std_logic_vector(1 downto 0);  -- ALU source from control unit.
            i_MemRead    : in  std_logic;  -- Memory Read control
            i_MemWrite   : in  std_logic;  -- Memory Write control
            i_MemtoReg   : in  std_logic;  -- Memory to Register control
            i_RegWrite   : in  std_logic;  -- Register Write control
            i_Branch     : in  std_logic;  -- Branch control
            i_Extended   : in  std_logic_vector(N-1 downto 0);
            i_Read1      : in  std_logic_vector(N-1 downto 0);
            i_Read2      : in  std_logic_vector(N-1 downto 0);
            i_ForwardA   : in  std_logic_vector(1 downto 0);
            i_ForwardB   : in  std_logic_vector(1 downto 0);
            i_WriteData  : in  std_logic_vector(N-1 downto 0);  -- Data from the end of writeback stage's mux
            i_DMem1      : in  std_logic_vector(N-1 downto 0);  -- Data from the first input to the DMem output of ex/mem
            i_Halt       : in  std_logic_vector(0 downto 0);
            o_ALU        : out std_logic_vector(N-1 downto 0);
            o_ALUSrc     : out std_logic_vector(1 downto 0);
            o_MemRead    : out std_logic;
            o_MemWrite   : out std_logic;
            o_MemtoReg   : out std_logic;
            o_RegWrite   : out std_logic;
            o_Branch     : out std_logic;
            o_BranchAddr : out std_logic_vector(N-1 downto 0);
            o_Read1      : out std_logic_vector(N-1 downto 0);
            o_Read2      : out std_logic_vector(N-1 downto 0);
            o_Halt       : out std_logic_vector(0 downto 0)
            );

    end component;

    signal s_clk : std_logic := '0';

    signal i_RST                  : std_logic := '0';
    signal i_WE                   : std_logic := '0';
    signal i_PC                   : std_logic_vector(31 downto 0);
    signal i_PCplus4              : std_logic_vector(31 downto 0);
    signal i_RegDst               : std_logic;
    signal i_ALUOp                : std_logic_vector(3 downto 0);
    signal i_ALUSrc               : std_logic_vector(1 downto 0);
    signal i_Extended             : std_logic_vector(31 downto 0);
    signal i_Read1, i_Read2       : std_logic_vector(31 downto 0);
    signal i_ForwardA, i_ForwardB : std_logic_vector(1 downto 0);
    signal i_WriteData, i_DMem1   : std_logic_vector(31 downto 0);
    signal i_Halt                 : std_logic_vector(0 downto 0);
    signal i_MemRead, i_MemWrite  : std_logic;
    signal i_MemtoReg, i_RegWrite : std_logic;
    signal i_Branch               : std_logic;


    signal o_ALU        : std_logic_vector(31 downto 0);
    signal o_ALUSrc     : std_logic_vector(1 downto 0);
    signal o_MemRead    : std_logic;
    signal o_MemWrite   : std_logic;
    signal o_MemtoReg   : std_logic;
    signal o_RegWrite   : std_logic;
    signal o_Branch     : std_logic;
    signal o_BranchAddr : std_logic_vector(31 downto 0);
    signal o_Read1      : std_logic_vector(31 downto 0);
    signal o_Read2      : std_logic_vector(31 downto 0);
    signal o_Halt       : std_logic_vector(0 downto 0);


    -- Add signals for expected values
    signal s_expected_alu        : std_logic_vector(31 downto 0);
    signal s_expected_alusrc     : std_logic_vector(1 downto 0);
    signal s_expected_memread    : std_logic;
    signal s_expected_memwrite   : std_logic;
    signal s_expected_memtoreg   : std_logic;
    signal s_expected_regwrite   : std_logic;
    signal s_expected_branch     : std_logic;
    signal s_expected_branchaddr : std_logic_vector(31 downto 0);
    signal s_expected_read1      : std_logic_vector(31 downto 0);
    signal s_expected_read2      : std_logic_vector(31 downto 0);

    -- Simplified helper procedure that uses architecture-level signals
    procedure check_outputs is
    begin
        assert o_ALU = s_expected_alu
            report "ALU output mismatch. Expected: " & integer'image(to_integer(unsigned(s_expected_alu))) &
            " Got: " & integer'image(to_integer(unsigned(o_ALU)))
            severity error;
        assert o_ALUSrc = s_expected_alusrc
            report "ALUSrc mismatch. Expected: " & integer'image(to_integer(unsigned(s_expected_alusrc))) &
            " Got: " & integer'image(to_integer(unsigned(o_ALUSrc)))
            severity error;
        assert o_MemRead = s_expected_memread
            report "MemRead mismatch. Expected: " & std_logic'image(s_expected_memread) &
            " Got: " & std_logic'image(o_MemRead)
            severity error;
        assert o_MemWrite = s_expected_memwrite
            report "MemWrite mismatch. Expected: " & std_logic'image(s_expected_memwrite) &
            " Got: " & std_logic'image(o_MemWrite)
            severity error;
        assert o_MemtoReg = s_expected_memtoreg
            report "MemtoReg mismatch. Expected: " & std_logic'image(s_expected_memtoreg) &
            " Got: " & std_logic'image(o_MemtoReg)
            severity error;
        assert o_RegWrite = s_expected_regwrite
            report "RegWrite mismatch. Expected: " & std_logic'image(s_expected_regwrite) &
            " Got: " & std_logic'image(o_RegWrite)
            severity error;
        assert o_Branch = s_expected_branch
            report "Branch mismatch. Expected: " & std_logic'image(s_expected_branch) &
            " Got: " & std_logic'image(o_Branch)
            severity error;
        assert o_BranchAddr = s_expected_branchaddr
            report "Branch address mismatch. Expected: " & integer'image(to_integer(unsigned(s_expected_branchaddr))) &
            " Got: " & integer'image(to_integer(unsigned(o_BranchAddr)))
            severity error;
        assert o_Read1 = s_expected_read1
            report "Read1 mismatch. Expected: " & integer'image(to_integer(unsigned(s_expected_read1))) &
            " Got: " & integer'image(to_integer(unsigned(o_Read1)))
            severity error;
        assert o_Read2 = s_expected_read2
            report "Read2 mismatch. Expected: " & integer'image(to_integer(unsigned(s_expected_read2))) &
            " Got: " & integer'image(to_integer(unsigned(o_Read2)))
            severity error;
    end procedure;
begin

    p_clk : process is
    begin
        s_clk <= '0';
        wait for gclk_hper;
        s_clk <= '1';
        wait for gclk_hper;
    end process p_clk;

    stage_idex_inst : Execute
        generic map(32)
        port map(
            i_CLK        => s_clk,
            i_RST        => i_RST,
            i_WE         => i_WE,
            i_PC         => i_PC,
            i_PCplus4    => i_PCplus4,
            i_RegDst     => i_RegDst,
            i_ALUOp      => i_ALUOp,
            i_ALUSrc     => i_ALUSrc,
            i_MemRead    => i_MemRead,
            i_MemWrite   => i_MemWrite,
            i_MemtoReg   => i_MemtoReg,
            i_RegWrite   => i_RegWrite,
            i_Branch     => i_Branch,
            i_Extended   => i_Extended,
            i_Read1      => i_Read1,
            i_Read2      => i_Read2,
            i_ForwardA   => i_ForwardA,
            i_ForwardB   => i_ForwardB,
            i_WriteData  => i_WriteData,
            i_DMem1      => i_DMem1,
            i_Halt       => i_Halt,
            o_ALU        => o_ALU,
            o_ALUSrc     => o_ALUSrc,
            o_MemRead    => o_MemRead,
            o_MemWrite   => o_MemWrite,
            o_MemtoReg   => o_MemtoReg,
            o_RegWrite   => o_RegWrite,
            o_Branch     => o_Branch,
            o_Read1      => o_Read1,
            o_Read2      => o_Read2,
            o_BranchAddr => o_BranchAddr,
            o_Halt       => o_Halt
            );

    p_tb : process is
    -- Variables for expected results
    begin
        -- ForwardA & ForwardB determine 1st & 2nd alu operands respectively
        -- MuxInputs    -> {Source} -> {Explanation}
        -- ForwardA=00  -> ID/EX    -> operand from registerfile
        -- ForwardA=10  -> EX/MEM   -> operand is forwarded from prior alu result
        -- ForwardA=01  -> MEM/WB   -> operand is forwarded from dmem or earlier alu result
        -- ForwardB=00  -> ID/EX    -> operand from registerfile
        -- ForwardB=10  -> EX/MEM   -> operand is forwarded from prior alu result
        -- ForwardB=01  -> MEM/WB   -> operand is forwarded from dmem or earlier alu result

        -- Initialize all inputs
        i_RST       <= '1';
        i_WE        <= '0';
        i_PC        <= x"00000000";
        i_PCplus4   <= x"00000004";
        i_RegDst    <= '0';
        i_ALUOp     <= "0000";
        i_ALUSrc    <= "00";
        i_MemRead   <= '0';
        i_MemWrite  <= '0';
        i_MemtoReg  <= '0';
        i_RegWrite  <= '0';
        i_Branch    <= '0';
        i_Extended  <= x"00000000";
        i_Read1     <= x"00000000";
        i_Read2     <= x"00000000";
        i_ForwardA  <= "00";
        i_ForwardB  <= "00";
        i_WriteData <= x"00000000";
        i_DMem1     <= x"00000000";
        i_Halt      <= "0";

        -- Initialize expected signals
        s_expected_alu        <= x"00000000";
        s_expected_alusrc     <= "00";
        s_expected_memread    <= '0';
        s_expected_memwrite   <= '0';
        s_expected_memtoreg   <= '0';
        s_expected_regwrite   <= '0';
        s_expected_branch     <= '0';
        s_expected_branchaddr <= x"00000000";
        s_expected_read1      <= x"00000000";
        s_expected_read2      <= x"00000000";

        wait for cclk_per;

        -- Test 1: Basic ALU Add operation (R-type)
        i_RST      <= '0';
        i_WE       <= '1';
        i_RegDst   <= '1';              -- R-type instruction
        i_ALUOp    <= "0010";           -- ADD operation
        i_Read1    <= x"00000005";      -- First operand = 5
        i_Read2    <= x"00000003";      -- Second operand = 3
        i_ForwardA <= "00";             -- No forwarding
        i_ForwardB <= "00";             -- No forwarding

        s_expected_alu        <= x"00000008";  -- Expected sum: 5 + 3 = 8
        s_expected_alusrc     <= "00";
        s_expected_memread    <= '0';
        s_expected_memwrite   <= '0';
        s_expected_memtoreg   <= '0';
        s_expected_regwrite   <= '1';
        s_expected_branch     <= '0';
        s_expected_branchaddr <= x"00000004";
        s_expected_read1      <= x"00000005";
        s_expected_read2      <= x"00000003";

        wait for cclk_per;
        check_outputs;

        -- Test 2: Forwarding from EX/MEM stage
        i_ForwardA <= "10";             -- Forward from EX/MEM
        i_DMem1    <= x"0000000A";      -- Forward value = 10
        i_Read2    <= x"00000002";      -- Second operand = 2

        s_expected_alu   <= x"0000000C";  -- Expected: 10 + 2 = 12
        s_expected_read2 <= x"00000002";

        wait for cclk_per;
        check_outputs;

        -- Test 3: Test branch address calculation
        i_Branch   <= '1';
        i_Extended <= x"00000010";      -- Offset of 16
        i_PCplus4  <= x"00000100";      -- PC+4 = 256

        s_expected_branch     <= '1';
        s_expected_branchaddr <= x"00000140";  -- Expected: 256 + (16 << 2) = 256 + 64 = 320

        wait for cclk_per;
        check_outputs;

        -- Test 4: Load word operation
        i_RegDst   <= '0';              -- I-type instruction
        i_ALUOp    <= "0000";           -- Load operation
        i_ALUSrc   <= "01";             -- Use immediate
        i_MemRead  <= '1';
        i_MemtoReg <= '1';
        i_Branch   <= '0';
        i_Extended <= x"00000004";      -- Offset of 4
        i_Read1    <= x"00000100";      -- Base address

        s_expected_alu      <= x"00000104";  -- Expected: base + offset = 256 + 4 = 260
        s_expected_alusrc   <= "01";
        s_expected_memread  <= '1';
        s_expected_memtoreg <= '1';
        s_expected_branch   <= '0';
        s_expected_read1    <= x"00000100";

        wait for cclk_per;
        check_outputs;

        -- Test 5: Store word operation
        i_MemRead  <= '0';
        i_MemWrite <= '1';
        i_MemtoReg <= '0';
        i_RegWrite <= '0';
        i_Read2    <= x"DEADBEEF";      -- Data to store

        s_expected_memread  <= '0';
        s_expected_memwrite <= '1';
        s_expected_memtoreg <= '0';
        s_expected_regwrite <= '0';
        s_expected_read2    <= x"DEADBEEF";

        wait for cclk_per;
        check_outputs;

        -- Test 6: Reset behavior
        i_RST <= '1';

        s_expected_alu        <= x"00000000";
        s_expected_alusrc     <= "00";
        s_expected_memread    <= '0';
        s_expected_memwrite   <= '0';
        s_expected_memtoreg   <= '0';
        s_expected_regwrite   <= '0';
        s_expected_branch     <= '0';
        s_expected_branchaddr <= x"00000000";
        s_expected_read1      <= x"00000000";
        s_expected_read2      <= x"00000000";

        wait for cclk_per;
        check_outputs;

        report "Testbench completed successfully!";
        wait;
    end process p_tb;

end architecture Behavioral;
