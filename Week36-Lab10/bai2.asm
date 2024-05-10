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
	li $t3, 0
loop_red:
 	li $t2, 1
      	beq $t1, 8, next_line_red
	li $t0, RED
	sw $t0, 0($k0)
	addi $k0, $k0, 4
	addi $t1, $t1, 1
 	j loop_red 
next_line_red:
	li $t1, 0
loop_green:
 	li $t2, 1
      	beq $t1, 8, next_line_green
	li $t0, GREEN
	sw $t0, 0($k0)
	addi $k0, $k0, 4
	addi $t1, $t1, 1
 	j loop_green	
next_line_green:
       li $t1, 0
loop_blue:
 	li $t2, 1
      	beq $t1, 8, next_line_blue
	li $t0, BLUE
	sw $t0, 0($k0)
	addi $k0, $k0, 4
	addi $t1, $t1, 1
 	j loop_blue	
next_line_blue:
       li $t1, 0
loop_white:
 	li $t2, 1
      	beq $t1, 8, next_line_white
	li $t0, WHITE
	sw $t0, 0($k0)
	addi $k0, $k0, 4
	addi $t1, $t1, 1
 	j loop_white	
next_line_white:
       li $t1, 0
loop_yellow:
 	li $t2, 1
      	beq $t1, 8, next_line_yellow
	li $t0, YELLOW
	sw $t0, 0($k0)
	addi $k0, $k0, 4
	addi $t1, $t1, 1
 	j loop_yellow	
next_line_yellow:
       li $t1, 0
loop_magenta:
 	li $t2, 1
      	beq $t1, 8, next_line_magenta
	li $t0, MAGENTA
	sw $t0, 0($k0)
	addi $k0, $k0, 4
	addi $t1, $t1, 1
 	j loop_magenta	
next_line_magenta:
       li $t1, 0
loop_cyan:
 	li $t2, 1
      	beq $t1, 8, next_line_cyan
	li $t0, CYAN
	sw $t0, 0($k0)
	addi $k0, $k0, 4
	addi $t1, $t1, 1
 	j loop_cyan	
next_line_cyan:
       li $t1, 0
loop_purple:
 	li $t2, 1
      	beq $t1, 8, next_line_purple
	li $t0, PURPLE
	sw $t0, 0($k0)
	addi $k0, $k0, 4
	addi $t1, $t1, 1
 	j loop_purple	
next_line_purple:
       li $t1, 0