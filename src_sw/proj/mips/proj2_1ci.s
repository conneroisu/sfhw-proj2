#Aidan W Foss Dec 5th 2024

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

add	$11, $1,  $2		# $11 = $1 + $2	 (1+2 = 3)
addu	$12, $3,  $4		# $12 = $3 + $4	 (3+4 = 7)
sub 	$13, $11, $5 		# $12 = $11 - $5 (3-5 = -2)
subu	$14, $12, $6		# $14 = $12 - $6 (7-6 = 1)
and	$15, $5, $1		# $15 = $4 AND $1 (0101 AND 0001 = 0001 = 1)
andi	$16, $5, 1		# $16 = $4 AND 0001 (0101 AND 0001 = 0001 = 1)
or	$17, $4, $1		# $17 = $4 OR $1 (0101 OR 0001 = 0101 = 5)
ori	$18, $4, 1		# $18 = $4 OR 1 (0101 OR 0001 = 0101 = 5)
xor	$19, $7, $5		# $19 = $7 XOR $5 (0111 XOR 0101 = 0010 = 2)
xori	$20, $7, 4 		# $20 = $7 XOR 4 (0111 XOR 0100 = 0011 = 3)
nor	$11, $5, $4		# $11 = $5 NOR $4 (0...0101 NOR 0...0100 = 11111111111111111111111111111011 = -5)
slt	$12, $2, $3		# if $2 < $3 (it is), set $12 to 1
slti	$13, $2, 3		# if $2 < $3 (it is), set $13 to 1
sll	$14, $1, 1		# shift $1 left one bit, so 0001 becomes 0010
srl	$15, $2, 1		# shift $2 right one bit, so 0010 becomes 0001
sra	$16, $10, 1		# shift $10 (-8) right one bit, so -8 becomes -4
sllv	$17, $1, $2		# shift $1 left $2 times (2), so 0001 becomes 0100 = 4
srlv	$18, $4, $2		# shift $4 right $2 times (2), so 0100 becomes 0001
srav	$19, $10, $2		# shift $10 (-8) right $2 times (2) maintaining signage, so -8 becomes -2

##FINISH OR FIX ALL INSTRUCTIONS BELOW THIS
lui 	$20, 0x1001        	# Load the upper part of the address of words
lw  	$11, 0($20)        	# Load word at address $20 + 0 (words[0])
lh      $12, 2($20)        	# Load halfword at address $20 + 2 (words[1]) (2 bytes)
lhu     $13, 4($20)        	# Load unsigned halfword at address $20 + 4 (words[2])
lb      $14, 6($20)        	# Load byte at address $20 + 6 (words[3])
lbu     $15, 8($20)        	# Load unsigned byte at address $20 + 8 (words[4])

sw     	$16, 0($20)        	# Store word in $16 at address $20 + 0 (words[0])
sh     	$17, 2($20)        	# Store halfword in $17 at address $20 + 2 (words[1])
sb     	$18, 4($20)        	# Store byte in $18 at address $20 + 4 (words[2])

 
beq	$1, $0, die		# branches to jumps if 1 == 0
bne	$1, $0, Jump1		# branches to jumps if 1 != 0


Jump1: 
jal Jump2 #jumps away, then returns
j die

Jump2:
jr $ra

die:
halt