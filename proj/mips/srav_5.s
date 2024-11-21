#Stress test file 1 for the (srav) "shift right arithmetic variable" instruction
# Shift R-Type Instruction (only uses two registers but needs the shamt field, thererfore is R-type)
#
# This particular file checks that different shifting values yield different results, this part is probably the most
# important to the actual functionality of the instruction, if the amount you ask to shift is not matched to the output
# the instruction then even though structure whats being called is ok, its not producing anything of value
#
# Instructions addi, lui, and sub are needed to load values to be shifted, and to create registers to compare to/act upon 
.data
.text
.globl main

main:

    # Begin Test
    lui $t0, 0x7FFF # t0 = 0x7FFF0000
    lui $t1, 0x3FFF # $t1 = 0x3FFF0000
    ori $t1, $0, 0x8000 #t1 = 0x3FFF800
    addi $t2, $0, 1 # t2 = 0x00000001

    #check that different shift amounts work
    srav $t0, $0, $2 # t0 = 0x3FFF8000
    sub $s1, $t0, $t1 # s1 = 0x00000000
    
    addi $t2, $0, 1 # t2 = 0x00000001
    srav $t0, $0, $2 # t0 = 0x0FFFE000
    sub $t2, $0, 1 # t2 = 0x00000001
    
    srav $t0, $t0, $t2 # t0 = 0x00007FFF #should actually get arguments from register
    sub $s4, $t1, $t0 # s4 = 0x00000000 #they should be zero if shifting worked correctly
    
    
    # End Test
    
    # Exit program
    halt
