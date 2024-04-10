.data
string: .space 100 
messenger1: .asciiz "Nhap xau ki tu: "
ketqua1: .asciiz "So ki tu chu hoa co trong xau la: "
ketqua2: .asciiz "\nSo ki tu chu thuong co trong xau la: "
ketqua3: .asciiz "\nSo ki tu chu so co trong xau la: "
.text
   li $v0, 4
   la $a0, messenger1
   syscall
   li $v0, 8
   la $a0, string   # save address of inputString
   li $a1, 100
   syscall
   li $t0, -1
   li $s0, 0 # count_hoa
   li $s1, 0 # count_thuong
   li $s2, 0 # count_so
loop: 
   addi $t0, $t0, 1 # i++
   lb $t1, string($t0)
   beq $t1, 10, exit
   bge $t1, 'a', count_thuong
   bge $t1, 'A', count_hoa
   bge $t1, '0', count_so
   j loop
count_thuong:
   bgt $t1, 'z', loop # lớn hơn 'z' thì không phải thường
   addi $s1, $s1, 1
   j loop 
count_hoa:
   bgt $t1, 'Z', loop # nhỏ hơn 'Z' thì khong phải hoa
   addi $s0, $s0, 1
   j loop
count_so:
   bgt $t1, '9', loop # lớn hơn '9' thì khong phải số
   addi $s2, $s2, 1
   j loop
exit:
   li $v0, 4
   la $a0, ketqua1
   syscall
   li $v0, 1
   move $a0, $s0
   syscall
   li $v0, 4
   la $a0, ketqua2
   syscall
   li $v0, 1
   move $a0, $s1
   syscall
   li $v0, 4
   la $a0, ketqua3
   syscall
   li $v0, 1
   move $a0, $s2
   syscall
   li $v0, 10		# exit program 
   syscall