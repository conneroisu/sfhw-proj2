.data
.text
    .globlmain
main:
    # Start Test
    # uses add, addi, slti

    # this test takes 2 numbers to make sure each can have a larger and smaller number tested against them correctly

    addi    $30,    $0,     0       #set to zero
    addi    $1,     $0,     1000    # set for later
    addi    $3,     $0,     3003    # set for later

    slti    $10,    $1,     1111    #true
    add     $30,    $30,    $10     #add to sum
    add     $30,    $30,    $30     #double (bitshift)

    slti    $10,    $3,     9970    #true
    add     $30,    $30,    $10     #add to sum
    add     $30,    $30,    $30     #double (bitshift)

    slti    $10,    $3,     3004    #true
    add     $30,    $30,    $10     #add to sum
    add     $30,    $30,    $30     #double (bitshift)

    slti    $10,    $3,     1089    #false
    add     $30,    $30,    $10     #add to sum
    add     $30,    $30,    $30     #double (bitshift)

    slti    $10,    $3,     3010    #true
    add     $30,    $30,    $10     #add to sum

    #$30 should be 0b00011101

    # End Test

    # Exit program
    halt    
