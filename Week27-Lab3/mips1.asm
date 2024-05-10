li $s1, 1 # gán i = s1
li $s2, 2 # gán j = s2
li $s3, 3 # gán m = s3
li $s4, 4 # gán n = s4
add $s5, $s1, $s2 # gán s5 = i + j
add $s6, $s3, $s4 # gán s6 = m + n
start: 
slt $t0, $s6, $s5 # so sánh m + n < i + j 
beq $t0,$zero,else # chạy tới else nếu m + n >= i + j
addi $t1,$t1,1 # then part: x=x+1 
addi $t3,$zero,1 # z=1 
j endif # skip “else” part 
else: addi $t2,$t2,-1 # begin else part: y=y-1 
add $t3,$t3,$t3 # z=2*z 
endif: 
