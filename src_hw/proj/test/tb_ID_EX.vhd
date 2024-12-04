-- <header>
-- Author(s): Conner Ohnesorge
-- Name: 
-- Notes:
--      Conner Ohnesorge 2024-12-01T12:19:14-06:00 moved-all-files-into-the-hardware-directory
-- </header>

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity tb_ID_EX is
end entity;

architecture testbench of tb_ID_EX is

    -- Component under test
    component ID_EX is
        generic(N : integer := 32);
        port (
            -- Common Stage Signals [begin]
            i_CLK        : in  std_logic;
            i_RST        : in  std_logic;
            i_WE         : in  std_logic;
            i_PC         : in  std_logic_vector(N-1 downto 0);
            i_PCplus4    : in  std_logic_vector(N-1 downto 0);
            o_PCplus4    : out std_logic_vector(N-1 downto 0);
            -- Control Signals
            i_RegDst     : in  std_logic;
            i_ALUOp      : in  std_logic_vector(2 downto 0);
            i_ALUSrc     : in  std_logic_vector(1 downto 0);
            i_MemRead    : in  std_logic;
            i_MemWrite   : in  std_logic;
            i_MemtoReg   : in  std_logic;
            i_RegWrite   : in  std_logic;
            i_Branch     : in  std_logic;
            -- Future Stage Signals
            o_ALU        : out std_logic_vector(N-1 downto 0);
            o_ALUSrc     : out std_logic_vector(1 downto 0);
            o_MemRead    : out std_logic;
            o_MemWrite   : out std_logic;
            o_MemtoReg   : out std_logic;
            o_RegWrite   : out std_logic;
            o_Branch     : out std_logic;
            -- Input Signals
            i_Read1      : in  std_logic_vector(N-1 downto 0);
            i_Read2      : in  std_logic_vector(N-1 downto 0);
            o_Read1      : out std_logic_vector(N-1 downto 0);
            o_Read2      : out std_logic_vector(N-1 downto 0);
            i_ForwardA   : in  std_logic_vector(1 downto 0);
            i_ForwardB   : in  std_logic_vector(1 downto 0);
            i_WriteData  : in  std_logic_vector(N-1 downto 0);
            i_DMem1      : in  std_logic_vector(N-1 downto 0);
            i_Rs         : in  std_logic_vector(4 downto 0);
            i_Rt         : in  std_logic_vector(4 downto 0);
            i_Rd         : in  std_logic_vector(4 downto 0);
            i_Shamt      : in  std_logic_vector(4 downto 0);
            i_Funct      : in  std_logic_vector(5 downto 0);
            i_Imm        : in  std_logic_vector(15 downto 0);
            i_Extended   : in  std_logic_vector(31 downto 0);
            o_BranchAddr : out std_logic_vector(31 downto 0)
        );
    end component;

    -- Signals for DUT
    signal s_CLK, s_RST, s_WE             : std_logic := '0';
    signal s_PC, s_PCplus4               : std_logic_vector(31 downto 0) := (others => '0');
    signal s_RegDst, s_MemRead, s_MemWrite, s_MemtoReg, s_RegWrite, s_Branch : std_logic := '0';
    signal s_ALUOp                       : std_logic_vector(2 downto 0) := (others => '0');
    signal s_ALUSrc                      : std_logic_vector(1 downto 0) := (others => '0');
    signal s_ForwardA, s_ForwardB        : std_logic_vector(1 downto 0) := (others => '0');

    signal s_i_Read1, s_i_Read2          : std_logic_vector(31 downto 0) := (others => '0');
    signal s_o_Read1, s_o_Read2          : std_logic_vector(31 downto 0);
    signal s_i_WriteData, s_i_DMem1      : std_logic_vector(31 downto 0) := (others => '0');
    signal s_i_ForwardA, s_i_ForwardB    : std_logic_vector(1 downto 0) := (others => '0');

    signal s_i_Rs, s_i_Rt, s_i_Rd, s_i_Shamt : std_logic_vector(4 downto 0) := (others => '0');
    signal s_i_Funct                     : std_logic_vector(5 downto 0) := (others => '0');
    signal s_i_Imm                       : std_logic_vector(15 downto 0) := (others => '0');
    signal s_i_Extended                  : std_logic_vector(31 downto 0) := (others => '0');

    signal s_o_PCplus4, s_o_ALU          : std_logic_vector(31 downto 0);
    signal s_o_ALUSrc                    : std_logic_vector(1 downto 0);
    signal s_o_MemRead, s_o_MemWrite, s_o_MemtoReg, s_o_RegWrite, s_o_Branch : std_logic;
    signal s_o_BranchAddr                : std_logic_vector(31 downto 0);


    -- Clock period
    constant CLK_PERIOD : time := 10 ns;

    -- Helper procedure to check results and report
    procedure check_signal(name : in string; actual, expected : in std_logic_vector) is
    begin
        if actual /= expected then
            report "ERROR: " & name & " mismatch. Expected: " &
                   integer'image(to_integer(unsigned(expected))) & " Got: " &
                   integer'image(to_integer(unsigned(actual))) severity error;
        else
            report "INFO: " & name & " correct. Value: " &
                   integer'image(to_integer(unsigned(actual)));
        end if;
    end procedure;

    procedure check_signal_std(name : in string; actual, expected : in std_logic) is
    begin
        if actual /= expected then
            report "ERROR: " & name & " mismatch. Expected: " &
                   std_logic'image(expected) & " Got: " &
                   std_logic'image(actual) severity error;
        else
            report "INFO: " & name & " correct. Value: " &
                   std_logic'image(actual);
        end if;
    end procedure;

