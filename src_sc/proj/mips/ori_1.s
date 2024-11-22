
    #Here we are testing
    # Start Test
.data
.text
    .globlmain
main:
    # Loads all registers with 1 field, then ori each register with its number. This tests that registers are correctly read and ori is completed correctly
    # Start Test
    addi    $1,     $0,     0xFFFFFFFF
    addi    $2,     $0,     0xFFFFFFFF
    addi    $3,     $0,     0xFFFFFFFF
    addi    $4,     $0,     0xFFFFFFFF
    addi    $5,     $0,     0xFFFFFFFF
    addi    $6,     $0,     0xFFFFFFFF
    addi    $7,     $0,     0xFFFFFFFF
    addi    $8,     $0,     0xFFFFFFFF
    addi    $9,     $0,     0xFFFFFFFF
    addi    $10,    $0,     0xFFFFFFFF
    addi    $11,    $0,     0xFFFFFFFF
    addi    $12,    $0,     0xFFFFFFFF
    addi    $13,    $0,     0xFFFFFFFF
    addi    $14,    $0,     0xFFFFFFFF
    addi    $15,    $0,     0xFFFFFFFF
    addi    $16,    $0,     0xFFFFFFFF
    addi    $17,    $0,     0xFFFFFFFF
    addi    $18,    $0,     0xFFFFFFFF
    addi    $19,    $0,     0xFFFFFFFF
    addi    $20,    $0,     0xFFFFFFFF
    addi    $21,    $0,     0xFFFFFFFF
    addi    $22,    $0,     0xFFFFFFFF
    addi    $23,    $0,     0xFFFFFFFF
    addi    $24,    $0,     0xFFFFFFFF
    addi    $25,    $0,     0xFFFFFFFF
    addi    $26,    $0,     0xFFFFFFFF
    addi    $27,    $0,     0xFFFFFFFF
    addi    $28,    $0,     0xFFFFFFFF
    addi    $29,    $0,     0xFFFFFFFF
    addi    $30,    $0,     0xFFFFFFFF
    addi    $31,    $0,     0xFFFFFFFF

    ori     $1,     $1,     1
    ori     $2,     $2,     2
    ori     $3,     $3,     3
    ori     $4,     $4,     4
    ori     $5,     $5,     5
    ori     $6,     $6,     6
    ori     $7,     $7,     7
    ori     $8,     $8,     8
    ori     $9,     $9,     9
    ori     $10,    $10,    10
    ori     $11,    $11,    11
    ori     $12,    $12,    12
    ori     $13,    $13,    13
    ori     $14,    $14,    14
    ori     $15,    $15,    15
    ori     $16,    $16,    16
    ori     $17,    $17,    17
    ori     $18,    $18,    18
    ori     $19,    $19,    19
    ori     $20,    $20,    20
    ori     $21,    $21,    21
    ori     $22,    $22,    22
    ori     $23,    $23,    23
    ori     $24,    $24,    24
    ori     $25,    $25,    25
    ori     $26,    $26,    26
    ori     $27,    $27,    27
    ori     $28,    $28,    28
    ori     $29,    $29,    29
    ori     $30,    $30,    30
    ori     $31,    $31,    31
    # End Test

    # Exit program
    halt    
    li      $v0,    10
    syscall 
