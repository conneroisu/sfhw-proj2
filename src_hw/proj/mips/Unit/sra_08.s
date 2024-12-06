.data
.text
    .globlmain
main:
    # This file is designed to test edge cases of the value of the register
    # Start Test
    # Test 1: put 0xFFFFFFFF in register and shift it 31 bits, expecting 0xFFFFFFFF
    lui     $t0,    0xFFFF
    addi    $t0,    $t0,    0xFFFF
    sra     $t0,    $t0,    31

    # Test 2: put 0x00000000 in register and shift it 31 bits, expecting 0x00000000
    lui     $t0,    0x0000
    sra     $t0,    $t0,    31

    # Test 3: put 0x7FFFFFFF in register and shift it 31 bits, expecting 0x00000000
    lui     $t0,    0x7FFF
    addi    $t0,    $t0,    0xFFFF
    sra     $t0,    $t0,    31

    # Test 4: put 0x8FFFFFFF in register and shift it 11 bits, expecting 0xFFF1FFFF
    lui     $t0,    0x8FFF
    addi    $t0,    $t0,    0xFFFF
    sra     $t0,    $t0,    11

    # Test 5: put 0x00000000 in register and shift it 0 bits, expecting 0x00000000
    lui     $t0,    0x0000
    sra     $t0,    $t0,    0

    # Test 6: put 0x00000000 in register and shift it 15 bits, expecting 0x00000000
    lui     $t0,    0x0000
    sra     $t0,    $t0,    15

    # Test 7: put 0x7FFFFFFF in register and shift it 15 bits, expecting 0x0000FFFF
    lui     $t0,    0x7FFF
    addi    $t0,    $t0,    0xFFFF
    sra     $t0,    $t0,    15

    # End Test
    #Exit Program
    halt    
