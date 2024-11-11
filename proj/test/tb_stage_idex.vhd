library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_stage_idex is
end entity tb_stage_idex;

architecture Behavioral of tb_stage_idex is

    component stage_idex is
        generic(N : integer := 32);
        port (
            -- Common Stage Signals [begin]
            i_CLK      : in  std_logic;
            i_RST      : in  std_logic;
            i_WE       : in  std_logic;
            i_PC       : in  std_logic_vector(N-1 downto 0);
            o_PC       : out std_logic_vector(N-1 downto 0);
            i_PCplus4  : in  std_logic_vector(N-1 downto 0);
            o_PCplus4  : out std_logic_vector(N-1 downto 0);
            -- Control Signals [begin]
            --= Stage Specific Signals [begin]
            -- ex:     RegDst  ALUOp  ALUSrc
            -- R-Type:   1      10      00
            -- lw    :   0      00      01
            -- sw    :   x      00      01
            -- beq   :   x      01      00
            i_RegDst   : in  std_logic_vector(4 downto 0);
            i_ALUOp    : in  std_logic_vector(1 downto 0);
            i_ALUSrc   : in  std_logic_vector(1 downto 0);
            -- Future Stage Signals [begin]
            -- see: https://private-user-images.githubusercontent.com/88785126/384028866-8e8d5e84-ca22-462e-8b85-ea1c00c43e8f.png
            --== Memory Stage Control Signals [begin]
            i_MemRead  : in  std_logic;
            o_MemRead  : out std_logic;
            i_MemWrite : in  std_logic;
            o_MemWrite : out std_logic;
            i_PCSrc    : in  std_logic_vector(1 downto 0);
            o_PCSrc    : out std_logic_vector(1 downto 0);
            --== Write Back Stage Control Signals [begin]
            i_RegWrite : in  std_logic;
            i_MemToReg : in  std_logic;
            o_RegWrite : out std_logic;
            o_MemToReg : out std_logic;
            -- Stage Passthrough Signals [begin]
            --= Forwarding Signals [begin]
            i_WriteData : in  std_logic_vector(N-1 downto 0); -- Data from the end of writeback stage's mux
            i_DMem1     : in  std_logic_vector(N-1 downto 0); -- Data from the first input to the DMem
            --= Register File Signals [begin]
            i_Read1    : in  std_logic_vector(N-1 downto 0);
            i_Read2    : in  std_logic_vector(N-1 downto 0);
            o_Read1    : out std_logic_vector(N-1 downto 0);
            o_Read2    : out std_logic_vector(N-1 downto 0);
            --= Sign Extend Signals [begin]
            i_Extended : in  std_logic_vector(N-1 downto 0);
            o_Extended : out std_logic_vector(N-1 downto 0);
            --= Instruction Memory Signals [begin]
            i_Rd       : in  std_logic_vector(4 downto 0);  -- I-bits[11-15] into RegDstMux (bits[4-0])
            i_Rt       : in  std_logic_vector(4 downto 0)  --- I-bits[16-20] into RegDstMux and Register (bits[4-0])
            );
    end component;
begin

    
end architecture Behavioral;
