.data
.text
    .globlmain
main:
    # Checks common edge cases of slti

    # Start Test
    addi    $2, $0, 5
    addi    $3, $0, -5

    slti    $1, $0, 0   # 0 < 0          (shows edge case of zero less than zero)
    slti    $1, $2, 5   # 5 < 5          (shows edge case of positive number less than the same positive number)
    slti    $1, $3, -5  # -5 < -5        (shows edge case of negative number less than the same negative number)

    # End Test

    # Exit program
    halt    
