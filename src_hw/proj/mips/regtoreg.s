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
#store 1-10 in $t1-$t10
addi  $1,  $0,  1 		# Place “1” in $1
addiu $2,  $0,  2		# Place “2” in $2
addi  $3,  $0,  3		# Place “3” in $3
addi  $4,  $0,  4		# Place “4” in $4
addi  $5,  $0,  5		# Place “5” in $5
addi  $6,  $0,  6		# Place “6” in $6
addi  $7,  $0,  7		# Place “7” in $7
addi  $8,  $0,  8		# Place “8” in $8
addi  $9,  $0,  9		# Place “9” in $9
addi  $10, $0,  -8		# Place “10” in $10


add	$11, $10,  $2		# $11 = -8 + 2 = -6
addu	$12, $11,  $4		# $12 = -6 + 4 = -2
sub 	$13, $12,  $5 		# $12 = -2 - 5 = -7
