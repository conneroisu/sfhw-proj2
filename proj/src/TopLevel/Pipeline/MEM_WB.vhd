--not sure what size we are storing in the datamem, assuming 32 bits per address

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity MEM_WB is
    port (
        clk     : in std_logic;
        reset   : in std_logic;
        WriteEn : in std_logic;         -- Write enable signal


        ALU_result_in : in std_logic_vector(31 downto 0);  -- ALU result to WB
        DataMem_in    : in std_logic_vector(31 downto 0);
        RegDst_in     : in std_logic_vector(4 downto 0);  -- Destination register number to Register File
        RegWrite_in   : in std_logic;
        MemToReg_in   : in std_logic;

        -- Outputs to WB stage
        ALU_result_out: out std_logic_vector(31 downto 0);  -- ALU result to WB
        DataMem_out   : out std_logic_vector(31 downto 0);
        RegDst_out    : out std_logic_vector(4 downto 0); -- Destination reguster number to register file
        RegWrite_out  : out std_logic;
        MemToReg_out  : out std_logic
    );
end MEM_WB;

architecture behavioral of MEM_WB is
    -- Internal signals to hold values b/twn clock cycles
    signal ALUreg       : std_logic_vector(31 downto 0); 
    signal DataMemReg   : std_logic_vector(31 downto 0);
    signal RegDstReg    : std_logic_vector(4 downto 0); 
    signal RegWrite_reg  : std_logic;     
    signal MemToReg_reg  : std_logic;
begin
    process(clk, reset)
    begin
        if reset = '1' then
            --reset all registers to 0 if reset is high
            ALUreg <= (others => '0');
            DataMemReg  <= (others => '0');
            RegDstReg   <= (others => '0');
            RegWrite_reg <= '0';
            MemToReg_reg <= '0';
        elsif rising_edge(clk) then
            ALUreg <= ALU_result_in;
            DataMemReg  <= DataMem_in;
            RegDstReg   <= RegDst_in;
            RegWrite_reg <= RegWrite_in;
            MemToReg_reg <= MemToReg_in;
        end if;
    end process;

    ALU_result_out <= ALUreg;
    DataMem_out   <= DataMemReg;
    RegDst_out    <= RegDstReg;
    RegWrite_out  <= RegWrite_reg;
    MemToReg_out  <= MemToReg_reg;

end behavioral;
            