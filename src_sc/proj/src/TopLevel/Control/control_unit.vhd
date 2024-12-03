-- <header>
-- Author(s): Conner Ohnesorge
-- Name: 
-- Notes:
--      Conner Ohnesorge 2024-11-21T11:05:34-06:00 added-old-single-cycle-processor-and-added-documentation-for-the
-- </header>

library IEEE;
use IEEE.std_logic_1164.all;
entity control_unit is
    port
        (
            i_opcode    : in  std_logic_vector(5 downto 0);  -- determines Non-R-type instruction type
            i_funct     : in  std_logic_vector(5 downto 0);  -- determines R-type instruction type
            o_Ctrl_Unit : out std_logic_vector(20 downto 0)  -- output control signals
            );
end control_unit;
-- architecture declaration of control_unit
architecture dataflow of control_unit is
    signal s_RTYPE_funct : std_logic_vector(20 downto 0);  -- if its an R-type instruction, use the R-type funct code
begin
    -- bit(s) 20        selects between either loading a word or a half/byte from memory
    -- bit(s) 19        half or byte extention type indicator, determines if lb/lbu/lh/lhu instruction
    -- bit(s) 18        half or byte indicator, determines if lb/lbu/lh/lhu instruction
    -- bit(s) 17        branch
    -- bit(s) 16        sllv/srlv/srav          determines if sllv/srlv/srav instruction is happening muxes in register value in place of shamt 
    -- bit(s) 15        lui                     determines if and lui or v instruction is happening and hardcodes shamt value or swaps
    -- bit(s) 14        jr                      determines if a jr instruction is happening, muxes/replaces the normal jump address reg val in $31
    -- bit(s) 13        jal                     determines if a jal instruction is happening, causes PC+4 to be stored in $31 and 
    -- bit(s) 12        ALU                     determines if ALU gets an immediate or register value
    -- bit(s) [11:8]    ALU opcode,             concatonated with shamt to make the ALUcontrol for the mainALU
    -- bit(s) 7         Memory writeback,       determines if memory value or ALU value goes back into reg_file
    -- bit(s) 6         Memory write,           determines if memory is written to during instruction
    -- bit(s) 5         Register write,         determines if instruction writes to memory or not
    -- bit(s) 4         Register Destination,   determines destination of either ALU or Memory value back into reg_file
    -- bit(s) 3         Branch bit,             indicates in 1st mux if branch is occuring (dictates address going back to PC)
    -- bit(s) 2         Sign-extend bit,        determines if extenders have signed or unsigned extend
    -- bit(s) 1         Jump-bit,               used in final mux to indicate jump address goes back to PC
    -- bit(s) 0         halt bit,               used to stop simulation
    with i_opcode select o_Ctrl_Unit <=
        s_RTYPE_funct           when "000000",  -- R-TYPE instructions don't use opcode (use funct field instead)
        "000000000000000000001" when "010100",  -- halt
        "000000000000000000110" when "000010",  -- j
        "000000010000000100110" when "000011",  -- jal
        "000000000000100001100" when "000100",  -- beq (do subtraction)
        "000100000000100000100" when "000101",  -- bne (do subtraction)
        "000000001001000100100" when "001000",  -- addi
        "000000001000000100100" when "001001",  -- addiu
        "000000001011100100100" when "001010",  -- slti
        "000000001110100100100" when "001011",  -- sltiu
        "000000001010100100000" when "001100",  -- andi
        "000000001100100100000" when "001101",  -- ori
        "000000001101000100000" when "001110",  -- xori
        "000001001010000100100" when "001111",  -- lui (do a sll injecting 16 as shamt)
        "110000001000010100100" when "100000",  -- lb
        "111000001000010100100" when "100001",  -- lh
        "000000001000010100100" when "100011",  -- lw
        "100000001000010100100" when "100100",  -- lbu
        "101000001000010100100" when "100101",  -- lhu
        "000000001000001000100" when "101011",  -- sw
        "000000000000000000000" when others;
    with i_funct select s_RTYPE_funct <=
        "000000100000000000110" when "001000",  -- jr
        "000000000010000110100" when "000000",  -- sll
        "000000000110000110000" when "000010",  -- srl
        "000000000111000110100" when "000011",  -- sra
        "000010000010000110100" when "000100",  -- sllv
        "000010000110000110000" when "000110",  -- srlv
        "000010000111000110100" when "000111",  -- srav
        "000000000001000110100" when "100000",  -- add
        "000000000000000110100" when "100001",  -- addu
        "000000000001100110100" when "100010",  -- sub
        "000000000000100110100" when "100011",  -- subu
        "000000000010100110100" when "100100",  -- and
        "000000000101000110100" when "100110",  -- xor
        "000000000100000110100" when "100111",  -- nor
        "000000000100100110100" when "100101",  -- or
        "000000000011100110100" when "101010",  -- slt
        "000000000110100110100" when "101011",  -- sltu
        "000000000000000000000" when others;    -- R-TYPE and others
end dataflow;

