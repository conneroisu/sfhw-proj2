# Test 1: Loading a byte from memory
# Justification: This tests the basic functionality of the lb instruction, making sure that it can load a byte from memory correctly into each register.

.data
    byte_data: .byte 255

.text
    lb $2, byte_data    # Load byte from memory into $2
    lb $3, byte_data    # Load byte from memory into $3
    lb $4, byte_data    # Load byte from memory into $4
    lb $5, byte_data    # Load byte from memory into $5
    lb $6, byte_data    # Load byte from memory into $6
    lb $7, byte_data    # Load byte from memory into $7
    lb $8, byte_data    # Load byte from memory into $8
    lb $9, byte_data    # Load byte from memory into $9
    lb $10, byte_data    # Load byte from memory into $10
    lb $11, byte_data    # Load byte from memory into $11
    lb $12, byte_data    # Load byte from memory into $12
    lb $13, byte_data    # Load byte from memory into $13
    lb $14, byte_data    # Load byte from memory into $14
    lb $15, byte_data    # Load byte from memory into $15
    lb $16, byte_data    # Load byte from memory into $16
    lb $17, byte_data    # Load byte from memory into $17
    lb $18, byte_data    # Load byte from memory into $18
    lb $19, byte_data    # Load byte from memory into $19
    lb $20, byte_data    # Load byte from memory into $20
    lb $21, byte_data    # Load byte from memory into $21
    lb $22, byte_data    # Load byte from memory into $22
    lb $23, byte_data    # Load byte from memory into $23
    lb $24, byte_data    # Load byte from memory into $24
    lb $25, byte_data    # Load byte from memory into $25
    lb $26, byte_data    # Load byte from memory into $26
    lb $27, byte_data    # Load byte from memory into $27
    lb $28, byte_data    # Load byte from memory into $28
    lb $29, byte_data    # Load byte from memory into $29
    lb $30, byte_data    # Load byte from memory into $30
    lb $31, byte_data    # Load byte from memory into $31
    lb $1, byte_data    # Load byte from memory into $1 tested last because at resets
    
    
# Exit program
    halt

