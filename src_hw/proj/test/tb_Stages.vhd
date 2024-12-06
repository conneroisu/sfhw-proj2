
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
    signal 
    IF_PC4, -- vec 32
    IF_Instruction, -- vec 32
    ID_PC4, -- vec 32
    ID_Instruction,-- vec 32
    ID_RegisterFileReadA,-- vec 32
    ID_RegisterFileReadB,-- vec 32
    ID_ImmediateExtended,-- vec 32
    EX_RegisterFileReadA,--vec 32
    EX_RegisterFileReadB,--vec 32
    EX_ImmediateExtended,--vec 32
    EX_PC4,--vec 32
    EX_ALU, --vec 32
    EX_B,--vec 32
    MEM_ALU,--vec 32
    MEM_B,--vec 32
    MEM_PC4,--vec 32
    WB_ALU,--vec 32
    WB_Mem,--vec 32
    WB_PC4,--vec 32
    MEM_Mem--vec 32
    :STD_LOGIC_VECTOR(31 downto 0);
    signal
    ID_IDRt, --vec 5
    ID_IDRd, -- vec 5
    ID_RS, --vec 5
    EX_RS, -- vec 5
    EX_Rt,--vec 5
    EX_Rd,--vec 5
    EX_WrAddr, --vec 5
    MEM_WrAddr,--vec 5
    WB_WrAddr:--vec 5
    std_logic_vector(4 downto 0);
    signal
    ID_ALUOp, -- vec 4
    EX_ALUOp: -- vec 4
    STD_LOGIC_VECTOR(3 downto 0);
    signal
    IF_CLK,
    IF_RST,
    IF_Stall,
    ID_CLK,
    ID_Reset,
    ID_Stall,
    ID_RegDst,
    ID_RegWrite,
    ID_MemToReg,
    ID_MemWrite,
    ID_ALUSrc,
    ID_Jal, 
    ID_Halt,
    ID_MEMRd,
    EX_RegDst,
    EX_RegWrite,
    EX_MemWrite,
    EX_ALUSrc,
    EX_Halt,
    EX_MEMRd,
    EX_CLK,
    EX_RST,
    EX_stall,
    EX_MemWr,
    EX_MemtoReg,
    EX_RegWr,
    EX_Jal,
    MEM_MemWr,
    MEM_MemtoReg,
    MEM_Halt,
    MEM_RegWr,
    MEM_Jal,
    MEM_CLK,
    MEM_RST,
    MEM_stall,
    WB_MemtoReg,
    WB_Halt,
    WB_RegWr,
    WB_Jal
    : std_logic;
begin

    IF_ID_inst: IF_ID
    port map(
       i_CLK => IF_CLK,
       i_RST => IF_RST,
       i_Stall => IF_Stall,
       i_PC4 => IF_PC4,
       i_Instruction => IF_Instruction,
       o_PC4 => ID_PC4,
       o_Instruction => ID_Instruction
   );

    ID_EX_inst: ID_EX
     port map(
        i_CLK =>        ID_CLK,
        i_Reset =>      ID_Reset,
        i_Stall =>      ID_Stall,
        i_PC4 =>        ID_PC4,
        i_RegisterFileReadA =>  ID_RegisterFileReadA,
        i_RegisterFileReadB =>  ID_RegisterFileReadB,
        i_ImmediateExtended =>  ID_ImmediateExtended,
        i_IDRt =>               ID_IDRt,
        i_IDRd =>               ID_IDRd,
        i_RegDst =>             ID_RegDst,
        i_RegWrite =>           ID_RegWrite,
        i_MemToReg =>           ID_MemToReg,
        i_MemWrite =>           ID_MemWrite,
        i_ALUSrc =>             ID_ALUSrc,
        i_ALUOp =>              ID_ALUOp,
        i_Jal =>                ID_Jal,
        i_Halt =>               ID_Halt,
        i_RS =>                 ID_RS,
        i_MEMRd =>              ID_MEMRd,
        o_RS =>                 EX_RS,
        o_PC4 =>                EX_PC4,
        o_RegisterFileReadA =>  EX_RegisterFileReadA,
        o_RegisterFileReadB =>  EX_RegisterFileReadB,
        o_ImmediateExtended =>  EX_ImmediateExtended,
        o_Rt =>                 EX_Rt,
        o_Rd =>                 EX_Rd,
        o_RegDst =>             EX_RegDst,
        o_RegWrite =>           EX_RegWrite,
        o_memToReg =>           EX_MemToReg,
        o_MemWrite =>           EX_MemWrite,
        o_ALUSrc =>             EX_ALUSrc,
        o_ALUOp =>              EX_ALUOp,
        o_Jal =>                EX_Jal,
        o_Halt =>               EX_Halt,
        o_MEMRd =>              EX_MEMRd
    );

    EX_MEM_inst: EX_MEM
     port map(
        i_CLK => EX_CLK,
        i_RST => EX_RST,
        i_stall => EX_stall,
        i_ALU => EX_ALU,
        i_B => EX_B,
        i_WrAddr => EX_WrAddr,
        i_MemWr => EX_MemWr,
        i_MemtoReg => EX_MemtoReg,
        i_Halt => EX_Halt,
        i_RegWr => EX_RegWr,
        i_Jal => EX_Jal,
        i_PC4 => EX_PC4,
        o_ALU => MEM_ALU,
        o_B => MEM_B,
        o_WrAddr => MEM_WrAddr,
        o_MemWr => MEM_MemWr,
        o_MemtoReg =>   MEM_MemtoReg,
        o_Halt =>       MEM_Halt,
        o_RegWr =>      MEM_RegWr,
        o_Jal =>        MEM_Jal,
        o_PC4 =>        MEM_PC4
    );

    MEM_WB_inst: MEM_WB
     port map(
        i_CLK =>        MEM_CLK,
        i_RST =>        MEM_RST,
        i_stall =>      MEM_stall,
        i_ALU =>        MEM_ALU,
        i_Mem =>        MEM_Mem,
        i_WrAddr =>     MEM_WrAddr,
        i_MemtoReg =>   MEM_MemtoReg,
        i_Halt =>       MEM_Halt,
        i_RegWr =>      MEM_RegWr,
        i_Jal =>        MEM_Jal,
        i_PC4 =>        MEM_PC4,
        o_ALU =>        WB_ALU,
        o_Mem =>        WB_Mem,
        o_WrAddr =>     WB_WrAddr,
        o_MemtoReg =>   WB_MemtoReg,
        o_Halt =>       WB_Halt,
        o_RegWr =>      WB_RegWr,
        o_Jal =>        WB_Jal,
        o_PC4 =>        WB_PC4
    );


end behavior;