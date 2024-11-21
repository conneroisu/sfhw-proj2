.data
.text
    .globlmain
main:
    # Start Test Base case
    addi    $t1,    $t1,    182
    sra     $t3,    $t1,    0   #should be 182 again
    # End Test

    # Exit program
    halt    
    li      $v0,    10
    syscall 
