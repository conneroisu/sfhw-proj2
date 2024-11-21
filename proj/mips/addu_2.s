.text

    # addu stress test 2
main:
    # Initialize registers for unsigned addition.
    lui     $1,     0x1000          # $1 = 0x10000000
    lui     $2,     0x0FFF
    ori     $2,     $2,     0xFFFF  # $2 = 0x0FFFFFFF

    # verify unsigned addition works for all registers without creating overflow
    addu    $3,     $1,     $2      # 0x1FFFFFFF
    addu    $4,     $2,     $3      # 0x2FFFFFFE
    addu    $5,     $2,     $4      # 0x3FFFFFFD
    addu    $6,     $2,     $5      # 0x4FFFFFFC
    addu    $7,     $2,     $6      # 0x5FFFFFFB
    addu    $8,     $2,     $7      # 0x6FFFFFFA
    addu    $9,     $2,     $8      # 0x7FFFFFF9
    addu    $10,    $2,     $9      # 0x8FFFFFF8
    addu    $11,    $2,     $10     # 0x9FFFFFF7
    addu    $12,    $2,     $11     # 0xAFFFFFF6
    addu    $13,    $2,     $12     # 0xBFFFFFF5
    addu    $14,    $2,     $13     # 0xCFFFFFF4
    addu    $15,    $2,     $14     # 0xDFFFFFF3
    addu    $16,    $2,     $15     # 0xEFFFFFF2
    addu    $17,    $2,     $16     # 0xFFFFFFF1
    addu    $18,    $2,     $17     # 0x0FFFFFF0, no overflow sice unsigned
    addu    $19,    $2,     $18     # 0x1FFFFFEF
    addu    $20,    $2,     $19     # 0x2FFFFFEE
    addu    $21,    $2,     $20     # 0x3FFFFFED
    addu    $22,    $2,     $21     # 0x4FFFFFEC
    addu    $23,    $2,     $22     # 0x5FFFFFEB
    addu    $24,    $2,     $23     # 0x6FFFFFEA
    addu    $25,    $2,     $24     # 0x7FFFFFE9
    addu    $26,    $2,     $25     # 0x8FFFFFE8
    addu    $27,    $2,     $26     # 0x9FFFFFE7
    addu    $28,    $2,     $27     # 0xAFFFFFE6
    addu    $29,    $2,     $28     # 0xBFFFFFE5
    addu    $30,    $2,     $29     # 0xCFFFFFE4
    addu    $31,    $2,     $30     # 0xDFFFFFE3

    # Exit program
    halt    
    li      $v0,    10
    syscall 
