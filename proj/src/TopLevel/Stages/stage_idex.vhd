library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity stage_idex is
    generic(N : integer := 32);
    port (
        i_CLK : in std_logic;
        i_RST : in std_logic;
        i_WE  : in std_logic;
        -- Execute Stage Control Signals
        i_ALUSrc   : in  std_logic_vector(1 downto 0);
        i_ALUOp    : in  std_logic_vector(1 downto 0);
        i_RegDst   : in  std_logic_vector(4 downto 0);
        -- Execute -> Memory Stage Control Signals
        i_MemRead  : in  std_logic;
        i_MemWrite : in  std_logic;
        i_PCSrc    : in  std_logic_vector(1 downto 0);
        o_MemRead  : out std_logic;
        o_MemWrite : out std_logic;
        o_PCSouce  : out std_logic_vector(1 downto 0);
        -- Execute -> Memory -> Write Back Stage Control Signals
        i_RegWrite : in  std_logic;
        i_MemToReg : in  std_logic;
        -- Control signals in
        i_Ctrl : in  std_logic_vector(20 downto 0);
        o_Ctrl : out std_logic_vector(20 downto 0);
        --the registers in
        i_Read1 : in  std_logic_vector(N-1 downto 0);
        i_Read2 : in  std_logic_vector(N-1 downto 0);
        --the registers out
        o_Read1 : out std_logic_vector(N-1 downto 0);
        o_Read2 : out std_logic_vector(N-1 downto 0);
        -- the PC and instruction in
        i_PC       : in  std_logic_vector(N-1 downto 0);
        i_Inst     : in  std_logic_vector(N-1 downto 0);
        i_PCplus4  :     std_logic_vector(N-1 downto 0);
        i_extended : in  std_logic_vector(N-1 downto 0);
        -- the PC and instruction out
        o_PC       : out std_logic_vector(N-1 downto 0);
        o_Inst     : out std_logic_vector(N-1 downto 0);
        o_PCplus4  :     std_logic_vector(N-1 downto 0);
        o_extended : out std_logic_vector(N-1 downto 0)
        );

end entity;

architecture structure of stage_idex is

    component dffg_n_alt is  -- dffg for designated N sized signals to be forwarded
        generic(N : integer := 32);
        port(i_CLK : in  std_logic;
             i_RST : in  std_logic;
             i_WrE : in  std_logic;
             i_D   : in  std_logic_vector(N-1 downto 0);
             o_Q   : out std_logic_vector(N-1 downto 0));
    end component;

    component dffg is  -- dffg for a single "std_logic" aka 0, 1 to be forwarded
        port(i_CLK : in  std_logic;     -- Clock input
             i_RST : in  std_logic;     -- Reset input
             i_WE  : in  std_logic;     -- Write enable input
             i_D   : in  std_logic;     -- Data value input
             o_Q   : out std_logic);    -- Data value output
    end component;

    component dffg_5 is  -- dffg for a single "std_logic" aka 0, 1 to be forwarded
        port(i_CLK : in  std_logic;     -- Clock input
             i_RST : in  std_logic;     -- Reset input
             i_WE  : in  std_logic;     -- Write enable input
             i_D   : in  std_logic_vector(4 downto 0);   -- Data value input
             o_Q   : out std_logic_vector(4 downto 0));  -- Data value output
    end component;

    component dffg_21 is  -- dffg for a single "std_logic" aka 0, 1 to be forwarded
        port(i_CLK : in  std_logic;     -- Clock input
             i_RST : in  std_logic;     -- Reset input
             i_WE  : in  std_logic;     -- Write enable input
             i_D   : in  std_logic_vector(20 downto 0);   -- Data value input
             o_Q   : out std_logic_vector(20 downto 0));  -- Data value output
    end component;

begin

    Ctrl : dffg_n  -- Control signals (being passed through and used as it goes)
        generic map (N => 21)
        port map(i_CLK => i_CLK,        -- Clock input
                 i_RST => i_RST,        -- Reset input
                 i_WE  => i_WE,         -- Write enable input
                 i_D   => i_Ctrl,       -- Data value input
                 o_Q   => o_Ctrl        -- Data value output
                 );

    WrAddr : dffg_n_alt  -- Destination write address for register file (rd)
        generic map (N => 5)
        port map(i_CLK => i_CLK,        -- Clock input
                 i_RST => i_RST,        -- Reset input
                 i_WrE => i_WE,         -- Write enable input
                 i_D   => i_RegDst,     -- Data value input
                 o_Q   => i_RegDst      -- Data value output
                 );

    Reg1 : dffg_n_alt                   -- output of register file, output 1
        generic map (N => 32)
        port map(i_CLK => i_CLK,        -- Clock input
                 i_RST => i_RST,        -- Reset input
                 i_WrE => i_WE,         -- Write enable input
                 i_D   => i_Read1,      -- Data value input
                 o_Q   => o_Read1       -- Data value output
                 );

    Reg2 : dffg_n_alt                   -- output of register file, output 2
        generic map (N => 32)
        port map(i_CLK => i_CLK,        -- Clock input
                 i_RST => i_RST,        -- Reset input
                 i_WrE => i_WE,         -- Write enable input
                 i_D   => i_Read2,      -- Data value input
                 o_Q   => o_Read2       -- Data value output
                 );

    PC : dffg_n_alt                     -- PC
        generic map (N => 32)
        port map(i_CLK => i_CLK,        -- Clock input
                 i_RST => i_RST,        -- Reset input
                 i_WrE => i_WE,         -- Write enable input
                 i_D   => i_PC,         -- Data value input
                 o_Q   => o_PC          -- Data value output
                 );

    PCplus4 : dffg_n_alt                -- PC + 4
        generic map (N => 32)
        port map(i_CLK => i_CLK,        -- Clock input
                 i_RST => i_RST,        -- Reset input
                 i_WrE => i_WE,         -- Write enable input
                 i_D   => i_PCplus4,    -- Data value input
                 o_Q   => o_PCplus4     -- Data value output
                 );

    Inst : dffg_n_alt                   -- instruction signal
        generic map (N => 32)
        port map(i_CLK => i_CLK,        -- Clock input
                 i_RST => i_RST,        -- Reset input
                 i_WrE => i_WE,         -- Write enable input
                 i_D   => i_Inst,       -- Data value input
                 o_Q   => o_Inst        -- Data value output
                 );

    Extended : dffg_n_alt               -- extended immediate
        generic map (N => 32)
        port map(i_CLK => i_CLK,        -- Clock input
                 i_RST => i_RST,        -- Reset input
                 i_WrE => i_WE,         -- Write enable input
                 i_D   => i_Extended,  -- Data value input (extended immediate)
                 o_Q   => o_Extended  -- Data value output (extended immediate)
                 );
end structure;
