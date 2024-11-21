library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity TB_MEM_WB is
    end TB_MEM_WB;

architecture Behavioral of TB_MEM_WB is
    component MEM_WB
        port (
            clk     : in std_logic;
            reset   : in std_logic;

            i_ALUResult : in std_logic_vector(31 downto 0);  -- ALU result to WB
            i_DataMem    : in std_logic_vector(31 downto 0);
            i_RegDst     : in std_logic_vector(4 downto 0);  -- Destination register number to Register File
            i_RegWrite   : in std_logic;
            i_MemToReg   : in std_logic;

            o_regDst    : out std_logic_vector(4 downto 0); -- Destination reguster number to register file
            o_regWrite  : out std_logic;
            o_wbData      : out std_logic_vector(31 downto 0)
        );
        end component;
        signal clk          :  std_logic := '0';
        signal reset        :  std_logic := '0';

        signal i_ALUResult  :  std_logic_vector(31 downto 0);  -- ALU result to WB
        signal i_DataMem    :  std_logic_vector(31 downto 0);
        signal i_MemToReg   :  std_logic;
        signal i_RegDst     :  std_logic_vector(4 downto 0);  -- Destination register number to Register File
        signal i_RegWrite   :  std_logic;

        signal o_regDst     :  std_logic_vector(4 downto 0); -- Destination reguster number to register file
        signal o_regWrite   :  std_logic;
        signal o_wbData     :  std_logic_vector(31 downto 0);

        constant clk_period : time := 50 ns;
    
    begin
        uut : MEM_WB port map(
            clk         => clk        ,
            reset       => reset      ,
            i_ALUResult => i_ALUResult,
            i_DataMem   => i_DataMem  ,
            i_RegDst    => i_RegDst   ,
            i_RegWrite  => i_RegWrite ,
            i_MemToReg  => i_MemToReg ,
            o_regDst    => o_regDst   ,
            o_regWrite  => o_regWrite ,
            o_wbData    => o_wbData
        );

    --clock gen
        clk_process : process
        begin
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;
        end process;

        stim_proc: process
        begin
            --reset behavior
            reset <= '1';
            wait for clk_period;
            reset <= '0';
            wait for clk_period;
            
            --apply null value to alu result and legitimate value from memory, and mux to grab the memory value
            i_ALUResult <= X"AAAAAAAA";
            i_DataMem   <= X"00000010";
            i_MemToReg  <= '1';
            i_RegDst    <= "00001";
            i_RegWrite  <= '1';
            wait for clk_period;

            --assert values
     
            assert o_wbData   = X"00000010"     report "o_wbData    mismatch on test 1";
            assert i_MemToReg  = '1'            report "i_MemToReg  mismatch on test 1";
            assert i_RegDst    = "00001"        report "i_RegDst    mismatch on test 1";
            assert i_RegWrite  = '1'            report "i_RegWrite  mismatch on test 1";
                   

            --apply null to mem and legitimate value from alu, mux to grab alu result
            i_ALUResult <= X"00000010";
            i_DataMem   <= X"AAAAAAAA";
            i_MemToReg  <= '0';
            i_RegDst    <= "00001";
            i_RegWrite  <= '1';
            wait for clk_period;

            --assert values
            assert o_wbData = X"00000010"       report "o_wbData    mismatch on test 2";       
            assert i_MemToReg  = '1'            report "i_MemToReg  mismatch on test 2";
            assert i_RegDst    = "00001"        report "i_RegDst    mismatch on test 2";
            assert i_RegWrite  = '1'            report "i_RegWrite  mismatch on test 2";

            --check to see if regwrite and regdst are properly passed
            i_RegDst    <= "00100";
            i_RegWrite  <= '0';
            wait for clk_period;
        
            --assert values
            assert i_RegDst    = "00100"        report "i_RegDst    mismatch on test 3";
            assert i_RegWrite  = '0'            report "i_RegWrite  mismatch on test 3";
        end process;
end Behavioral;