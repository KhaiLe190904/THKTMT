.data
postscript1:	.word		180,1,6000, 90,1,1500, 60,1,1000, 0,1,5000, 300,1,1000, 270,1,1500, 90,0,6500, 270,1,1500, 240,1,1000, 180,1,5000, 120,1,1000, 90,1,1500, 90,0,2500, 270,1,1500, 0,1,3000, 90,1,1500, 270,0,1500, 0,1,3000, 90,1,1500   
postscript1_length:	.word	57
postscript2:	.word		180,1,8600, 0, 0, 4300, 135,1,6080, 315,0,6080, 45,1,6080, 225,0,6080, 0,0,4300, 90,0,6000, 180,1,8600, 90,0,4060, 0,1,8600, 180,0,4300, 270,1,4060, 180,0,4300, 90,0,6000, 0,1,6100, 10,1,470, 20,1,470, 30,1,470, 40,1,470, 50,1,470, 60,1,470, 70,1,470, 80,1,470, 90,1,20, 100,1,470, 110,1,470, 120,1,470, 130,1,470, 140,1,470, 150,1,470, 160,1,470, 170,1,470, 180,1,6100, 0,0,4300, 270,1,5000, 180,0,4300, 90,0,7000, 0,1,8600  
postscript2_length:	.word	117
postscript3: 	.word		180,1,8600, 90,0,4600, 0,1,8600, 180,0,4300, 270,1,4600, 90,0,6000, 0,0,4310, 180,1,6100, 170,1,470, 160,1,470, 150,1,470, 140,1,470, 130,1,470, 120,1,470, 110,1,470, 100,1,470, 90,1,20, 80,1,470, 70,1,470, 60,1,470, 50,1,470, 40,1,470, 30,1,470, 20,1,470,10,1,470, 0,1,6100, 90,0,1500,150,1,5000,30,1,5000,210,0,5000,180,1,4300
postscript3_length:	.word	93

Pleasechoose:	.asciiz		"Press 0 to print DCE\nPress 4 to print KHAI\nPress 8 to print HUY\n\n"
Messenger1:	.asciiz		"You choose to print DCE!\n"
enter:	.asciiz		"\n"
Messenger2:	.asciiz		"You choose to print KHAI!\n"
Messenger3: 	.asciiz		"You choose to print HUY!\n"
space:	.asciiz
# declaring table
# postscript length = numberOfLines*3
.eqv 	IN_ADDRESS_HEXA_KEYBOARD 	0xFFFF0012
.eqv 	OUT_ADDRESS_HEXA_KEYBOARD 	0xFFFF0014 
.eqv 	HEADING 	0xffff8010 	# Integer: An angle between 0 and 359
					# 0 : North (up)
					# 90: East (right)
					# 180: South (down)
					# 270: West (left)
.eqv 	LEAVETRACK 	0xffff8020 	# Boolean (0 or non-0):
 					# whether or not to leave a track
.eqv	WHEREX 		0xffff8030 	# Integer: Current x-location of MarsBot
.eqv 	WHEREY 		0xffff8040 	# Integer: Current y-location of MarsBot
.eqv	MOVING 		0xffff8050 	# Boolean: whether or not to move

.text 
	addi 	$s5, $0, 0		# count number of successful postscript
	addi 	$t4, $0, 0		# $t4 là biến check xem postscript1 đã được vẽ chưa
	addi 	$t5, $0, 0 		# $t5 là biến check xem postscript2 đã được vẽ chưa
	addi 	$t6, $0, 0		# $s6 là biến check xem postscript3 đã được vẽ chưa
					# 0 - chưa vẽ, 1 - đã vẽ => $s5 += 1
					# $s5 === 3 => cả 3 postscript đều đã được vẽ => complete
	addi 	$s6, $0, 3		# $s6 = 3 lần vẽ
polling:
row1: 
	li 	$t1, IN_ADDRESS_HEXA_KEYBOARD 
 	li 	$t2, OUT_ADDRESS_HEXA_KEYBOARD 
 	li 	$t3, 0x01 				# check row 1 with key 0, 1, 2, 3
 	sb 	$t3, 0($t1) 				# must reassign expected row
 	lb 	$a0, 0($t2) 				# read scan code of key button
	bne	$a0, 0x00000011, row2			# check trùng với 0 thì vẽ postscript1 nếu không thì check row2
	
draw0:	li	$v0, 4
	la	$a0, Messenger1
	syscall
	la	$t8, postscript1
check0:	bne	$t4, 0, postscript1_already_done	# nếu poscript1 đã được vẽ 1 lần trước đó rồi thì $t5=1 và không tăng $t4 nữa
	li	$t4, 1					# postscript1 sẽ done
	addi	$s5, $s5, 1				# done 1/3 postscript 
postscript1_already_done:
	la	$t7, postscript1_length			# gán $t7=length của mảng
	lw	$t7, 0($t7)
	j	main
	nop

row2: 
	li 	$t1, IN_ADDRESS_HEXA_KEYBOARD 
 	li 	$t2, OUT_ADDRESS_HEXA_KEYBOARD 
	li 	$t3, 0x02 				# check row 2 with key 4, 5, 6, 7
	sb 	$t3, 0($t1) 				# must reassign expected row
	lb 	$a0, 0($t2) 				# read scan code of key button
	bne	$a0, 0x00000012, row3			# 4 - postscript2
draw4:	li	$v0, 4
	la	$a0, Messenger2
	syscall
	la	$t8, postscript2
