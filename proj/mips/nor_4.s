.data
.text
    .globlmain
main:

    # Start test
    # Test to see if it will function like other gates
    addiu   $t0,    $zero,  0x00000004

    #not gate
    nor     $t0,    $t0,    $t0

    #xor gate
    addiu   $t0,    $zero,  0x00000004
    addiu   $t1,    $zero,  0x00000005

    nor     $t2,    $t1,    $t0
    nor     $t0,    $t0,    $t0
    nor     $t1,    $t1,    $t1
    nor     $t0,    $t1,    $t0
    nor     $t0,    $t2,    $t0

    #or gate
    addiu   $t0,    $zero,  0x00000004
    addiu   $t1,    $zero,  0x00000001
    nor     $t0,    $t0,    $t1
    nor     $t0,    $t0,    $t0

    #and gate
    addiu   $t0,    $zero,  0x00000004
    addiu   $t1,    $zero,  0x00000004
    nor     $t1,    $t1,    $t1
    nor     $t0,    $t0,    $t0
    nor     $t0,    $t1,    $t0

    #test complete

    # Exit program
    halt    
    li      $v0,    10
    syscall 