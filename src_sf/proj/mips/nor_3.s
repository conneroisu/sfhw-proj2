.data
.text
    .globlmain

main:
    # START TEST
    nor     $1,     $0, $0  # 0 NOR 0 = 1; test to see if bits can be inverted, $1 = 0xFFFFFFFF.
    nor     $2,     $1, $2  # test whether registers can be cleared. clear $2 (0x00000000)
    nor     $3,     $1, $3  # test whether registers can be cleared. clear $3 (0x00000000)
    nor     $4,     $1, $4  # test whether registers can be cleared. clear $4 (0x00000000)
    nor     $5,     $1, $5  # test whether registers can be cleared. clear $5 (0x00000000)
    nor     $6,     $1, $6  # test whether registers can be cleared. clear $6 (0x00000000)
    nor     $7,     $1, $7  # test whether registers can be cleared. clear $7 (0x00000000)
    nor     $8,     $1, $8  # test whether registers can be cleared. clear $8 (0x00000000)
    nor     $9,     $1, $9  # test whether registers can be cleared. clear $9 (0x00000000)
    nor     $10,    $1, $10 # test whether registers can be cleared. clear $10 (0x00000000)
    nor     $11,    $1, $11 # test whether registers can be cleared. clear $11 (0x00000000)
    nor     $12,    $1, $12 # test whether registers can be cleared. clear $12 (0x00000000)
    nor     $13,    $1, $13 # test whether registers can be cleared. clear $13 (0x00000000)
    nor     $14,    $1, $14 # test whether registers can be cleared. clear $14 (0x00000000)
    nor     $15,    $1, $15 # test whether registers can be cleared. clear $15 (0x00000000)
    nor     $16,    $1, $16 # test whether registers can be cleared. clear $16 (0x00000000)
    nor     $17,    $1, $17 # test whether registers can be cleared. clear $17 (0x00000000)
    nor     $18,    $1, $18 # test whether registers can be cleared. clear $18 (0x00000000)
    nor     $19,    $1, $19 # test whether registers can be cleared. clear $19 (0x00000000)
    nor     $20,    $1, $20 # test whether registers can be cleared. clear $20 (0x00000000)
    nor     $21,    $1, $21 # test whether registers can be cleared. clear $21 (0x00000000)
    nor     $22,    $1, $22 # test whether registers can be cleared. clear $22 (0x00000000)
    nor     $23,    $1, $23 # test whether registers can be cleared. clear $23 (0x00000000)
    nor     $24,    $1, $24 # test whether registers can be cleared. clear $24 (0x00000000)
    nor     $25,    $1, $25 # test whether registers can be cleared. clear $25 (0x00000000)
    nor     $26,    $1, $26 # test whether registers can be cleared. clear $26 (0x00000000)
    nor     $27,    $1, $27 # test whether registers can be cleared. clear $27 (0x00000000)
    nor     $28,    $1, $28 # test whether registers can be cleared. clear $28 (0x00000000)
    nor     $29,    $1, $29 # test whether registers can be cleared. clear $29 (0x00000000)
    nor     $30,    $1, $30 # test whether registers can be cleared. clear $30 (0x00000000)
    nor     $31,    $1, $31 # test whether registers can be cleared. clear $31 (0x00000000)
    nor     $1,     $1, $1  # test whether registers can be cleared. clear $1 (0x00000000)

    #END TEST
    halt    
    li      $v0,    10
    syscall 