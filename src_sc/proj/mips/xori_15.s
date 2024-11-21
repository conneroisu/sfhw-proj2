.data
.text
    .globlmain
main:
    # Start Test
    # The goal of this test is to test if the xori behaves properly when xored wtih general use cases
    addi    $s1,    $0,     6       #load registers
    xori    $s1,    $s1,    7
    addi    $s1,    $0,     65465   #load registers
    xori    $s1,    $s1,    4165
    addi    $s1,    $0,     0x5413  #load registers
    lui     $s1,    0xf644          #load registers for a "negative" number
    xori    $s1,    $s1,    56134
    xori    $t1,    $t1,    0x0001
    xori    $t1,    $t1,    0xf000  #negative immediate
    addi    $t1,    $t1,    1161
    xori    $t1,    $s1,    0xff01
    # End Test
    #TA Edit
    halt    

    # Exit program
    #li $v0, 10
    #syscall
