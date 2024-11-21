.data
.text
    .globlmain
main:
    #test adds -4 and 6 together and prints out the result
    #this tests the range of addu 4294967295 is the biggest unsigned int that
    #a register can hold and adding 1 to that should result in a 0
    addu    $t1,    $zero,  4294967295
    addu    $t2,    $zero,  1
    addu    $t3,    $t2,    $t1
    li      $v0,    1
    move    $a0,    $t3
    syscall 
    halt    