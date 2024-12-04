-- <header>
-- Author(s): Conner Ohnesorge
-- Name: 
-- Notes:
--      Conner Ohnesorge 2024-12-01T22:55:31-06:00 add-daniels-changes
--      Conner Ohnesorge 2024-12-01T12:19:14-06:00 moved-all-files-into-the-hardware-directory
-- </header>

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity EX_MEM is
    generic (N : integer := 32);        -- Default data width for buses

    port (
        -- Clock, Reset, and Write Enable
        i_CLK : in std_logic;
        i_RST : in std_logic;
        i_WE  : in std_logic;           -- Write enable for EX/MEM registers
        -- Inputs from ID/EX Stage
        i_PC         : in std_logic_vector(N-1 downto 0);
        i_ALUResult  : in std_logic_vector(N-1 downto 0);
        i_ReadData2  : in std_logic_vector(N-1 downto 0);
        i_RegDstAddr : in std_logic_vector(4 downto 0);  -- Destination register address
        i_Zero       : in std_logic;    -- Zero flag from ALU
        -- Control Signals
        i_MemRead  : in std_logic;
        i_MemWrite : in std_logic;
        i_Branch   : in std_logic;
        i_MemtoReg : in std_logic;
        i_RegWrite : in std_logic;
        -- Outputs to MEM/WB Stage
        o_ALUResult  : out std_logic_vector(N-1 downto 0);
        o_ReadData2  : out std_logic_vector(N-1 downto 0);
        o_RegDstAddr : out std_logic_vector(4 downto 0);
        o_MemtoReg   : out std_logic;
        o_RegWrite   : out std_logic;
        -- Outputs for Memory Stage
        o_MemRead     : out std_logic;
        o_MemWrite    : out std_logic;
        o_BranchAddr  : out std_logic_vector(N-1 downto 0);  -- Branch address for PC update
        o_BranchTaken : out std_logic   -- Indicates if branch is taken
        );
    
end entity;

architecture structure of EX_MEM is

    -- Signal for branch address calculation
    signal s_BranchAddr : std_logic_vector(N-1 downto 0);

    -- Intermediate signals for single-bit control signals
    signal s_MemtoReg : std_logic_vector(0 downto 0);
    signal s_RegWrite : std_logic_vector(0 downto 0);
    signal s_MemRead  : std_logic_vector(0 downto 0);
    signal s_MemWrite : std_logic_vector(0 downto 0);

    -- Component for dffg_n (Pipeline Register)
    component dffg_n is
        generic (N : integer := 32);
        port (
            i_CLK : in  std_logic;
            i_RST : in  std_logic;
            i_WrE : in  std_logic;      -- Write Enable for the register
            i_D   : in  std_logic_vector(N-1 downto 0);
            o_Q   : out std_logic_vector(N-1 downto 0)
            );
    end component;

begin
    -- Pipeline registers to store stage-specific values
    ALUResult_reg : dffg_n
        generic map (N)
        port map (
            i_CLK => i_CLK,
            i_RST => i_RST,
            i_WrE => i_WE,
            i_D   => i_ALUResult,
            o_Q   => o_ALUResult
            );

    ReadData2_reg : dffg_n
        generic map (N)
        port map (
            i_CLK => i_CLK,
            i_RST => i_RST,
            i_WrE => i_WE,
            i_D   => i_ReadData2,
            o_Q   => o_ReadData2
            );

    RegDstAddr_reg : dffg_n
        generic map (5)
        port map (
            i_CLK => i_CLK,
            i_RST => i_RST,
            i_WrE => i_WE,
            i_D   => i_RegDstAddr,
            o_Q   => o_RegDstAddr
            );

    -- Assign single-bit control signals to 1-bit vectors
    s_MemtoReg <= (0 => i_MemtoReg);
    s_RegWrite <= (0 => i_RegWrite);
    s_MemRead  <= (0 => i_MemRead);
    s_MemWrite <= (0 => i_MemWrite);

    MemtoReg_reg : dffg_n
        generic map (1)
        port map (
            i_CLK => i_CLK,
            i_RST => i_RST,
            i_WrE => i_WE,
            i_D   => s_MemtoReg,
            o_Q   => s_MemtoReg
            );
    o_MemtoReg <= s_MemtoReg(0);

    RegWrite_reg : dffg_n
        generic map (1)
        port map (
            i_CLK => i_CLK,
            i_RST => i_RST,
            i_WrE => i_WE,
            i_D   => s_RegWrite,
            o_Q   => s_RegWrite
            );
    o_RegWrite <= s_RegWrite(0);

    MemRead_reg : dffg_n
        generic map (1)
        port map (
            i_CLK => i_CLK,
            i_RST => i_RST,
            i_WrE => i_WE,
            i_D   => s_MemRead,
            o_Q   => s_MemRead
            );
    o_MemRead <= s_MemRead(0);

    MemWrite_reg : dffg_n
        generic map (1)
        port map (
            i_CLK => i_CLK,
            i_RST => i_RST,
            i_WrE => i_WE,
            i_D   => s_MemWrite,
            o_Q   => s_MemWrite
            );
    o_MemWrite <= s_MemWrite(0);

    BranchAddr_reg : dffg_n
        generic map (N)
        port map (
            i_CLK => i_CLK,
            i_RST => i_RST,
            i_WrE => i_WE,
            i_D   => s_BranchAddr,
            o_Q   => o_BranchAddr
            );

    -- Calculate branch address
    s_BranchAddr <= std_logic_vector(unsigned(i_PC) + unsigned(i_ALUResult));

    -- Branch Taken Signal
    o_BranchTaken <= i_Branch and i_Zero;

end structure;

