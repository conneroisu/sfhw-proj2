.data
.text
    .globlmain
main:
    # Test 2: Jumping to a distant address
    # This test will check if the j instruction correctly handles jumping to a distant address
    # addi instructions are included to track and ensure the expected amount of jump instructions are being executed
    # Start Test
start:
    addi    $t0,    $t0,    1
    j       loop

    addi    $t0,    $t0,    1
    j       end

loop:
    addi    $t0,    $t0,    1
    j       end

end:
    addi    $t0,    $t0,    1

    # End Test

    # Exit program
    halt    
