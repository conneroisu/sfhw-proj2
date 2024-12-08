.data
.text
    .globlmain
main:
    #Goal: Ensure all bits can be cleard

    #Start Test
    addi    $t2,    $zero,  0x1234      #$t2 <= 0x1234
    or      $t2,    $zero,  $zero       #Expect $t2 to be 0x00000000

    addi    $t3,    $zero,  0xFFFFFFFF  #$t3 <= 0xFFFFFFFF
    or      $t3,    $zero,  $zero       #$t3 <= 0x00000000

    # Exit program
    halt    
    li      $v0,    10
    syscall 
