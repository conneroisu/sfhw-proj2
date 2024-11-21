.data
.text
    .globlmain
main:
    # Start Test
    ori     $1,     $0, 1
    subu    $1,     $0, $1  # test subu with register one, we should see zero-t0 = FFFF..
    subu    $2,     $0, $1
    subu    $3,     $0, $1
    subu    $4,     $0, $1
    subu    $5,     $0, $1
    subu    $6,     $0, $1
    subu    $7,     $0, $1
    subu    $8,     $0, $1
    subu    $9,     $0, $1
    subu    $10,    $0, $1
    subu    $11,    $0, $1
    subu    $12,    $0, $1
    subu    $13,    $0, $1
    subu    $14,    $0, $1
    subu    $15,    $0, $1
    subu    $16,    $0, $1
    subu    $17,    $0, $1
    subu    $18,    $0, $1
    subu    $19,    $0, $1
    subu    $20,    $0, $1
    subu    $21,    $0, $1
    subu    $22,    $0, $1
    subu    $23,    $0, $1
    subu    $24,    $0, $1
    subu    $25,    $0, $1
    subu    $26,    $0, $1
    subu    $27,    $0, $1
    subu    $28,    $0, $1
    subu    $29,    $0, $1
    subu    $30,    $0, $1
    subu    $31,    $0, $1
    # End Test

    # Exit program
    halt    
    li      $v0,    10
    syscall 