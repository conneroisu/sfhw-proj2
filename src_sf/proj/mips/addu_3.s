.text

    # addu stress test 3
main:
    # Initialize registers for unsigned addition.
    lui     $1,     0x8000          # $1 = 0x80000000
    lui     $2,     0x0FFF
    ori     $2,     $2,     0xFFFF  # $2 = 0x0FFFFFFF

    # verify unsigned addition works without overflow adds correctly
    addu    $3,     $1,     $2      # $3 = 0x8FFFFFFF
    lui     $2,     0x7000
    addu    $4,     $3,     $2      # $4 = 0xFFFFFFFF
    addi    $2,     $zero,  1
    addu    $5,     $4,     $2      # $5 = 0x00000000, no overflow
    addu    $5,     $zero,  $1      # $5 = 0x80000000
    addu    $5,     $5,     $5      # $5 = 0x00000000, no overflow

    lui     $2,     0x800F
    ori     $2,     $2,     0xF001

    addu    $5,     $1,     $2      # $5 = 0x00000001, no overflow
    addu    $5,     $1,     $2      # $5 = 0x000FF001, no overflow
    addu    $6,     $5,     $2      # $6 = 0x801FE002
    addu    $7,     $6,     $2      # $7 = 0x002FD003, no overflow

    # Exit program
    halt    
    li      $v0,    10
    syscall 
