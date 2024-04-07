.data
messenger: .asciiz "Nhap n: "
ketqua: .asciiz "Tong cac chu so trong bieu dien nhi phan cua n la: "
newline: .asciiz "\n"
space: .asciiz " "

.text
main:
    li $v0, 4
    la $a0, messenger
    syscall
    li $v0, 5
    syscall
    move $s0, $v0 # $s0 = n
    li $s1, 0 # sum = 0
loop:
    beqz $s0, endloop 
    andi $t0, $s0, 1 # pop số cuối cùng của n
    add $s1, $s1, $t0 # sum = sum + $t0
    srl $s0, $s0, 1 # dịch phải 1
    j loop
endloop:
    li $v0, 4
    la $a0, ketqua
    syscall
    li $v0, 1
    move $a0, $s1
    syscall
    li $v0, 10
    syscall