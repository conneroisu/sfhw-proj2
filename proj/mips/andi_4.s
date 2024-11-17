.data
.text
    .globlmain
main:

    #Start Test Reset: Set all to 0 (same as addi). This is good to make sure to make sure you are placing x and y into $z and not placing z into $z
    #Justification: This is just a good base case, because if this fails then I screwed up heavily in the base design.
    andi    $1,     $0, 0
    andi    $2,     $0, 0
    andi    $3,     $0, 0
    andi    $4,     $0, 0
    andi    $5,     $0, 0
    andi    $6,     $0, 0
    andi    $7,     $0, 0
    andi    $8,     $0, 0
    andi    $9,     $0, 0
    andi    $10,    $0, 0
    andi    $11,    $0, 0
    andi    $12,    $0, 0
    andi    $13,    $0, 0
    andi    $14,    $0, 0
    andi    $15,    $0, 0
    andi    $16,    $0, 0
    andi    $17,    $0, 0
    andi    $18,    $0, 0
    andi    $19,    $0, 0
    andi    $20,    $0, 0
    andi    $21,    $0, 0
    andi    $22,    $0, 0
    andi    $23,    $0, 0
    andi    $24,    $0, 0
    andi    $25,    $0, 0
    andi    $26,    $0, 0
    andi    $27,    $0, 0
    andi    $28,    $0, 0
    andi    $29,    $0, 0
    andi    $30,    $0, 0
    andi    $31,    $0, 0
    halt    

