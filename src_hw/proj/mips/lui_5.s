    # Test to prove that lui overrides any bits in its way
addi    $t0,    $0,     0x10000 # place one bit at the very end of lui's reach.
lui     $t0,    0xFFFE          # One less than the full bit. If it were to add to what was there, $t0 would equal 0xFFFF0000, but it will equal 0xFFFE0000
    #TA edit
halt    
