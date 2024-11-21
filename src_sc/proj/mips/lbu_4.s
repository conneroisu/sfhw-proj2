# Test 1: lbu Max Byte Value Load
# Purpose: Verify lbu works correctly with max unsigned value for a byte (FF)

.data
testByte: .byte 0xFF # Test value

.text
.globl main
main:
    lui $a0, 0x1001       # Manually set upper address
    ori $a0, $a0, 0x0000  # Manually set lower address

    # Values of registers after lbu should be 0x000000FF
    lbu $zero, 0($a0)       # Load and zero-extend byte to reg 0 -- should not load value
    lbu $at, 0($a0)       # Load and zero-extend byte to reg 1
    lbu $v0, 0($a0)       # Load and zero-extend byte to reg 2
    lbu $a1, 0($a0)       # Load and zero-extend byte to reg 5
    lbu $t0, 0($a0)       # Load and zero-extend byte to reg 8
    lbu $s0, 0($a0)       # Load and zero-extend byte to reg 16
    lbu $k0, 0($a0)       # Load and zero-extend byte to reg 26
    lbu $gp, 0($a0)       # Load and zero-extend byte to reg 28 
    lbu $sp, 0($a0)       # Load and zero-extend byte to reg 28
    lbu $fp, 0($a0)       # Load and zero-extend byte to reg 30
    lbu $ra, 0($a0)       # Load and zero-extend byte to reg 31
    # End Test
    
    # Exit program
    halt

 
