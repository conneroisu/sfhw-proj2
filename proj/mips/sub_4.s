.data
.text
    .globlmain
main:
    #Start Test
    addi    $1,     $0, 1
    addi    $2,     $0, 2
    addi    $3,     $0, 3
    addi    $4,     $0, 4
    addi    $5,     $0, 5   # load starting values into reg 1-5

    sub     $6,     $2, $1  # average case test, 2 - 1 = 1
    sub     $7,     $4, $2  # average case test, 4 - 2 = 2
    sub     $8,     $5, $3  # average case test, 5 - 3 = 2
    sub     $9,     $1, $5  # average case test for negative results, 1 - 5 = -4
    sub     $10,    $4, $4  # average case test, 4 - 4 = 0

    #End Test

    #Exit
    halt    
    li      $v0,    10
    syscall 