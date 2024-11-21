# Test 3: Loading a halfword near the boundary value from memory.
# This test will ensure there are no overflow and sign extension issues

.text
la $t1, 0x10010020

addiu $t0, $zero, 0x7FFF #put value 0x7FFF into $t0

sw $t0, 0($t1) # Store 0x7FFF at address 0x10010020

lh $t2, 0($t1) # Load value from address 0x10010020

halt
