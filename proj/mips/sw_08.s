    # Test 8 - SW (store word)
    #       
    # Assuming Test 0, 1, AND 2 have passed...
    # The objective of this test assembly file will be to check if the zero register can be used to clear
    # an arbitrary value stored at the base data address location.

.data
.text
    .globlmain
main:
    # Start Test
    addi    $t9,    $0,     0x10010000  # Initialization

    addi    $t1,    $0,     0x391AFCDF  # Arbritrary value written into temporary register 0.
    sw      $t1,    0($t9)              # Write to base address with arbitrary value.

    sw      $0,     0($t9)              # Write zero to base address.
    # End Test

    # Exit program
    halt    
    li      $v0,    10
    syscall 
