.data
.text
    .globlmain
main:
    # Start Test
    # this is test to make sure that the line of code followinng the j instruction
    # will not run because it pc will be set to TEST skiping it.
    # expect value in $t0 = 3
    addi    $t0,    $zero,  1
    j       test
    addi    $t0,    $t0,    8
test:
    addi    $t0,    $t0,    2
    # End Test

    # Exit program
    halt    
    li      $v0,    10
    syscall 
