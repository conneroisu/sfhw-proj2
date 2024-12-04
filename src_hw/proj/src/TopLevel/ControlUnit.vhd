library IEEE;
use IEEE.std_logic_1164.all;

entity ControlUnit is
    
    port (
        i_opCode    : in  std_logic_vector(5 downto 0);  --MIPS instruction opcode (6 bits wide)
        i_funct     : in  std_logic_vector(5 downto 0);  --MIPS instruction function code (6 bits wide) used for R-Type instructions
        o_RegDst    : out std_logic;
        o_RegWrite  : out std_logic;
        o_memToReg  : out std_logic;
        o_memWrite  : out std_logic;
        o_ALUSrc    : out std_logic;
        o_ALUOp     : out std_logic_vector(3 downto 0);
        o_signed    : out std_logic;
        o_addSub    : out std_logic;
        o_shiftType : out std_logic;
        o_shiftDir  : out std_logic;
        o_bne       : out std_logic;
        o_beq       : out std_logic;
        o_j         : out std_logic;
        o_jr        : out std_logic;
        o_jal       : out std_logic;
        o_branch    : out std_logic;
        o_jump      : out std_logic;
        o_lui       : out std_logic;
        o_halt      : out std_logic
        );
    
end ControlUnit;

architecture behavioral of ControlUnit is
begin
    process(i_opcode, i_funct)
    begin
        if i_opcode /= "000000" then        --I and J type instructions
            if i_opCode = "001000" then     --addi 
                o_RegDst    <= '0';
                o_RegWrite  <= '1';
                o_memToReg  <= '0';
                o_memWrite  <= '0';
                o_ALUSrc    <= '1';
                o_ALUOp     <= "0010";
                o_signed    <= '1';
                o_addSub    <= '0';
                o_shiftType <= '0';
                o_shiftDir  <= '0';
                o_bne       <= '0';
                o_beq       <= '0';
                o_branch    <= '0';
                o_j         <= '0';
                o_jr        <= '0';
                o_jal       <= '0';
                o_jump      <= '0';
                o_lui       <= '0';
                o_halt      <= '0';
            elsif i_opCode = "001001" then  --addiu 
                o_RegDst    <= '0';
                o_RegWrite  <= '1';
                o_memToReg  <= '0';
                o_memWrite  <= '0';
                o_ALUSrc    <= '1';
                o_ALUOp     <= "0001";
                o_signed    <= '1';
                o_addSub    <= '0';
                o_shiftType <= '0';
                o_shiftDir  <= '0';
                o_bne       <= '0';
                o_beq       <= '0';
                o_branch    <= '0';
                o_j         <= '0';
                o_jr        <= '0';
                o_jal       <= '0';
                o_jump      <= '0';
                o_lui       <= '0';
                o_halt      <= '0';
            elsif i_opCode = "001100" then  --andi 
                o_RegDst    <= '0';
                o_RegWrite  <= '1';
                o_memToReg  <= '0';
                o_memWrite  <= '0';
                o_ALUSrc    <= '1';
                o_ALUOp     <= "0100";
                o_signed    <= '0';
                o_addSub    <= '0';
                o_shiftType <= '0';
                o_shiftDir  <= '0';
                o_bne       <= '0';
                o_beq       <= '0';
                o_branch    <= '0';
                o_j         <= '0';
                o_jr        <= '0';
                o_jal       <= '0';
                o_jump      <= '0';
                o_lui       <= '0';
                o_halt      <= '0';
            elsif i_opCode = "001111" then  --lui 
                o_RegDst    <= '0';
                o_RegWrite  <= '1';
                o_memToReg  <= '0';
                o_memWrite  <= '0';
                o_ALUSrc    <= '1';
                o_ALUOp     <= "1001";
                o_signed    <= '0';
                o_addSub    <= '0';
                o_shiftType <= '0';
                o_shiftDir  <= '1';
                o_bne       <= '0';
                o_beq       <= '0';
                o_branch    <= '0';
                o_j         <= '0';
                o_jr        <= '0';
                o_jal       <= '0';
                o_jump      <= '0';
                o_lui       <= '1';
                o_halt      <= '0';
            elsif i_opCode = "100011" then  --lw 
                o_RegDst    <= '0';
                o_RegWrite  <= '1';
                o_memToReg  <= '1';
                o_memWrite  <= '0';
                o_ALUSrc    <= '1';
                o_ALUOp     <= "0010";
                o_signed    <= '0';
                o_addSub    <= '0';
                o_shiftType <= '0';
                o_shiftDir  <= '0';
                o_bne       <= '0';
                o_beq       <= '0';
                o_branch    <= '0';
                o_j         <= '0';
                o_jr        <= '0';
                o_jal       <= '0';
                o_jump      <= '0';
                o_lui       <= '0';
                o_halt      <= '0';
            elsif i_opCode = "001110" then  --xori 
                o_RegDst    <= '0';
                o_RegWrite  <= '1';
                o_memToReg  <= '0';
                o_memWrite  <= '0';
                o_ALUSrc    <= '1';
                o_ALUOp     <= "0110";
                o_signed    <= '0';
                o_addSub    <= '0';
                o_shiftType <= '0';
                o_shiftDir  <= '0';
                o_bne       <= '0';
                o_beq       <= '0';
                o_branch    <= '0';
                o_j         <= '0';
                o_jr        <= '0';
                o_jal       <= '0';
                o_jump      <= '0';
                o_lui       <= '0';
                o_halt      <= '0';
            elsif i_opCode = "001101" then  --ori 
                o_RegDst    <= '0';
                o_RegWrite  <= '1';
                o_memToReg  <= '0';
                o_memWrite  <= '0';
                o_ALUSrc    <= '1';
                o_ALUOp     <= "0101";
                o_signed    <= '0';
                o_addSub    <= '0';
                o_shiftType <= '0';
                o_shiftDir  <= '0';
                o_bne       <= '0';
                o_beq       <= '0';
                o_branch    <= '0';
                o_j         <= '0';
                o_jr        <= '0';
                o_jal       <= '0';
                o_jump      <= '0';
                o_lui       <= '0';
                o_halt      <= '0';
            elsif i_opCode = "001010" then  --slti 
                o_RegDst    <= '0';
                o_RegWrite  <= '1';
                o_memToReg  <= '0';
                o_memWrite  <= '0';
                o_ALUSrc    <= '1';
                o_ALUOp     <= "1000";
                o_signed    <= '1';
                o_addSub    <= '0';
                o_shiftType <= '0';
                o_shiftDir  <= '0';
                o_bne       <= '0';
                o_beq       <= '0';
                o_branch    <= '0';
                o_j         <= '0';
                o_jr        <= '0';
                o_jal       <= '0';
                o_jump      <= '0';
                o_lui       <= '0';
                o_halt      <= '0';
            elsif i_opCode = "101011" then  --sw 
                o_RegDst    <= '0';
                o_RegWrite  <= '0';
                o_memToReg  <= '0';
                o_memWrite  <= '1';
                o_ALUSrc    <= '1';
                o_ALUOp     <= "0010";
                o_signed    <= '0';
                o_addSub    <= '0';
                o_shiftType <= '0';
                o_shiftDir  <= '0';
                o_bne       <= '0';
                o_beq       <= '0';
                o_branch    <= '0';
                o_j         <= '0';
                o_jr        <= '0';
                o_jal       <= '0';
                o_jump      <= '0';
                o_lui       <= '0';
                o_halt      <= '0';
            elsif i_opCode = "000100" then  --beq 
                o_RegDst    <= '0';
                o_RegWrite  <= '0';
                o_memToReg  <= '0';
                o_memWrite  <= '0';
                o_ALUSrc    <= '0';
                o_ALUOp     <= "1110";
                o_signed    <= '1';
                o_bne       <= '0';
                o_beq       <= '1';
                o_branch    <= '1';
                o_addSub    <= '0';
                o_shiftType <= '0';
                o_shiftDir  <= '0';
                o_j         <= '0';
                o_jr        <= '0';
                o_jal       <= '0';
                o_jump      <= '0';
                o_lui       <= '0';
                o_halt      <= '0';
            elsif i_opCode = "000101" then  --bne 
                o_RegDst    <= '0';
                o_RegWrite  <= '0';
                o_memToReg  <= '0';
                o_memWrite  <= '0';
                o_ALUSrc    <= '0';
                o_ALUOp     <= "1101";
                o_signed    <= '1';
                o_bne       <= '1';
                o_beq       <= '0';
                o_branch    <= '1';
                o_addSub    <= '0';
                o_shiftType <= '0';
                o_shiftDir  <= '0';
                o_j         <= '0';
                o_jr        <= '0';
                o_jal       <= '0';
                o_jump      <= '0';
                o_lui       <= '0';
                o_halt      <= '0';
            elsif i_opCode = "000010" then  --j 
                o_RegDst    <= '0';
                o_RegWrite  <= '0';
                o_memToReg  <= '0';
                o_memWrite  <= '0';
                o_ALUSrc    <= '0';
                o_ALUOp     <= "1011";
                o_signed    <= '0';
                o_j         <= '1';
                o_jal       <= '0';
                o_jr        <= '0';
                o_jump      <= '1';
                o_addSub    <= '0';
                o_shiftType <= '0';
                o_shiftDir  <= '0';
                o_bne       <= '0';
                o_beq       <= '0';
                o_branch    <= '0';
                o_lui       <= '0';
                o_halt      <= '0';
            elsif i_opCode = "000011" then  --jal 
                o_RegDst    <= '0';
                o_RegWrite  <= '1';
                o_memToReg  <= '0';
                o_memWrite  <= '0';
                o_ALUSrc    <= '0';
                o_ALUOp     <= "1011";
                o_signed    <= '0';
                o_j         <= '0';
                o_jal       <= '1';
                o_jr        <= '0';
                o_jump      <= '1';
                o_addSub    <= '0';
                o_shiftType <= '0';
                o_shiftDir  <= '0';
                o_bne       <= '0';
                o_beq       <= '0';
                o_branch    <= '0';
                o_lui       <= '0';
                o_halt      <= '0';
            elsif i_opCode = "010100" then  --halt  
                o_RegDst    <= '0';
                o_RegWrite  <= '0';
                o_memToReg  <= '0';
                o_memWrite  <= '0';
                o_ALUSrc    <= '0';
                o_ALUOp     <= "0000";
                o_signed    <= '0';
                o_addSub    <= '0';
                o_shiftType <= '0';
                o_shiftDir  <= '0';
                o_bne       <= '0';
                o_beq       <= '0';
                o_branch    <= '0';
                o_j         <= '0';
                o_jr        <= '0';
                o_jal       <= '0';
                o_jump      <= '0';
                o_lui       <= '0';
                o_halt      <= '1';
            else
                o_RegDst    <= '0';
                o_RegWrite  <= '0';
                o_memToReg  <= '0';
                o_memWrite  <= '0';
                o_ALUSrc    <= '0';
                o_ALUOp     <= "0000";
                o_signed    <= '0';
                o_addSub    <= '0';
                o_shiftType <= '0';
                o_shiftDir  <= '0';
                o_bne       <= '0';
                o_beq       <= '0';
                o_branch    <= '0';
                o_j         <= '0';
                o_jr        <= '0';
                o_jal       <= '0';
                o_jump      <= '0';
                o_lui       <= '0';
                o_halt      <= '0';
            end if;
        else                                -- Handle R-Type instruciton
            if i_funct = "100000" then      --add 
                o_RegDst    <= '1';
                o_RegWrite  <= '1';
                o_memToReg  <= '0';
                o_memWrite  <= '0';
                o_ALUSrc    <= '0';
                o_ALUOp     <= "0010";
                o_signed    <= '1';
                o_addSub    <= '0';
                o_shiftType <= '0';
                o_shiftDir  <= '0';
                o_bne       <= '0';
                o_beq       <= '0';
                o_branch    <= '0';
                o_j         <= '0';
                o_jr        <= '0';
                o_jal       <= '0';
                o_jump      <= '0';
                o_lui       <= '0';
                o_halt      <= '0';
            elsif i_funct = "100001" then   --addu 
                o_RegDst    <= '1';
                o_RegWrite  <= '1';
                o_memToReg  <= '0';
                o_memWrite  <= '0';
                o_ALUSrc    <= '0';
                o_ALUOp     <= "0001";
                o_signed    <= '0';
                o_addSub    <= '0';
                o_shiftType <= '0';
                o_shiftDir  <= '0';
                o_bne       <= '0';
                o_beq       <= '0';
                o_branch    <= '0';
                o_j         <= '0';
                o_jr        <= '0';
                o_jal       <= '0';
                o_jump      <= '0';
                o_lui       <= '0';
                o_halt      <= '0';
            elsif i_funct = "100100" then   --and 
                o_RegDst    <= '1';
                o_RegWrite  <= '1';
                o_memToReg  <= '0';
                o_memWrite  <= '0';
                o_ALUSrc    <= '0';
                o_ALUOp     <= "0100";
                o_signed    <= '0';
                o_addSub    <= '0';
                o_shiftType <= '0';
                o_shiftDir  <= '0';
                o_bne       <= '0';
                o_beq       <= '0';
                o_branch    <= '0';
                o_j         <= '0';
                o_jr        <= '0';
                o_jal       <= '0';
                o_jump      <= '0';
                o_lui       <= '0';
                o_halt      <= '0';
            elsif i_funct = "100111" then   --nor 
                o_RegDst    <= '1';
                o_RegWrite  <= '1';
                o_memToReg  <= '0';
                o_memWrite  <= '0';
                o_ALUSrc    <= '0';
                o_ALUOp     <= "0111";
                o_signed    <= '0';
                o_addSub    <= '0';
                o_shiftType <= '0';
                o_shiftDir  <= '0';
                o_bne       <= '0';
                o_beq       <= '0';
                o_branch    <= '0';
                o_j         <= '0';
                o_jr        <= '0';
                o_jal       <= '0';
                o_jump      <= '0';
                o_lui       <= '0';
                o_halt      <= '0';
            elsif i_funct = "100110" then   --xor 
                o_RegDst    <= '1';
                o_RegWrite  <= '1';
                o_memToReg  <= '0';
                o_memWrite  <= '0';
                o_ALUSrc    <= '0';
                o_ALUOp     <= "0110";
                o_signed    <= '0';
                o_addSub    <= '0';
                o_shiftType <= '0';
                o_shiftDir  <= '0';
                o_bne       <= '0';
                o_beq       <= '0';
                o_branch    <= '0';
                o_j         <= '0';
                o_jr        <= '0';
                o_jal       <= '0';
                o_jump      <= '0';
                o_lui       <= '0';
                o_halt      <= '0';
            elsif i_funct = "100101" then   --or 
                o_RegDst    <= '1';
                o_RegWrite  <= '1';
                o_memToReg  <= '0';
                o_memWrite  <= '0';
                o_ALUSrc    <= '0';
                o_ALUOp     <= "0101";
                o_signed    <= '0';
                o_addSub    <= '0';
                o_shiftType <= '0';
                o_shiftDir  <= '0';
                o_bne       <= '0';
                o_beq       <= '0';
                o_branch    <= '0';
                o_j         <= '0';
                o_jr        <= '0';
                o_jal       <= '0';
                o_jump      <= '0';
                o_lui       <= '0';
                o_halt      <= '0';
            elsif i_funct = "101010" then   --slt 
                o_RegDst    <= '1';
                o_RegWrite  <= '1';
                o_memToReg  <= '0';
                o_memWrite  <= '0';
                o_ALUSrc    <= '0';
                o_ALUOp     <= "1000";
                o_signed    <= '1';
                o_addSub    <= '0';
                o_shiftType <= '0';
                o_shiftDir  <= '0';
                o_bne       <= '0';
                o_beq       <= '0';
                o_branch    <= '0';
                o_j         <= '0';
                o_jr        <= '0';
                o_jal       <= '0';
                o_jump      <= '0';
                o_lui       <= '0';
                o_halt      <= '0';
            elsif i_funct = "000000" then   --sll 
                o_RegDst    <= '1';
                o_RegWrite  <= '1';
                o_memToReg  <= '0';
                o_memWrite  <= '0';
                o_ALUSrc    <= '0';
                o_ALUOp     <= "1010";
                o_signed    <= '0';
                o_shiftType <= '0';
                o_shiftDir  <= '1';
                o_addSub    <= '0';
                o_bne       <= '0';
                o_beq       <= '0';
                o_branch    <= '0';
                o_j         <= '0';
                o_jr        <= '0';
                o_jal       <= '0';
                o_jump      <= '0';
                o_lui       <= '0';
                o_halt      <= '0';
            elsif i_funct = "000010" then   --srl 
                o_RegDst    <= '1';
                o_RegWrite  <= '1';
                o_memToReg  <= '0';
                o_memWrite  <= '0';
                o_ALUSrc    <= '0';
                o_ALUOp     <= "1011";
                o_signed    <= '0';
                o_shiftType <= '0';
                o_shiftDir  <= '0';
                o_addSub    <= '0';
                o_bne       <= '0';
                o_beq       <= '0';
                o_branch    <= '0';
                o_j         <= '0';
                o_jr        <= '0';
                o_jal       <= '0';
                o_jump      <= '0';
                o_lui       <= '0';
                o_halt      <= '0';
            elsif i_funct = "000011" then   --sra 
                o_RegDst    <= '1';
                o_RegWrite  <= '1';
                o_memToReg  <= '0';
                o_memWrite  <= '0';
                o_ALUSrc    <= '0';
                o_ALUOp     <= "1100";
                o_signed    <= '0';
                o_shiftType <= '1';
                o_shiftDir  <= '0';
                o_addSub    <= '0';
                o_bne       <= '0';
                o_beq       <= '0';
                o_branch    <= '0';
                o_j         <= '0';
                o_jr        <= '0';
                o_jal       <= '0';
                o_jump      <= '0';
                o_lui       <= '0';
                o_halt      <= '0';
            elsif i_funct = "100010" then   --sub 
                o_RegDst    <= '1';
                o_RegWrite  <= '1';
                o_memToReg  <= '0';
                o_memWrite  <= '0';
                o_ALUSrc    <= '0';
                o_ALUOp     <= "1111";
                o_signed    <= '1';
                o_addSub    <= '1';
                o_shiftType <= '0';
                o_shiftDir  <= '0';
                o_bne       <= '0';
                o_beq       <= '0';
                o_branch    <= '0';
                o_j         <= '0';
                o_jr        <= '0';
                o_jal       <= '0';
                o_jump      <= '0';
                o_lui       <= '0';
                o_halt      <= '0';
            elsif i_funct = "100011" then   --subu 
                o_RegDst    <= '1';
                o_RegWrite  <= '1';
                o_memToReg  <= '0';
                o_memWrite  <= '0';
                o_ALUSrc    <= '0';
                o_ALUOp     <= "0011";
                o_signed    <= '0';
                o_addSub    <= '1';
                o_shiftType <= '0';
                o_shiftDir  <= '0';
                o_bne       <= '0';
                o_beq       <= '0';
                o_branch    <= '0';
                o_j         <= '0';
                o_jr        <= '0';
                o_jal       <= '0';
                o_jump      <= '0';
                o_lui       <= '0';
                o_halt      <= '0';
            elsif i_funct = "001000" then   --jr 
                o_RegDst    <= '0';
                o_RegWrite  <= '0';
                o_memToReg  <= '0';
                o_memWrite  <= '0';
                o_ALUSrc    <= '0';
                o_ALUOp     <= "1011";
                o_signed    <= '0';
                o_addSub    <= '0';
                o_shiftType <= '0';
                o_shiftDir  <= '0';
                o_bne       <= '0';
                o_beq       <= '0';
                o_branch    <= '0';
                o_j         <= '0';
                o_jal       <= '0';
                o_jr        <= '1';
                o_jump      <= '1';
                o_lui       <= '0';
                o_halt      <= '0';
            else
                o_RegDst    <= '0';
                o_RegWrite  <= '0';
                o_memToReg  <= '0';
                o_memWrite  <= '0';
                o_ALUSrc    <= '0';
                o_ALUOp     <= "0000";
                o_signed    <= '0';
                o_addSub    <= '0';
                o_shiftType <= '0';
                o_shiftDir  <= '0';
                o_bne       <= '0';
                o_beq       <= '0';
                o_branch    <= '0';
                o_j         <= '0';
                o_jal       <= '0';
                o_jr        <= '0';
                o_jump      <= '0';
                o_lui       <= '0';
                o_halt      <= '0';
            end if;
        end if;
    end process;
end behavioral;
