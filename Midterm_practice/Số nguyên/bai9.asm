.data
messenger: .asciiz "Nhap n (2 chu so tro len): "
ketqua: .asciiz "Chu so nho nhat trong n la: "
newline: .asciiz "\n"
.text
main:
    li $v0, 4
    la $a0, messenger
    syscall
    li $v0, 5
    syscall
    move $s0, $v0 # $s0 = n
    move $s1, $s0 # $s1 = temp = n
    li $t0, 9 # khởi tạo min = 9
    li $s2, 10
loop:
    beq $s1, $0, endloop 
    div $s1, $s2 # temp chia 10
    mflo $s1 # temp = temp/10
    mfhi $t1 # lay chu so cuoi cung
    ble $t1, $t0, update_min # $t1 < min thi jump
    j loop
update_min:
    move $t0, $t1 # max = $t1
    j loop
endloop:
    li $v0, 4
    la $a0, ketqua
    syscall
    li $v0, 1
    move $a0, $t0 
    syscall
    li $v0, 10
    syscall