.data
.text
    .globlmain
main:
    #this is simply testing a common case to see if two registers contain the same value.
    # Start Test
    addi    $1, $0, 7       #adding the value 7 to register 1
    addi    $2, $0, 7       #adding the value 7 to register 2
    beq     $2, $1, exit    #checking to see if both registers contain some value, if so exit.

    # End Test
exit:
    # Exit program
    halt    
