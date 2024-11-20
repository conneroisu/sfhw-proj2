.data
.text
    .globlmain
main:
    # Start Test base case
    addi    $t1,    $t1,    5
    sra     $t3,    $t1,    2   #$t3 should be 1
    # End Test

    # Exit program
    halt    
    li      $v0,    10
    syscall 
