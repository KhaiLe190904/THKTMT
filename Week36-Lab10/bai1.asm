.eqv SEVENSEG_LEFT 0xFFFF0011 # Dia chi cua den led 7 doan trai. 
 # Bit 0 = doan a; 
 # Bit 1 = doan b; ... 
 # Bit 7 = dau . 
.eqv SEVENSEG_RIGHT 0xFFFF0010 # Dia chi cua den led 7 doan phai 
.text 
main: 
 	li $a0, 7 # set value for segments 
 	jal SHOW_7SEG_LEFT # show 
 	nop 
 	li $a0, 109 # set value for segments 
 	jal SHOW_7SEG_RIGHT # show 
 	nop 
exit: 	li $v0, 10 
 	syscall 
endmain: 
#--------------------------------------------------------------- 
# Function SHOW_7SEG_LEFT : turn on/off the 7seg 
# param[in] $a0 value to shown 
# remark $t0 changed 
#--------------------------------------------------------------- 
SHOW_7SEG_LEFT: 
	li $t0, SEVENSEG_LEFT # assign port's address 
 	sb $a0, 0($t0) # assign new value 
 	nop 
 	jr $ra 
 	nop 
#--------------------------------------------------------------- 
# Function SHOW_7SEG_RIGHT : turn on/off the 7seg 
# param[in] $a0 value to shown 
# remark $t0 changed 
#--------------------------------------------------------------- 
SHOW_7SEG_RIGHT: 
	li $t0, SEVENSEG_RIGHT # assign port's address 
 	sb $a0, 0($t0) # assign new value 
 	nop 
 	jr $ra 
 	nop 