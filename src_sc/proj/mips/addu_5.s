.data
.text
    .globlmain
main:
    #test adds -4 and 6 together and prints out the result
    #good test case to show limits of addu as answers is -2 in this case when it should be 10
    addu    $t1,    $zero,  4
    addu    $t2,    $zero,  -6
    addu    $t3,    $t2,    $t1
    li      $v0,    1
    move    $a0,    $t3
    syscall 
    halt    