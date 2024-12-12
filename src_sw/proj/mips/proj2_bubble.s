

.data

numbers:
	.word 8, 99, 0, 2, 6, 8, 2, 7, -3, 0, 21  

	.text

	.text

main:
	la $s7, numbers     
	nop
	nop
	nop
	li $s0, 0     
	nop
	nop
	nop
	li $s6, 10      
	nop
	nop
	nop
	li $s1, 0      
	nop
	nop
	nop
	li $t3, 0     
	nop
	nop
	nop
	li $t4, 11     
loop:
	nop
	nop
	nop
	sll $t7, $s1, 2     
	nop
	nop
	nop
	add $t7, $s7, $t7     
	nop
	nop
	nop
	lw  $t0, 0($t7)      
	nop
	nop
	nop
	lw  $t1, 4($t7)      
	nop
	nop
	nop
	slt $t2, $t0, $t1    
	nop
	nop
	nop
	bne $t2, $zero, increment
	nop
	nop
	nop
	sw  $t1, 0($t7)      
	nop
	nop
	nop
	sw  $t0, 4($t7)
	nop
	nop
	nop
increment:
	nop
	nop
	nop
	addi $s1, $s1, 1    
	nop
	nop
	nop
	sub  $s5, $s6, $s0     
	nop
	nop
	nop
	bne  $s1, $s5, loop    
	nop
	nop
	nop
	addi $s0, $s0, 1     
	nop
	nop
	nop
	li   $s1, 0      
	nop
	nop
	nop
	bne  $s0, $s6, loop    
	nop
	nop
	nop
final:
	halt 
