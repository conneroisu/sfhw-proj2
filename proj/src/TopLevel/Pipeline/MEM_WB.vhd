library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity MEM_WB is
    port (
        clk        : in std_logic;
        reset      : in std_logic;
        i_ALUResult : in std_logic_vector(31 downto 0);  -- ALU result to WB
        i_DataMem   : in std_logic_vector(31 downto 0);  -- Data from memory
        i_RegDst    : in std_logic_vector(4 downto 0);   -- Destination register number
        i_RegWrite  : in std_logic;
        i_MemToReg  : in std_logic;                     -- MUX select signal
        o_regDst    : out std_logic_vector(4 downto 0); -- Destination register output
        o_regWrite  : out std_logic;                    -- Write enable output
        o_wbData    : out std_logic_vector(31 downto 0) -- Data to write back
    );
end MEM_WB;

architecture structural of MEM_WB is

    -- Internal signals for the pipeline registers
    signal ALUreg       : std_logic_vector(31 downto 0) := (others => '0');
    signal DataMemReg   : std_logic_vector(31 downto 0) := (others => '0');
    signal RegDstReg    : std_logic_vector(4 downto 0) := (others => '0');
    signal RegWrite_reg : std_logic := '0';
    signal MemToReg_reg : std_logic := '0';

    -- MUX component declaration
    component mux2t1_N is
        port (
            i_S  : in  std_logic;                         -- Select input
            i_D0 : in  std_logic_vector(31 downto 0);     -- Input 0
            i_D1 : in  std_logic_vector(31 downto 0);     -- Input 1
            o_O  : out std_logic_vector(31 downto 0)      -- Output
        );
    end component;

begin

    -- Pipeline behavior: Capturing inputs on clock edge
    process(clk, reset)
    begin
        if reset = '1' then
            -- Reset all registers
            ALUreg       <= (others => '0');
            DataMemReg   <= (others => '0');
            RegDstReg    <= (others => '0');
            RegWrite_reg <= '0';
            MemToReg_reg <= '0';
        elsif rising_edge(clk) then
            -- Latch input signals, this looks like d flip flops inside the schematic
            -- Need to pipe the values regardless, as this is creating a 1 clock cycle delay, which I don't want.
            -- How could I make this store values with DFF's, but also pass along to avoid the delay? is the delay intrinsic to DFF's?
            ALUreg       <= i_ALUResult;
            DataMemReg   <= i_DataMem;
            RegDstReg    <= i_RegDst;
            RegWrite_reg <= i_RegWrite;
            MemToReg_reg <= i_MemToReg;
        end if;

        -- Output assignments
        o_regDst   <= RegDstReg;
        o_regWrite <= RegWrite_reg;
        o_wbData <= ALUreg; -- For testing purposes
    end process;



    -- MUX instantiation to generate o_wbData
    MemToRegMux : mux2t1_N
        port map (
            i_S  => MemToReg_reg,   -- Select signal from pipeline register
            i_D0 => ALUreg,         -- ALU result from pipeline register
            i_D1 => DataMemReg,     -- Data memory result from pipeline register
            o_O  => o_wbData        -- Final write-back data
        );

end structural;
