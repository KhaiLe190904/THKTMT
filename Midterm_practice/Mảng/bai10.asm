.data
A: .word 100
newline: .asciiz "\n"
messenger1: .asciiz "\nEnter array length: "
messenger2: .asciiz "Enter a number: "
ketqua: .asciiz "Phan tu am lon nhat cua mang la: "
vitri: .asciiz ", o vi tri thu "
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
   li $s2, 0x80000000 # max âm = âm nhỏ nhất
   li $t5, 2 # $t5 = 2
   li $t1, 0 # i = 0
   j find_maxam
find_maxam:
   addi $s0, $s0, 4
   addi $t1, $t1, 1 # i++
   bgt $s0, $s1, print
   lw $t0, 0($s0) # $t0 = A[i]
   bltz $t0, find_max
   j find_maxam
find_max:
   bgt $t0, $s2, update_max
   j find_maxam
update_max:
   move $s2, $t0 # cập nhật min
   move $s3, $t1 # cập nhật vị trí
   j find_maxam
print: 
   li $v0, 4
   la $a0, ketqua
   syscall  
   li $v0, 1
   move $a0, $s2
   syscall
   li $v0, 4
   la $a0, vitri
   syscall
   li $v0, 1
   move $a0, $s3
   syscall  
   li $v0, 10 #end chuong trinh
   syscall  
   