.data
.text
.globl main
main:
	#Start Test
	addi $t0, $zero,0xaa1f
	sw $t0, 0x10000000($zero)
	lbu $t2, 0x10000000($zero)
    	# End Test
    	# Exit program
halt
