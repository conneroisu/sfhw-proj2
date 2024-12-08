.data
.text
    .globlmain
main:
    #start test
    sub     $1,     $0, $0  #verify that the ALU can handle 0-0 and output 0
    # Exit program
    halt    
    li      $v0,    10
    syscall 