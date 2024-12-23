-- <header>
-- Author(s): connerohnesorge, Conner Ohnesorge
-- Name: 
-- Notes:
--      connerohnesorge 2024-12-06T08:12:54-06:00 Update-ID_EX-to-be-compatible-with-the-style-guide
--      connerohnesorge 2024-12-04T20:56:05-06:00 finish-presentation-of-pipeline-stages-in-both-hardware-and-software-implementations-and-make-sure-adherence-to-styleguide
--      Conner Ohnesorge 2024-12-04T07:44:46-06:00 updated-the-software-pipeline-to-use-the-simplified-contgrol-flow
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;

entity ID_EX is

    port (
        i_CLK               : in  std_logic;
        i_Reset             : in  std_logic;
        i_PC4               : in  std_logic_vector(31 downto 0);
        i_RegisterFileReadA : in  std_logic_vector(31 downto 0);
        i_RegisterFileReadB : in  std_logic_vector(31 downto 0);
        i_ImmediateExtended : in  std_logic_vector(31 downto 0);
        i_Rt                : in  std_logic_vector(4 downto 0);  -- 20-16
        i_Rd                : in  std_logic_vector(4 downto 0);  -- 15-11
        i_RegDst            : in  std_logic;
        i_RegWrite          : in  std_logic;
        i_MemToReg          : in  std_logic;
        i_MemWrite          : in  std_logic;
        i_ALUSrc            : in  std_logic;
        i_ALUOp             : in  std_logic_vector(3 downto 0);
        i_Jal               : in  std_logic;
        i_Halt              : in  std_logic;
        o_PC4               : out std_logic_vector(31 downto 0);
        o_RegisterFileReadA : out std_logic_vector(31 downto 0);
        o_RegisterFileReadB : out std_logic_vector(31 downto 0);
        o_ImmediateExtended : out std_logic_vector(31 downto 0);
        o_Rt                : out std_logic_vector(4 downto 0);  -- 20-16
        o_Rd                : out std_logic_vector(4 downto 0);  -- 15-11
        o_RegDst            : out std_logic;
        o_RegWrite          : out std_logic;
        o_MemToReg          : out std_logic;
        o_MemWrite          : out std_logic;
        o_ALUSrc            : out std_logic;
        o_ALUOp             : out std_logic_vector(3 downto 0);
        o_Jal               : out std_logic;
        o_Halt              : out std_logic
        );

end ID_EX;

architecture structural of ID_EX is

    component dffg_N is
        generic (N : integer := 32);
        port (
            i_CLK : in  std_logic;
            i_RST : in  std_logic;
            i_WE  : in  std_logic;
            i_D   : in  std_logic_vector(N - 1 downto 0);
            o_Q   : out std_logic_vector(N - 1 downto 0)
            );
    end component;

    component dffg is
        port (
            i_CLK : in  std_logic;
            i_RST : in  std_logic;
            i_WE  : in  std_logic;
            i_D   : in  std_logic;
            o_Q   : out std_logic
            );
    end component;

begin

    instPCPlus4Reg : dffg_N
        generic map(N => 32)
        port map(
            i_CLK => i_CLK,
            i_RST => i_Reset,
            i_WE  => '1',
            i_D   => i_PC4,
            o_Q   => o_PC4
            );

    instReadAReg : dffg_N
        generic map(N => 32)
        port map(
            i_CLK => i_CLK,
            i_RST => i_Reset,
            i_WE  => '1',
            i_D   => i_RegisterFileReadA,
            o_Q   => o_RegisterFileReadA
            );

    instReadBReg : dffg_N
        generic map(N => 32)
        port map(
            i_CLK => i_CLK,
            i_RST => i_Reset,
            i_WE  => '1',
            i_D   => i_RegisterFileReadB,
            o_Q   => o_RegisterFileReadB
            );

    instImmExtReg : dffg_N
        generic map(N => 32)
        port map(
            i_CLK => i_CLK,
            i_RST => i_Reset,
            i_WE  => '1',
            i_D   => i_ImmediateExtended,
            o_Q   => o_ImmediateExtended
            );

    instRs : dffg_N
        generic map(N => 5)
        port map(
            i_CLK => i_CLK,
            i_RST => i_Reset,
            i_WE  => '1',
            i_D   => i_Rt,
            o_Q   => o_Rt);

    instRdReg : dffg_N
        generic map(N => 5)
        port map(
            i_CLK => i_CLK,
            i_RST => i_Reset,
            i_WE  => '1',
            i_D   => i_Rd,
            o_Q   => o_Rd
            );

    instRegDstReg : dffg
        port map(
            i_CLK => i_CLK,
            i_RST => i_Reset,
            i_WE  => '1',
            i_D   => i_RegDst,
            o_Q   => o_RegDst
            );

    instRegWriteReg : dffg
        port map(
            i_CLK => i_CLK,
            i_RST => i_Reset,
            i_WE  => '1',
            i_D   => i_RegWrite,
            o_Q   => o_RegWrite
            );

    instMemToRegReg : dffg
        port map(
            i_CLK => i_CLK,
            i_RST => i_Reset,
            i_WE  => '1',
            i_D   => i_MemToReg,
            o_Q   => o_MemToReg
            );

    instMemWriteReg : dffg
        port map(

            i_CLK => i_CLK,
            i_RST => i_Reset,
            i_WE  => '1',
            i_D   => i_MemWrite,
            o_Q   => o_MemWrite
            );

    instALUSrcReg : dffg
        port map(
            i_CLK => i_CLK,
            i_RST => i_Reset,
            i_WE  => '1',
            i_D   => i_ALUSrc,
            o_Q   => o_ALUSrc
            );

    instALUOpReg : dffg_N
        generic map(N => 4)
        port map(
            i_CLK => i_CLK,
            i_RST => i_Reset,
            i_WE  => '1',
            i_D   => i_ALUOp,
            o_Q   => o_ALUOp);

    instJalReg : dffg
        port map(

            i_CLK => i_CLK,
            i_RST => i_Reset,
            i_WE  => '1',
            i_D   => i_Jal,
            o_Q   => o_Jal
            );

    instHaltReg : dffg
        port map(
            i_CLK => i_CLK,
            i_RST => i_Reset,
            i_WE  => '1',
            i_D   => i_Halt,
            o_Q   => o_Halt
            );

end structural;

