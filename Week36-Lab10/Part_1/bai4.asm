.eqv MONITOR_SCREEN 0x10010000 #Dia chi bat dau cua bo nho man hinh 
.eqv RED 0x00FF0000 #Cac gia tri mau thuong su dung 
.eqv GREEN 0x0000FF00 
.eqv BLUE 0x000000FF 
.eqv WHITE 0x00FFFFFF 
.eqv YELLOW 0x00FFFF00 
.eqv MAGENTA 0x00FF00FF
.eqv CYAN 0x0000FFFF
.eqv PURPLE 0x00800080

.text 
 	li $k0, MONITOR_SCREEN #Nap dia chi bat dau cua man hinh 
 	li $t1, 0 # counter
 	li $t2, 0
 	li $t3, 2
 	li $t7, 8
loop:
      	beq $t1, $t7, next_line
	li $t0, PURPLE
	sw $t0, 0($k0)
	addi $t1, $t1, 1
	addi $k0, $k0, 4
	li $t0, CYAN
	sw $t0, 0($k0)
	addi $t1, $t1, 1
	addi $k0, $k0, 4
 	j loop
next_line:
	beq $t2, $t7, endmain
	li $t1, 0
	addi $t2, $t2, 1
	div $t2, $t3
	mfhi $s0
	beq $s0, $zero, loop
	j loop_2
loop_2:
      	beq $t1, $t7, next_line
	li $t0, CYAN
	sw $t0, 0($k0)
	addi $t1, $t1, 1
	addi $k0, $k0, 4
	li $t0, PURPLE
	sw $t0, 0($k0)
	addi $t1, $t1, 1
	addi $k0, $k0, 4
 	j loop_2
endmain:
