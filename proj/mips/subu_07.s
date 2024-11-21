.data
.text
    .globlmain
main:
    lui     $t0,    0xFFFF
    ori     $t0,    $t0,    0xFFFF
    subu    $t0,    $t0,    $t0     # checks subtracting number from itself should zero out a register (return 0) (zero flag should be set)

    addi    $t0,    $0,     -1
    subu    $t0,    $zero,  $t0     # checks that subtracting a negative adds the number (return 1)

    addi    $t0,    $0,     1
    subu    $t0,    $zero,  $t0     # checks that subtracting a positive 1 from zero works (return FFFF FFFF)

    addi    $t0,    $0,     4
    addi    $t1,    $0,     2
    subu    $t0,    $t0,    $t1     # checks that subtracting two normal numbers works correctly (return 2)

    subu    $t0,    $zero,  $zero   # checks that subtracting two zeros from eachother works correctly (return 0) (zero flag should be set)

    # Exit program
    halt    
    li      $v0,    10
    syscall 