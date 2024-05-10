.data
messenger: .asciiz "Nhap vao mot ki tu: "
.eqv SEVENSEG_LEFT 0xFFFF0011 	# Dia chi cua den led 7 doan trai. 
 				# Bit 0 = doan a; 
 				# Bit 1 = doan b; ... 
 				# Bit 7 = dau . 
.eqv SEVENSEG_RIGHT 0xFFFF0010 # Dia chi cua den led 7 doan phai 
.eqv SEVENSEG_0 0x3F
.eqv SEVENSEG_1 0x6
.eqv SEVENSEG_2 0x5B
.eqv SEVENSEG_3 0x4F
.eqv SEVENSEG_4 0x66
.eqv SEVENSEG_5 0x6D
.eqv SEVENSEG_6 0x7D
.eqv SEVENSEG_7 0x7
.eqv SEVENSEG_8 0x7F
.eqv SEVENSEG_9 0x6F
.text 
input: 
        li $v0, 4
        la $a0, messenger
        syscall
        li $v0, 12
        syscall
        move $t0, $v0
        li $s0, 10
main: 
       	div $t0, $s0
       	mfhi $t1 # lấy ra chữ số cuối
       	mflo $t0
       	div $t0, $s0
       	mfhi $t2 # lấy ra chữ số hàng chục
       	move $a0, $t2  # set value for segments 
       	jal convert 
 	jal SHOW_7SEG_LEFT # show 
 	nop 
       	move $a0, $t1  # set value for segments 
       	jal convert 
 	jal SHOW_7SEG_RIGHT # show 
 	nop 
exit: 	li $v0, 10 
 	syscall 
endmain: 

SHOW_7SEG_LEFT: 
	li $t0, SEVENSEG_LEFT # assign port's address 
 	sb $a0, 0($t0) # assign new value 
 	nop 
 	jr $ra 
 	nop 

SHOW_7SEG_RIGHT: 
	li $t0, SEVENSEG_RIGHT # assign port's address 
 	sb $a0, 0($t0) # assign new value 
 	nop 
 	jr $ra 
 	nop 
convert:
	beq $a0, 0, zero
	beq $a0, 1, one
	beq $a0, 2, two
	beq $a0, 3, three
	beq $a0, 4, four
	beq $a0, 5, five
	beq $a0, 6, six
	beq $a0, 7, seven
	beq $a0, 8, eight
	beq $a0, 9, nine
zero:
	li $a0, SEVENSEG_0
	jr $ra
one:
	li $a0, SEVENSEG_1
	jr $ra
two:
	li $a0, SEVENSEG_2
	jr $ra
three:
	li $a0, SEVENSEG_3
	jr $ra
four:
	li $a0, SEVENSEG_4
	jr $ra
five:
	li $a0, SEVENSEG_5
	jr $ra
six:
	li $a0, SEVENSEG_6
	jr $ra
seven:
	li $a0, SEVENSEG_7
	jr $ra
eight:
	li $a0, SEVENSEG_8
	jr $ra
nine:
	li $a0, SEVENSEG_9
	jr $ra
       	
