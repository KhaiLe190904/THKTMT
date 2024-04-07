.data
messengerM: .asciiz "Nhap M: "
messengerN: .asciiz "Nhap N: "
ketqua: .asciiz "BCNN(M,N): "
newline: .asciiz "\n"

.text
main:
    li $v0, 4
    la $a0, messengerM
    syscall
    li $v0, 5
    syscall
    move $s0, $v0 # $s0 = M
    
    li $v0, 4
    la $a0, messengerN
    syscall
    li $v0, 5
    syscall
    move $s1, $v0 # $s1 = N
    j tim_UCLN
endmain:
    li $v0, 4
    la $a0, ketqua
    syscall
    
    li $v0, 1
    move $a0, $t4
    syscall
    li $v0, 4
    la $a0, newline
    syscall
    li $v0, 10
    syscall
tim_UCLN:
    move $t0, $s0 # $t0 = M
    move $t1, $s1 # $t1 = N
loop:   
    beqz $t1, done # n = 0 thì dừng
    # Euclid
    div $t0, $t1
    move $t0, $t1
    mfhi $t1
    j loop
done:
    move $t2, $t0 # $t2 = UCLN
    mult $s0, $s1 # M*N
    mflo $t3      # $t3 = M*N
    div $t3, $t2  # BCNN(M,N) = (M*N)/UCLN(M,N)
    mflo $t4      # $t4 = BCNN
    j endmain
