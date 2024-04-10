.data
messenger1: .asciiz "Nhap m: "
messenger2: .asciiz "Nhap n: "
ketqua: .asciiz "Cac so nguyen to tu m-n la:\""
space: .asciiz " "
newline: .asciiz "\n"
dongngoac: .asciiz " \""
.text
main: 
   li $v0, 4
   la $a0, messenger1
   syscall
   li $v0, 5 # Nhap m
   syscall
   addi $s1, $v0, 0 # Gán $s1 = m
   li $v0, 4
   la $a0, messenger2
   syscall
   li $v0, 5 # Nhap n
   syscall
   addi $s2, $v0, 0 # Gán $s2 = n
   li $v0, 4
   la $a0, ketqua
   syscall
   addi $s0, $s1, -1 # gán $s0 = m-1
   j checksnt
endmain:
   li $v0, 4
   la $a0, dongngoac
   syscall  
   li $v0, 10
   syscall 
checksnt:
   bge $s0, $s2, endmain # m > n thì dừng
   addi $s0, $s0, 1 # tăng m->m+1 (vòng lặp đầu là chạy từ m)
   li $t0, 1 # khởi tạo i=1
   li $t1, 0 # khởi tạo đếm = 0
   li $s3, 1 # gán $s3 là số 1 (nếu đếm = 1 thì nó là số nguyên tố)
loop:
   addi $t0, $t0, 1 # i++ (ở vòng lặp đầu là i chạy từ 2-n)
   bgt $t0, $s0, endloop # i > n thi endloop
   div $s0, $t0
   mfhi $t3
   bne $t3, $0, loop
   addi $t1, $t1, 1
   j loop
endloop:
   beq $t1, $s3, printsnt # $t1 = 1 thì n là số nguyên tố
   j checksnt
printsnt:
   li $v0, 4
   la $a0, space
   syscall
   li $v0, 1
   addi $a0, $s0, 0
   syscall
   j checksnt
