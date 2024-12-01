.data
.text
    .globlmain
main:
    # Start Test
    # This test is to confirm that jumping will work forward and backward
    # if the jumps behave correctly they will add 8 or 16 to $t0
    # expect value in $t0 = 3 aka 0b0011
    addi    $t0,        $zero,  0
    j       FORWARD
    addi    $t0,        $t0,    8

BACKWARD:
    addi    $t0,        $t0,    2
    # Exit program
    halt    
    li      $v0,        10
    syscall 

FORWARD:
    addi    $t0,        $t0,    1
    j       BACKWARD

    # Exit program
    halt    
    li      $v0,        10
    syscall 
