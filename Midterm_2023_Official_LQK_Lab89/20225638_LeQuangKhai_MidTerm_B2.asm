.data
A: .word 
newline: .asciiz "\n"
messenger1: .asciiz "Nhap kich thuoc cua mang: "
messenger2: .asciiz "Enter a number: "
ketqua: .asciiz "Cap phan tu lien ke co tich lon nhat la: "
comma: .asciiz ", "
.text
main: 
   la $a0, messenger1
   li $v0, 4
   syscall
   li $v0, 5
   syscall
   add $a1, $zero, $v0 		# length = $a1
   addi $t0, $zero, 0 		# gán i = 0
read:
   bge $t0, $a1, end_read 	# end loop after reaching the length of the array
   la $a0, messenger2
   li $v0, 4
   syscall
   li $v0, 5
   syscall
   la $a0, A
   add $t2, $t0, $t0 	# put 2i in $t2
   add $t2, $t2, $t2 	# put 4i in $t2
   add $t3, $t2, $a0 	# put 4i+A (address of A[i]) in $t3
   sw $v0, 0($t3) 	# store v0 in A[i]
   addi $t0, $t0, 1
   j read
end_read:
   la $s0, A		# gán $s0 = &A[0]
   move $s1, $t3 	# với $t3 là address of A[n-1] đã làm ở phần read 
   addi $s1, $s1, -4 	# $a1 = Address(A[n-1])
   lw $t2, 0($s0) 	# t2 = A[0]
   lw $t3, 4($s0) 	# t3 = A[1]
   mult $t2, $t3
   mflo $s3       	# s3 = A[0]*A[1]
   move $t0, $s3  	# $t0 = max
   move $s4, $t2  	# cập nhật cặp số mà có tích là max
   move $s5, $t3 
   j find
end_main:
   li $v0, 10
   syscall
find: 
   beq $s0, $s1, print 	#single element list is sorted
   j find_max
find_max:
   addi $s0, $s0, 4 	# trỏ tiếp lên A[i+1]
   lw $t2, 0($s0) 	# s0 = A[i]
   lw $t3, 4($s0) 	# s1 = A[i+1]
   mult $t2, $t3
   mflo $s3       	# s3 = A[i]*A[i+1]
   blt $s3, $t0, find
   move $t0, $s3  	# $t0 = max_new
   move $s4, $t2  	# cập nhật cặp số mà có tích là max
   move $s5, $t3 
   j find
print: 
   li $v0, 4
   la $a0, ketqua 	# in ra màn hình kết quả
   syscall
   li $v0, 1
   move $a0, $s4
   syscall
   li $v0, 4
   la $a0, comma
   syscall
   li $v0, 1
   move $a0, $s5
   syscall
