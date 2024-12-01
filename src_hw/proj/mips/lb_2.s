# Test 1: Loading a signed value
# Justification: This test is to make sure load byte is loading in the signed value and we test that the operation is correct

.data
positivebyte: .byte 0x01 #value of +1
negativebyte: .byte 0xFF #-1 also tests sign extension

.text
main:
    lb $t1, positivebyte   # Load positive value into $t1
    lb $t2, negativebyte   # Load negative value into $t2
    add $t3, $t1, $t2      # Add $t1 and $t2 and store result in $t3 | t3 is 0 so 1 + (-1) works correctly


  # Exit program
    halt
