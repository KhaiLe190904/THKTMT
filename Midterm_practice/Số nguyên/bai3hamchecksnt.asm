.data
messenger: .asciiz "Nhap n: "
ketqua: .asciiz "Cac so nguyen to tu m-n la: "
comma: .asciiz ", "
newline: .asciiz "\n"
cham: .asciiz ". "
.text
main: 
   
   li $s0, 12
   li $t0, 1
   li $t1, 0   
loop:
   addi $t0, $t0, 1 # i++ (ở vòng lặp đầu là i chạy từ 2-n)
   bgt $t0, $s0, endloop # i > n thi endloop
   div $s0, $t0
   mfhi $t3
   bne $t3, $0, loop
   addi $t1, $t1, 1
   j loop
endloop:
   beq $t1, $0, printsnt # $t1=0 thì n là số nguyên tố
   j endmain
printsnt:
   li $v0, 4
   la $a0, ketqua
   syscall
   li $v0, 1
   addi $a0, $s0, 0
   syscall
endmain:
   li $v0, 4
   la $a0, cham
   syscall