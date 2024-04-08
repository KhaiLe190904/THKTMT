.data
A: .word 100
newline: .asciiz "\n"
messenger1: .asciiz "\nEnter array length: "
messenger2: .asciiz "Enter a number: "
sochen: .asciiz "Nhap M: "
nhapsai: .asciiz "Nhap sai! So sau phai lon hon so truoc no."
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
   blt $v0, $v1, end
   la $a0, A
   add $t2, $t0, $t0 #put 2i in $t2
   add $t2, $t2, $t2 #put 4i in $t2
   add $t3, $t2, $a0 #put 4i+A (address of A[i]) in $t3
   sw $v0, 0($t3) #store v0 in A[i]
   lw $v1, 0($t3)
   addi $t0, $t0, 1   # $t0 = kích thước mảng
   j read
end_read:
   la $s0, A
   move $s1, $t3 # với $t3 là address of A[n-1] đã làm ở phần read
   li $v0, 4
   la $a0, sochen
   syscall
   li $v0, 5
   syscall
   move $s2, $v0 # $s2 = M
   li $t1, 0 # i = 0      
   j insert
end_main:
   li $v0, 10
   syscall
end:
   li $v0, 4
   la $a0, nhapsai
   syscall
   li $v0, 10
   syscall
insert:
   bgt $t1, $t0, insert_end # chạy hết mảng có nghĩa là số đó lớn hơn tất cả thì chèn vào cuối
   sll $t2, $t1, 2 # $t2 = 4*i
   add $t2, $t2, $s0 
   lw $t3, 0($t2) # $t3 = A[i]
   ble $s2, $t3, chen_here # baoh M >= A[i] thì bắt đầu chèn
   addi $t1, $t1, 1 # i++
   j insert
chen_here:
   # Dịch phải tất cả các số từ vị trí chèn
   move $t4, $t0 # $t4 = n
   addi $t0, $t0, 1 # n++
   j loop
loop:
   sll $s3, $t4, 2 # $s3 = 4*n
   add $s3, $s3, $s0
   sll $s4, $t0, 2 # $s4 = 4*(n+1)
   add $s4, $s4, $s0
   lw $t5, 0($s3) # $s5 = A[n]
   sw $t5, 0($s4) # A[n+1] = A[n] lùi phần từ cuối sang phải 1
   beq $t1, $t4, end_loop
   addi $t4, $t4, -1
   addi $t0, $t0, -1 # giảm giá trị n xuống tới khi n tới vị trí của M chèn vào
   j loop
end_loop:
   # Chèn M
   sll $t1, $t1, 2 # 4*i
   add $t1, $t1, $s0
   sw $s2, 0($t1) # A[i] = M với i là vị trí chèn vào
   addi $s1, $s1, 4
   j print
insert_end:
   sw $s2, 4($t0) # Ghi M vào cuối mảng
print: 
   li $v0, 1
   lw $a0, 0($s0)
   syscall
   beq $s0, $s1, end_main # so sánh với A[0] chạy baoh tới A[n-2]
   li $v0, 4
   la $a0, comma
   syscall
   addi $s0, $s0, 4
   j print