.data
.text
    .globlmain
main:
    # Start Test
    addi    $1,     $0, 0xFFFF  # Load an initial value
    sll     $2,     $1, 0       # verify that shifting 0 works
    sll     $3,     $1, 0       # verify that shifting 0 works
    sll     $4,     $1, 0       # verify that shifting 0 works
    sll     $5,     $1, 0       # verify that shifting 0 works
    sll     $6,     $1, 0       # verify that shifting 0 works
    sll     $7,     $1, 0       # verify that shifting 0 works
    sll     $8,     $1, 0       # verify that shifting 0 works
    sll     $9,     $1, 0       # verify that shifting 0 works
    sll     $10,    $1, 0       # verify that shifting 0 works
    sll     $11,    $1, 0       # verify that shifting 0 works
    sll     $12,    $1, 0       # verify that shifting 0 works
    sll     $13,    $1, 0       # verify that shifting 0 works
    sll     $14,    $1, 0       # verify that shifting 0 works
    sll     $15,    $1, 0       # verify that shifting 0 works
    sll     $16,    $1, 0       # verify that shifting 0 works
    sll     $17,    $1, 0       # verify that shifting 0 works
    sll     $18,    $1, 0       # verify that shifting 0 works
    sll     $19,    $1, 0       # verify that shifting 0 works
    sll     $20,    $1, 0       # verify that shifting 0 works
    sll     $21,    $1, 0       # verify that shifting 0 works
    sll     $22,    $1, 0       # verify that shifting 0 works
    sll     $23,    $1, 0       # verify that shifting 0 works
    sll     $24,    $1, 0       # verify that shifting 0 works
    sll     $25,    $1, 0       # verify that shifting 0 works
    sll     $26,    $1, 0       # verify that shifting 0 works
    sll     $27,    $1, 0       # verify that shifting 0 works
    sll     $28,    $1, 0       # verify that shifting 0 works
    sll     $29,    $1, 0       # verify that shifting 0 works
    sll     $30,    $1, 0       # verify that shifting 0 works
    sll     $31,    $1, 0       # verify that shifting 0 works
    # End Test

    # Exit program
    halt    
    li      $v0,    10
    syscall 
