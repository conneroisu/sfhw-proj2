.data
.text
    .globlmain
main:
    #Start Test
    sub     $1,     $0, $0  # Test that 0-0 results in 0 and register can be cleared
    sub     $2,     $0, $0  # Test that 0-0 results in 0 and register can be cleared
    sub     $3,     $0, $0  # Test that 0-0 results in 0 and register can be cleared
    sub     $4,     $0, $0  # Test that 0-0 results in 0 and register can be cleared
    sub     $5,     $0, $0  # Test that 0-0 results in 0 and register can be cleared
    sub     $6,     $0, $0  # Test that 0-0 results in 0 and register can be cleared
    sub     $7,     $0, $0  # Test that 0-0 results in 0 and register can be cleared
    #End Test

    #Exit Program
    halt    
    li      $v0,    10
    syscall 