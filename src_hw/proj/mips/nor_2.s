.data
.text
    .globlmain

main:
    # START TEST
    addi    $10,    $0,     0xAAAAAAAA  # set $10 = 0xAAAAAAAA adn make sure sign extention works appropriately
    nor     $10,    $10,    $0          # test whether bits of the value stored in $10 can be inverted (0x55555555)
    nor     $11,    $10,    $0          # invert bits stored in $10; $11 = 0xAAAAAAAA

    #END TEST
    halt    
    li      $v0,    10
    syscall 