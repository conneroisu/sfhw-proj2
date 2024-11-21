.data
.text
    .globlmain
main:
    # Start Tests for positive value comparisons
    slt     $1,     $0,     $0      # Verify 0<0 sets $1 to 0
    addi    $1,     $0,     1       # Set $1 = 1
    slt     $2,     $0,     $1      # Verify 0<1 sets $2 to 1
    slt     $2,     $1,     $0      # Verify 1<0 sets $2 to 0
    add     $1,     $0,     $0      # Set clear $1
    lui     $1,     0xefff          # Set $1 = 0xefff0000
    addiu   $1,     $1,     0xffff  # Set $1 to 0xefffffff aka the max positive value
    slt     $2,     $0,     $1      # Verify that 0<0xefffffff sets $2 to 1
    slt     $2,     $1,     $0      # Verify that 0xefffffff<0 sets $2 to 0
    addi    $1,     $0,     10      # Set $1 = 10
    addi    $2,     $0,     100     # Set $2 = 100
    slt     $3,     $1,     $2      # Verify that 10<100 sets $3 to 1
    slt     $3,     $2,     $1      # Verify that 100<10 sets $3 to 0
    # End Test

    # Exit program
    halt    
    li      $v0,    10
    syscall 
