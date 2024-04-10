.data
messenger: .asciiz "Nhap n: "
mayman: .asciiz " la so may man."
khongmayman: .asciiz " khong la so may man."
space: .asciiz " "
.text
main:    
    li $v0, 4
    la $a0, messenger
    syscall
    li $v0, 5
    syscall
    addi $s0, $v0, 0 # n = $s0
    addi $s4, $s0, 0 # n = $s4
    li $t2, 10 # $t2=10
    li $t3, 2 # $t3=2
    j dem
endmain:
    li $v0, 10
    syscall
dem:
    move $s1, $s0 # temp = n
    li $t1, 0 # dem = 0
loopdem:
    div $s1, $t2 # temp chia 10
    addi $t1, $t1, 1 # dem++
    mflo $s1 # temp = temp/10
    beq $s1, $0, checkdemchanle
    j loopdem
checkdemchanle:
    div $t1, $t3 # dem chia 2
    mfhi $t4
    bne $t4, $0, print_0mayman
    j checksmm
checksmm:
    mflo $t4 # $t4 = half = dem/2
    li $t0, 0 # i = 0
    li $t1, 0 # j = 0
    li $s2, 0 # sumright = 0
    li $s3, 0 # sumleft = 0
loop_sumright:
    div $s0, $t2 # n chia 10
    mfhi $t5
    mflo $s0
    add $s2, $s2, $t5 # sumright = sumright + $t5
    addi $t0, $t0, 1 # i++
    beq $t0, $t4, loop_sumleft # i = hafl thì tính tổng trái
    j loop_sumright
loop_sumleft:
    div $s0, $t2 # n chia 10
    mfhi $t5
    mflo $s0
    add $s3, $s3, $t5 # sumleft = sumleft + $t5
    addi $t1, $t1, 1 # j++
    beq $t1, $t4, sosanh
    j loop_sumleft
sosanh:
    beq $s2, $s3, print_mayman
    j print_0mayman
print_mayman:  
    li $v0, 1
    move $a0, $s4
    syscall
    li $v0, 4
    la $a0, mayman
    syscall
    j endmain   
print_0mayman:
    li $v0, 1
    move $a0, $s4
    syscall
    li $v0, 4
    la $a0, khongmayman
    syscall
    j endmain    
    
    