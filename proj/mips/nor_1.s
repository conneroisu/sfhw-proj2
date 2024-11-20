.data
.text
    .globlmain

main:
    # START TEST
    nor     $8,     $0, $0  # 0 NOR 0 = 1; test to see if $8 = 0xFFFFFFFF.
    nor     $9,     $8, $0  # 0 NOR 1 = 0; test whether registers can be cleared. clear $9 (0x00000000)

    #END
    halt    
    li      $v0,    10
    syscall 