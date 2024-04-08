.data
messenger1: .asciiz "\nEnter array length: "
messenger2: .asciiz "Enter a number: "
messengerM: .asciiz "Nhap M: "
messengerN: .asciiz "Nhap N: "
ketqua: .asciiz "So phan tu trong [M, N] là: "
comma: .asciiz ", "
newline: .asciiz "\n"
A: .word 100
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
   # Nhập số nguyên M
   li $v0, 4 
   la $a0, messengerM
   syscall
   li $v0, 5 
   syscall 
   move $s2, $v0  # Lưu giá trị M vào $s2
   # Nhập số nguyên N
   li $v0, 4 
   la $a0, messengerN
   syscall
   li $v0, 5 
   syscall 
   move $s3, $v0  # Lưu giá trị N vào $s3
   li $t0, 0  # dem = 0
   li $t1, -1  # i = -1
count_loop:
   addi $t1, $t1, 1  # i++
   beq $t1, $a1, end_count  # i->length(A) dừng
   la $s4, A
   add $t3, $t1, $t1  # 2 * $t1
   add $t3, $t3, $t3  # 4 * $t1
   add $t4, $t3, $s4 # Tính địa chỉ của A[$t1] và lưu vào $t4
   lw $t5, 0($t4)  # Load giá trị của A[$t1] vào $t5
   bge $t5, $s2, check_N  # A[i] >= M thì check N
   j count_loop # Ngược lại, chuyển sang phần tử tiếp
check_N:
   bgt $t5, $s3, count_loop # A[i] > N, chuyển sang phần tử kế tiếp
tang_dem:
   addi $t0, $t0, 1  # dem++
   j count_loop
end_count:
   li $v0, 4
   la $a0, ketqua
   syscall
   move $a0, $t0 
   li $v0, 1
   syscall
   li $v0, 10
   syscall
