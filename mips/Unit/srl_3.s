.data
.text
    .globlmain
main:
    # Start Test
    #This tests that the srl instruction is able to be used as the source and destination register.  Also tests that there is no error with large shift values consecutively.

    lui     $1, 0xFFFF
    ori     $1, $1,     0xFFFF

    #Tests that there is no exception with performing large shifts. Value in $2 should be cleared after these instructions
    srl     $2, $1,     31
    srl     $2, $2,     31
    srl     $2, $2,     31

    #Tests that many shift instructions can be done on the same register, value in $3 should be 0x3
    srl     $3, $1,     2
    srl     $3, $3,     10
    srl     $3, $3,     1
    srl     $3, $3,     15
    srl     $3, $3,     2
    # End Test

    # Exit program
    halt    
