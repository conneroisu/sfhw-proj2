-- <header>
-- Author(s): Conner Ohnesorge, connerohnesorge
-- Name: 
-- Notes:
--      Conner Ohnesorge 2024-12-06T18:43:09-06:00 putback
--      Conner Ohnesorge 2024-12-06T18:40:53-06:00 remove-shiftType
--      Conner Ohnesorge 2024-12-06T18:39:36-06:00 put-back
--      Conner Ohnesorge 2024-12-06T18:38:05-06:00 latest
--      Conner Ohnesorge 2024-12-06T18:34:10-06:00 latest
--      Conner Ohnesorge 2024-12-06T11:13:04-06:00 ensure-complience-with-styleguide-for-ControlUnit
--      Conner Ohnesorge 2024-12-06T11:09:43-06:00 remove-unused-signal
--      connerohnesorge 2024-12-06T08:26:15-06:00 remove-s_j-from-MIPS_Processor-and-o_J-from-ControlUnit
--      Conner Ohnesorge 2024-12-04T05:13:48-06:00 optimizat-control-unit-for-performance
--      Conner Ohnesorge 2024-12-04T00:49:07-06:00 latest
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;

entity ControlUnit is

    port (
        i_OpCode    : in  std_logic_vector(5 downto 0);  --MIPS instruction opcode (6 bits wide)
        i_Funct     : in  std_logic_vector(5 downto 0);  --MIPS instruction function code (6 bits wide) used for R-Type instructions
        o_RegDst    : out std_logic;
        o_RegWrite  : out std_logic;
        o_MemToReg  : out std_logic;
        o_MemWrite  : out std_logic;
        o_ALUSrc    : out std_logic;
        o_ALUOp     : out std_logic_vector(3 downto 0);
        o_Signed    : out std_logic;
        o_shiftType : out std_logic;
        o_Bne       : out std_logic;
        o_Beq       : out std_logic;
        o_Jr        : out std_logic;
        o_Jal       : out std_logic;
        o_Branch    : out std_logic;
        o_Jump      : out std_logic;
        o_Lui       : out std_logic;
        o_Halt      : out std_logic
        );

end ControlUnit;

