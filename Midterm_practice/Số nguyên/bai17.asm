.data
messengerM: .asciiz "Nhap M (M > N): "
messengerN: .asciiz "Nhap N: "
result: .asciiz "So nguyen thoa man de bai la: "
khongtimthay: .asciiz "Khong tim thay so nguyen thoa man!"
newline: .asciiz "\n"
.text
main:
    li $v0, 4
    la $a0, messengerN
    syscall
    li $v0, 5
    syscall
    move $s1, $v0 # $s1 = N

    li $v0, 4
    la $a0, messengerM
    syscall
    li $v0, 5
    syscall
    move $s0, $v0 # $s0 = M
    move $t0, $s0 # $t0 = M
    move $t1, $s1 # $t1 = N
    j funtion
endmain:    
    move $t3, $t0 # $t3 = số thỏa mãn
    li $v0, 4
    la $a0, result
    syscall
    move $a0, $t3
    li $v0, 1
    syscall
    li $v0, 4
    la $a0, newline
    syscall
    li $v0, 10
    syscall
# Hàm tìm số nguyên lớn nhất chia hết cho N và nhỏ hơn M
funtion:
    beq $t1, $t0, print_khongtimthay
    sub $t0, $t0, 1 # M = M-1
    div $t0, $t1 # (M-1)/N 
    mfhi $t2
    beq $t2, $0, endmain
    j funtion
print_khongtimthay:
    li $v0, 4
    la $a0, khongtimthay
    syscall