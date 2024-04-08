.data
A: .word 100
newline: .asciiz "\n"
messenger1: .asciiz "\nEnter array length: "
messenger2: .asciiz "Enter a number: "
vitrimuonxoa: .asciiz "Nhap vi tri k muon xoa: "
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
   addi $s0, $s0, -4 # giảm đi để khi trỏ thì trỏ đúng k
   move $s1, $t3 # với $t3 là address of A[n-1] đã làm ở phần read 
   li $v0, 4
   la $a0, vitrimuonxoa
   syscall
   li $v0, 5
   syscall
   move $t3, $v0 # $t3 = k
   li $t1, 0 # i = 0
   j remove
end_main:
   li $v0, 10
   syscall
remove:
   sll $t7, $t3, 2 # 4*k
   add $t4, $s0, $t7 # $t4 chứa address A[k]
   addi $t5, $t7, 4 
   add $t5, $s0, $t5 # $t5 chứa address A[k+1]
loop:
   lw $t6, 0($t5) # $t6 = A[k+1]
   sw $t6, 0($t4) # A[k] = A[k+1]
   addi $t4, $t4, 4 # tăng address A[k++]
   addi $t5, $t5, 4 # tăng address A[k+1++]
   addi $t3, $t3, 1 # tăng k
   bge $t3, $a1, end_remove # k bằng số phần tử của mảng thì dừng
   j loop
end_remove:
   addi $a1, $a1, -1 # n = n-1
   addi $s1, $s1, -4 # với $s1 là address of A[n-2]
   la $s0, A
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