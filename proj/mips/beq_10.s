main:
	ori $s0, $zero 0x1234
	j skip
	li $s0 0xffffffff
skip:
	ori $s1 $zero 0x1234
	beq $s0 $s1 skip2
	li $s0 0xffffffff
skip2:
	jal fun
	ori $s3 $zero 0x1234
	
	beq $s0, $zero exit
	ori $s4 $zero 0x1234
	j exit

fun:
	ori $s2 $zero 0x1234
	jr $ra
exit:
	halt

