.data
.text
    .globlmain
main:
    # Test to see if the registers can hold Max values
    lui     $1,     0xFFFF
    lui     $2,     0xFFFF
    lui     $3,     0xFFFF
    lui     $4,     0xFFFF
    lui     $5,     0xFFFF
    lui     $6,     0xFFFF
    lui     $7,     0xFFFF
    lui     $8,     0xFFFF
    lui     $9,     0xFFFF
    lui     $10,    0xFFFF
    lui     $11,    0xFFFF
    lui     $12,    0xFFFF
    lui     $13,    0xFFFF
    lui     $14,    0xFFFF
    lui     $15,    0xFFFF
    lui     $16,    0xFFFF
    lui     $17,    0xFFFF
    lui     $18,    0xFFFF
    lui     $19,    0xFFFF
    lui     $20,    0xFFFF
    lui     $21,    0xFFFF
    lui     $22,    0xFFFF
    lui     $23,    0xFFFF
    lui     $24,    0xFFFF
    lui     $25,    0xFFFF
    lui     $26,    0xFFFF
    lui     $27,    0xFFFF
    lui     $28,    0xFFFF
    lui     $29,    0xFFFF
    lui     $30,    0xFFFF
    lui     $31,    0xFFFF
    # Check to make sure that the registers can store the min value
    lui     $1,     0x0000
    lui     $2,     0x0000
    lui     $3,     0x0000
    lui     $4,     0x0000
    lui     $5,     0x0000
    lui     $6,     0x0000
    lui     $7,     0x0000
    lui     $8,     0x0000
    lui     $9,     0x0000
    lui     $10,    0x0000
    lui     $11,    0x0000
    lui     $12,    0x0000
    lui     $13,    0x0000
    lui     $14,    0x0000
    lui     $15,    0x0000
    lui     $16,    0x0000
    lui     $17,    0x0000
    lui     $18,    0x0000
    lui     $19,    0x0000
    lui     $20,    0x0000
    lui     $21,    0x0000
    lui     $22,    0x0000
    lui     $23,    0x0000
    lui     $24,    0x0000
    lui     $25,    0x0000
    lui     $26,    0x0000
    lui     $27,    0x0000
    lui     $28,    0x0000
    lui     $29,    0x0000
    lui     $30,    0x0000
    lui     $31,    0x0000
    # End Test

    # Exit program
    halt    
