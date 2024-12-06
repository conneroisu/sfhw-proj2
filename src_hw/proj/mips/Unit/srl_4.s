.data
.text
    .globlmain
main:
    # Start Test
    lui     $1, 0xFFFF

    #Check that shifting 0 just sets $2 to the value of $1
    srl     $2, $1,     0

    #Shifts the upper 16 bits to the bottom 16 bits, filling up first 16 with 0s
    srl     $3, $1,     16
    # End Test

    # Exit program
    halt    
