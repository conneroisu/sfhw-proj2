# Test 1: Bit extension test
# Justification: This test is to make sure load byte is correctly storing the sign of the byte loaded by storing it in the rest of the register.

.data
positive_byte: .byte 0x7F #loading a value of 0b01111111
negative_byte: .byte 0xFF #loading a value of 0b11111111
zero_byte:     .byte 0x00

.text
main:
    # Positive Value Test
    lb $t0, positive_byte
    # Check upper 24 bits
    andi $s1, $t0, 0xFFFFFF00  # Mask lower 8 bits, excpecting the 0 in bit 7 of positive byte to carry over
    # Negative Value Test
    lb $t0, negative_byte
    # Check upper 24 bits
    andi $s2, $t0, 0xFFFFFF00  # Mask lower 8 bits, excpecting the 1 in bit 7 of positive byte to carry over

    lb $s3, zero_byte


  # Exit program
    halt
