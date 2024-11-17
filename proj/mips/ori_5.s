    #edge case, ensures or operation with 0 immediate and $zero reg outputs 0 to all registers
    # Expected Output: $Dest[15:0] = 0x0000
ori     $1,     $0, 0x0000
ori     $2,     $0, 0x0000
ori     $3,     $0, 0x0000
ori     $4,     $0, 0x0000
ori     $5,     $0, 0x0000
ori     $6,     $0, 0x0000
ori     $7,     $0, 0x0000
ori     $8,     $0, 0x0000
ori     $9,     $0, 0x0000
ori     $10,    $0, 0x0000
ori     $11,    $0, 0x0000
ori     $12,    $0, 0x0000
ori     $13,    $0, 0x0000
ori     $14,    $0, 0x0000
ori     $15,    $0, 0x0000
ori     $16,    $0, 0x0000
ori     $17,    $0, 0x0000
ori     $18,    $0, 0x0000
ori     $19,    $0, 0x0000
ori     $20,    $0, 0x0000
ori     $21,    $0, 0x0000
ori     $22,    $0, 0x0000
ori     $23,    $0, 0x0000
ori     $24,    $0, 0x0000
ori     $25,    $0, 0x0000
ori     $26,    $0, 0x0000
ori     $27,    $0, 0x0000
ori     $28,    $0, 0x0000
ori     $29,    $0, 0x0000
ori     $30,    $0, 0x0000
ori     $31,    $0, 0x0000
    # End Test

    # Exit program
halt    