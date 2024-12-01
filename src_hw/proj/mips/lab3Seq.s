#
# First part of the Lab 3 test program
#

# data section
.data

# code/instruction section
.text
addi  $1,  $0,  1 		# Place “1” in $1
addi  $2,  $0,  2		# Place “2” in $2
addi  $3,  $0,  3		# Place “3” in $3
addi  $4,  $0,  4		# Place “4” in $4
addi  $5,  $0,  5		# Place “5” in $5
addi  $6,  $0,  6		# Place “6” in $6
addi  $7,  $0,  7		# Place “7” in $7
addi  $8,  $0,  8		# Place “8” in $8
addi  $9,  $0,  9		# Place “9” in $9
addi  $10, $0,  10		# Place “10” in $10
add	 $11, $1,  $2		# $11 = $1 + $2
sub 	 $12, $11, $3 		# $12 = $11 - $3
add 	 $13, $12, $4		# $13 = $12 + $4
sub	 $14, $13, $5		# $14 = $13 - $5
add   $15, $14, $6		# $15 = $14 + $6
sub 	 $16, $15, $7		# $16 = $15 - $7
add   $17, $16, $8		# $17 = $16 + $8
sub 	 $18, $17, $9		# $18 = $17 - $9
add   $19, $18, $10 	# $19 = $18 + $10
addi  $20, $0,  35		# Place “35” in $20
add 	 $21, $19, $20	 	# $21 = $19 + $20

halt
