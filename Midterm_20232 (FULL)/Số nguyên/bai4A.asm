.data
messenger: .asciiz "Nhap n: "
ketqua: .asciiz "Cac so hoan hao nho hon n la:\" "
space: .asciiz " "
cham: .asciiz "\""
.text
main: 
   li $v0, 4
   la $a0, messenger
   syscall
   li $v0, 5
   syscall
   addi $s0, $v0, 0 # n = $s0
   li $v0, 4
   la $a0, ketqua
   syscall
   li $s1, 0 # k = 0
   j find
endmain:
   li $v0, 4
   la $a0, cham
   syscall
   li $v0, 10
   syscall
find:
   beq $s1, $s0, endmain # k chạy từ 0->n
   addi $s1, $s1, 1 # k++ 
   li $t0, 0 # i = 0
   li $t1, 0 # sum = 0
loop:
   addi $t0, $t0, 1 # i++
   beq $t0, $s1, endloop # i = k thì dừng
   div $s1, $t0
   mfhi $t2 # lấy dư ra $t2
   bne $t2, $0, loop
   add $t1, $t1, $t0 # sum = sum + i (với i là ước)
   j loop
endloop:
   beq $t1, $s1, print
   j find
print:
   li $v0, 1
   move $a0, $s1
   syscall
   li $v0, 4
   la $a0, space
   syscall
   j find