#Aidan W Foss Dec 5th 2024
#Commented out lines are because they are not implemented in the hw pipeline - they arent required
#add, addi, addiu, addu, and, andi, lui, lw, nor, xor, xori, or,
#ori, slt, slti, sll, srl, sra, sw, sub, subu, beq, bne, j, jal, jr

#data sections
.data
words:.word	0 : 19        # "array" of words to contain word values
size: .word  	19             # size of "array" (agrees with array declaration)

##
##Tests the following instructions
## Add, Addi, addiu, addu, sub, subu, and, andi or, ori, xor, xori, nor, slt, slti, sll, srl, sra, sllv, srlv, srav
## lw, lh, lhu, lb, lbu, sw, sh, sb, lui
## beq, bne
## j, jal, jr
##

.text
addi $t0, $zero, 5

halt
