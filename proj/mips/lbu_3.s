# Test 1: lbu Normal Load
# Purpose: Verify lbu loads a byte and zero-extends correctly.

.data
testByte: .byte 0x12 # Test value

.text
.globl main
main:
    lui $a0, 0x1001       # Manually set upper address
    ori $a0, $a0, 0x0000  # Manually set lower address

    # Values of registers after lbu should be 0x00000012
    lbu $zero, 0($a0)       # Load and zero-extend byte to reg 0 -- should not load value
    lbu $at, 0($a0)       # Load and zero-extend byte to reg 1
    lbu $v0, 0($a0)       # Load and zero-extend byte to reg 2
    lbu $v1, 0($a0)       # Load and zero-extend byte to reg 3
    
    lbu $a1, 0($a0)       # Load and zero-extend byte to reg 5
    lbu $a2, 0($a0)       # Load and zero-extend byte to reg 6
    lbu $a3, 0($a0)       # Load and zero-extend byte to reg 7
    lbu $t0, 0($a0)       # Load and zero-extend byte to reg 8
    lbu $t1, 0($a0)       # Load and zero-extend byte to reg 9
    lbu $t2, 0($a0)       # Load and zero-extend byte to reg 10
    lbu $t3, 0($a0)       # Load and zero-extend byte to reg 11
    lbu $t4, 0($a0)       # Load and zero-extend byte to reg 12
    lbu $t5, 0($a0)       # Load and zero-extend byte to reg 13
    lbu $t6, 0($a0)       # Load and zero-extend byte to reg 14
    lbu $t7, 0($a0)       # Load and zero-extend byte to reg 15
    lbu $s0, 0($a0)       # Load and zero-extend byte to reg 16
    lbu $s1, 0($a0)       # Load and zero-extend byte to reg 17
    lbu $s2, 0($a0)       # Load and zero-extend byte to reg 18
    lbu $s3, 0($a0)       # Load and zero-extend byte to reg 19
    lbu $s4, 0($a0)       # Load and zero-extend byte to reg 20
    lbu $s5, 0($a0)       # Load and zero-extend byte to reg 21
    lbu $s6, 0($a0)       # Load and zero-extend byte to reg 22
    lbu $s7, 0($a0)       # Load and zero-extend byte to reg 23
    lbu $t8, 0($a0)       # Load and zero-extend byte to reg 24
    lbu $t9, 0($a0)       # Load and zero-extend byte to reg 25
    lbu $k0, 0($a0)       # Load and zero-extend byte to reg 26 
    lbu $k1, 0($a0)       # Load and zero-extend byte to reg 27
    lbu $gp, 0($a0)       # Load and zero-extend byte to reg 28
    lbu $sp, 0($a0)       # Load and zero-extend byte to reg 29
    lbu $fp, 0($a0)       # Load and zero-extend byte to reg 30
    lbu $ra, 0($a0)       # Load and zero-extend byte to reg 31
    # End Test
    
    # Exit program
    halt 


 
