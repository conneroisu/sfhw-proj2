.data
.text
    .globlmain
    # This test makes sure jr can jump to the end and start of the instruction memory.
main:
    jal     START

START:
    # Start Test.
    addi    $t6,    $31,    0
    slt     $t2,    $zero,  $t1
    bne     $t2,    $zero,  TOEND
    addi    $t1,    $zero,  1
    jal     FILL

FILL:
    #filler instructions.
    addi    $0,     $0,     0
    addi    $0,     $0,     0
    addi    $0,     $0,     0
    addi    $0,     $0,     0
    addi    $0,     $0,     0
    addi    $0,     $0,     0
    addi    $0,     $0,     0
    addi    $0,     $0,     0
    addi    $0,     $0,     0
    addi    $0,     $0,     0
    addi    $0,     $0,     0
    addi    $0,     $0,     0
    addi    $0,     $0,     0
    addi    $0,     $0,     0

    #set the return address to be the start of the instruction memory.
    subi    $t3,    $31,    24
    #jump to the start of the instruction memory.
    jr      $t3

EXIT:
    # Exit program.
    halt    
    li      $v0,    10
    syscall 

    #jumps to the end of the instruction memory.
TOEND:
    addi    $t7,    $t3,    144
    jr      $t7

    #filler code to extend the end of the instruction memory.
    #t9 should be 0.
ENDOFMEM:
    addi    $0,     $0,     0
    addi    $0,     $0,     0
    addi    $0,     $0,     0
    addi    $0,     $0,     0
    addi    $0,     $0,     0
    addi    $0,     $0,     0
    addi    $0,     $0,     0
    addi    $0,     $0,     0
    addi    $t9,    $0,     -1
    jal     EXIT




