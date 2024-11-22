.data
.text
    .globlmain
main:
    # Start Test 0 -- common case
    # this tests a normal j instruction and is important
    # as it will be the type most used

    addi    $8,         $0, 1   #set $8 to 1
    j       skipAdd             # skip an add to $8
    addi    $8,         $8, 2   #add 2 to $8 (should not execute)

skipAdd:

    # succesful test: $8 will be 1
    # failed test: $8 will be 3
    # End Test

    # Exit
    halt    
    li      $v0,        10
    syscall 