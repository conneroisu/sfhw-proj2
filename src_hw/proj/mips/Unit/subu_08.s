.data
.text
    .globlmain
main:
    addi    $t0,    $zero,  1
    subu    $t1,    $t0,    $zero   #verifies that subtracting by zero will keep the same value from iA (esentially a NOP)
    subu    $t2,    $t1,    $zero   #verifies that subtracting by zero will keep the same value from iA (esentially a NOP)
    subu    $t3,    $t2,    $zero   #verifies that subtracting by zero will keep the same value from iA (esentially a NOP)
    subu    $t4,    $t3,    $zero   #verifies that subtracting by zero will keep the same value from iA (esentially a NOP)
    subu    $t5,    $t4,    $zero   #verifies that subtracting by zero will keep the same value from iA (esentially a NOP)
    subu    $t6,    $t5,    $zero   #verifies that subtracting by zero will keep the same value from iA (esentially a NOP)
    subu    $t7,    $t6,    $zero   #verifies that subtracting by zero will keep the same value from iA (esentially a NOP)

    # Exit program
    halt    
    li      $v0,    10
    syscall 