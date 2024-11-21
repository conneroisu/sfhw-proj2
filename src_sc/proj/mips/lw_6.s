.data   
myArray:    .word   2, 4, 6, 8, 10      # an array of integers #TA EDIT
.text   
            .globl  main
main:       
    # Start Test
    addi    $t1,    $t1,    0x7ffffe00
    lw      $t2,    0($t1)              # expected = pass as it is the top of stack
    and     $t1,    $t1,    $zero       # set to 0 for next test

    # End Test
    # Exit program
    halt    
