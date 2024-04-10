.data
A: .word 200
newline: .asciiz "\n"
messenger1: .asciiz "\nEnter array length: "
messenger2: .asciiz "Enter a number: "
ketqua: .asciiz "Mang do sau khi duoc sap xep la: "
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
   la $t5, A
   la $t7, A
   addi $t7, $t7, -4
   la $t6, A
   addi $t6, $t6, -4
   la $s0, A
   move $s1, $t3 # với $t3 là address of A[n-1] đã làm ở phần read 
   li $v0, 4
   la $a0, ketqua
   syscall
   j sort
end_main:
   li $v0, 10
   syscall
sort: 
loop_i:
    addi $t7, $t7, 4
    bgt $t7, $s1, print
    lw $t2, 0($t7) # $t2 = A[i]
    la $t6, A
    addi $t6, $t6, -4
    bltz $t2, loop_j
    j loop_i
loop_j:
    addi $t6, $t6, 4
    beq $t6, $t7, loop_i
    lw $t3, 0($t6) # $t3 = A[j]
    bltz $t3, check
    j loop_j
check:
    blt $t3, $t2, swap
    j loop_j
swap:
    sw $t3, 0($t7) # A[j] = A[i]
    sw $t2, 0($t6) # A[i] = A[j] trong bộ nhớ
    lw $t2, 0($t7) # $t2 = A[i] = A[j]
    j loop_j
print: 
   li $v0, 1
   lw $a0, 0($t5)
   syscall
   beq $t5, $s1, end_main # so sánh với A[i] chạy baoh tới A[n-1]
   li $v0, 4
   la $a0, comma
   syscall
   addi $t5, $t5, 4
   j print
