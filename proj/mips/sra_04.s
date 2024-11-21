.data
.text
    .globlmain
main:
    # Start Test
    addi    $t1,    $t1,    4294967200
    sra     $t3,    $t1,    1           #should be testing to make sure the top bits stay one when it shifts
    #goes from 0xffffffa0 to should be 0xffffffd0
    # End Test

    # Exit program
    halt    
    li      $v0,    10
    syscall 
