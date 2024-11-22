.data
.text
    .globlmain
main:
    # Start Test
    addi    $t0,    $0,     0xffffffff  #loads value of -1 for testing a large hex value with zero. Results should be -1 each case
    or      $t1,    $0,     $t0         #Testing 0 or -1
    or      $t2,    $t0,    $0          #Testing -1 or 0
    addi    $t4,    $0,     0xc         #Setting $t4 value to 0b1100
    addi    $t5,    $0,     0xa         #Setting $t5 value to 0b1010
    or      $t5,    $t4,    $t5         #Testing or function on $t4 with non zero register $t5. Result should be 0xe (0b1110) in $t5
    or      $t5,    $t4,    $t0         #Testing large hex value with no zero value. Result should be -1 in $t5
    or      $0,     $0,     $t4         #or should not be able to set zero register (Is this a reasonable thing to test?)
    or      $t6,    $t4,    $t4         #using or on the same register should result in the same value in $t6 as in $t4
    # End Test

    # Exit program
    halt    
