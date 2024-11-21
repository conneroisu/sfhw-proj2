.data
.text
    .globlmain
main:
    # Start Test

    #Test Edge Cases and Overflow Cases (make sure no overflow is generated)
    addi    $21,    $0, 1           #changed from 1 to 21 and I found $1 is assembler temporary and subu is a pseudoinstruction
    addi    $2,     $0, -1
    addi    $3,     $0, 0x80000000  #Smallest Negative Number
    addi    $4,     $0, 0X7FFFFFFF  #Largest Positive Number

    subu    $5,     $3, $2          #2nd smallest negative number
    subu    $6,     $4, $21         #2nd largest positive number

    #No Overflow Generated, instruction is unsigned
    subu    $7,     $3, $21         #Wraparound to largest positive integer
    subu    $8,     $4, $2          #Wraparound to smallest negative integer

    subu    $9,     $7, $4          #Should be zero if they are equal
    subu    $10,    $8, $3          #Should be zero if they are equal


    # End Test

    # Exit program
    halt    
    li      $v0,    10
    syscall 
