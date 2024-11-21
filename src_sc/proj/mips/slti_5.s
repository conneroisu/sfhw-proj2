.data
.text
    .globlmain
main:
    # Start Test
    # uses add, addi, slti

    # this test takes three negative numbers in registers, and
    # tests to make sure each can have a larger and smaller number tested against them correctly

    addi    $30,    $0,     0       #set to zero
    addi    $1,     $0,     -2340   # set for later
    addi    $3,     $0,     -87111  # set for later

    slti    $10,    $1,     -1550   #true
    add     $30,    $30,    $10     #add to sum
    add     $30,    $30,    $30     #double (bitshift)


    # OUT OF RANGE EDIT slti $10, $1, -999990 #false
    slti    $10,    $1,     -9999   #false
    add     $30,    $30,    $10     #add to sum
    add     $30,    $30,    $30     #double (bitshift)

    slti    $10,    $3,     -9756   #true
    add     $30,    $30,    $10     #add to sum
    add     $30,    $30,    $30     #double (bitshift)

    # OUT OF RANGE EDIT slti $10, $3, -123456 #false
    slti    $10,    $3,     -9990   #false
    add     $30,    $30,    $10     #add to sum
    add     $30,    $30,    $30     #double (bitshift)

    #$30 should be 0b00010100

    # End Test

    # Exit program
    halt    
