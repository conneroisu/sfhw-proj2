.data
.text
    .globlmain
main:
    # Start Test base case
    addi    $t1,    $t1,    29
    sra     $t3,    $t1,    21  #should be a value of 0
    # End Test

    # Exit program
    halt    
    li      $v0,    10
    syscall 
