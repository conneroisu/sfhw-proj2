-- <header>
-- Author(s): Conner Ohnesorge
-- Name: proj/src/TopLevel/Stages/stage_idex.vhd
-- Notes:
--      conneroisu 2024-11-11T15:42:29Z Format-and-Header
--      Conner Ohnesorge 2024-11-11T09:04:24-06:00 remove-extraneous-semicolons-in-initial-declaration
--      Conner Ohnesorge 2024-11-11T09:03:17-06:00 added-stage-guide-and-finished-stage_idex-without-component-instantiations
--      Conner Ohnesorge 2024-11-11T08:29:19-06:00 final-version-of-the-header-program-with-tests-and-worked-on-the-stage_idex.vhd-file
--      Conner Ohnesorge 2024-11-07T09:51:12-06:00 progress-on-stage-2
-- </header>

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Stage 3
entity stage_idex is
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
        -- see: https://private-user-images.githubusercontent.com/88785126/384028866-8e8d5e84-ca22-462e-8b85-ea1c00c43e8f.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3MzEzMzIyOTUsIm5iZiI6MTczMTMzMTk5NSwicGF0aCI6Ii84ODc4NTEyNi8zODQwMjg4NjYtOGU4ZDVlODQtY2EyMi00NjJlLThiODUtZWExYzAwYzQzZThmLnBuZz9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNDExMTElMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjQxMTExVDEzMzMxNVomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPTMzNzM4ZjA4NDAxYjVhM2ZhMzQyNzIxNTJjYTBlNTc3ZjRiY2NlZWUwZTFhOWZkMGNhNzliMDVkMDM5MTgyMDUmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.XG3ua9fePqVvlV9ENBneOm_dfjEvY2qnAtWhg7wU6xU
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

end entity;

architecture structure of stage_idex is

    component dffg_n is
        generic(N : integer := 32);
        port(i_CLK : in  std_logic;
             i_RST : in  std_logic;
             i_WrE : in  std_logic;
             i_D   : in  std_logic_vector(N-1 downto 0);
             o_Q   : out std_logic_vector(N-1 downto 0));
    end component;

    signal s_ALUOp  : std_logic_vector(1 downto 0);
    signal s_ALUSrc : std_logic_vector(1 downto 0);

    signal s_ForwardA : std_logic_vector(1 downto 0);
    signal s_ForwardB : std_logic_vector(1 downto 0);
    -- see: https://private-user-images.githubusercontent.com/88785126/384987984-b31df788-32cf-48a5-a3ac-c44345cac682.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3MzEzNDEzNDgsIm5iZiI6MTczMTM0MTA0OCwicGF0aCI6Ii84ODc4NTEyNi8zODQ5ODc5ODQtYjMxZGY3ODgtMzJjZi00OGE1LWEzYWMtYzQ0MzQ1Y2FjNjgyLnBuZz9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNDExMTElMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjQxMTExVDE2MDQwOFomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPTlmZTY4MmI0ZDYzNmE1Mzg4YTlkMTgyODNkY2Y4ZWM0ZDhjYmJjYWU2ZTkwMjAyN2RmMDk2YTk4NzdiMjg3YjMmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.HlxyYpdSHKRrAJxoadF1q2Tf_ajySP-e8BSQ0sB0L2A

begin

    -- Common Stage Signals [begin]
    PC : dffg_n
        generic map (N => 32)
        port map(
            i_CLK => i_CLK,             -- Clock input
            i_RST => i_RST,             -- Reset input
            i_WrE => i_WE,              -- Write enable input
            i_D   => i_PC,              -- Data value input
            o_Q   => o_PC               -- Data value output
            );

    PCplus4 : dffg_n
        generic map (N => 32)
        port map(
            i_CLK => i_CLK,             -- Clock input
            i_RST => i_RST,             -- Reset input
            i_WrE => i_WE,              -- Write enable input
            i_D   => i_PCplus4,         -- Data value input
            o_Q   => o_PCplus4          -- Data value output
            );
    -- Common Stage Signals [end]

    WrAddr : dffg_n  -- Destination write address for register file (rd)
        generic map (N => 5)
        port map(
            i_CLK => i_CLK,             -- Clock input
            i_RST => i_RST,             -- Reset input
            i_WrE => i_WE,              -- Write enable input
            i_D   => i_RegDst,          -- Data value input
            o_Q   => i_RegDst           -- Data value output
            );

    Reg1 : dffg_n                       -- output of register file, output 1
        generic map (N => 32)
        port map(
            i_CLK => i_CLK,             -- Clock input
            i_RST => i_RST,             -- Reset input
            i_WrE => i_WE,              -- Write enable input
            i_D   => i_Read1,           -- Data value input
            o_Q   => o_Read1            -- Data value output
            );

    Reg2 : dffg_n                       -- output of register file, output 2
        generic map (N => 32)
        port map(
            i_CLK => i_CLK,             -- Clock input
            i_RST => i_RST,             -- Reset input
            i_WrE => i_WE,              -- Write enable input
            i_D   => i_Read2,           -- Data value input
            o_Q   => o_Read2            -- Data value output
            );

    Extended : dffg_n                   -- extended immediate
        generic map (N => 32)
        port map(
            i_CLK => i_CLK,             -- Clock input
            i_RST => i_RST,             -- Reset input
            i_WrE => i_WE,              -- Write enable input
            i_D   => i_Extended,  -- Data value input (extended immediate)
            o_Q   => o_Extended   -- Data value output (extended immediate)
            );

    ALUOperation : dffg_n               -- ALU operation
        generic map (N => 2)
        port map(
            i_CLK => i_CLK,             -- Clock input
            i_RST => i_RST,             -- Reset input
            i_WrE => i_WE,              -- Write enable input
            i_D   => i_ALUOp,           -- Data value input
            o_Q   => s_ALUOp            -- Data value output
            );

    ALUSrc : dffg_n                     -- ALU source
        generic map (N => 2)
        port map(
            i_CLK => i_CLK,             -- Clock input
            i_RST => i_RST,             -- Reset input
            i_WrE => i_WE,              -- Write enable input
            i_D   => i_ALUSrc,          -- Data value input
            o_Q   => s_ALUSrc           -- Data value output
            );

end structure;

