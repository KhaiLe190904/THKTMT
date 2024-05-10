.data
nhapX1: .asciiz "Nhap x1: "
nhapY1: .asciiz "Nhap y1: "
nhapX2: .asciiz "Nhap x2: "
nhapY2: .asciiz "Nhap y2: "
.eqv MONITOR_SCREEN 0x10010000 # Dia chi bat dau cua bo nho man hinh 
.eqv RED 0x00FF0000 # Cac gia tri mau thuong su dung 
.eqv GREEN 0x0000FF00 

.text 
 	li $k0, MONITOR_SCREEN #Nap dia chi bat dau cua man hinh 
 	li $t1, 0
 	li $t2, 0 
input:
       li $v0, 4
       la $a0, nhapX1
       syscall
       li $v0, 5
       syscall
       move $s0, $v0 	# x1 = s0
       li $v0, 4
       la $a0, nhapY1
       syscall
       li $v0, 5
       syscall
       move $s1, $v0 	# y1 = s1
       li $v0, 4
       la $a0, nhapX2
       syscall
       li $v0, 5
       syscall
       move $s2, $v0 	# x2 = s2
       li $v0, 4
       la $a0, nhapY2
       syscall
       li $v0, 5
       syscall
       move $s3, $v0 	# y2 = s3
compare_x:
	bgt $s0, $s2, set_max_x
compare_y:
	bgt $s1, $s3, set_max_y
start:
	move $t0, $s0 # current x
	move $t1, $s1 # current y
draw_border:
	bgt $t0, $s2, next_line_border
	bgt $t1, $s3, start_fill
	mul $t2, $t1, 8
	add $t2, $t2, $t0
	mul $t2, $t2, 4
	add $k1, $k0, $t2
	li $t3, RED
	sw $t3, 0($k1)
	addi $t0, $t0, 1
	j draw_border
next_line_border:
	move $t0, $s0
	addi $t1, $t1, 1
	j draw_border
start_fill:
	addi $s0, $s0, 1
	addi $s1, $s1, 1
	subi $s2, $s2, 1
	subi $s3, $s3, 1
	move $t0, $s0 # current x
	move $t1, $s1 # current y
fill:
	bgt $t0, $s2, next_line_fill
	bgt $t1, $s3, fill
	mul $t2, $t1, 8
	add $t2, $t2, $t0
	mul $t2, $t2, 4
	add $k1, $k0, $t2
	li $t3, GREEN
	sw $t3, 0($k1)
	addi $t0, $t0, 1
	j fill
next_line_fill:
	move $t0, $s0
	addi $t1, $t1, 1
	j fill
set_max_x:
	move $t0, $s0
	move $s0, $s2
	move $s2, $t0
	j compare_y
set_max_y:
	move $t0, $s0
	move $s1, $s3
	move $s3, $t0
	j start
