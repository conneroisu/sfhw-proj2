.data
.text
    .globlmain
main:
    # Start Test
    # The goal of this test is to test if the xori behaves properly when xored wtih maxed out edge cases
    addi    $s1,    $0,     6       #load registers
    xori    $s1,    $s1,    0xffff
    addi    $s1,    $0,     0xffff  #load registers
    xori    $s1,    $s1,    0xffff
    addi    $s1,    $0,     0xffff  #load registers
    lui     $s1,    0xffff          #load registers for a "negative" number
    xori    $s1,    $s1,    0xffff
    addi    $s1,    $0,     0x0012  #load registers
    lui     $s1,    0x055f          #load registers for a "negative" number
    xori    $s1,    $s1,    0xffff
    addi    $s1,    $0,     0xffff  #load registers
    lui     $s1,    0xffff          #load registers for a "negative" number
    xori    $s1,    $s1,    0x0123
    xori    $t1,    $t1,    0xffff
    xori    $t1,    $t1,    0xffff  #negative immediate
    addi    $t1,    $t1,    0x3f3f
    xori    $t1,    $s1,    0xffff
    # End Test
    #TA edit
    halt    
    # Exit program
    #li $v0, 10
    #syscall
