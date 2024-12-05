#
# First part of the Lab 3 test program
#

# data section
.data

# code/instruction section
.text
addi  $1,  $0,  1 		# Place “1” in $1
    nop
    nop
addi  $2,  $0,  2		# Place “2” in $2
    nop
    nop
addi  $3,  $0,  3		# Place “3” in $3
    nop
    nop
addi  $4,  $0,  4		# Place “4” in $4
    nop
    nop
addi  $5,  $0,  5		# Place “5” in $5
    nop
    nop
addi  $6,  $0,  6		# Place “6” in $6
    nop
    nop
addi  $7,  $0,  7		# Place “7” in $7
    nop
    nop
addi  $8,  $0,  8		# Place “8” in $8
    nop
    nop
addi  $9,  $0,  9		# Place “9” in $9
    nop
    nop
addi  $10, $0,  10		# Place “10” in $10
    nop
    nop
add	 $11, $1,  $2		# $11 = $1 + $2
    nop
    nop
sub 	 $12, $11, $3 		# $12 = $11 - $3
    nop
    nop
add 	 $13, $12, $4		# $13 = $12 + $4
sub	 $14, $13, $5		# $14 = $13 - $5
    nop
    nop
add   $15, $14, $6		# $15 = $14 + $6
    nop
    nop
sub 	 $16, $15, $7		# $16 = $15 - $7
add   $17, $16, $8		# $17 = $16 + $8
    nop
    nop
sub 	 $18, $17, $9		# $18 = $17 - $9
    nop
    nop
add   $19, $18, $10 	# $19 = $18 + $10
addi  $20, $0,  35		# Place “35” in $20
    nop
add 	 $21, $19, $20	 	# $21 = $19 + $20

halt
