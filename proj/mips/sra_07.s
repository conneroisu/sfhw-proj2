.data
.text
    .globlmain
main:
    # This file is designed to test th edge cases of the shamt value, as well as some other shamt values
    # Start Test
    # Test 1: Test shamt 31 on value 0x80000000, expecting 0xFFFFFFFF
    lui     $t0,    0x8000
    sra     $t0,    $t0,    31

    # Test 2: Test shamt 31 on value 0x7FFFFFFF, expecting 0x00000000
    lui     $t0,    0x7FFF
    addi    $t0,    $t0,    0xFFFF
    sra     $t0,    $t0,    31

    # Test 3: Test shamt 0 on value 0x000FF000, expecting 0x000FF000
    lui     $t0,    0x000F
    addi    $t0,    $t0,    0xF000
    sra     $t0,    $t0,    0

    # Test 4: Test shamt 12 on value 0x000FF000, expecting 0x000000FF
    sra     $t0,    $t0,    12

    #Test 5: Test shamt 17 on value 0x8000000, expecting 0xFFFFC000
    lui     $t0,    0x8000
    sra     $t0,    $t0,    17

    #Test 6: Test shamt 24 on value 0x7FFFFFFF, expecting 0x0000007F
    lui     $t0,    0x7FFF
    addi    $t0,    $t0,    0xFFFF
    sra     $t0,    $t0,    24

    # End Test
    #Exit Program
    halt    