check4:	bne 	$t5, 0, postscript2_already_done	# nếu poscript2 đã được vẽ 1 lần trước đó rồi thì $t6=1 và không tăng $t4 nữa
	li	$t5, 1					# postscript2 done
	addi	$s5, $s5, 1				# done 1 postscript
postscript2_already_done:
	la	$t7, postscript2_length			# gán $t7=length của mảng
	lw	$t7, 0($t7)
	j	main
	nop			
	
row3: 
	li 	$t1, IN_ADDRESS_HEXA_KEYBOARD 
 	li 	$t2, OUT_ADDRESS_HEXA_KEYBOARD 
	li 	$t3, 0x04 				# check row 3 with key 8, 9, A, B
	sb 	$t3, 0($t1) 				# must reassign expected row
	lb 	$a0, 0($t2) 				# read scan code of key button
	bne	$a0, 0x00000014, invalid		# 8 - postscript3
draw8:	li	$v0, 4
	la	$a0, Messenger3
	syscall
	la	$t8, postscript3
check8:	bne	$t6, 0, postscript3_already_done	# nếu poscript3 đã được vẽ 1 lần trước đó rồi thì $s5=1 và không tăng $t4 nữa
	li	$t6, 1					# postscript3 done
	addi	$s5, $s5, 1				# done 1 postscript
postscript3_already_done:
	la	$t7, postscript3_length			# gán $t7=length của mảng
	lw	$t7, 0($t7)
	j	main
	nop		

invalid: 
	li	$v0, 4
	la	$a0, Pleasechoose
	syscall
sleep_wait: 
	li 	$a0, 1000 				# đợi 1000ms 
 	li 	$v0, 32 
	syscall 
	j 	polling

main: 
# Go to cut area
	jal 	UNTRACK 		# no draw track line
 	addi 	$s2, $zero, 135 	# Marsbot rotates given radius and start 
start_running:
 	jal 	ROTATE
 	jal 	GO
start_sleep: 
	addi 	$v0,$zero, 32 		# Keep running by sleeping in 5000 ms
 	addi 	$a0,$zero, 5000
 	syscall
 	
 	jal 	UNTRACK 		# keep old track

	li 	$s0, 0			# Set index counter for postscript array
loop:
	beq	$s0, $t7, end_loop	# if i == numberOfLines*3 then quit
	sll 	$s1, $s0, 2		# s1 = 4i
	add	$s1, $s1, $t8		# s1 = A[i]'s address
	lw	$s2, 0($s1)		# s2 = A[i]'s value - <Góc chuyển động>
	addi	$s1, $s1, 4
	lw	$s3, 0($s1)		# s3 = A[i+1]'s value - <Cắt/Không cắt>		
	addi	$s1, $s1, 4 
	lw	$s4, 0($s1)		# s4 = A[i+2]'s value - <Thời gian chạy>
		
	jal 	TRACK_UNTRACK 		# draw track line/ or not 
running:
 	jal 	ROTATE
 	jal 	GO
sleep: 
	addi 	$v0,$zero,32 		# Keep running by sleeping bằng <Thời gian chạy>
 	add 	$a0,$zero,$s4
 	syscall
 
 	jal 	UNTRACK 		# keep old track
 	
	addi	$s0, $s0, 3		# tăng lên 3 phần tử của mảng tiếp theo	
	j 	loop
end_loop:
	jal	STOP
	beq	$s5, $s6, end_main	# Nếu $s4 = $s6 thì dừng chương trình (với $s6 define bằng 3 ở ban đầu)
	j 	polling			# Nếu chưa vẽ đủ 3 postscript thì tiếp tục polling
end_main:	
	li	$v0, 10
	syscall
 
#-----------------------------------------------------------
# GO procedure, to start running
# param[in] none
#-----------------------------------------------------------

GO: 
	li 	$at, MOVING 		# change MOVING port
 	addi 	$k0, $zero,1 		# to logic 1,
 	sb 	$k0, 0($at) 		# to start running
 	jr 	$ra
 	
#-----------------------------------------------------------
# STOP procedure, to stop running
# param[in] none
#-----------------------------------------------------------

STOP: 
	li 	$at, MOVING 		# change MOVING port to 0
 	sb 	$zero, 0($at) 		# to stop
 	jr 	$ra
 	
#-----------------------------------------------------------
# TRACK procedure, to start drawing line 
# param[in] none
#----------------------------------------------------------- 

TRACK_UNTRACK: 
	li 	$at, LEAVETRACK 	# change LEAVETRACK port
 	sb 	$s3, 0($at) 		# to start tracking/ or not
 	jr 	$ra
 
#-----------------------------------------------------------
# UNTRACK procedure, to stop drawing line
# param[in] none
#----------------------------------------------------------- 

TRACK: 
	li 	$at, LEAVETRACK 	# change LEAVETRACK port
 	addi 	$k0, $zero,1 		# to logic 1,
 	sb 	$k0, 0($at) 		# to start tracking
 	jr 	$ra

UNTRACK:
	li 	$at, LEAVETRACK 	# change LEAVETRACK port to 0
 	sb 	$zero, 0($at) 		# to stop drawing tail
 	jr 	$ra
#-----------------------------------------------------------
# ROTATE procedure, to rotate the robot
# param[in] $a0, An angle between 0 and 359
# 0 : North (up)
# 90: East (right)
# 180: South (down)
# 270: West (left)
#-----------------------------------------------------------
ROTATE: 
	li 	$at, HEADING 		# change HEADING port
 	sw 	$s2, 0($at) 		# to rotate robot
 	jr 	$ra
