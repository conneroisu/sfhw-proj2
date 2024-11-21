.data
.text
    .globlmain
    #  Could be used as a way to clear registers. An edge case otherwise
main:
    # Start Test
    xori    $1,     $0, 0   # verify that one can clear registers, reading from 0 reg, 0 xor 0 works in the ALU
    # End Test

    # Exit program
    halt    
    li      $v0,    10
    syscall 
