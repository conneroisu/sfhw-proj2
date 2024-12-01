.data
.text
    .globlmain
main:
    # Start Test
    #Common Case Negative Numbers
    addi    $1,     $0,     -1
    addi    $2,     $0,     -2
    addi    $3,     $0,     -4
    addi    $4,     $0,     -8
    addi    $5,     $0,     -16
    addi    $6,     $0,     -32
    addi    $7,     $0,     -64
    addi    $8,     $0,     -128
    addi    $9,     $0,     -256

    addi    $11,    $0,     1
    addi    $12,    $0,     2
    addi    $13,    $0,     4
    addi    $14,    $0,     8
    addi    $15,    $0,     16
    addi    $16,    $0,     32
    addi    $17,    $0,     64
    addi    $18,    $0,     128
    addi    $19,    $0,     256

    subu    $11,    $11,    $1      #Double the Positive Numbers
    subu    $12,    $12,    $2
    subu    $13,    $13,    $3
    subu    $14,    $14,    $4
    subu    $15,    $15,    $5
    subu    $16,    $16,    $6
    subu    $17,    $17,    $7
    subu    $18,    $18,    $8
    subu    $19,    $19,    $9

    subu    $1,     $1,     $11     #Triple all Negative Numbers
    subu    $2,     $2,     $12
    subu    $3,     $3,     $13
    subu    $4,     $4,     $14
    subu    $5,     $5,     $15
    subu    $6,     $6,     $16
    subu    $7,     $7,     $17
    subu    $8,     $8,     $18
    subu    $9,     $9,     $19

    # End Test

    # Exit program
    halt    
    li      $v0,    10
    syscall 
