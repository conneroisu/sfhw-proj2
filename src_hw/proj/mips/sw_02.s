    # Test 2 - SW (store word)
    #       
    # Assuming Test 0 AND 1 have passed...
    # The objective of this test assembly file will be to check if arbritrary data values stored
    # in registers $t0 to $t3 can be written, starting at the base address of the data segment (0x10010000),
    # to each subsequent word (4 bytes). In this test, sw will use the 0(base address) to c(base address) notation.
    # We will set temporary register $t9 to the base address as an initialization.
    # The idea/justification is to test whether R[rs] will add SignExtImm to it before performing the memory access.
    # At a lower level this will test whether the ALU can properly perform addition of the sign extended immediate value
    # and the base address value.

.data
.text
    .globlmain
main:
    # Start Test
    addi    $t9,    $0,         0x10010000  # Initialization

    addi    $t0,    $0,         0x391AFCDE  # Arbritrary value written into temporary register 0.
    sw      $t0,    0($t9)                  # Store into start of data segment.

    addi    $t1,    $0,         0x391AFCDF  # Arbritrary value written into temporary register 1.
    sw      $t1,    4($t9)                  # Store into next data segment word location (start + 4).

    addi    $t2,    $0,         0x391AFCE0  # Arbritrary value written into temporary register 2.
    sw      $t2,    8($t9)                  # Store into next data segment word location (start + 8).

    addi    $t3,    $0,         0x391AFCE1  # Arbritrary value written into temporary register 3.
    sw      $t3,    12($t9)                 # Store into next data segment word location (start + c).
    # End Test

    # Exit program
    halt    
    li      $v0,    10
    syscall 
