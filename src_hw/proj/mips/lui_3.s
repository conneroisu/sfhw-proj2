.data
.text
    .globlmain
main:
    # Test to see if the registers can hold a random value
    lui     $1,     0xE404
    lui     $2,     0xD01C
    lui     $3,     0x8F37
    lui     $4,     0x3649
    lui     $5,     0x1F4B
    lui     $6,     0x22C9
    lui     $7,     0x101A
    lui     $8,     0x22A6
    lui     $9,     0x7E71
    lui     $10,    0x08E6
    lui     $11,    0xF853
    lui     $12,    0x2722
    lui     $13,    0X0D5D
    lui     $14,    0x442E
    lui     $15,    0x152D
    lui     $16,    0x8120
    lui     $17,    0xE627
    lui     $18,    0xC688
    lui     $19,    0x59D0
    lui     $20,    0x7ED9
    lui     $21,    0x1D7A
    lui     $22,    0x2A45
    lui     $23,    0xB3F9
    lui     $24,    0x7247
    lui     $25,    0xBDEE
    lui     $26,    0x83A7
    lui     $27,    0xC60F
    lui     $28,    0x3C3A
    lui     $29,    0x5D8A
    lui     $30,    0xDB32
    lui     $31,    0x120B
    # End Test

    # Exit program
    halt    