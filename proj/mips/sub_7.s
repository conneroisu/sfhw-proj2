.data
.text
.globl main
main:
    # Start Test
    lui $8, 0xFFFF
    addi $8, $8, 0xFFFF
    lui $9, 0xFFFF
    addi $9, $9, 0xFFFE
    sub $10, $8, $9  #Test a negative number minus a negative nunmber $10 should be 1
    
    addi $11, $0, 0x0002
    addi $12, $0, 0x0001
    sub $13, $11, $12 #Test positive number minus positive number $13 should be 1
    
    sub $14, $8, $12 #Test negative number minus positive number $14 should be -2 aka 0xFFFFFFFE
    
    sub $15, $12, $8 #Test positive number minus negative number $15 should be 2
    #End Test
    halt 