    # Test 0 - SW (store word)
    #       
    # The objective of this test assembly file will be to check if an arbritrary data
    # value stored in any of the argument, temporary, and saved registers, can be put
    # into the starting address allocation of the data segment (0x10010000).
    # My justification for including only these registers is that I think that these are
    # likely going to involved in holding data that needs to potentially be sent out to data
    # segment; therefore, the other remaining registers are not included in this test. The
    # functionality of those other registers will be checked in other tests.

.data
.text
    .globlmain
main:
    # Start Test
    addi    $t0,    $0,         0x391AFCDE  # Arbritrary value written into temporary register 0.
    sw      $t0,    0x10010000              # Store into start of data segment.

    addi    $t1,    $0,         0x391AFCDF  # Arbritrary value written into temporary register 1.
    sw      $t1,    0x10010000              # Store into start of data segment.

    addi    $t2,    $0,         0x391AFCE0  # Arbritrary value written into temporary register 2.
    sw      $t2,    0x10010000              # Store into start of data segment.

    addi    $t3,    $0,         0x391AFCE1  # Arbritrary value written into temporary register 3.
    sw      $t3,    0x10010000              # Store into start of data segment.

    addi    $t4,    $0,         0x391AFCE2  # Arbritrary value written into temporary register 4.
    sw      $t4,    0x10010000              # Store into start of data segment.

    addi    $t5,    $0,         0x391AFCE3  # Arbritrary value written into temporary register 5.
    sw      $t5,    0x10010000              # Store into start of data segment.

    addi    $t6,    $0,         0x391AFCE4  # Arbritrary value written into temporary register 6.
    sw      $t6,    0x10010000              # Store into start of data segment.

    addi    $t7,    $0,         0x391AFCE5  # Arbritrary value written into temporary register 7.
    sw      $t7,    0x10010000              # Store into start of data segment.

    addi    $t8,    $0,         0x391AFCE6  # Arbritrary value written into temporary register 8.
    sw      $t8,    0x10010000              # Store into start of data segment.

    addi    $t9,    $0,         0x391AFCE7  # Arbritrary value written into temporary register 9.
    sw      $t9,    0x10010000              # Store into start of data segment.

    addi    $a0,    $0,         0x391AFCE8  # Arbritrary value written into argument register 0.
    sw      $a0,    0x10010000              # Store into start of data segment.

    addi    $a1,    $0,         0x391AFCE9  # Arbritrary value written into argument register 1.
    sw      $a1,    0x10010000              # Store into start of data segment.

    addi    $a2,    $0,         0x391AFCEA  # Arbritrary value written into argument register 2.
    sw      $a2,    0x10010000              # Store into start of data segment.

    addi    $a3,    $0,         0x391AFCEB  # Arbritrary value written into argument register 3.
    sw      $a3,    0x10010000              # Store into start of data segment.

    addi    $s0,    $0,         0x391AFCEC  # Arbritrary value written into saved register 0.
    sw      $s0,    0x10010000              # Store into start of data segment.

    addi    $s1,    $0,         0x391AFCED  # Arbritrary value written into saved register 1.
    sw      $s1,    0x10010000              # Store into start of data segment.

    addi    $s2,    $0,         0x391AFCEE  # Arbritrary value written into saved register 2.
    sw      $s2,    0x10010000              # Store into start of data segment.

    addi    $s3,    $0,         0x391AFCEF  # Arbritrary value written into saved register 3.
    sw      $s3,    0x10010000              # Store into start of data segment.

    addi    $s4,    $0,         0x391AFCF0  # Arbritrary value written into saved register 4.
    sw      $s4,    0x10010000              # Store into start of data segment.

    addi    $s5,    $0,         0x391AFCF1  # Arbritrary value written into saved register 5.
    sw      $s5,    0x10010000              # Store into start of data segment.

    addi    $s6,    $0,         0x391AFCF2  # Arbritrary value written into saved register 6.
    sw      $s6,    0x10010000              # Store into start of data segment.

    addi    $s7,    $0,         0x391AFCF3  # Arbritrary value written into saved register 7.
    sw      $s7,    0x10010000              # Store into start of data segment.
    # End Test

    # Exit program
    halt    
    li      $v0,    10
    syscall 
