.data
.text
    .globlmain
main:
    # Start Test
    # This test is to confirm that jumping to main will work
    # expect value in $t0 = 2 aka 0b0010
    beq     $t0,    1,      ISONE
    beq     $t0,    0,      ISZERO
    addi    $t0,    $zero,  0

ISONE:
ISZERO:
    addi    $t0,    $t0,    1
    beq     $t0,    2,      DONTJUMP
    j       main

DONTJUMP:
    # Exit program
    halt
    li      $v0,    10
    syscall 
