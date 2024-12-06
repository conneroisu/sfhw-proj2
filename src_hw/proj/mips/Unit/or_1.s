.data
.text
    .globlmain
main:
    #Test to see if we can copy a value from one reg over to another

    #Start Test
    addi    $t1,    $zero,  0x1234  #reg t1 <= 0x1234
    or      $t2,    $zero,  $t1     #Expect: $t2 to be 0x1234

    # Exit program
    halt    
    li      $v0,    10
    syscall 
