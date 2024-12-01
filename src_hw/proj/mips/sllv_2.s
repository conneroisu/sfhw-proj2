# "sllv" Unit Test 2
# This test case covers the edge case 
# where the shift amount is equal to the word size.
.data
    .align 2
test_array: .word 0x12345678, 0x87654321, 0x0, 0xFFFFFFFF, 0x7FFFFFFF
result:     .word 0, 0, 0, 0, 0
.text
    .globl main
main:
    # Start Test
    la $t0, test_array
    la $t1, result

    lw $s0, 4($t0)      # s0 = 0x7FFFFFFF
    li $s1, 31           # s1 = 31 (shift amount)
    
    sllv $s2, $s0, $s1   # s2 = s0 << s1

    sw $s2, 4($t1)       # Store result

    # End Test

    # Exit Program
    halt
