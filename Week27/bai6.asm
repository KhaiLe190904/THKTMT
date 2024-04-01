.data 
   array: .word 5, -40, -150, 6, 160, -99 
.text
   addi $s0, $0, 0 # i = 0
   la   $s1, array # khoi tao chuoi
   addi $s2, $0, 6 # n = 6
   addi $s3, $0, 1 # step = 1
   lw  $s5, 0($s1) # max = A[0] 
loop: 
   slt $t2, $s0, $s2 # $t2 = i < n ? 1 : 0 
   beq $t2, $zero, endloop
   add $t1, $s0, $s0
   add $t1, $t1, $t1 # $t1 = 4 * $s0 
   add $t1, $t1, $s1 # $t1 store the address of A[i]
   lw  $t0, 0($t1) # $t0 = A[i]
   slt $t4, $t0, $zero # A[i] < 0
   bne $t4, $zero, then
   j defaut
then:  
   sub $t0, $0, $t0 # A[i] = -A[i]
defaut:
   slt $t5, $s5, $t0 # maxabs < A[i]
   beq $t5, $zero, endif
   add $s5, $t0, $0 # max = A[i]
   lw  $s6, 0($t1) # gán biến tạm để lưu phần tử có abs lớn nhất
endif:
   add $s0, $s0, $s3
j loop  
endloop:
