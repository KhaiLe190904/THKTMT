.data
A: .word 200
newline: .asciiz "\n"
messenger1: .asciiz "\nEnter array length: "
messenger2: .asciiz "Enter a number: "
ketqua: .asciiz "So chan nho nhat lon hon moi so le trong mang la: "
khongtimthay: .asciiz "Khong co so chan nao thoa man de bai!"
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
   addi $s1, $s1, -4
   move $s2, $t3 # với $t3 là address of A[n-1] đã làm ở phần read 
   li $s5, 0x7fffffff # $s5 = số dương lớn nhất 32 bit
   li $s3, 0 # $s3 = max_le = 0
   move $s4, $s5 # $s4 = min_chan = lớn nhất 32bit
   li $t5, 2 # $t5 = 2
   j loop_maxle
loop_maxle:
   addi $s0, $s0, 4
   bgt $s0, $s2, loop_minchan
   lw $t0, 0($s0) # $t0 = A[i]
   bltz $t0, loop_maxle # A[i] < 0 thì k xét tính chẵn lẻ
   div $t0, $t5   # A[i] / 2
   mfhi $t1       # lấy dư ra $t1
   bne $t1, $0, find_maxle # $t1 = 1 thì xét A[i] lẻ có lớn hơn max không
   j loop_maxle
find_maxle:
   blt $t0, $s3, loop_maxle # A[i] > max_le thì update maxle
   move $s3, $t0 # $s3 = maxle
   j loop_maxle
loop_minchan:
   addi $s1, $s1, 4
   bgt $s1, $s2, print
   lw $t0, 0($s1) # $t0 = A[i]
   bltz $t0, loop_minchan # A[i] < 0 thì k xét tính chẵn lẻ
   div $t0, $t5   # A[i] / 2
   mfhi $t1       # lấy dư ra $t1
   beq $t1, $0, find_minchanlonhonmaxle # $t1 = 0 thì A[i] chẵn xong ta tìm min_chan lớn hơn max_le
   j loop_minchan
find_minchanlonhonmaxle:
   bgt $t0, $s3, compare_chan
   j loop_minchan
compare_chan:
   bgt $t0, $s4, loop_minchan # A[i] > min_chan thì tăng trỏ tìm tiếp
   move $s4, $t0 # nếu không thì update min_chan
   j loop_minchan
print: 
   beq $s4, $s5, print_khongtimthay
   li $v0, 4
   la $a0, ketqua
   syscall  
   li $v0, 1
   move $a0, $s4
   syscall
   li $v0, 10 #end chuong trinh
   syscall  
print_khongtimthay:
   li $v0, 4
   la $a0, khongtimthay
   syscall