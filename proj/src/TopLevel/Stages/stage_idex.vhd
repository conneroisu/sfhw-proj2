library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Stage 3
entity stage_idex is
    generic(N : integer := 32);
    port (
        -- Common Stage Signals [begin]
        i_CLK     : in  std_logic;
        i_RST     : in  std_logic;
        i_WE      : in  std_logic;
        i_PC      : in  std_logic_vector(N-1 downto 0);
        o_PC      : out std_logic_vector(N-1 downto 0);
        i_Inst    : in  std_logic_vector(N-1 downto 0);
        i_PCplus4 : in  std_logic_vector(N-1 downto 0);
        o_PCplus4 : out std_logic_vector(N-1 downto 0);
        -- Common Stage Signals [end]

        -- Control Signals [begin]
        --= Stage Specific Signals [begin]
        -- ex:     RegDst  ALUOp  ALUSrc
        -- R-Type:   1      10      00
        -- lw    :   0      00      01
        -- sw    :   x      00      01
        -- beq   :   x      01      00
        i_RegDst : in std_logic_vector(4 downto 0);
        i_ALUOp  : in std_logic_vector(1 downto 0);
        i_ALUSrc : in std_logic_vector(1 downto 0);
        --= Stage Specific Signals [end]

        -- Future Stage Signals [begin]
        -- see: https://private-user-images.githubusercontent.com/88785126/384028866-8e8d5e84-ca22-462e-8b85-ea1c00c43e8f.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3MzEzMzIyOTUsIm5iZiI6MTczMTMzMTk5NSwicGF0aCI6Ii84ODc4NTEyNi8zODQwMjg4NjYtOGU4ZDVlODQtY2EyMi00NjJlLThiODUtZWExYzAwYzQzZThmLnBuZz9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNDExMTElMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjQxMTExVDEzMzMxNVomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPTMzNzM4ZjA4NDAxYjVhM2ZhMzQyNzIxNTJjYTBlNTc3ZjRiY2NlZWUwZTFhOWZkMGNhNzliMDVkMDM5MTgyMDUmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.XG3ua9fePqVvlV9ENBneOm_dfjEvY2qnAtWhg7wU6xU
        --== Memory Stage Control Signals [begin]
        i_MemRead  : in  std_logic;
        o_MemRead  : out std_logic;
        i_MemWrite : in  std_logic;
        o_MemWrite : out std_logic;
        i_PCSrc    : in  std_logic_vector(1 downto 0);
        o_PCSrc    : out std_logic_vector(1 downto 0);
        -- Memory Stage Control Signals [end]
        --== Write Back Stage Control Signals [begin]
        i_RegWrite : in  std_logic;
        i_MemToReg : in  std_logic;
        o_RegWrite : out std_logic;
        o_MemToReg : out std_logic;
        -- Write Back Stage Control Signals [end]
        --= Future Stage Signals [end]
        -- Control Signals [end]

        -- Stage Passthrough Signals [begin]
        --= Register File Signals [begin]
        i_Read1    : in  std_logic_vector(N-1 downto 0);
        i_Read2    : in  std_logic_vector(N-1 downto 0);
        o_Read1    : out std_logic_vector(N-1 downto 0);
        o_Read2    : out std_logic_vector(N-1 downto 0);
        --= Register File Signals [end]
        --= Sign Extend Signals [begin]
        i_Extended : in  std_logic_vector(N-1 downto 0);
        o_Extended : out std_logic_vector(N-1 downto 0);
        --= Sign Extend Signals [end]
        --= Instruction Memory Signals [begin]
        i_Rd       : in  std_logic_vector(4 downto 0);  -- I-bits[11-15] into RegDstMux bits[4-0]
        i_Rt       : in  std_logic_vector(4 downto 0);  -- I-bits[16-20] into RegDstMux and Register (bits[4-0])
        --= Instruction Memory Signals [end]
        i_Ctrl     : in  std_logic_vector(20 downto 0);
        o_Ctrl     : out std_logic_vector(20 downto 0);
        o_Inst     : out std_logic_vector(N-1 downto 0)
         --= Stage Passthrough Signals [end]
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

    component dffg_n is  -- dffg for designated N sized signals to be forwarded
        generic(N : integer := 32);
        port(i_CLK : in  std_logic;
             i_RST : in  std_logic;
             i_WE  : in  std_logic;
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
