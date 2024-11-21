--not sure what size we are storing in the datamem, assuming 32 bits per address

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity MEM_WB is
    port (
        clk     : in std_logic;
        reset   : in std_logic;
        --WriteEn : in std_logic;         -- Write enable signal


        i_ALUResult : in std_logic_vector(31 downto 0);  -- ALU result to WB
        i_DataMem    : in std_logic_vector(31 downto 0);
        i_RegDst     : in std_logic_vector(4 downto 0);  -- Destination register number to Register File
        i_RegWrite   : in std_logic;
        i_MemToReg   : in std_logic;

        -- Outputs to WB stage
        --ALU_result_out: out std_logic_vector(31 downto 0);  -- ALU result to WB
        --DataMem_out   : out std_logic_vector(31 downto 0);
        o_regDst    : out std_logic_vector(4 downto 0); -- Destination reguster number to register file
        o_regWrite  : out std_logic;
        o_wbData      : out std_logic_vector(31 downto 0)
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
            ALUreg <= i_ALUResult;
            DataMemReg  <= i_DataMem;
            RegDstReg   <= i_RegDst;
            RegWrite_reg <= i_RegWrite;
            --MemToReg_reg <= i_MemToReg; this should be the muxed value
        end if;
    end process;

    --ALU_result_out <= ALUreg;
    --DataMem_out   <= DataMemReg;
    o_regDst    <= RegDstReg;
    o_regWrite  <= RegWrite_reg;
    --o_wbData  <= MemToReg_reg;

end behavioral;

architecture structural of MEM_WB is

    component mux2t1_N is
        port(
        i_S  : in  std_logic;           -- Select input.
        i_D0 : in  std_logic_vector(N - 1 downto 0);  -- Input data width is N.
        i_D1 : in  std_logic_vector(N - 1 downto 0);  -- Input data width is N.
        o_O  : out std_logic_vector(N - 1 downto 0)  -- Output data width is N.
        );
    end component;
    
begin
    MemToRegMux : mux2t1_N
        port map (
            i_d0 => i_ALUResult,
            i_d1 => i_DataMem,
            i_S => i_MemToReg,
            o_O => o_wbData
            );       
    
end structural;
            