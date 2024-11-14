library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity EX_MEM is
    Port (
        clk          : in  STD_LOGIC;
        reset        : in  STD_LOGIC;
        WriteEn      : in  STD_LOGIC;                      -- Write enable signal
        
        -- Inputs from EX stage
        ALU_result_in : in  STD_LOGIC_VECTOR(31 downto 0);  -- ALU result
        Read_data2_in : in  STD_LOGIC_VECTOR(31 downto 0);  -- Value for store instructions
        RegDst_in     : in  STD_LOGIC_VECTOR(4 downto 0);   -- Destination register number
        MemRead_in    : in  STD_LOGIC;                      -- Control signal for memory read
        MemWrite_in   : in  STD_LOGIC;                      -- Control signal for memory write
        RegWrite_in   : in  STD_LOGIC;                      -- Control signal for register write-back
        MemToReg_in   : in  STD_LOGIC;                      -- Control signal for memory-to-register selection
        
        -- Outputs to MEM stage
        ALU_result_out : out STD_LOGIC_VECTOR(31 downto 0); -- ALU result to MEM
        Read_data2_out : out STD_LOGIC_VECTOR(31 downto 0); -- Data to be written to memory
        RegDst_out     : out STD_LOGIC_VECTOR(4 downto 0);  -- Destination register number to MEM/WB
        MemRead_out    : out STD_LOGIC;                     -- Control signal to MEM
        MemWrite_out   : out STD_LOGIC;                     -- Control signal to MEM
        RegWrite_out   : out STD_LOGIC;                     -- Control signal to MEM/WB
        MemToReg_out   : out STD_LOGIC                      -- Control signal to MEM/WB
    );
end EX_MEM;

architecture Behavioral of EX_MEM is
    -- Internal signals to hold values between clock cycles
    signal ALU_result_reg : STD_LOGIC_VECTOR(31 downto 0);
    signal Read_data2_reg : STD_LOGIC_VECTOR(31 downto 0);
    signal RegDst_reg     : STD_LOGIC_VECTOR(4 downto 0);
    signal MemRead_reg    : STD_LOGIC;
    signal MemWrite_reg   : STD_LOGIC;
    signal RegWrite_reg   : STD_LOGIC;
    signal MemToReg_reg   : STD_LOGIC;
begin

    -- Process to update pipeline register values on rising clock edge with WriteEn control
    process (clk, reset)
    begin
        if reset = '1' then
            -- Reset all register values to zero when reset is high
            ALU_result_reg <= (others => '0');
            Read_data2_reg <= (others => '0');
            RegDst_reg     <= (others => '0');
            MemRead_reg    <= '0';
            MemWrite_reg   <= '0';
            RegWrite_reg   <= '0';
            MemToReg_reg   <= '0';
        elsif rising_edge(clk) then
            -- Only update registers if WriteEn is high
            if WriteEn = '1' then
                ALU_result_reg <= ALU_result_in;
                Read_data2_reg <= Read_data2_in;
                RegDst_reg     <= RegDst_in;
                MemRead_reg    <= MemRead_in;
                MemWrite_reg   <= MemWrite_in;
                RegWrite_reg   <= RegWrite_in;
                MemToReg_reg   <= MemToReg_in;
            end if;
        end if;
    end process;

    -- Assign registered values to outputs
    ALU_result_out <= ALU_result_reg;
    Read_data2_out <= Read_data2_reg;
    RegDst_out     <= RegDst_reg;
    MemRead_out    <= MemRead_reg;
    MemWrite_out   <= MemWrite_reg;
    RegWrite_out   <= RegWrite_reg;
    MemToReg_out   <= MemToReg_reg;

end Behavioral;
