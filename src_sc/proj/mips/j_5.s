.data
.text
    .globlmain
main:
    # Start Test 2 -- uncommon case
    # usually j will not be used for a while loop
    # but it gives repeated used as other things are changing for j
    addi    $9,     $0, 8       #set $9 to 8
    add     $8,     $0, $0      #set $8 to 0

loop:
    beq     $8,     $9, exit    #if $8 == 8 exit loop
    addi    $8,     $8, 1       #add 1 to $8
    j       loop                #jump to loop

exit:
    # succesful test: $8 will be 8
    # failed test: $8 will not be 8, most likley 1
    # End Test

    # Exit program
    halt    
    li      $v0,    10
    syscall 
