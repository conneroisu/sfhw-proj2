.text
addi    $t0,    $0,         0x391AFCDE  # Arbritrary value written into temporary register 0.
nop
nop
nop
nop
nop
sw      $t0,    0x10010000              # Store into start of data segment.

halt
