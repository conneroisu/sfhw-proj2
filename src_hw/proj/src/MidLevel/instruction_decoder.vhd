library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity instruction_decoder is
    port(
        i_Instruction : in  std_logic_vector(31 downto 0);  -- [31-00] 
        o_Opcode      : out std_logic_vector(5 downto 0);   -- [31-26] R J I
        o_Rs          : out std_logic_vector(4 downto 0);   -- [25-21] R I
        o_Rt          : out std_logic_vector(4 downto 0);   -- [20-16] R I
        o_Rd          : out std_logic_vector(4 downto 0);   -- [15-11] R
        o_Shamt       : out std_logic_vector(4 downto 0);   -- [10-06] R
        o_Funct       : out std_logic_vector(5 downto 0);   -- [05-00] R
        o_Imm         : out std_logic_vector(15 downto 0);  -- [15-00] I
        o_Addr        : out std_logic_vector(25 downto 0)   -- [25-00] I
        );
end entity instruction_decoder;

architecture rtl of instruction_decoder is
begin
    o_Opcode <= i_Instruction(31 downto 26);
    o_Rs     <= i_Instruction(25 downto 21);
    o_Rt     <= i_Instruction(20 downto 16);
    o_Rd     <= i_Instruction(15 downto 11);
    o_Shamt  <= i_Instruction(10 downto 6);
    o_Funct  <= i_Instruction(5 downto 0);
    o_Imm    <= i_Instruction(15 downto 0);
    o_Addr   <= i_Instruction(25 downto 0);
end architecture rtl;
