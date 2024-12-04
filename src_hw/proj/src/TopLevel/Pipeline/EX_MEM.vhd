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

        -- Inputs from EX Stage
        i_PC         : in  std_logic_vector(N-1 downto 0);
        i_ALUResult  : in  std_logic_vector(N-1 downto 0);
        i_ReadData2  : in  std_logic_vector(N-1 downto 0);
        i_RegDstAddr : in  std_logic_vector(4 downto 0);
        i_Zero       : in  std_logic;

        -- Control Signals from EX Stage
        i_MemRead    : in  std_logic;
        i_MemWrite   : in  std_logic;
        i_Branch     : in  std_logic;
        i_MemtoReg   : in  std_logic;
        i_RegWrite   : in  std_logic;

        -- Outputs to MEM Stage
        o_ALUResult  : out std_logic_vector(N-1 downto 0);
        o_ReadData2  : out std_logic_vector(N-1 downto 0);
        o_RegDstAddr : out std_logic_vector(4 downto 0);
        o_MemtoReg   : out std_logic;
        o_RegWrite   : out std_logic;

        -- Outputs for Control and Data Memory
        o_MemRead    : out std_logic;
        o_MemWrite   : out std_logic;
        o_BranchAddr : out std_logic_vector(N-1 downto 0);
        o_BranchTaken: out std_logic;
        o_DataOut    : out std_logic_vector(N-1 downto 0)
    );
end entity;

architecture structure of EX_MEM is

    -- Signal for branch address calculation
    signal s_BranchAddr : std_logic_vector(N-1 downto 0);
    signal s_DataOut    : std_logic_vector(N-1 downto 0);

    -- Intermediate signals for single-bit control signals
    signal s_MemtoReg   : std_logic_vector(0 downto 0);
    signal s_RegWrite   : std_logic_vector(0 downto 0);
    signal s_MemRead    : std_logic_vector(0 downto 0);
    signal s_MemWrite   : std_logic_vector(0 downto 0);

    -- Temporary signals for direct assignments to pipeline registers
    signal tmp_MemtoReg : std_logic_vector(0 downto 0);
    signal tmp_RegWrite : std_logic_vector(0 downto 0);
    signal tmp_MemRead  : std_logic_vector(0 downto 0);
    signal tmp_MemWrite : std_logic_vector(0 downto 0);

    -- Component for dffg_n (Pipeline Register)
    component dffg_n is
        generic (N : integer := 32);
        port (
            i_CLK : in  std_logic;
            i_RST : in  std_logic;
            i_WrE : in  std_logic;
            i_D   : in  std_logic_vector(N-1 downto 0);
            o_Q   : out std_logic_vector(N-1 downto 0)
        );
    end component;

    -- Data Memory Component
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
        q    : out std_logic_vector((DATA_WIDTH-1) downto 0)
    );
end component;


begin
    -- Temporary signals assignments
    tmp_MemtoReg <= (0 => i_MemtoReg);
    tmp_RegWrite <= (0 => i_RegWrite);
    tmp_MemRead  <= (0 => i_MemRead);
    tmp_MemWrite <= (0 => i_MemWrite);

    -- Pipeline Registers
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

    MemtoReg_reg : dffg_n
        generic map (1)
        port map (
            i_CLK => i_CLK,
            i_RST => i_RST,
            i_WrE => i_WE,
            i_D   => tmp_MemtoReg,
            o_Q   => s_MemtoReg
        );
    o_MemtoReg <= s_MemtoReg(0);

    RegWrite_reg : dffg_n
        generic map (1)
        port map (
            i_CLK => i_CLK,
            i_RST => i_RST,
            i_WrE => i_WE,
            i_D   => tmp_RegWrite,
            o_Q   => s_RegWrite
        );
    o_RegWrite <= s_RegWrite(0);

    MemRead_reg : dffg_n
        generic map (1)
        port map (
            i_CLK => i_CLK,
            i_RST => i_RST,
            i_WrE => i_WE,
            i_D   => tmp_MemRead,
            o_Q   => s_MemRead
        );
    o_MemRead <= s_MemRead(0);

    MemWrite_reg : dffg_n
        generic map (1)
        port map (
            i_CLK => i_CLK,
            i_RST => i_RST,
            i_WrE => i_WE,
            i_D   => tmp_MemWrite,
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

    -- Branch Address Calculation
    s_BranchAddr <= std_logic_vector(unsigned(i_PC) + unsigned(i_ALUResult));

    -- Branch Taken Logic
    o_BranchTaken <= i_Branch and i_Zero;

    -- DMEM Instance
   dmem_inst : mem
    generic map (
        DATA_WIDTH => 32,
        ADDR_WIDTH => 10
    )
    port map (
        clk  => i_CLK,
        addr => i_ALUResult(9 downto 0), -- Address width matches ADDR_WIDTH
        data => i_ReadData2,            -- Data input for writing
        we   => s_MemWrite(0),          -- Write enable from control signal
        q    => s_DataOut               -- Data output from memory
    );


    -- Pass Data Memory Output
    o_DataOut <= s_DataOut;

end structure;

