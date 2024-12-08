.data
.text
    .globlmain
main:
    # Start Test
    addi    $1,     $0,     1   #Load $1 with 1, load all other registers with 10
    #Subtract all registers by 1
    addi    $2,     $0,     10  #This is to show that the subu instruction can
    subu    $2,     $2,     $1  #write to any register
    addi    $3,     $0,     10
    subu    $3,     $3,     $1  # These are all common case instructions
    addi    $4,     $0,     10
    subu    $4,     $4,     $1
    addi    $5,     $0,     10
    subu    $5,     $5,     $1
    addi    $6,     $0,     10
    subu    $6,     $6,     $1
    addi    $7,     $0,     10
    subu    $7,     $7,     $1
    addi    $8,     $0,     10
    subu    $8,     $8,     $1
    addi    $9,     $0,     10
    subu    $9,     $9,     $1
    addi    $10,    $0,     10
    subu    $10,    $10,    $1
    addi    $11,    $0,     10
    subu    $11,    $11,    $1
    addi    $12,    $0,     10
    subu    $12,    $12,    $1
    addi    $13,    $0,     10
    subu    $13,    $13,    $1
    addi    $14,    $0,     10
    subu    $14,    $14,    $1
    addi    $15,    $0,     10
    subu    $15,    $15,    $1
    addi    $16,    $0,     10
    subu    $16,    $16,    $1
    addi    $17,    $0,     10
    subu    $17,    $17,    $1
    addi    $18,    $0,     10
    subu    $18,    $18,    $1
    addi    $19,    $0,     10
    subu    $19,    $19,    $1
    addi    $20,    $0,     10
    subu    $20,    $20,    $1
    addi    $21,    $0,     10
    subu    $21,    $21,    $1
    addi    $22,    $0,     10
    subu    $22,    $22,    $1
    addi    $23,    $0,     10
    subu    $23,    $23,    $1
    addi    $24,    $0,     10
    subu    $24,    $24,    $1
    addi    $25,    $0,     10
    subu    $25,    $25,    $1
    addi    $26,    $0,     10
    subu    $26,    $26,    $1
    addi    $27,    $0,     10
    subu    $27,    $27,    $1
    addi    $28,    $0,     10
    subu    $28,    $28,    $1
    addi    $29,    $0,     10
    subu    $29,    $29,    $1
    addi    $30,    $0,     10
    subu    $30,    $30,    $1
    addi    $31,    $0,     10
    subu    $31,    $31,    $1

    subu    $1,     $1,     $1  #Finally, subtract 1 from $1
    # End Test

    # Exit program
    halt    
    li      $v0,    10
    syscall 
