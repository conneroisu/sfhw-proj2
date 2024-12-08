.text
main:
beq $1, $2, Label
add $3, $4, $5
sub $6, $7, $8
beq $1, $2, Label
Label:
or $9, $1, $2
halt