architecture behavioral of ControlUnit is
begin
    process(i_OpCode, i_Funct)
    begin
        if i_OpCode /= "000000" then        -- I and J type instructions
            if i_OpCode = "001000" then     -- addi 
                o_RegDst    <= '0';
                o_RegWrite  <= '1';
                o_MemToReg  <= '0';
                o_MemWrite  <= '0';
                o_ALUSrc    <= '1';
                o_ALUOp     <= "0010";
                o_Signed    <= '1';
                o_shiftType <= '0';
                o_Bne       <= '0';
                o_Beq       <= '0';
                o_Branch    <= '0';
                o_Jr        <= '0';
                o_Jal       <= '0';
                o_Jump      <= '0';
                o_Lui       <= '0';
                o_Halt      <= '0';
            elsif i_OpCode = "001001" then  -- addiu 
                o_RegDst    <= '0';
                o_RegWrite  <= '1';
                o_MemToReg  <= '0';
                o_MemWrite  <= '0';
                o_ALUSrc    <= '1';
                o_ALUOp     <= "0001";
                o_Signed    <= '1';
                o_shiftType <= '0';
                o_Bne       <= '0';
                o_Beq       <= '0';
                o_Branch    <= '0';
                o_Jr        <= '0';
                o_Jal       <= '0';
                o_Jump      <= '0';
                o_Lui       <= '0';
                o_Halt      <= '0';
            elsif i_OpCode = "001100" then  -- andi 
                o_RegDst    <= '0';
                o_RegWrite  <= '1';
                o_MemToReg  <= '0';
                o_MemWrite  <= '0';
                o_ALUSrc    <= '1';
                o_ALUOp     <= "0100";
                o_Signed    <= '0';
                o_shiftType <= '0';
                o_Bne       <= '0';
                o_Beq       <= '0';
                o_Branch    <= '0';
                o_Jr        <= '0';
                o_Jal       <= '0';
                o_Jump      <= '0';
                o_Lui       <= '0';
                o_Halt      <= '0';
            elsif i_OpCode = "001111" then  -- lui 
                o_RegDst    <= '0';
                o_RegWrite  <= '1';
                o_MemToReg  <= '0';
                o_MemWrite  <= '0';
                o_ALUSrc    <= '1';
                o_ALUOp     <= "1001";
                o_Signed    <= '0';
                o_shiftType <= '0';
                o_Bne       <= '0';
                o_Beq       <= '0';
                o_Branch    <= '0';
                o_Jr        <= '0';
                o_Jal       <= '0';
                o_Jump      <= '0';
                o_Lui       <= '1';
                o_Halt      <= '0';
            elsif i_OpCode = "100011" then  -- lw 
                o_RegDst    <= '0';
                o_RegWrite  <= '1';
                o_MemToReg  <= '1';
                o_MemWrite  <= '0';
                o_ALUSrc    <= '1';
                o_ALUOp     <= "0010";
                o_Signed    <= '0';
                o_shiftType <= '0';
                o_Bne       <= '0';
                o_Beq       <= '0';
                o_Branch    <= '0';
                o_Jr        <= '0';
                o_Jal       <= '0';
                o_Jump      <= '0';
                o_Lui       <= '0';
                o_Halt      <= '0';
            elsif i_OpCode = "001110" then  -- xori 
                o_RegDst    <= '0';
                o_RegWrite  <= '1';
                o_MemToReg  <= '0';
                o_MemWrite  <= '0';
                o_ALUSrc    <= '1';
                o_ALUOp     <= "0110";
                o_Signed    <= '0';
                o_shiftType <= '0';
                o_Bne       <= '0';
                o_Beq       <= '0';
                o_Branch    <= '0';
                o_Jr        <= '0';
                o_Jal       <= '0';
                o_Jump      <= '0';
                o_Lui       <= '0';
                o_Halt      <= '0';
            elsif i_OpCode = "001101" then  -- ori 
                o_RegDst    <= '0';
                o_RegWrite  <= '1';
                o_MemToReg  <= '0';
                o_MemWrite  <= '0';
                o_ALUSrc    <= '1';
                o_ALUOp     <= "0101";
                o_Signed    <= '0';
                o_shiftType <= '0';
                o_Bne       <= '0';
                o_Beq       <= '0';
                o_Branch    <= '0';
                o_Jr        <= '0';
                o_Jal       <= '0';
                o_Jump      <= '0';
                o_Lui       <= '0';
                o_Halt      <= '0';
            elsif i_OpCode = "001010" then  -- slti 
                o_RegDst    <= '0';
                o_RegWrite  <= '1';
                o_MemToReg  <= '0';
                o_MemWrite  <= '0';
                o_ALUSrc    <= '1';
                o_ALUOp     <= "1000";
                o_Signed    <= '1';
                o_shiftType <= '0';
                o_Bne       <= '0';
                o_Beq       <= '0';
                o_Branch    <= '0';
                o_Jr        <= '0';
                o_Jal       <= '0';
                o_Jump      <= '0';
                o_Lui       <= '0';
                o_Halt      <= '0';
            elsif i_OpCode = "101011" then  -- sw 
                o_RegDst    <= '0';
                o_RegWrite  <= '0';
                o_MemToReg  <= '0';
                o_MemWrite  <= '1';
                o_ALUSrc    <= '1';
                o_ALUOp     <= "0010";
                o_Signed    <= '0';
                o_shiftType <= '0';
                o_Bne       <= '0';
                o_Beq       <= '0';
                o_Branch    <= '0';
                o_Jr        <= '0';
                o_Jal       <= '0';
                o_Jump      <= '0';
                o_Lui       <= '0';
                o_Halt      <= '0';
            elsif i_OpCode = "000100" then  -- beq 
                o_RegDst    <= '0';
                o_RegWrite  <= '0';
                o_MemToReg  <= '0';
                o_MemWrite  <= '0';
                o_ALUSrc    <= '0';
                o_ALUOp     <= "1110";
                o_Signed    <= '1';
                o_Bne       <= '0';
                o_Beq       <= '1';
                o_Branch    <= '1';
                o_shiftType <= '0';
                o_Jr        <= '0';
                o_Jal       <= '0';
                o_Jump      <= '0';
                o_Lui       <= '0';
                o_Halt      <= '0';
            elsif i_OpCode = "000101" then  -- bne 
                o_RegDst    <= '0';
                o_RegWrite  <= '0';
                o_MemToReg  <= '0';
                o_MemWrite  <= '0';
                o_ALUSrc    <= '0';
                o_ALUOp     <= "1101";
                o_Signed    <= '1';
                o_Bne       <= '1';
                o_Beq       <= '0';
                o_Branch    <= '1';
                o_shiftType <= '0';
                o_Jr        <= '0';
                o_Jal       <= '0';
                o_Jump      <= '0';
                o_Lui       <= '0';
                o_Halt      <= '0';
            elsif i_OpCode = "000010" then  -- j 
                o_RegDst    <= '0';
                o_RegWrite  <= '0';
                o_MemToReg  <= '0';
                o_MemWrite  <= '0';
                o_ALUSrc    <= '0';
                o_ALUOp     <= "1011";
                o_Signed    <= '0';
                o_Jal       <= '0';
                o_Jr        <= '0';
                o_Jump      <= '1';
                o_shiftType <= '0';
                o_Bne       <= '0';
                o_Beq       <= '0';
                o_Branch    <= '0';
                o_Lui       <= '0';
                o_Halt      <= '0';
            elsif i_OpCode = "000011" then  -- jal 
                o_RegDst    <= '0';
                o_RegWrite  <= '1';
                o_MemToReg  <= '0';
                o_MemWrite  <= '0';
                o_ALUSrc    <= '0';
                o_ALUOp     <= "1011";
                o_Signed    <= '0';
                o_Jal       <= '1';
                o_Jr        <= '0';
                o_Jump      <= '1';
                o_shiftType <= '0';
                o_Bne       <= '0';
                o_Beq       <= '0';
                o_Branch    <= '0';
                o_Lui       <= '0';
                o_Halt      <= '0';
            elsif i_OpCode = "010100" then  -- halt  
                o_RegDst    <= '0';
                o_RegWrite  <= '0';
                o_MemToReg  <= '0';
                o_MemWrite  <= '0';
                o_ALUSrc    <= '0';
                o_ALUOp     <= "0000";
                o_Signed    <= '0';
                o_shiftType <= '0';
                o_Bne       <= '0';
                o_Beq       <= '0';
                o_Branch    <= '0';
                o_Jr        <= '0';
                o_Jal       <= '0';
                o_Jump      <= '0';
                o_Lui       <= '0';
                o_Halt      <= '1';
            else
                o_RegDst    <= '0';
                o_RegWrite  <= '0';
                o_MemToReg  <= '0';
                o_MemWrite  <= '0';
                o_ALUSrc    <= '0';
                o_ALUOp     <= "0000";
                o_Signed    <= '0';
                o_shiftType <= '0';
                o_Bne       <= '0';
                o_Beq       <= '0';
                o_Branch    <= '0';
                o_Jr        <= '0';
                o_Jal       <= '0';
                o_Jump      <= '0';
                o_Lui       <= '0';
                o_Halt      <= '0';
            end if;
        else                                -- Handle R-Type instruciton
            if i_Funct = "100000" then      -- add 
                o_RegDst    <= '1';
                o_RegWrite  <= '1';
                o_MemToReg  <= '0';
                o_MemWrite  <= '0';
                o_ALUSrc    <= '0';
                o_ALUOp     <= "0010";
                o_Signed    <= '1';
                o_shiftType <= '0';
                o_Bne       <= '0';
                o_Beq       <= '0';
                o_Branch    <= '0';
                o_Jr        <= '0';
                o_Jal       <= '0';
                o_Jump      <= '0';
                o_Lui       <= '0';
                o_Halt      <= '0';
            elsif i_Funct = "100001" then   -- addu 
                o_RegDst    <= '1';
                o_RegWrite  <= '1';
                o_MemToReg  <= '0';
                o_MemWrite  <= '0';
                o_ALUSrc    <= '0';
                o_ALUOp     <= "0001";
                o_Signed    <= '0';
                o_shiftType <= '0';
                o_Bne       <= '0';
                o_Beq       <= '0';
                o_Branch    <= '0';
                o_Jr        <= '0';
                o_Jal       <= '0';
                o_Jump      <= '0';
                o_Lui       <= '0';
                o_Halt      <= '0';
            elsif i_Funct = "100100" then   -- and 
                o_RegDst    <= '1';
                o_RegWrite  <= '1';
                o_MemToReg  <= '0';
                o_MemWrite  <= '0';
                o_ALUSrc    <= '0';
                o_ALUOp     <= "0100";
                o_Signed    <= '0';
                o_shiftType <= '0';
                o_Bne       <= '0';
                o_Beq       <= '0';
                o_Branch    <= '0';
                o_Jr        <= '0';
                o_Jal       <= '0';
                o_Jump      <= '0';
                o_Lui       <= '0';
                o_Halt      <= '0';
            elsif i_Funct = "100111" then   -- nor 
                o_RegDst    <= '1';
                o_RegWrite  <= '1';
                o_MemToReg  <= '0';
                o_MemWrite  <= '0';
                o_ALUSrc    <= '0';
                o_ALUOp     <= "0111";
                o_Signed    <= '0';
                o_shiftType <= '0';
                o_Bne       <= '0';
                o_Beq       <= '0';
                o_Branch    <= '0';
                o_Jr        <= '0';
                o_Jal       <= '0';
                o_Jump      <= '0';
                o_Lui       <= '0';
                o_Halt      <= '0';
            elsif i_Funct = "100110" then   -- xor 
                o_RegDst    <= '1';
                o_RegWrite  <= '1';
                o_MemToReg  <= '0';
                o_MemWrite  <= '0';
                o_ALUSrc    <= '0';
                o_ALUOp     <= "0110";
                o_Signed    <= '0';
                o_shiftType <= '0';
                o_Bne       <= '0';
                o_Beq       <= '0';
                o_Branch    <= '0';
                o_Jr        <= '0';
                o_Jal       <= '0';
                o_Jump      <= '0';
                o_Lui       <= '0';
                o_Halt      <= '0';
            elsif i_Funct = "100101" then   -- or 
                o_RegDst    <= '1';
                o_RegWrite  <= '1';
                o_MemToReg  <= '0';
                o_MemWrite  <= '0';
                o_ALUSrc    <= '0';
                o_ALUOp     <= "0101";
                o_Signed    <= '0';
                o_shiftType <= '0';
                o_Bne       <= '0';
                o_Beq       <= '0';
                o_Branch    <= '0';
                o_Jr        <= '0';
                o_Jal       <= '0';
                o_Jump      <= '0';
                o_Lui       <= '0';
                o_Halt      <= '0';
            elsif i_Funct = "101010" then   -- slt 
                o_RegDst    <= '1';
                o_RegWrite  <= '1';
                o_MemToReg  <= '0';
                o_MemWrite  <= '0';
                o_ALUSrc    <= '0';
                o_ALUOp     <= "1000";
                o_Signed    <= '1';
                o_shiftType <= '0';
                o_Bne       <= '0';
                o_Beq       <= '0';
                o_Branch    <= '0';
                o_Jr        <= '0';
                o_Jal       <= '0';
                o_Jump      <= '0';
                o_Lui       <= '0';
                o_Halt      <= '0';
            elsif i_Funct = "000000" then   -- sll 
                o_RegDst    <= '1';
                o_RegWrite  <= '1';
                o_MemToReg  <= '0';
                o_MemWrite  <= '0';
                o_ALUSrc    <= '0';
                o_ALUOp     <= "1010";
                o_Signed    <= '0';
                o_shiftType <= '0';
                o_Bne       <= '0';
                o_Beq       <= '0';
                o_Branch    <= '0';
                o_Jr        <= '0';
                o_Jal       <= '0';
                o_Jump      <= '0';
                o_Lui       <= '0';
                o_Halt      <= '0';
            elsif i_Funct = "000010" then   -- srl 
                o_RegDst    <= '1';
                o_RegWrite  <= '1';
                o_MemToReg  <= '0';
                o_MemWrite  <= '0';
                o_ALUSrc    <= '0';
                o_ALUOp     <= "1011";
                o_Signed    <= '0';
                o_shiftType <= '0';
                o_Bne       <= '0';
                o_Beq       <= '0';
                o_Branch    <= '0';
                o_Jr        <= '0';
                o_Jal       <= '0';
                o_Jump      <= '0';
                o_Lui       <= '0';
                o_Halt      <= '0';
            elsif i_Funct = "000011" then   -- sra 
                o_RegDst    <= '1';
                o_RegWrite  <= '1';
                o_MemToReg  <= '0';
                o_MemWrite  <= '0';
                o_ALUSrc    <= '0';
                o_ALUOp     <= "1100";
                o_Signed    <= '0';
                o_shiftType <= '1';
                o_Bne       <= '0';
                o_Beq       <= '0';
                o_Branch    <= '0';
                o_Jr        <= '0';
                o_Jal       <= '0';
                o_Jump      <= '0';
                o_Lui       <= '0';
                o_Halt      <= '0';
            elsif i_Funct = "100010" then   -- sub 
                o_RegDst    <= '1';
                o_RegWrite  <= '1';
                o_MemToReg  <= '0';
                o_MemWrite  <= '0';
                o_ALUSrc    <= '0';
                o_ALUOp     <= "1111";
                o_Signed    <= '1';
                o_shiftType <= '0';
                o_Bne       <= '0';
                o_Beq       <= '0';
                o_Branch    <= '0';
                o_Jr        <= '0';
                o_Jal       <= '0';
                o_Jump      <= '0';
                o_Lui       <= '0';
                o_Halt      <= '0';
            elsif i_Funct = "100011" then   -- subu 
                o_RegDst    <= '1';
                o_RegWrite  <= '1';
                o_MemToReg  <= '0';
                o_MemWrite  <= '0';
                o_ALUSrc    <= '0';
                o_ALUOp     <= "0011";
                o_Signed    <= '0';
                o_shiftType <= '0';
                o_Bne       <= '0';
                o_Beq       <= '0';
                o_Branch    <= '0';
                o_Jr        <= '0';
                o_Jal       <= '0';
                o_Jump      <= '0';
                o_Lui       <= '0';
                o_Halt      <= '0';
            elsif i_Funct = "001000" then   -- jr 
                o_RegDst    <= '0';
                o_RegWrite  <= '0';
                o_MemToReg  <= '0';
                o_MemWrite  <= '0';
                o_ALUSrc    <= '0';
                o_ALUOp     <= "1011";
                o_Signed    <= '0';
                o_shiftType <= '0';
                o_Bne       <= '0';
                o_Beq       <= '0';
                o_Branch    <= '0';
                o_Jal       <= '0';
                o_Jr        <= '1';
                o_Jump      <= '1';
                o_Lui       <= '0';
                o_Halt      <= '0';
            else                            -- UNKNOWN
                o_RegDst    <= '0';
                o_RegWrite  <= '0';
                o_MemToReg  <= '0';
                o_MemWrite  <= '0';
                o_ALUSrc    <= '0';
                o_ALUOp     <= "0000";
                o_Signed    <= '0';
                o_shiftType <= '0';
                o_Bne       <= '0';
                o_Beq       <= '0';
                o_Branch    <= '0';
                o_Jal       <= '0';
                o_Jr        <= '0';
                o_Jump      <= '0';
                o_Lui       <= '0';
                o_Halt      <= '0';
            end if;
        end if;
    end process;
end behavioral;

