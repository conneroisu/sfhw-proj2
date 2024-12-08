#Aidan Foss

#data sections
.data
words:.word	0 : 19        # "array" of words to contain word values
size: .word  	19             # size of "array" (agrees with array declaration)


.text
lui 	$20, 0x1001        	# Load the upper part of the address of words
nop
nop
nop
nop
nop
lw  	$11, 0($20)        	# Load word at address $20 + 0 (words[0])

halt
