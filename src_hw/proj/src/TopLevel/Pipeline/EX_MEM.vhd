library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity EX_MEM is
    generic (N : integer := 32);

    port (
        -- Clock, Reset, and Write Enable
        i_CLK        : in  std_logic;
        i_RST        : in  std_logic;
        i_WE         : in  std_logic;

        -- Inputs from ID/EX Stage
        i_PC         : in  std_logic_vector(N-1 downto 0);
        i_ALUResult  : in  std_logic_vector(N-1 downto 0);
        i_ReadData2  : in  std_logic_vector(N-1 downto 0);
        i_RegDstAddr : in  std_logic_vector(4 downto 0);
        i_Zero       : in  std_logic;

        -- Control Signals
        i_MemRead    : in  std_logic;
        i_MemWrite   : in  std_logic;
        i_Branch     : in  std_logic;
        i_MemtoReg   : in  std_logic;
        i_RegWrite   : in  std_logic;

        -- Outputs to MEM/WB Stage
        o_ALUResult  : out std_logic_vector(N-1 downto 0);
        o_ReadData2  : out std_logic_vector(N-1 downto 0);
        o_RegDstAddr : out std_logic_vector(4 downto 0);
        o_MemtoReg   : out std_logic;
        o_RegWrite   : out std_logic;

        -- Outputs for Memory Stage
        o_MemRead    : out std_logic;
        o_MemWrite   : out std_logic;
        o_BranchAddr : out std_logic_vector(N-1 downto 0);
        o_BranchTaken: out std_logic;

        -- Data Memory Outputs
        o_DataOut    : out std_logic_vector(N-1 downto 0)
    );
end entity;

architecture structure of EX_MEM is

    -- Declare the mem component
    component mem is
        generic (
            DATA_WIDTH : natural := 32;
            ADDR_WIDTH : natural := 10
        );
        port (
            clk  : in  std_logic;
            addr : in  std_logic_vector((ADDR_WIDTH-1) downto 0);
            data : in  std_logic_vector((DATA_WIDTH-1) downto 0);
            we   : in  std_logic := '1';
            q    : out std_logic_vector((DATA_WIDTH -1) downto 0)
        );
    end component;

    -- Signals for branch and memory output
    signal s_BranchAddr : std_logic_vector(N-1 downto 0);
    signal s_DataOut    : std_logic_vector(N-1 downto 0);

begin
    -- ALU Result Register
    o_ALUResult <= i_ALUResult;
    o_ReadData2 <= i_ReadData2;
    o_RegDstAddr <= i_RegDstAddr;

    -- Control Signals
    o_MemtoReg <= i_MemtoReg;
    o_RegWrite <= i_RegWrite;
    o_MemRead  <= i_MemRead;
    o_MemWrite <= i_MemWrite;

    -- Branch Address Calculation
    s_BranchAddr <= std_logic_vector(unsigned(i_PC) + unsigned(i_ALUResult));
    o_BranchAddr <= s_BranchAddr;
    o_BranchTaken <= i_Branch and i_Zero;

    -- Data Memory Integration
    mem_inst : mem
        generic map (
            DATA_WIDTH => 32,
            ADDR_WIDTH => 10
        )
        port map (
            clk  => i_CLK,
            addr => i_ALUResult(9 downto 0), -- Address from ALUResult (10 LSBs)
            data => i_ReadData2,            -- Data to write to memory
            we   => i_MemWrite,             -- Write enable
            q    => s_DataOut               -- Data output
        );

    -- Memory data output to MEM/WB
    o_DataOut <= s_DataOut;

end architecture;

