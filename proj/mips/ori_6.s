    # edge case, ensure ORI operation with Immediate 0 and nonzero source register sets destination reg to $1[15:0]
    # Input:  $t0[15:0] = 0xA080
    #         IMM = 0x0000
    # Expected Output: $t0 = 0x XXXX A080
addi    $1,     $0, 0xA080
ori     $2,     $1, 0x0000
ori     $3,     $1, 0x0000
ori     $4,     $1, 0x0000
ori     $5,     $1, 0x0000
ori     $6,     $1, 0x0000
ori     $7,     $1, 0x0000
ori     $8,     $1, 0x0000
ori     $9,     $1, 0x0000
ori     $10,    $1, 0x0000
ori     $11,    $1, 0x0000
ori     $12,    $1, 0x0000
ori     $13,    $1, 0x0000
ori     $14,    $1, 0x0000
ori     $15,    $1, 0x0000
ori     $16,    $1, 0x0000
ori     $17,    $1, 0x0000
ori     $18,    $1, 0x0000
ori     $19,    $1, 0x0000
ori     $20,    $1, 0x0000
ori     $21,    $1, 0x0000
ori     $22,    $1, 0x0000
ori     $23,    $1, 0x0000
ori     $24,    $1, 0x0000
ori     $25,    $1, 0x0000
ori     $26,    $1, 0x0000
ori     $27,    $1, 0x0000
ori     $28,    $1, 0x0000
ori     $29,    $1, 0x0000
ori     $30,    $1, 0x0000
ori     $31,    $1, 0x0000
    # End Test

    # Exit program
halt    