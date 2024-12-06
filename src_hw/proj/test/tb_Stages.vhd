
library ieee;
use ieee.std_logic_1164.all;

entity tb_Stages is
    generic (
        gclk_hper : time := 50 ns
        );
end entity tb_Stages;

architecture behavior of tb_stages is
    
    -- Calculate the clock period as twice the half-period
    constant cclk_per : time := gclk_hper * 2;
    
    component IF_ID is
        port (
            i_CLK         : in  std_logic;
            i_RST         : in  std_logic;
            i_Stall       : in  std_logic;
            i_PC4         : in  std_logic_vector(31 downto 0);
            i_Instruction : in  std_logic_vector(31 downto 0);
            o_PC4         : out std_logic_vector(31 downto 0);
            o_Instruction : out std_logic_vector(31 downto 0)
            );
    end component;
    
    component ID_EX is

        port (
                i_CLK               : in  std_logic;
                i_Reset             : in  std_logic;
                i_Stall             : in  std_logic;
                i_PC4               : in  std_logic_vector(31 downto 0);
                i_RegisterFileReadA : in  std_logic_vector(31 downto 0);
                i_RegisterFileReadB : in  std_logic_vector(31 downto 0);
                i_ImmediateExtended : in  std_logic_vector(31 downto 0);
                i_IDRt              : in  std_logic_vector(4 downto 0);
                i_IDRd              : in  std_logic_vector(4 downto 0);
                i_RegDst            : in  std_logic;
                i_RegWrite          : in  std_logic;
                i_MemToReg          : in  std_logic;
                i_MemWrite          : in  std_logic;
                i_ALUSrc            : in  std_logic;
                i_ALUOp             : in  std_logic_vector(3 downto 0);
                i_Jal               : in  std_logic;
                i_Halt              : in  std_logic;
                i_RS                : in  std_logic_vector(4 downto 0);
                i_MEMRd             : in  std_logic;
                o_RS                : out std_logic_vector(4 downto 0);
                o_PC4               : out std_logic_vector(31 downto 0);
                o_RegisterFileReadA : out std_logic_vector(31 downto 0);
                o_RegisterFileReadB : out std_logic_vector(31 downto 0);
                o_ImmediateExtended : out std_logic_vector(31 downto 0);
                o_Rt                : out std_logic_vector(4 downto 0);  -- [20-16]
                o_Rd                : out std_logic_vector(4 downto 0);  -- [15-11]
                o_RegDst            : out std_logic;
                o_RegWrite          : out std_logic;
                o_memToReg          : out std_logic;
                o_MemWrite          : out std_logic;
                o_ALUSrc            : out std_logic;
                o_ALUOp             : out std_logic_vector(3 downto 0);
                o_Jal               : out std_logic;
                o_Halt              : out std_logic;
                o_MEMRd             : out std_logic
                );
    end component;

    component EX_MEM is

        port (
            i_CLK      : in  std_logic;   
            i_RST      : in  std_logic;    
            i_stall    : in  std_logic;     
            i_ALU      : in  std_logic_vector(31 downto 0);
            i_B        : in  std_logic_vector(31 downto 0); 
            i_WrAddr   : in  std_logic_vector(4 downto 0); 
            i_MemWr    : in  std_logic;  
            i_MemtoReg : in  std_logic;    
            i_Halt     : in  std_logic;     
            i_RegWr    : in  std_logic;     
            i_Jal      : in  std_logic;    
            i_PC4      : in  std_logic_vector(31 downto 0);  
            o_ALU      : out std_logic_vector(31 downto 0);
            o_B        : out std_logic_vector(31 downto 0);  
            o_WrAddr   : out std_logic_vector(4 downto 0);
            o_MemWr    : out std_logic;   
            o_MemtoReg : out std_logic;
            o_Halt     : out std_logic;
            o_RegWr    : out std_logic;
            o_Jal      : out std_logic;
            o_PC4      : out std_logic_vector(31 downto 0)
            );
    end component;

    component MEM_WB is
        port (
            i_CLK      : in  std_logic;
            i_RST      : in  std_logic;
            i_stall    : in  std_logic;
            i_ALU      : in  std_logic_vector(31 downto 0);
            i_Mem      : in  std_logic_vector(31 downto 0);
            i_WrAddr   : in  std_logic_vector(4 downto 0);
            i_MemtoReg : in  std_logic;
            i_Halt     : in  std_logic;
            i_RegWr    : in  std_logic;
            i_Jal      : in  std_logic;
            i_PC4      : in  std_logic_vector(31 downto 0);
            o_ALU      : out std_logic_vector(31 downto 0);
            o_Mem      : out std_logic_vector(31 downto 0);
            o_WrAddr   : out std_logic_vector(4 downto 0);
            o_MemtoReg : out std_logic;
            o_Halt     : out std_logic;
            o_RegWr    : out std_logic;
            o_Jal      : out std_logic;
            o_PC4      : out std_logic_vector(31 downto 0)
            );
    end component;
    
begin

end behavior;