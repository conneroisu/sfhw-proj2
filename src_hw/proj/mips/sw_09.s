# 
#  In this test case, we are testing to verify that sw will store a value in all 31 writable registers
#  
#
#
.data
.text
lui $at, 0x1000		# Setting register to 0x1000_0000
lui $v0, 0x1000		# Setting register to 0x1000_0000
lui $v1, 0x1000		# Setting register to 0x1000_0000
lui $a0, 0x1000		# Setting register to 0x1000_0000
lui $a1, 0x1000		# Setting register to 0x1000_0000
lui $a2, 0x1000		# Setting register to 0x1000_0000
lui $a3, 0x1000		# Setting register to 0x1000_0000
lui $t1, 0x1000		# Setting register to 0x1000_0000
lui $t2, 0x1000		# Setting register to 0x1000_0000
lui $t3, 0x1000		# Setting register to 0x1000_0000
lui $t4, 0x1000		# Setting register to 0x1000_0000
lui $t5, 0x1000		# Setting register to 0x1000_0000
lui $t6, 0x1000		# Setting register to 0x1000_0000
lui $t7, 0x1000		# Setting register to 0x1000_0000
lui $s0, 0x1000		# Setting register to 0x1000_0000
lui $s1, 0x1000		# Setting register to 0x1000_0000
lui $s2, 0x1000		# Setting register to 0x1000_0000
lui $s3, 0x1000		# Setting register to 0x1000_0000
lui $s4, 0x1000		# Setting register to 0x1000_0000
lui $s5, 0x1000		# Setting register to 0x1000_0000
lui $s6, 0x1000		# Setting register to 0x1000_0000
lui $s7, 0x1000		# Setting register to 0x1000_0000
lui $t8, 0x1000		# Setting register to 0x1000_0000
lui $t9, 0x1000		# Setting register to 0x1000_0000
lui $k0, 0x1000		# Setting register to 0x1000_0000
lui $k1, 0x1000		# Setting register to 0x1000_0000
lui $gp, 0x1000		# Setting register to 0x1000_0000
lui $sp, 0x1000		# Setting register to 0x1000_0000
lui $fp, 0x1000		# Setting register to 0x1000_0000
lui $ra, 0x1000		# Setting register to 0x1000_0000

lui $t0, 0xABCD		# Setting upper value of $t0 to 0xABCD
ori $t0, 0xEFAA		# Setting lower value of $t0 to 0xEFAA

sw $t0, 0($at)		# Storing value of $t0 into register
sw $t0, 4($v0)		# Storing value of $t0 into register
sw $t0, 8($v1)		# Storing value of $t0 into register
sw $t0, 12($a0)		# Storing value of $t0 into register
sw $t0, 16($a1)		# Storing value of $t0 into register
sw $t0, 20($a2)		# Storing value of $t0 into register
sw $t0, 24($a3)		# Storing value of $t0 into register
sw $t0, 28($t1)		# Storing value of $t0 into register
sw $t0, 32($t2)		# Storing value of $t0 into register
sw $t0, 36($t3)		# Storing value of $t0 into register
sw $t0, 40($t4)		# Storing value of $t0 into register
sw $t0, 44($t5)		# Storing value of $t0 into register
sw $t0, 48($t6)		# Storing value of $t0 into register
sw $t0, 52($t7)		# Storing value of $t0 into register
sw $t0, 56($s0)		# Storing value of $t0 into register
sw $t0, 60($s1)		# Storing value of $t0 into register
sw $t0, 64($s2)		# Storing value of $t0 into register
sw $t0, 68($s3)		# Storing value of $t0 into register
sw $t0, 72($s4)		# Storing value of $t0 into register
sw $t0, 76($s5)		# Storing value of $t0 into register
sw $t0, 80($s6)		# Storing value of $t0 into register
sw $t0, 84($s7)		# Storing value of $t0 into register
sw $t0, 88($t8)		# Storing value of $t0 into register
sw $t0, 92($t9)		# Storing value of $t0 into register
sw $t0, 96($k0)		# Storing value of $t0 into register
sw $t0, 100($k1)	# Storing value of $t0 into register
sw $t0, 104($gp)	# Storing value of $t0 into register
sw $t0, 108($sp)	# Storing value of $t0 into register
sw $t0, 112($fp)	# Storing value of $t0 into register
sw $t0, 116($ra)	# Storing value of $t0 into register

lui $t0, 0x1000		# Setting register to 0x1000_0000
lui $t1, 0xABCD		# Setting upper value of $t1 to 0xABCD
ori $t1, 0xEFAA		# Setting lower value of $t1 to 0xEFAA
sw $t1, 120($t0)	# Storing value of $t1 into register
halt