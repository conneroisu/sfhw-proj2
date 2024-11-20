.data
.text
    .globlmain
main:
    #start test

    addi    $t1,    $0,     -1
    addi    $t2,    $0,     -2
    sub     $t3,    $t1,    $t2 #check to see if ALU can handle sign change with two same signed inputs
    # Exit program
    halt    
    li      $v0,    10
    syscall 