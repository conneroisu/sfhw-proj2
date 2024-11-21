.data   
x:  .word   10, 1, 2, 3, 4
.text   
    .globl  main

main:

    la      $t0,    x
    lw      $t1,    0($t0)  # loads t1 with 10
    lw      $t2,    4($t0)  # loads t2 with 1
    lw      $t3,    8($t0)  # loads t3 with 2
    lw      $t4,    12($t0) # loads t4 with 3
    lw      $t5,    16($t0) # loads t5 with 4

    # Exit program
    li      $v0,    10
    syscall 
    halt    
