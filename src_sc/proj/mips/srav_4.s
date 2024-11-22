#Stress test file 1 for the (srav) "shift right arithmetic variable" instruction
# Shift R-Type Instruction (only uses two registers but needs the shamt field, thererfore is R-type)

# This file covers the common cases of how someone would use srav, checks that correct register is being used for shamt
# checks that target is working ok, this is neseccary as if the overall integrity of the instruction is not ok (wrong type etc)
# there no reason to make further tests for edge cases
#
# Instructions addi, lui, and sub are needed to load values to be shifted, and to create registers to compare to/act upon 
#
.data
.text
.globl main

#This test file is checking common cases
main:
    # Begin Test
    lui $t0, 0x7FFF # t0 = 0x7FFF0000
    addi $t1, $0, 0x7FFF # $t1 = 0x00007FFF
    addi $t2, $0, 16 # t2 = 0x00000010
    
    srav $t0, $t0, $t2 # t0 = 0x00007FFF #should actually get arguments from register
    sub $s4, $t1, $t0 # s4 = 0x00000000 #they should be zero if shifting worked correctly
    
    srav $t0, $t0, $0 # t0 = 0x00007FFF #shouldn't change it
    sub $s4, $t1, $t0 # s4 = 0x00000000
    
    srav $t0, $t0, $t0 # t0 = 0x00007FFF #rrgister with value of $0 should work too
    sub $s4, $t1, $t0 # s4 = 0x00000000
    
    srav $s1, $t0, $t2 # t0 = 0x00000000 #nothing left in it #testing changing rd
    sub $s4, $t0, $s1 # s4 = 0x00000000
    
    # End Test
    halt
    
