.data
.text
    .globlmain
main:
    # Start Test
    # The goal of this test is to test if the xori behaves properly when xored wtih 0
    addi    $s1,    $0,     0       #clear registers
    xori    $s1,    $s1,    0       #xor with 0
    addi    $s1,    $0,     0       #clear registers
    xori    $s1,    $s1,    0xffff  #xor with 0 and max input
    addi    $s1,    $0,     0xffff
    lui     $s1,    0xffff
    xori    $s1,    $s1,    0
    xori    $t1,    $t1,    0       #some genral use case but with 0
    xori    $t1,    $t1,    0       #some genral use case but with 0
    addi    $t1,    $t1,    1161
    xori    $t1,    $s1,    0       #some genral use case but with 0
    # End Test

    #TA Edit
    halt    
    # Exit program
    # li $v0, 10
    #syscall

