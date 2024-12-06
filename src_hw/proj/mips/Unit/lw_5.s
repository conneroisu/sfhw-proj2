.data   
x:  .word   3, 6, 9, 12, 15
.text   
    .globl  main

main:

    la      $t0,    x           # loads x's address
    addi    $t1,    $zero,  20  # sets t1 to 20
    lui     $t2,    0x1001      # sets t2 to the address of x
    sw      $t1,    4($t2)      # sets 4(x) t0 20
    lw      $t2,    4($t0)      # loads 4(x) to t2

    # Exit program
    li      $v0,    10
    syscall 
    halt    
