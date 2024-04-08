.data
A: .word 200
newline: .asciiz "\n"
messenger1: .asciiz "\nEnter array length: "
messenger2: .asciiz "Enter a number: "
ketqua_tongduong: .asciiz "Tong duong cua mang la: "
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
   move $s1, $t3 # với $t3 là address of A[n-1] đã làm ở phần read 
   li $s2, 0 # sum_duong = 0
   li $s3, 0 # sum_am = 0
   j find_sum
find_sum:
   addi $s0, $s0, 4
   bgt $s0, $s1, print
   lw $t0, 0($s0) # $t0 = A[i]
   bgez $t0, tong_duong # A[i] >= 0 thì tính tổng
   j tong_am
tong_duong:
   add $s2, $s2, $t0 # sum_duong = sum_duong + A[i]
   j find_sum
tong_am:
   add $s3, $s3, $t0 # sum_am = sum_am + A[i]
   j find_sum
print: 
   li $v0, 4
   la $a0, ketqua_tongduong
   syscall  
   li $v0, 1
   move $a0, $s2
   syscall
   li $v0, 4
   la $a0, ketqua_tongam
   syscall
   li $v0, 1
   move $a0, $s3
   syscall
   li $v0, 10 #end chuong trinh
   syscall  
   