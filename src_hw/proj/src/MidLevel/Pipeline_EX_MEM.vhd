library IEEE;
use IEEE.std_logic_1164.all;

entity EX_MEM is

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
        i_jal      : in  std_logic;    
        i_PC4      : in  std_logic_vector(31 downto 0);  
        o_ALU      : out std_logic_vector(31 downto 0);
        o_B        : out std_logic_vector(31 downto 0);  
        o_WrAddr   : out std_logic_vector(4 downto 0);
        o_MemWr    : out std_logic;   
        o_MemtoReg : out std_logic;
        o_Halt     : out std_logic;
        o_RegWr    : out std_logic;
        o_jal      : out std_logic;
        o_PC4      : out std_logic_vector(31 downto 0)
        );
    
end EX_MEM;

architecture structural of EX_MEM is

    component dffg is
        port (
            i_CLK : in  std_logic;      -- Clock input
            i_RST : in  std_logic;      -- Reset input
            i_WE  : in  std_logic;      -- Write enable input
            i_D   : in  std_logic;      -- Data value input
            o_Q   : out std_logic);     -- Data value output
    end component;

    signal s_stall : std_logic;

begin
    s_stall <= not i_stall;

    G_ALU_Reg : for i in 0 to 31 generate
        ALUDFFGI : dffg port map(
            i_CLK => i_CLK,
            i_RST => i_RST,
            i_WE  => s_stall,
            i_D   => i_ALU(i),
            o_Q   => o_ALU(i));
    end generate G_ALU_Reg;

    G_B_Reg : for i in 0 to 31 generate
        BDFFGI : dffg port map(
            i_CLK => i_CLK,
            i_RST => i_RST,
            i_WE  => s_stall,
            i_D   => i_B(i),
            o_Q   => o_B(i)
            );
    end generate G_B_Reg;

    G_WrAddr_Reg : for i in 0 to 4 generate
        WrAddrI : dffg port map(
            i_CLK => i_CLK,
            i_RST => i_RST,
            i_WE  => s_stall,
            i_D   => i_WrAddr(i),
            o_Q   => o_WrAddr(i)
            );
    end generate G_WrAddr_Reg;

    MemWrReg : dffg
        port map(
            i_CLK => i_CLK,
            i_RST => i_RST,
            i_WE  => s_stall,
            i_D   => i_MemWr,
            o_Q   => o_MemWr
            );

    MemtoReg : dffg
        port map(
            i_CLK => i_CLK,
            i_RST => i_RST,
            i_WE  => s_stall,
            i_D   => i_MemtoReg,
            o_Q   => o_MemtoReg
            );

    HaltReg : dffg
        port map(
            i_CLK => i_CLK,
            i_RST => i_RST,
            i_WE  => s_stall,
            i_D   => i_Halt,
            o_Q   => o_Halt
            );

    RegWrReg : dffg
        port map(
            i_CLK => i_CLK,
            i_RST => i_RST,
            i_WE  => s_stall,
            i_D   => i_RegWr,
            o_Q   => o_RegWr
            );

    jalReg : dffg
        port map(
            i_CLK => i_CLK,
            i_RST => i_RST,
            i_WE  => s_stall,
            i_D   => i_jal,
            o_Q   => o_jal
            );

    G_PC4_reg : for i in 0 to 31 generate
        WrAddrI : dffg port map(
            i_CLK => i_CLK,
            i_RST => i_RST,
            i_WE  => s_stall,
            i_D   => i_PC4(i),
            o_Q   => o_PC4(i)
            );
    end generate G_PC4_reg;

end structural;
