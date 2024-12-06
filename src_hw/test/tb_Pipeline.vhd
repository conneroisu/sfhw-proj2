library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
library std;
use std.env.all;
use std.textio.all;

entity tb_Pipeline is
    generic(gCLK_HPER : time := 10 ns);
end tb_Pipeline;

architecture behavior of tb_Pipeline is
    constant cCLK_PER : time := gCLK_HPER * 2;

    component Pipeline_IF_ID is
        port (
            i_CLK         : in  std_logic;
            i_RST         : in  std_logic;
            i_Stall       : in  std_logic;
            i_PC4         : in  std_logic_vector(31 downto 0);
            i_Instruction : in  std_logic_vector(31 downto 0);
            o_PC4         : out std_logic_vector(31 downto 0);
            o_Instruction : out std_logic_vector(31 downto 0)
        );
    end component;

    component Pipeline_ID_EX is
        port (
            i_CLK               : in  std_logic;
            i_Reset             : in  std_logic;
            i_Stall             : in  std_logic;
            i_PC4               : in  std_logic_vector(31 downto 0);
            i_RegisterFileReadA : in  std_logic_vector(31 downto 0);
            i_RegisterFileReadB : in  std_logic_vector(31 downto 0);
            i_ImmediateExtended : in  std_logic_vector(31 downto 0);
            i_IDRt              : in  std_logic_vector(4 downto 0);
            i_IDRd              : in  std_logic_vector(4 downto 0);
            i_RegDst            : in  std_logic;
            i_RegWrite          : in  std_logic;
            i_MemToReg          : in  std_logic;
            i_MemWrite          : in  std_logic;
            i_ALUSrc            : in  std_logic;
            i_ALUOp             : in  std_logic_vector(3 downto 0);
            i_Jal               : in  std_logic;
            i_Halt              : in  std_logic;
            i_RS                : in  std_logic_vector(4 downto 0);
            i_MEMRd             : in  std_logic;
            o_RS                : out std_logic_vector(4 downto 0);
            o_PC4               : out std_logic_vector(31 downto 0);
            o_RegisterFileReadA : out std_logic_vector(31 downto 0);
            o_RegisterFileReadB : out std_logic_vector(31 downto 0);
            o_ImmediateExtended : out std_logic_vector(31 downto 0);
            o_Rt                : out std_logic_vector(4 downto 0);
            o_Rd                : out std_logic_vector(4 downto 0);
            o_RegDst            : out std_logic;
            o_RegWrite          : out std_logic;
            o_memToReg          : out std_logic;
            o_MemWrite          : out std_logic;
            o_ALUSrc            : out std_logic;
            o_ALUOp             : out std_logic_vector(3 downto 0);
            o_Jal               : out std_logic;
            o_Halt              : out std_logic;
            o_MEMRd             : out std_logic
        );
    end component;

    component Pipeline_EX_MEM is
        port (
            i_CLK      : in  std_logic;
            i_RST      : in  std_logic;
            i_stall    : in  std_logic;
            i_ALU      : in  std_logic_vector(31 downto 0);
            i_B        : in  std_logic_vector(31 downto 0);
            i_WrAddr   : in  std_logic_vector(4 downto 0);
            i_MemWr    : in  std_logic;
            i_MemtoReg : in  std_logic;
            i_Halt     : in  std_logic;
            i_RegWr    : in  std_logic;
            i_Jal      : in  std_logic;
            i_PC4      : in  std_logic_vector(31 downto 0);
            o_ALU      : out std_logic_vector(31 downto 0);
            o_B        : out std_logic_vector(31 downto 0);
            o_WrAddr   : out std_logic_vector(4 downto 0);
            o_MemWr    : out std_logic;
            o_MemtoReg : out std_logic;
            o_Halt     : out std_logic;
            o_RegWr    : out std_logic;
            o_Jal      : out std_logic;
            o_PC4      : out std_logic_vector(31 downto 0)
        );
    end component;

    component Pipeline_MEM_WB is
        port (
            i_CLK      : in  std_logic;
            i_RST      : in  std_logic;
            i_stall    : in  std_logic;
            i_ALU      : in  std_logic_vector(31 downto 0);
            i_Mem      : in  std_logic_vector(31 downto 0);
            i_WrAddr   : in  std_logic_vector(4 downto 0);
            i_MemtoReg : in  std_logic;
            i_Halt     : in  std_logic;
            i_RegWr    : in  std_logic;
            i_Jal      : in  std_logic;
            i_PC4      : in  std_logic_vector(31 downto 0);
            o_ALU      : out std_logic_vector(31 downto 0);
            o_Mem      : out std_logic_vector(31 downto 0);
            o_WrAddr   : out std_logic_vector(4 downto 0);
            o_MemtoReg : out std_logic;
            o_Halt     : out std_logic;
            o_RegWr    : out std_logic;
            o_Jal      : out std_logic;
            o_PC4      : out std_logic_vector(31 downto 0)
        );
    end component;

    signal CLK, reset : std_logic := '0';
    signal reset_done : std_logic := '0';

    signal IF_ID_PC4, IF_ID_Instruction : std_logic_vector(31 downto 0);
    signal ID_EX_PC4, ID_EX_RegisterFileReadA, ID_EX_RegisterFileReadB, ID_EX_ImmediateExtended : std_logic_vector(31 downto 0);
    signal ID_EX_Rt, ID_EX_Rd, ID_EX_RS : std_logic_vector(4 downto 0);
    signal ID_EX_RegDst, ID_EX_RegWrite, ID_EX_MemToReg, ID_EX_MemWrite, ID_EX_ALUSrc, ID_EX_Jal, ID_EX_Halt, ID_EX_MEMRd : std_logic;
    signal ID_EX_ALUOp : std_logic_vector(3 downto 0);

    signal EX_MEM_ALU, EX_MEM_B : std_logic_vector(31 downto 0);
    signal EX_MEM_WrAddr : std_logic_vector(4 downto 0);
    signal EX_MEM_MemWr, EX_MEM_MemtoReg, EX_MEM_Halt, EX_MEM_RegWr, EX_MEM_Jal : std_logic;
    signal EX_MEM_PC4 : std_logic_vector(31 downto 0);

    signal MEM_WB_ALU, MEM_WB_Mem : std_logic_vector(31 downto 0);
    signal MEM_WB_WrAddr : std_logic_vector(4 downto 0);
    signal MEM_WB_MemtoReg, MEM_WB_Halt, MEM_WB_RegWr, MEM_WB_Jal : std_logic;
    signal MEM_WB_PC4 : std_logic_vector(31 downto 0);

