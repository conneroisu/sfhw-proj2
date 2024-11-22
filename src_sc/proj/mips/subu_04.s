.data
.text
    .globlmain
main:
    # Start Test
    ori     $1,     $0, 1
    subu    $1,     $1, $0  # test subu with register one, we should see t1-zero = 1
    subu    $2,     $1, $0
    subu    $3,     $1, $0
    subu    $4,     $1, $0
    subu    $5,     $1, $0
    subu    $6,     $1, $0
    subu    $7,     $1, $0
    subu    $8,     $1, $0
    subu    $9,     $1, $0
    subu    $10,    $1, $0
    subu    $11,    $1, $0
    subu    $12,    $1, $0
    subu    $13,    $1, $0
    subu    $14,    $1, $0
    subu    $15,    $1, $0
    subu    $16,    $1, $0
    subu    $17,    $1, $0
    subu    $18,    $1, $0
    subu    $19,    $1, $0
    subu    $20,    $1, $0
    subu    $21,    $1, $0
    subu    $22,    $1, $0
    subu    $23,    $1, $0
    subu    $24,    $1, $0
    subu    $25,    $1, $0
    subu    $26,    $1, $0
    subu    $27,    $1, $0
    subu    $28,    $1, $0
    subu    $29,    $1, $0
    subu    $30,    $1, $0
    subu    $31,    $1, $0
    # End Test

    # Exit program
    halt    
    li      $v0,    10
    syscall 