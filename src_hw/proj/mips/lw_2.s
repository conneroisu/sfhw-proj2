.data   
temp:   .word   -23         # declare storage for temp: initial value is -23
.text   
        .globl  main

main:   
    # Start Test
    lw      $t0,    temp    # load contents of RAM locatrion into register $t0 = temp
    li      $t1,    -5      # $t1 = 5
    sw      $t1,    temp    # store contents of register $t1 into RAM: temp = $t1
    # End Test

    # Exit program
    halt    
    li      $v0,    10
    syscall 
