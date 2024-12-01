# Test 2: Loading a negative value from memory.
# This test is to make sure that the lh is properly sign extending in order to handle negative numbers.

.text
la $t1, 0x10010020

addiu $t0, $zero, 0xFFFF #put value 0xFFFF into $t0

sw $t0, 0($t1) # Store 0xFFFF at address 0x10010020

lh $t2, 0($t1) # Load value from address 0x10010020

halt
