-- <header>
-- Author(s): Conner Ohnesorge
-- Name: 
-- Notes:
--      Conner Ohnesorge 2024-12-02T15:00:49-06:00 added-missing-signals-for-each-stage-of-the-pipeline
--      Conner Ohnesorge 2024-12-01T12:19:14-06:00 moved-all-files-into-the-hardware-directory
-- </header>

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.MATH_REAL.all;
use IEEE.NUMERIC_STD.all;

entity Control is

    port (
        i_opcode      : in  std_logic_vector(5 downto 0);
        i_Rt          : in  std_logic_vector(4 downto 0);
        i_Rs          : in  std_logic_vector(4 downto 0);
        i_Rd          : in  std_logic_vector(4 downto 0);
        i_Shamt       : in  std_logic_vector(4 downto 0);
        i_Funct       : in  std_logic_vector(5 downto 0);
        i_Imm         : in  std_logic_vector(15 downto 0);
        o_RegDst      : out std_logic_vector(1 downto 0);
        o_PCWriteCond : out std_logic;
        o_PCWrite     : out std_logic;
        o_IorD        : out std_logic;
        o_MemtoReg    : out std_logic;
        o_IRWrite     : out std_logic;
        o_PCSrc       : out std_logic;
        o_ALUOp       : out std_logic_vector(3 downto 0);
        o_ALUSrcA     : out std_logic_vector(1 downto 0);
        o_ALUSrcB     : out std_logic_vector(1 downto 0);
        o_RegWrite    : out std_logic;
        o_Halt        : out std_logic;
        o_IFFlush     : out std_logic   -- figure 4.9.4
        );

end entity;

architecture structure of Control is

begin


end structure;

