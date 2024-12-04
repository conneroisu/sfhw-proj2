library IEEE;
use IEEE.std_logic_1164.all;

entity MEM_WB is

    port (
        i_CLK      : in  std_logic;
        i_RST      : in  std_logic;
        i_ALU      : in  std_logic_vector(31 downto 0);
        o_ALU      : out std_logic_vector(31 downto 0);
        i_Mem      : in  std_logic_vector(31 downto 0);
        o_Mem      : out std_logic_vector(31 downto 0);
        i_WrAddr   : in  std_logic_vector(4 downto 0);
        o_WrAddr   : out std_logic_vector(4 downto 0);
        i_MemtoReg : in  std_logic;
        o_MemtoReg : out std_logic;
        i_Halt     : in  std_logic;
        o_Halt     : out std_logic;
        i_RegWr    : in  std_logic;
        o_RegWr    : out std_logic;
        i_jal      : in  std_logic;
        o_jal      : out std_logic;
        i_PC4      : in  std_logic_vector(31 downto 0);
        o_PC4      : out std_logic_vector(31 downto 0)
        );

end MEM_WB;

architecture structural of MEM_WB is

    component dffg is
        port (
            i_CLK : in  std_logic;      -- Clock input
            i_RST : in  std_logic;      -- Reset input
            i_WE  : in  std_logic;      -- Write enable input
            i_D   : in  std_logic;      -- Data value input
            o_Q   : out std_logic);     -- Data value output
    end component;


begin


    G_ALU_Reg : for i in 0 to 31 generate
        ALUDFFG : dffg port map(
            i_CLK => i_CLK,
            i_RST => i_RST,
            i_WE  => '1',
            i_D   => i_ALU(i),
            o_Q   => o_ALU(i));
    end generate G_ALU_Reg;

    G_Mem_Reg : for i in 0 to 31 generate
        BDFFG : dffg port map(
            i_CLK => i_CLK,
            i_RST => i_RST,
            i_WE  => '1',
            i_D   => i_Mem(i),
            o_Q   => o_Mem(i)
            );
    end generate G_Mem_Reg;

    G_WrAddr_Reg : for i in 0 to 4 generate
        WrAddrI : dffg port map(
            i_CLK => i_CLK,
            i_RST => i_RST,
            i_WE  => '1',
            i_D   => i_WrAddr(i),
            o_Q   => o_WrAddr(i)
            );
    end generate G_WrAddr_Reg;

    instMemtoReg : dffg
        port map(
            i_CLK => i_CLK,
            i_RST => i_RST,
            i_WE  => '1',
            i_D   => i_MemtoReg,
            o_Q   => o_MemtoReg
            );

    instHaltReg : dffg
        port map(
            i_CLK => i_CLK,
            i_RST => i_RST,
            i_WE  => '1',
            i_D   => i_Halt,
            o_Q   => o_Halt
            );

    instRegWrReg : dffg
        port map(
            i_CLK => i_CLK,
            i_RST => i_RST,
            i_WE  => '1',
            i_D   => i_RegWr,
            o_Q   => o_RegWr
            );

    instJalReg : dffg
        port map(
            i_CLK => i_CLK,
            i_RST => i_RST,
            i_WE  => '1',
            i_D   => i_jal,
            o_Q   => o_jal
            );

    G_PC4_reg : for i in 0 to 31 generate
        WrAddrI : dffg port map(
            i_CLK => i_CLK,
            i_RST => i_RST,
            i_WE  => '1',
            i_D   => i_PC4(i),
            o_Q   => o_PC4(i)
            );
    end generate G_PC4_reg;

end structural;
