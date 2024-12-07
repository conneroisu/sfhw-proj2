.text
main:
add $t1, $t2, $t3
sub $t4, $t1, $t5
and $t6, $t4, $t7
lw $t8, 0($t6)
sw $t8, 4($t6)
beq $t1, $t2, Label
or $t9, $t6, $t8
add $t1, $t9, $t3
Label:
xor $t4, $t1, $t7
jr $ra
