.data
.text
    .globlmain
main:
    # Start Test
    addi    $1,     $0, 281     #Ensure instruction takes common positive number
    addi    $1,     $0, -381    #Ensure instruction takes common negative number
    addi    $1,     $1, 381     #Ensure opposite sign and same magnitude will clear register

    addi    $2,     $0, -1      #Ensure that instruction reads from zero register
    addi    $0,     $2, 1       #Ensure that the zero register cannot be written to

    addi    $3,     $0, 2       #Ensure random sequence of +,-, and 0 outputs expected values
    addi    $3,     $3, -1
    addi    $3,     $3, 0

    addi    $3,     $3, -100    #Ensure random sequence of +,-, and 0 outputs expected values
    addi    $3,     $3, 53
    addi    $3,     $3, 0

    addi    $3,     $3, 0       #Ensure random sequence of +,-, and 0 outputs expected values
    addi    $3,     $3, 22
    addi    $3,     $3, -1000

    # End Test

    # Exit program
    halt    
    li      $v0,    10
    syscall 
