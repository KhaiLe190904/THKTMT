.data
A: .word 200
newline: .asciiz "\n"
messenger1: .asciiz "\nEnter array length: "
messenger2: .asciiz "Enter a number: "
ketqua_tongle: .asciiz "Tong le cua mang la: "
ketqua_tongam: .asciiz "\nTong am cua mang la: "
comma: .asciiz ", "
.text
main: 
   la $a0, messenger1
   li $v0, 4
   syscall
   li $v0, 5
   syscall
   add $a1, $zero, $v0 #length = $a1
   addi $t0, $zero, 0 #initialize index i in $t0 to 0
read:
   beq $t0, $a1, end_read #end loop after reaching the length of the array
   la $a0, messenger2
   li $v0, 4
   syscall
   li $v0, 5
   syscall
   la $a0, A
   add $t2, $t0, $t0 #put 2i in $t2
   add $t2, $t2, $t2 #put 4i in $t2
   add $t3, $t2, $a0 #put 4i+A (address of A[i]) in $t3
   sw $v0, 0($t3) #store v0 in A[i]
   addi $t0, $t0, 1
   j read
end_read:
   la $s0, A
   addi $s0, $s0, -4
   la $s1, A
   add $s1, $s1, -4
   move $s2, $t3 # với $t3 là address of A[n-1] đã làm ở phần read 
   li $s3, 0 # sum_le = 0
   li $s4, 0 # sum_am = 0
   li $t5, 2 # $t5 = 2
loop_sumle:
   addi $s0, $s0, 4
   bgt $s0, $s2, loop_sumam
   lw $t0, 0($s0) # $t0 = A[i]
   bltz $t0, loop_sumle # A[i] < 0 hì không xét chẵn lẻ
   div $t0, $t5   # A[i] / 2
   mfhi $t1       # lấy dư ra $t1
   bne $t1, $0, tinh_tongle # $t1 = 1 thì tính tổng lẻ không thì tăng trỏ
   j loop_sumle
tinh_tongle:
   add $s3, $s3, $t0 # sum_le = sum_le + A[i]
   j loop_sumle
loop_sumam:
   addi $s1, $s1, 4
   bgt $s1, $s2, print
   lw $t0, 0($s1) # $t0 = A[i]
   bltz $t0, tong_am # A[i] < 0 thì tính tổng
   j loop_sumam # duong thì tăng con trỏ i++
tong_am:
   add $s4, $s4, $t0 # sum_am = sum_am + A[i]
   j loop_sumam
print: 
   li $v0, 4
   la $a0, ketqua_tongle
   syscall  
   li $v0, 1
   move $a0, $s3
   syscall
   li $v0, 4
   la $a0, ketqua_tongam
   syscall
   li $v0, 1
   move $a0, $s4
   syscall
   li $v0, 10 #end chuong trinh
   syscall  
   
