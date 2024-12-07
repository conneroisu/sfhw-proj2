.text
main:
addi $t1, $zero, 5
addi $t2, $zero, 10
addi $t3, $zero, 15
addi $t4, $zero, 20
addi $t5, $zero, 25
addi $t6, $zero, 30
addi $t7, $zero, 35
addi $t8, $zero, 40
addi $t9, $zero, 45
add $1, $2, $3
sub $4, $1, $5
and $6, $4, $7

beq $1, $2, Label
or $9, $6, $8
add $1, $9, $3
Label:
xor $4, $1, $7

halt
lw $8, 0($6)
sw $8, 4($6)
