.data
messenger1: .asciiz "Nhap n: "
ketqua: .asciiz "Cac so nguyen to lon hon N la: "
newline: .asciiz "\n"
.text
main: 
   li $v0, 4
   la $a0, messenger1
   syscall
   li $v0, 5 # Nhap n
   syscall
   addi $s1, $v0, 0 # Gán $s1 = N
   li $v0, 4
   la $a0, ketqua
   syscall
   addi $s0, $s1, 0 # gán m = $s0 = N 
   j checksnt
endmain:
   li $v0, 10
   syscall 
checksnt:
   addi $s0, $s0, 1 # tăng m->m+1 (vòng lặp đầu là chạy từ N+1)
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
   beq $t1, $s3, printsnt # $t1=1 thì n là số nguyên tố
   j checksnt
printsnt:
   li $v0, 1
   move $a0, $s0
   syscall
   j endmain
