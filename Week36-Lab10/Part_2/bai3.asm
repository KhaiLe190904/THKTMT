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
	addi $v0, $zero, 32 # Keep running by sleeping in 2500 ms
 	li $a0, 5000
 	syscall
 	jal TRACK # and draw new track line

	addi $a0, $zero, 162 
 	jal ROTATE
sleep2: 
	addi $v0,$zero, 32 # Keep running by sleeping in 3000 ms
 	li $a0, 2500
 	syscall
 	jal UNTRACK # keep old track
 	jal TRACK # and draw new track line

	addi $a0, $zero, 90 # goRIGHT
 	jal ROTATE
sleep3: 
	addi $v0,$zero, 32 # Keep running by sleeping in 2500 ms 
 	li $a0, 2500 
 	syscall
 	jal UNTRACK # keep old track
 	jal TRACK # and draw new track line

	addi $a0, $zero, 234
 	jal ROTATE
sleep4: 
	addi $v0 ,$zero, 32 # Keep running by sleeping in 2500 ms 
 	li $a0, 2500 
 	syscall
 	jal UNTRACK
 	jal TRACK

	addi $a0, $zero, 162 # Marsbot rotates 30* 
 	jal ROTATE	
sleep5: 
	addi $v0 ,$zero, 32 # Keep running by sleeping in 2500 ms 
 	li $a0, 2500 
 	syscall
 	jal UNTRACK
 	jal TRACK

	addi $a0, $zero, 306 # Marsbot rotates 30* 
 	jal ROTATE
sleep6: 
	addi $v0 ,$zero, 32 # Keep running by sleeping in 2500 ms 
 	li $a0, 2500 
 	syscall
 	jal UNTRACK
 	jal TRACK

	addi $a0, $zero, 234 
 	jal ROTATE
sleep7: 
	addi $v0 ,$zero, 32 # Keep running by sleeping in 2500 ms 
 	li $a0, 2500 
 	syscall
 	jal UNTRACK
 	jal TRACK

	addi $a0, $zero, 18 
 	jal ROTATE
sleep8: 
	addi $v0 ,$zero, 32 # Keep running by sleeping in 2500 ms 
 	li $a0, 2500 
 	syscall
 	jal UNTRACK
 	jal TRACK

	addi $a0, $zero, 306
 	jal ROTATE
sleep9: 
	addi $v0 ,$zero, 32 # Keep running by sleeping in 2500 ms 
 	li $a0, 2500 
 	syscall
 	jal UNTRACK
 	jal TRACK

	addi $a0, $zero, 90
 	jal ROTATE
sleep10:
        addi $v0 ,$zero, 32 # Keep running by sleeping in 2500 ms 
 	li $a0, 2500 
 	syscall
 	jal UNTRACK
 	jal TRACK 
	addi $a0, $zero, 18
 	jal ROTATE   	  	   
stop: 
	addi $v0,$zero, 32 # Keep running by sleeping in 2500 ms 
 	li $a0, 2500 
 	syscall
 	jal UNTRACK
 	jal TRACK
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
