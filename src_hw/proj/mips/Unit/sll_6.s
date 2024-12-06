.data
.text
    .globlmain
main:
    # Start Test

    addi    $s1,    $zero,  -1000   #Set $s1 to -1000
    sll     $t1,    $s1,    12      #Test overflow/unusual behavior, shift negative number by 12 whose last bits (MSB) are 11

    # End Test

    # Exit program
    halt    