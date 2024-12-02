    # common case, ensures ORI operation with IMM and source reg performs bitwise or operations and assigns to lower word of destination reg
    # Input:  $t0[15:0] = 0xA080
    #         IMM = 0xF123
    # Expected Output: $t0 = 0x XXXX F1A3
addi    $1,     $0, 0xA080
ori     $2,     $1, 0xF123
ori     $3,     $1, 0xF123
ori     $4,     $1, 0xF123
ori     $5,     $1, 0xF123
ori     $6,     $1, 0xF123
ori     $7,     $1, 0xF123
ori     $8,     $1, 0xF123
ori     $9,     $1, 0xF123
ori     $10,    $1, 0xF123
ori     $11,    $1, 0xF123
ori     $12,    $1, 0xF123
ori     $13,    $1, 0xF123
ori     $14,    $1, 0xF123
ori     $15,    $1, 0xF123
ori     $16,    $1, 0xF123
ori     $17,    $1, 0xF123
ori     $18,    $1, 0xF123
ori     $19,    $1, 0xF123
ori     $20,    $1, 0xF123
ori     $21,    $1, 0xF123
ori     $22,    $1, 0xF123
ori     $23,    $1, 0xF123
ori     $24,    $1, 0xF123
ori     $25,    $1, 0xF123
ori     $26,    $1, 0xF123
ori     $27,    $1, 0xF123
ori     $28,    $1, 0xF123
ori     $29,    $1, 0xF123
ori     $30,    $1, 0xF123
ori     $31,    $1, 0xF123
    # End Test

    # Exit program
halt    