.data
messenger: .asciiz "Nhap n (2 chu so tro len): "
ketqua: .asciiz " viet theo chieu nguoc lai la: "
newline: .asciiz "\n"
.text
main:
    li $v0, 4
    la $a0, messenger
    syscall
    li $v0, 5
    syscall
    move $s1, $v0 # $s1 = n
    li $s2, 10    # $s2 = 10
    li $v0, 1
    move $a0, $s1
    syscall
    li $v0, 4
    la $a0, ketqua
    syscall
loop:
    beq $s1, $0, endloop 
    div $s1, $s2 # temp chia 10
    mflo $s1 # temp = temp/10
    mfhi $t1 # lay chu so cuoi cung
    li $v0, 1
    move $a0, $t1 
    syscall # in ra so tu cuoi len
    j loop
endloop:
    li $v0, 10
    syscall