begin
    UUT_IF_ID : Pipeline_IF_ID
        port map (
            i_CLK         => CLK,
            i_RST         => reset,
            i_Stall       => '0',
            i_PC4         => x"00000004",
            i_Instruction => x"00000000",
            o_PC4         => IF_ID_PC4,
            o_Instruction => IF_ID_Instruction
        );

    UUT_ID_EX : Pipeline_ID_EX
        port map (
            i_CLK               => CLK,
            i_Reset             => reset,
            i_Stall             => '0',
            i_PC4               => IF_ID_PC4,
            i_RegisterFileReadA => x"00000000",
            i_RegisterFileReadB => x"00000000",
            i_ImmediateExtended => x"00000000",
            i_IDRt              => "00000",
            i_IDRd              => "00000",
            i_RegDst            => '0',
            i_RegWrite          => '0',
            i_MemToReg          => '0',
            i_MemWrite          => '0',
            i_ALUSrc            => '0',
            i_ALUOp             => "0000",
            i_Jal               => '0',
            i_Halt              => '0',
            i_RS                => "00000",
            i_MEMRd             => '0',
            o_RS                => ID_EX_RS,
            o_PC4               => ID_EX_PC4,
            o_RegisterFileReadA => ID_EX_RegisterFileReadA,
            o_RegisterFileReadB => ID_EX_RegisterFileReadB,
            o_ImmediateExtended => ID_EX_ImmediateExtended,
            o_Rt                => ID_EX_Rt,
            o_Rd                => ID_EX_Rd,
            o_RegDst            => ID_EX_RegDst,
            o_RegWrite          => ID_EX_RegWrite,
            o_memToReg          => ID_EX_MemToReg,
            o_MemWrite          => ID_EX_MemWrite,
            o_ALUSrc            => ID_EX_ALUSrc,
            o_ALUOp             => ID_EX_ALUOp,
            o_Jal               => ID_EX_Jal,
            o_Halt              => ID_EX_Halt,
            o_MEMRd             => ID_EX_MEMRd
        );

    UUT_EX_MEM : Pipeline_EX_MEM
        port map (
            i_CLK      => CLK,
            i_RST      => reset,
            i_stall    => '0',
            i_ALU      => ID_EX_RegisterFileReadA,
            i_B        => ID_EX_RegisterFileReadB,
            i_WrAddr   => ID_EX_Rt,
            i_MemWr    => ID_EX_MemWrite,
            i_MemtoReg => ID_EX_MemToReg,
            i_Halt     => ID_EX_Halt,
            i_RegWr    => ID_EX_RegWrite,
            i_Jal      => ID_EX_Jal,
            i_PC4      => ID_EX_PC4,
            o_ALU      => EX_MEM_ALU,
            o_B        => EX_MEM_B,
            o_WrAddr   => EX_MEM_WrAddr,
            o_MemWr    => EX_MEM_MemWr,
            o_MemtoReg => EX_MEM_MemtoReg,
            o_Halt     => EX_MEM_Halt,
            o_RegWr    => EX_MEM_RegWr,
            o_Jal      => EX_MEM_Jal,
            o_PC4      => EX_MEM_PC4
        );

    UUT_MEM_WB : Pipeline_MEM_WB
        port map (
            i_CLK      => CLK,
            i_RST      => reset,
            i_stall    => '0',
            i_ALU      => EX_MEM_ALU,
            i_Mem      => EX_MEM_B,
            i_WrAddr   => EX_MEM_WrAddr,
            i_MemtoReg => EX_MEM_MemtoReg,
            i_Halt     => EX_MEM_Halt,
            i_RegWr    => EX_MEM_RegWr,
            i_Jal      => EX_MEM_Jal,
            i_PC4      => EX_MEM_PC4,
            o_ALU      => MEM_WB_ALU,
            o_Mem      => MEM_WB_Mem,
            o_WrAddr   => MEM_WB_WrAddr,
            o_MemtoReg => MEM_WB_MemtoReg,
            o_Halt     => MEM_WB_Halt,
            o_RegWr    => MEM_WB_RegWr,
            o_Jal      => MEM_WB_Jal,
            o_PC4      => MEM_WB_PC4
        );

    P_CLK : process
    begin
        CLK <= '1';
        wait for gCLK_HPER;
        CLK <= '0';
        wait for gCLK_HPER;
    end process;

    P_RST : process
    begin
        reset      <= '0';
        wait for gCLK_HPER / 2;
        reset      <= '1';
        wait for gCLK_HPER * 2;
        reset      <= '0';
        reset_done <= '1';
        wait;
    end process;

    P_VERIFY_VALUES : process
    begin
        wait until rising_edge(CLK);
        assert (MEM_WB_ALU = x"00000000") report "Value mismatch in MEM_WB_ALU" severity error;
        assert (MEM_WB_Mem = x"00000000") report "Value mismatch in MEM_WB_Mem" severity error;
        assert (MEM_WB_WrAddr = "00000") report "Value mismatch in MEM_WB_WrAddr" severity error;
        assert (MEM_WB_MemtoReg = '0') report "Value mismatch in MEM_WB_MemtoReg" severity error;
        assert (MEM_WB_Halt = '0') report "Value mismatch in MEM_WB_Halt" severity error;
        assert (MEM_WB_RegWr = '0') report "Value mismatch in MEM_WB_RegWr" severity error;
        assert (MEM_WB_Jal = '0') report "Value mismatch in MEM_WB_Jal" severity error;
        assert (MEM_WB_PC4 = x"00000004") report "Value mismatch in MEM_WB_PC4" severity error;
        wait;
    end process;

    P_TEST_STALL_FLUSH : process
    begin
        wait until rising_edge(CLK);
        assert (IF_ID_PC4 = x"00000004") report "Stall/Flush test failed for IF_ID_PC4" severity error;
        assert (IF_ID_Instruction = x"00000000") report "Stall/Flush test failed for IF_ID_Instruction" severity error;
        wait;
    end process;
end behavior;
