library IEEE;
use IEEE.std_logic_1164.all;

entity alu_control is
  port (
    i_Funct  : in  std_logic_vector(5 downto 0);
    i_ALUOp  : in  std_logic_vector(2 downto 0);
    o_ALUSel : out std_logic_vector(4 downto 0)
    );
end alu_control;

architecture behavioral of alu_control is

begin
  process (i_funct, i_ALUOp)

  begin
    case i_ALUOp is
      when "000" =>  -- R-type instructions (function code determines the operation)
        case i_funct is
          when "100000" =>              -- ADD instruction
            o_ALUSel <= "11010";        -- Perform signed addition
          when "100001" =>              -- ADDU instruction
            o_ALUSel <= "01010";        -- Perform unsigned addition
          when "100100" =>              -- AND instruction
            o_ALUSel <= "00000";        -- Perform bitwise AND
          when "100101" =>              -- OR instruction
            o_ALUSel <= "00001";        -- Perform bitwise OR
          when "100110" =>              -- XOR instruction
            o_ALUSel <= "00111";        -- Perform bitwise XOR
          when "100111" =>              -- NOR instruction
            o_ALUSel <= "00110";        -- Perform bitwise NOR
          when "101010" =>              -- SLT instruction
            o_ALUSel <= "01111";        -- Set on less than (signed comparison)
          when "000000" =>              -- SLL instruction
            o_ALUSel <= "01011";        -- Shift left logical
          when "000010" =>              -- SRL instruction
            o_ALUSel <= "01100";        -- Shift right logical
          when "000011" =>              -- SRA instruction
            o_ALUSel <= "01101";        -- Shift right arithmetic
          when "100010" =>              -- SUB instruction
            o_ALUSel <= "11110";        -- Perform signed subtraction
          when "100011" =>              -- SUBU instruction
            o_ALUSel <= "01110";        -- Perform unsigned subtraction
          when others =>
            o_ALUSel <= "00000";        -- Default operation (e.g., NOP or AND)
        end case;

      when "001" =>           -- ADDI instruction (immediate addition)
        o_ALUSel <= "11010";            -- Perform signed addition

      when "010" =>  -- ADDIU instruction (immediate unsigned addition)
        o_ALUSel <= "01010";            -- Perform unsigned addition

      when "011" =>                     -- ANDI instruction (immediate AND)
        o_ALUSel <= "00000";            -- Perform bitwise AND

      when "100" =>                     -- XORI instruction (immediate XOR)
        o_ALUSel <= "00111";            -- Perform bitwise XOR

      when "101" =>                     -- ORI instruction (immediate OR)
        o_ALUSel <= "00001";            -- Perform bitwise OR

      when "110" =>           -- SLTI instruction (immediate set on less than)
        o_ALUSel <= "01111";            -- Set on less than (signed comparison)

      when others =>
        o_ALUSel <= "00000";            -- Default operation (e.g., NOP or AND)
    end case;
  end process;
end behavioral;
