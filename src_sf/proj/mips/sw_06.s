    # Test 6 - SW (store word)
    #       
    # Assuming Test 0, 1, AND 2 have passed...
    # The objective of this test assembly file will be to check an edge case to see if the first (base address)
    # and last address location can be written to with an arbritrary value.
    # The idea/justification for this is to test whether the immediate value can write to all possible addressible locations
    # as can be provided with a 16 bit value (0xFFFC or 65532 -- note that these are four less than the max due to word alignment).

.data
.text
    .globlmain
main:
    # Start Test
    addi    $t9,    $0,         0x10010000  # Initialization

    addi    $t0,    $0,         0x391AFCDE  # Arbritrary value written into temporary register 0.
    sw      $t0,    0($t9)                  # Store into start of data segment.

    addi    $t1,    $0,         0x391AFCDF  # Arbritrary value written into temporary register 1.
    sw      $t1,    65532($t9)              # Write to last location addressible by sign extension immediate value to base address.
    # End Test

    # Exit program
    halt    
    li      $v0,    10
    syscall 
