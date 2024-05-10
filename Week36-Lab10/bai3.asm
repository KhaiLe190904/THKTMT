.eqv HEADING 0xffff8010 # Integer: An angle between 0 and 359
.eqv MOVING 0xffff8050 # Boolean: whether or not to move
.eqv LEAVETRACK 0xffff8020 # Boolean (0 or non-0): # whether or not to leave a track
.eqv WHEREX 0xffff8030 # Integer: Current x-location of MarsBot
.eqv WHEREY 0xffff8040 # Integer: Current y-location of MarsBot
.text 
main: 
	addi $a0, $zero, 120 # Marsbot rotates 90* and start running
 	jal ROTATE
 	jal GO
sleep1: 
	addi $v0,$zero, 32 # Keep running by sleeping in 5000 ms
 	li $a0, 5000
 	syscall
 	jal TRACK # and draw new track line
go_150: 
	addi $a0, $zero, 150 # Marsbot rotates 150*
 	jal ROTATE
sleep2: 
	addi $v0,$zero, 32 # Keep running by sleeping in 3000 ms
 	li $a0, 5000
 	syscall
 	jal UNTRACK # keep old track
 	jal TRACK # and draw new track line
goLEFT: 
	addi $a0, $zero, 270 # Marsbot rotates 270* đi ngang sang trái
 	jal ROTATE
sleep3: 
	addi $v0,$zero, 32 # Keep running by sleeping in 5000 ms 
 	li $a0, 5000 
 	syscall
 	jal UNTRACK # keep old track
 	jal TRACK # and draw new track line
goUP:
	addi $a0, $zero, 30 # Marsbot rotates 30* 
 	jal ROTATE 
sleep4: 
	addi $v0,$zero,32 # Keep running by sleeping in 5000 ms 
 	li $a0,5000 
 	syscall
 	jal UNTRACK
 	jal STOP
end_main:
 	li $v0, 10
 	syscall
GO: 
	li $at, MOVING # change MOVING port
 	addi $k0, $zero, 1 # to logic 1,
 	sb $k0, 0($at) # to start running
 	jr $ra
STOP: 	
	li $at, MOVING # change MOVING port to 0
 	sb $zero, 0($at) # to stop
 	jr $ra
TRACK: 
	li $at, LEAVETRACK # change LEAVETRACK port
 	addi $k0, $zero, 1 # to logic 1
 	sb $k0, 0($at) # to start tracking
 	jr $ra
UNTRACK:
	li $at, LEAVETRACK # change LEAVETRACK port to 0
 	sb $zero, 0($at) # to stop drawing tail
 	jr $ra
ROTATE: 
	li $at, HEADING # change HEADING port
 	sw $a0, 0($at) # to rotate robot
 	jr $ra