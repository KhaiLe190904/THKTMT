.data
messenger: .asciiz "Nhap n: "
ketqua: .asciiz "Bieu dien cua n o he co so 8 la: "
newline: .asciiz "\n"
.text
main:
    li $v0, 4
    la $a0, messenger
    syscall
    li $v0, 5
    syscall
    move $s1, $v0 # $s1 = n
    li $s2, 0     # Oct = $s2 = 0
    li $s3, 8     # $s3 = 8
    li $s4, 10    # $s4 = 10
    li $t0, 1     # i = 1
    div $s1, $s3 # n chia 8
    mflo $s1 # n = n/8
    mfhi $t1 # lấy số dư
    add $s2, $s2, $t1 # Oct = Oct + $t1
    j loop
loop:
    beq $s1, $0, endloop 
    div $s1, $s3 # n chia 8
    mflo $s1 # n = n/8
    mfhi $t1 # lấy số dư
    mult $t0, $s4 # 10*i
    mflo $t2 # $t2 = 10*i
    mult $t1, $t2 # dư * (10*i)
    mflo $t1 # $t1 = dư * (10*i)
    add $s2, $s2, $t1 # Oct = Oct + $t1
    mul $t0, $t0, 10 # i = i*10
    j loop
endloop:
    li $v0, 4
    la $a0, ketqua
    syscall
    li $v0, 1
    move $a0, $s2
    syscall
    li $v0, 10
    syscall

