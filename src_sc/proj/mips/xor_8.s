.data
.text
    .globlmain
main:
    # Goal: This test stress tests the xor instruction to ensure that with a string having randomly flipped
    # bits will still give the correct output. We know that all 0's and all 1's inputs work, but this test proves taht
    # random inputs will work.

    # Start Test
    lui     $t0,    0xAAAA
    addi    $t0,    $t0,    0xAAAA  # initialize to binary 1010_1010_1010_1010_1010_1010_1010_1010
    lui     $t1,    0x5555
    addi    $t1,    $t1,    0x5555  # initialize to binary 0101_0101_0101_0101_0101_0101_0101_0101
    xor     $t2,    $t0,    $t1     # verify that 0xAAAAAAAA xor 0x55555555 = 0xFFFFFFFF
    # End Test

    # Exit program
    halt    
