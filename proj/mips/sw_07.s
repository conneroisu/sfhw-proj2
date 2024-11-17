    # Test 7 - SW (store word)
    #       
    # Assuming Test 0, 1, AND 2 have passed...
    # The objective of this test assembly file will be to check an edge case to see if the first (base address)
    # and last + 4 address location can be written to with an arbritrary value.
    # The idea/justification for this is to test whether the assembler can break down the immediate value to make sure it writes
    # properly to 0x10020000, which normally would not be able to be written to without help from the assembler (as the 16 bit immediate number
    # is larger than can be represented by those 16 bits).

.data
.text
    .globlmain
main:
    # Start Test
    addi    $t9,    $0,         0x10010000  # Initialization

    addi    $t0,    $0,         0x391AFCDF  # Arbritrary value written into temporary register 0.
    sw      $t0,    65536($t9)              # Write to last location addressible by sign extension immediate value + 4 to base address.
    # End Test

    # Exit program
    halt    
    li      $v0,    10
    syscall 
