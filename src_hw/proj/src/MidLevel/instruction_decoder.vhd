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
    operateProc : process(i_Instruction, o_Opcode, o_Rt, o_Rs, o_Rd, o_Shamt, o_Funct, o_Imm)
    begin
        o_Opcode <= i_Instruction(31 downto 26);
        case o_Opcode is
            when "000000" =>            -- R-format
                o_Rs    <= i_Instruction(25 downto 21);
                o_Rt    <= i_Instruction(20 downto 16);
                o_Rd    <= i_Instruction(15 downto 11);
                o_Shamt <= i_Instruction(10 downto 6);
                o_Funct <= i_Instruction(5 downto 0);
                o_Imm   <= (others => '0');
                o_Addr  <= (others => '0');
            when "000010" | "000011" =>  -- J-format
                o_Rs    <= (others => '0');
                o_Rt    <= (others => '0');
                o_Rd    <= (others => '0');
                o_Shamt <= (others => '0');
                o_Funct <= (others => '0');
                o_Imm   <= (others => '0');
                o_Addr  <= i_Instruction(25 downto 0);
            when others => -- I-format
                o_Rs    <= i_Instruction(25 downto 21);
                o_Rt    <= i_Instruction(20 downto 16);
                o_Rd    <= (others => '0');
                o_Shamt <= (others => '0');
                o_Funct <= (others => '0');
                o_Imm   <= i_Instruction(15 downto 0);
                o_Addr  <= (others => '0');
        end case;
    end process;
end architecture rtl;
