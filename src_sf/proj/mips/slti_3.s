.data
.text
    .globlmain
main:
    # Checks immediate edge cases of slti


    addi    $2, $2, -32768  # lowest immediate value (0xFFFF8000)
    addi    $3, $0, 32767   # highest immediate value (0x00007FFF)

    slti    $1, $2, -32768  # 0x8000 < 0x8000              (shows edge case of the lowest immediate value less than itself)
    slti    $1, $3, 32767   # 0x7FFF < 0x7FFF              (shows edge case of the highest immediate value less than itself)
    slti    $1, $2, 32767   # 0x8000 < 0x7FFF              (shows edge case of the lowest immediate value less than the highest immediate value)
    slti    $1, $3, -32768  # 0x7FFF < 0x8000              (shows edge case of the highest immediate value less than the lowest immediate value)

    addi    $2, $2, -1      # lowest immediate value minus one
    addi    $3, $3, 1       # highest immediate value plus one

    slti    $1, $2, -32768  # 0xFFFF7FFF < 0x8000          (shows edge case of the lowest immediate value minus one less than the lowest immediate value)
    slti    $1, $3, 32767   # 0x00008000 < 0x7FFF          (shows edge case of the highest immediate value plus one less than the highest immediate value)

    # End Test

    # Exit program
    halt    
