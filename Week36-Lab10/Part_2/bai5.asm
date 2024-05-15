.eqv KEY_CODE 0xFFFF0004 	# ASCII code from keyboard, 1 byte
.eqv KEY_READY 0xFFFF0000 	# =1 if has a new keycode ? # Auto clear after lw
.eqv DISPLAY_CODE 0xFFFF000C 	# ASCII code to show, 1 byte
.eqv DISPLAY_READY 0xFFFF0008 	# =1 if the display has already to do # Auto clear after sw
.eqv HEADING 0xffff8010 # Integer: An angle between 0 and 359
.eqv MOVING 0xffff8050 # Boolean: whether or not to move
.eqv LEAVETRACK 0xffff8020 # Boolean (0 or non-0): # whether or not to leave a track

.text
	li $k0, KEY_CODE
	li $k1, KEY_READY
	li $s0, DISPLAY_CODE
	li $s1, DISPLAY_READY
main:
loop:
	nop
WaitForKey: 
	lw $t1, 0($k1) # $t1 = [$k1] = KEY_READY
	beq $t1, $zero, WaitForKey # if $t1 == 0 then Polling
ReadKey: 
	lw $t0, 0($k0) # $t0 = [$k0] = KEY_CODE
WaitForDis: 
	lw $t2, 0($s1) # $t2 = [$s1] = DISPLAY_READY
	beq $t2, $zero, WaitForDis # if $t2 == 0 then Polling 
bot_move:
	beq $t0, 'w', GO_UP
	beq $t0, 'W', GO_UP
	beq $t0, 's', GO_DOWN
	beq $t0, 'S', GO_DOWN
	beq $t0, 'a', GO_LEFT
	beq $t0, 'A', GO_LEFT
	beq $t0, 'd', GO_RIGHT
	beq $t0, 'D', GO_RIGHT
	beq $t0, 32, start_stop # Space key for start/stop
	j start
GO_UP:
	addi $a0, $zero, 0
	jal UNTRACK
	jal ROTATE
	jal TRACK
	j start
GO_RIGHT:
	addi $a0, $zero, 90
	jal UNTRACK
	jal ROTATE
	jal TRACK
	j start	 
GO_DOWN:
	addi $a0, $zero, 180
	jal UNTRACK
	jal ROTATE
	jal TRACK
	j start
GO_LEFT:
	addi $a0, $zero, 270
	jal UNTRACK
	jal ROTATE
	jal TRACK
	j start
start_stop:
	li $at, MOVING
	lb $t3, 0($at)
	beq $t3, 1, STOP
	beq $t3, 0, GO
start:
	j loop
end_main:
	li $v0, 10
	syscall
	 	  	 	
GO: 
	li $at, MOVING # change MOVING port
	addi $s2, $zero, 1 # to logic 1,
	sb $s2, 0($at) # to start running
	jr $ra
STOP: 	
	li $at, MOVING # change MOVING port to 0
	sb $zero, 0($at) # to stop
	jr $ra
TRACK: 
	li $at, LEAVETRACK # change LEAVETRACK port
	addi $s2, $zero, 1 # to logic 1
	sb $s2, 0($at) # to start tracking
	jr $ra
UNTRACK:
	li $at, LEAVETRACK # change LEAVETRACK port to 0
	sb $zero, 0($at) # to stop drawing tail
	jr $ra
ROTATE: 
	li $at, HEADING # change HEADING port
	sw $a0, 0($at) # to rotate robot
	jr $ra
