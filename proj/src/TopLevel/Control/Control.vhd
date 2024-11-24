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


    ControlProc : process(i_opcode, i_Rt, i_Rs, i_Rd, i_Shamt, i_Funct, i_Imm, o_PCWriteCond, o_PCWrite, o_IorD, o_MemtoReg, o_IRWrite, o_PCSrc, o_ALUOp, o_ALUSrcA, o_ALUSrcB, o_RegWrite, o_RegDst, o_Halt)
    begin
        case i_opcode is
            --      R-format instructions (opcode = 000000)
            -- |31    26|25  21|20  16|15  11|10    6|5     0|
            -- |---------------------------------------------|
            -- | opcode |  rs  |  rt  |  rd  | shamt | funct |
            -- |---------------------------------------------|
            -- |6 bits  |5 bits|5 bits|5 bits|5 bits |6 bits |
            when "000000" =>
                o_RegDst <= "01";

            --      J-format instructions (opcode = 000010 or 000011)
            -- |31    26|25                                 0|
            -- |---------------------------------------------|
            -- | opcode |         address                    |
            -- |---------------------------------------------|
            -- |6 bits  |        26 bits                     |
            when "000010" | "000011" =>
                o_RegDst <= "10";
            --      I-format instructions (all other opcodes)
            -- |31    26|25  21|20  16|15                   0|
            -- |---------------------------------------------|
            -- | opcode |  rs  |  rt  |       immediate      |
            -- |---------------------------------------------|
            -- |6 bits  |5 bits|5 bits|       16 bits        |
            when others =>
                o_RegDst <= "00";
        end case;
    end process;

end structure;