begin

    -- Instantiate DUT
    DUT: ID_EX
        port map (
            i_CLK       => s_CLK,
            i_RST       => s_RST,
            i_WE        => s_WE,
            i_PC        => s_PC,
            i_PCplus4   => s_PCplus4,
            o_PCplus4   => s_o_PCplus4,
            i_RegDst    => s_RegDst,
            i_ALUOp     => s_ALUOp,
            i_ALUSrc    => s_ALUSrc,
            i_MemRead   => s_MemRead,
            i_MemWrite  => s_MemWrite,
            i_MemtoReg  => s_MemtoReg,
            i_RegWrite  => s_RegWrite,
            i_Branch    => s_Branch,
            o_ALU       => s_o_ALU,
            o_ALUSrc    => s_o_ALUSrc,
            o_MemRead   => s_o_MemRead,
            o_MemWrite  => s_o_MemWrite,
            o_MemtoReg  => s_o_MemtoReg,
            o_RegWrite  => s_o_RegWrite,
            o_Branch    => s_o_Branch,
            i_Read1     => s_i_Read1,
            i_Read2     => s_i_Read2,
            o_Read1     => s_o_Read1,
            o_Read2     => s_o_Read2,
            i_ForwardA  => s_ForwardA,
            i_ForwardB  => s_ForwardB,
            i_WriteData => s_i_WriteData,
            i_DMem1     => s_i_DMem1,
            i_Rs        => s_i_Rs,
            i_Rt        => s_i_Rt,
            i_Rd        => s_i_Rd,
            i_Shamt     => s_i_Shamt,
            i_Funct     => s_i_Funct,
            i_Imm       => s_i_Imm,
            i_Extended  => s_i_Extended,
            o_BranchAddr=> s_o_BranchAddr
        );

    -- Clock generation
    clk_proc: process
    begin
        s_CLK <= '0';
        wait for CLK_PERIOD/2;
        s_CLK <= '1';
        wait for CLK_PERIOD/2;
    end process;

    -- Test process
    stim_proc: process
    begin
        -- Reset
        s_RST <= '1';
        s_WE  <= '0';
        wait for 3*CLK_PERIOD;
        s_RST <= '0';
        s_WE  <= '1';

        report "Starting ID_EX Testbench";

        ------------------------------------------------------------------------
        -- Test 1: R-type Instruction: ADD $rd, $rs, $rt
        -- ALUOp=010 (example for R-type), RegDst='1', ALUSrc='00'
        -- Read1=5, Read2=6 => result=11
        -- i_Funct="100000" (add)
        ------------------------------------------------------------------------
        s_PC        <= x"00000000";
        s_PCplus4   <= x"00000004";
        s_RegDst    <= '1';
        s_ALUOp     <= "010";
        s_ALUSrc    <= "00";
        s_MemRead   <= '0';
        s_MemWrite  <= '0';
        s_MemtoReg  <= '0';
        s_RegWrite  <= '1';
        s_Branch    <= '0';
        s_i_Read1   <= x"00000005";
        s_i_Read2   <= x"00000006";
        s_i_ForwardA <= "00";
        s_i_ForwardB <= "00";
        s_i_WriteData <= (others => '0');
        s_i_DMem1   <= (others => '0');
        s_i_Rs      <= "00001";
        s_i_Rt      <= "00010";
        s_i_Rd      <= "00100";
        s_i_Shamt   <= "00000";
        s_i_Funct   <= "100000";
        s_i_Imm     <= x"0000";
        s_i_Extended<= (others => '0');

        wait for 2*CLK_PERIOD;

        -- Check outputs for R-type add
        -- Expect: o_ALU = 11 decimal = x"0000000B"
        assert s_o_ALU = x"0000000B" 
            report "R-Type ADD test failed. Expected 0x0000000B" severity error;
        check_signal_std("o_RegWrite", s_o_RegWrite, '1');
        check_signal_std("o_MemRead", s_o_MemRead, '0');
        check_signal_std("o_MemWrite", s_o_MemWrite, '0');
        check_signal_std("o_Branch", s_o_Branch, '0');
        check_signal("o_ALU", s_o_ALU, x"0000000B");

        report "R-Type ADD test passed.";

        ------------------------------------------------------------------------
        -- Test 2: lw instruction:
        -- lw $rt, offset($rs)
        -- ALUOp=000, RegDst='0', ALUSrc='01' (using immediate), MemRead='1'
        -- i_Extended = 4, i_Read1=0x10 => result = 0x14 after ALU
        ------------------------------------------------------------------------
        s_RegDst    <= '0';
        s_ALUOp     <= "000";
        s_ALUSrc    <= "01";
        s_MemRead   <= '1';
        s_MemWrite  <= '0';
        s_MemtoReg  <= '1';
        s_RegWrite  <= '1';
        s_Branch    <= '0';
        s_i_Read1   <= x"00000010";
        s_i_Read2   <= x"00000020"; -- just a dummy value
        s_i_ForwardA <= "00";
        s_i_ForwardB <= "00";
        s_i_WriteData <= (others => '0');
        s_i_DMem1   <= (others => '0');
        s_i_Extended<= x"00000004"; 
        s_i_Funct   <= "000000";
        wait for 2*CLK_PERIOD;

        -- Check lw ALU result: 0x10 + 0x4 = 0x14
        assert s_o_ALU = x"00000014"
            report "LW test failed. Expected 0x00000014" severity error;
        check_signal_std("o_MemRead", s_o_MemRead, '1');
        check_signal_std("o_MemWrite", s_o_MemWrite, '0');
        check_signal_std("o_MemtoReg", s_o_MemtoReg, '1');
        check_signal_std("o_RegWrite", s_o_RegWrite, '1');

        report "LW test passed.";

        ------------------------------------------------------------------------
        -- Test 3: BEQ instruction:
        -- beq $rs,$rt, offset
        -- ALUOp=001, Branch='1', ALUSrc='00', RegWrite='0', check BranchAddr
        -- Let Extended = 4, PCplus4=4 => BranchAddr = PCplus4 + (4<<2)=4+16=20=0x14
        ------------------------------------------------------------------------
        s_ALUOp     <= "001";
        s_ALUSrc    <= "00";
        s_Branch    <= '1';
        s_RegWrite  <= '0';
        s_MemRead   <= '0';
        s_MemWrite  <= '0';
        s_MemtoReg  <= '0';
        s_PCplus4   <= x"00000004";
        s_i_Extended<= x"00000004";
        s_i_Read1   <= x"00000005";
        s_i_Read2   <= x"00000005"; -- equal, so zero flag would be considered in a real hazard unit
        wait for 2*CLK_PERIOD;

        -- Check BranchAddr = 4 + (4<<2) = 4 +16 =20=0x14
        assert s_o_BranchAddr = x"00000014"
            report "BEQ test failed. Expected BranchAddr=0x00000014" severity error;
        check_signal_std("o_Branch", s_o_Branch, '1');

        report "BEQ test passed.";

        ------------------------------------------------------------------------
        -- Test 4: Forwarding test:
        -- Set ForwardA=10 and ForwardB=01
        -- This means ALU operand A from EX/MEM (i_DMem1) and operand B from MEM/WB (i_WriteData)
        -- i_DMem1 =0x0000000A, i_WriteData=0x0000000B => ALU performs ADD (R-type)
        -- Result = 0x0A + 0x0B = 0x15
        ------------------------------------------------------------------------
        s_i_Read1     <= x"000000FF"; -- ignored due to forwarding
        s_i_Read2     <= x"000000FF"; -- ignored due to forwarding
        s_i_DMem1     <= x"0000000A";
        s_i_WriteData <= x"0000000B";
        s_ForwardA    <= "10";  -- from EX/MEM
        s_ForwardB    <= "01";  -- from MEM/WB
        s_ALUOp       <= "010"; -- R-type add
        s_RegDst      <= '1';
        s_ALUSrc      <= "00"; 
        s_i_Funct     <= "100000"; -- add
        s_i_Shamt     <= "00000";
        wait for 2*CLK_PERIOD;

        -- Expect ALU result: 0x0A + 0x0B =0x15
        assert s_o_ALU = x"00000015"
            report "Forwarding test failed. Expected ALU result=0x00000015" severity error;

        report "Forwarding test passed.";

        ------------------------------------------------------------------------
        report "All tests completed successfully.";
        wait;
    end process;

end architecture;
