.data
.text
    .globlmain
main:
    # Start Test 1 -- multiple jumps
    # tests working of jump when multiple
    # jumps instructions are in the same code
    addi    $8,         $0, 10  #set $8 to 10

    j       skipAdd1            #skip adding 1 to $8
    addi    $8,         $8, 1
skipAdd1:
    addi    $8,         $8, 10  #add 10 to $8

    j       skipAdd2            #skip adding 2 to $8
    addi    $8,         $8, 2
skipAdd2:
    addi    $8,         $8, 10  #add 10 to $8

    j       skipAdd3            #skip adding 3 to $8
    addi    $8,         $8, 3
skipAdd3:
    addi    $8,         $8, 10  #add 10 to $8

    j       skipAdd4            #skip adding 4 to $8
    addi    $8,         $8, 4
skipAdd4:
    addi    $8,         $8, 10  #add 10 to $8

    # succesful test: $8 will be 50
    # failed test: $8 will most likley be 60
    # End Test

    # Exit program
    halt    
    li      $v0,        10
    syscall 
