-- <header>
-- Author(s): Conner Ohnesorge, Kariniux
-- Name: proj/src/TopLevel/Control.vhd
-- Notes:
--      Conner Ohnesorge 2024-11-21T09:31:56-06:00 removed-unused-uncompleted-files-and-implemented-control-unit-for-software-pipeline
--      Kariniux 2024-11-21T09:09:28-06:00 Merge-pull-request-63-from-conneroisu-New_IFIDSTAGE
--      Kariniux 2024-11-21T09:04:48-06:00 pushing-pulling
--      Conner Ohnesorge 2024-11-21T09:00:59-06:00 added-start-of-sf-pipeline-folder
--      Conner Ohnesorge 2024-11-18T10:09:21-06:00 move-control-to-top-level-dir-and-rename
-- </header>

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.MATH_REAL.all;
use IEEE.NUMERIC_STD.all;

entity Control is

    port (
        i_opcode : in std_logic_vector(5 downto 0);
        i_Rt     : in std_logic_vector(4 downto 0);
        i_Rs     : in std_logic_vector(4 downto 0);
        i_Rd     : in std_logic_vector(4 downto 0);
        i_Shamt  : in std_logic_vector(4 downto 0);
        i_Funct  : in std_logic_vector(5 downto 0);
        i_Imm    : in std_logic_vector(15 downto 0);
        o_RegDst : out std_logic_vector(1 downto 0);
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
        o_IFFlush     : out std_logic -- figure 4.9.4
        );

end entity;

architecture structure of Control is

begin


end structure;

