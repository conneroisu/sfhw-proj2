.data
.text
    .globlmain
main:
    # Start Test
    # uses add, addi, slti

    # this test takes numbers in registers, and
    # tests to make sure each can have an equal tested against them correctly

    addi    $30,    $0,     2       #set to (0b10)
    addi    $1,     $0,     -2340   # set for later
    addi    $3,     $0,     8871    # set for later

    slti    $10,    $1,     -2340   #false
    add     $30,    $30,    $10     #add to sum
    add     $30,    $30,    $30     #double (bitshift)

    slti    $10,    $1,     8871    #false
    add     $30,    $30,    $10     #add to sum
    add     $30,    $30,    $30     #double (bitshift)

    #$30 should be 0b00001000

    # End Test

    # Exit program
    halt    
