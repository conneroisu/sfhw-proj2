.data
.text
    .globlmain
    # This test makes sure jr can jump consecutively.
main:
    # Start Test
    jal     START

    #Setting up the registers with the values they need to jump to the commands above them in succession.
START:
    addi    $t0,            $31,    60
    subi    $t1,            $t0,    4
    subi    $t2,            $t1,    4
    subi    $t3,            $t2,    4
    subi    $t4,            $t3,    8
    jal     UPTHELADDER

    #This portion should have the jr jump to the instruction above, and then putting 1 in $t9 to show completion, then exit.
    addi    $t9,            $zero,  1
    beq     $zero,          $zero,  EXIT
    jr      $t4
    jr      $t3
    jr      $t2
    jr      $t1
    #The start of jr's climbing up a "ladder".
UPTHELADDER:
    jr      $t0

    # Exit program
EXIT:
    halt    
    li      $v0,            10
    syscall 

