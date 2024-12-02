.data
.text
.globl main
main:
	#Start Test
	li $t2, 0xffffffff
	li $t0, 0x1111
	sw $t0, 0x10000000($zero)
	lbu $t2, 0x10000000($zero)
    	# End Test



    	# Exit program
halt