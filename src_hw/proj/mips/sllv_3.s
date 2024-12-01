# "sllv" Unit Test 3
# This test case covers the edge case 
# where the shift amount is zero.
.data
    .align 2
test_array: .word 0x0, 0x0, 0x0, 0x0, 0x0
result:     .word 0, 0, 0, 0, 0
.text
    .globl main
main:
    # Start Test
    la $t0, test_array
    la $t1, result

    lw $s0, 0($t0)      # s0 = 0
    li $s1, 5            # s1 = 5 (shift amount)
    
    sllv $s2, $s0, $s1   # s2 = s0 << s1

    sw $s2, 0($t1)       # Store result

    # End Test

    # Exit Program
    halt
