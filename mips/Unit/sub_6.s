.data
.text
.globl main
main:
    # Start Test
    lui $8, 0x8000
    addi $9, $0, 1
    sub $10, $8, $9  #Test Overflow by subtracting the most negative number by 1 should throw overflow error
    #End Test
    halt 