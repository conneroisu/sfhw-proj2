.text
    lui     $t0,    0xFFFF
    ori     $t0,    $t0,    0xFFFF  # $t0 = 0xFFFFFFFF (max unsigned)
    addi    $t1,    $t0,    -1      # $t1 = 0xFFFFFFFE (1 less than the max unsigned)
    bne     $t0,    $t1,    goTo    # if $t0 is not equal to $t1
    addi    $t2,    $zero,  1       # Should be skipped
goTo:
    addi    $t2,    $zero,  2       # Should be executed
    halt    
