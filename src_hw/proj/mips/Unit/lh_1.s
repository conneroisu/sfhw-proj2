# Test 1: Loading a positive value from memory.
# This test test basic functionality of the lh instruction by storing a postive value. 
.text
la $t1, 0x10010020
addiu $t0, $zero, 0x1234 #put value 0x1234 into $t0

sw $t0, 0($t1) # Store 0x1234 at address 0x10010020

lh $t2, 0($t1) # Load value from address 0x10010020

halt
