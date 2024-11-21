.data
.text
    .globlmain
main:
    #Goal: or only interacts with desired bits

    #Start Test
    addi    $t0,    $zero,  0x1111  #reg t0 <= 0x1111
    addi    $t1,    $zero,  0x1234  #reg t1 <= 0x1234

    #Test 4:
    or      $t2,    $t0,    $t1     #reg t2 <= 0x1335

    # Exit program
    halt    
    li      $v0,    10
    syscall 
