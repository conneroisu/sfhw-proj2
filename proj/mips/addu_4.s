.data
.text
    .globlmain
main:
    #test adds 4 and 6 together and prints out the result
    #good easy unit test to see if basic concept of instruction works rwally just a common case
    addu    $t1,    $zero,  4
    addu    $t2,    $zero,  6
    addu    $t3,    $t2,    $t1
    li      $v0,    1
    move    $a0,    $t3
    syscall 
    halt    