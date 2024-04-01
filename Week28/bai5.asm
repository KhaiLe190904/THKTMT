addi $s1, $0, 100 # gán $s1
addi $s2, $s0, 8 # gán $s2
loop:
srl $s2, $s2, 1 # dịch bit $s2 sang phải $s2 / 2
beq $s2, $0, exit # check $s2 = 0 thì exit
sll $s1, $s1, 1 #dịch bit $s1 sang trái $s1 * 2
j loop
exit:
addi $s3, $s1, 0 