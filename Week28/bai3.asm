#abs
li $t1, -100
bltz $t1, negative
j next
negative: 
sub $t1, $0, $t1 
next: 
add $s0, $t1, $0
