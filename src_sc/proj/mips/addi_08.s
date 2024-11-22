
main:

    addi    $t0,    $0,     32767       # largest possible signed + number w/ 16 bits
    addi    $t0,    $t0,    1           # should be zero
    addi    $t1,    $t0,    -1          # I want to see it work while hovering around zero
    addi    $t1,    $t1,    2           # Back to positive 1 now

    addi    $t3,    $0,     -32767      # Trying to see how it handles signed sub overflow
    addi    $t4,    $t3,    -32767

    addi    $t5,    $0,     32767       # Trying to see how it handles signed add overflow
    addi    $t6,    $t5,    32767

    addi    $a0,    $0,     88888888888 # How does it handle numbers larger than 16

    halt    
