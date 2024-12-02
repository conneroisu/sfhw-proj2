.data
.text
    .globlmain
main:
    # Start Test
    # This is an normal adding case test for every register
    # The goal here is, for each register but the 2 used for the register, is to do an addition that runs every bit operation at least once
    #       
    # cIn | A | B | Sum | cOut
    #  0  | 0 | 0 |  0  |  0   # bits 13-15
    #  0  | 0 | 1 |  1  |  0   # bits 16-23
    #  0  | 1 | 0 |  1  |  0   # bits 24-31
    #  0  | 1 | 1 |  0  |  1   # bit 0
    #  1  | 0 | 0 |  1  |  0   # bit 12
    #  1  | 0 | 1 |  0  |  1   # bits 8-11, cOut into bit 12
    #  1  | 1 | 0 |  0  |  1   # bits 4-7, cOut into bit 8
    #  1  | 1 | 1 |  1  |  1   # bit 1-3, cOut into bit 4
    #       
    # first  = 0xFF|00|0|0|F|F
    # second = 0x00|FF|0|F|0|F
    #       
    # expected result in registers $3-$31 = 0xFFFF100E


    # $1 and $2 will hold the operands for this test
    lui     $1,     0xFF00
    addi    $1,     $1,     0x00FF
    lui     $2,     0x00FF
    addi    $2,     $2,     0x0F0F

    add     $3,     $1,     $2      # verify that the addition as described above works and the correct value is placed in the register
    add     $4,     $1,     $2      # verify that the addition as described above works and the correct value is placed in the register
    add     $5,     $1,     $2      # verify that the addition as described above works and the correct value is placed in the register
    add     $6,     $1,     $2      # verify that the addition as described above works and the correct value is placed in the register
    add     $7,     $1,     $2      # verify that the addition as described above works and the correct value is placed in the register
    add     $8,     $1,     $2      # verify that the addition as described above works and the correct value is placed in the register
    add     $9,     $1,     $2      # verify that the addition as described above works and the correct value is placed in the register
    add     $10,    $1,     $2      # verify that the addition as described above works and the correct value is placed in the register
    add     $11,    $1,     $2      # verify that the addition as described above works and the correct value is placed in the register
    add     $12,    $1,     $2      # verify that the addition as described above works and the correct value is placed in the register
    add     $13,    $1,     $2      # verify that the addition as described above works and the correct value is placed in the register
    add     $14,    $1,     $2      # verify that the addition as described above works and the correct value is placed in the register
    add     $15,    $1,     $2      # verify that the addition as described above works and the correct value is placed in the register
    add     $16,    $1,     $2      # verify that the addition as described above works and the correct value is placed in the register
    add     $17,    $1,     $2      # verify that the addition as described above works and the correct value is placed in the register
    add     $18,    $1,     $2      # verify that the addition as described above works and the correct value is placed in the register
    add     $19,    $1,     $2      # verify that the addition as described above works and the correct value is placed in the register
    add     $20,    $1,     $2      # verify that the addition as described above works and the correct value is placed in the register
    add     $21,    $1,     $2      # verify that the addition as described above works and the correct value is placed in the register
    add     $22,    $1,     $2      # verify that the addition as described above works and the correct value is placed in the register
    add     $23,    $1,     $2      # verify that the addition as described above works and the correct value is placed in the register
    add     $24,    $1,     $2      # verify that the addition as described above works and the correct value is placed in the register
    add     $25,    $1,     $2      # verify that the addition as described above works and the correct value is placed in the register
    add     $26,    $1,     $2      # verify that the addition as described above works and the correct value is placed in the register
    add     $27,    $1,     $2      # verify that the addition as described above works and the correct value is placed in the register
    add     $28,    $1,     $2      # verify that the addition as described above works and the correct value is placed in the register
    add     $29,    $1,     $2      # verify that the addition as described above works and the correct value is placed in the register
    add     $30,    $1,     $2      # verify that the addition as described above works and the correct value is placed in the register
    add     $31,    $1,     $2      # verify that the addition as described above works and the correct value is placed in the register
    # End Test

    # Exit
    halt    
    li      $v0,    10
    syscall 
