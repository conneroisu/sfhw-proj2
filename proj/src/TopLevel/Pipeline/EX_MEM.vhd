-- <header>
-- Author(s): Kariniux, Conner Ohnesorge
-- Name: proj/src/TopLevel/Pipeline/EX_MEM.vhd
-- Notes:
--      Kariniux 2024-11-21T09:04:48-06:00 pushing-pulling
--      Conner Ohnesorge 2024-11-18T10:07:32-06:00 rename-stages-to-pipeline-remove-back-up-file-and-add-space-for
-- </header>

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity EX_MEM is
    port (
        clk     : in std_logic;
        reset   : in std_logic;
        WriteEn : in std_logic;         -- Write enable signal

        -- Inputs from EX stage
        ALU_result_in : in std_logic_vector(31 downto 0);  -- ALU result
        Read_data2_in : in std_logic_vector(31 downto 0);  -- Value for store instructions
        RegDst_in     : in std_logic_vector(4 downto 0);  -- Destination register number
        MemRead_in    : in std_logic;   -- Control signal for memory read
        MemWrite_in   : in std_logic;   -- Control signal for memory write
        RegWrite_in   : in std_logic;  -- Control signal for register write-back
        MemToReg_in   : in std_logic;  -- Control signal for memory-to-register selection

        -- Outputs to MEM stage
        ALU_result_out : out std_logic_vector(31 downto 0);  -- ALU result to MEM
        Read_data2_out : out std_logic_vector(31 downto 0);  -- Data to be written to memory
        RegDst_out     : out std_logic_vector(4 downto 0);  -- Destination register number to MEM/WB
        MemRead_out    : out std_logic;  -- Control signal to MEM
        MemWrite_out   : out std_logic;  -- Control signal to MEM
        RegWrite_out   : out std_logic;  -- Control signal to MEM/WB
        MemToReg_out   : out std_logic  -- Control signal to MEM/WB
        );
end EX_MEM;

architecture Behavioral of EX_MEM is
    -- Internal signals to hold values between clock cycles
    signal ALU_result_reg : std_logic_vector(31 downto 0);
    signal Read_data2_reg : std_logic_vector(31 downto 0);
    signal RegDst_reg     : std_logic_vector(4 downto 0);
    signal MemRead_reg    : std_logic;
    signal MemWrite_reg   : std_logic;
    signal RegWrite_reg   : std_logic;
    signal MemToReg_reg   : std_logic;
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

