.data
.text
    .globlmain
main:
    # Start Test

    sll     $t1,    $t2,    31  #shift by max bits held in each register to test edge case, 31 is maximum number of bits MIPS, or MARS atleast, allows for SLL

    # End Test

    # Exit program
    halt    