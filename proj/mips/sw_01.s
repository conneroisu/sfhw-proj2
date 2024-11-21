    # Test 1 - SW (store word)
    #       
    # Assuming Test 0 has passed...
    # The objective of this test assembly file will be to check if arbritrary data values stored
    # in registers $t0 to $t3 can be written, starting at the base address of the data segment (0x10010000),
    # to each subsequent word (4 bytes). In this test, sw will continue to use an immediate hex listening for address location.
    # The idea/justification for this test is to see whether the addresses will be properly written in word format following the
    # given address intermediate value. I will do the same exact test in the next test file except I will use another register
    # to store the base address value and then do something like 0($t9) to c($t9) if $t9 contains the base address.

.data
.text
    .globlmain
main:
    # Start Test
    addi    $t0,    $0,         0x391AFCDE  # Arbritrary value written into temporary register 0.
    sw      $t0,    0x10010000              # Store into start of data segment.

    addi    $t1,    $0,         0x391AFCDF  # Arbritrary value written into temporary register 1.
    sw      $t1,    0x10010004              # Store into next data segment word location (start + 4).

    addi    $t2,    $0,         0x391AFCE0  # Arbritrary value written into temporary register 2.
    sw      $t2,    0x10010008              # Store into next data segment word location (start + 8).

    addi    $t3,    $0,         0x391AFCE1  # Arbritrary value written into temporary register 3.
    sw      $t3,    0x1001000C              # Store into next data segment word location (start + c).
    # End Test

    # Exit program
    halt    
    li      $v0,    10
    syscall 
