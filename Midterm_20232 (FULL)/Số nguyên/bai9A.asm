.data
messenger: .asciiz "Nhap n (2 chu so tro len): "
tongchan: .asciiz "Tong so chan trong n la: "
tongle: .asciiz "Tong so le trong n la: "
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
    li $s3, 2     # $s3 = 2
    li $s4, 0 # sumchan=0
    li $s5, 0 # sumle=0
    j loop
loop:
    beq $s1, $0, endloop 
    div $s1, $s2 # temp chia 10
    mflo $s1 # temp = temp/10
    mfhi $t1 # lay chu so cuoi cung
    div $t1, $s3 # chữ số cuối chia 2
    mfhi $t2 
    beq $t2, $0, tong_chan
    add $s5, $s5, $t1 # sumle = sumle + le
    j loop
tong_chan:
    add $s4, $s4, $t1 # sumchan = sumchan + chan
    j loop
endloop:
    li $v0, 4
    la $a0, tongchan
    syscall
    li $v0, 1
    move $a0, $s4
    syscall
    
    li $v0, 4
    la $a0, newline # xuống dòng
    syscall
    
    li $v0, 4
    la $a0, tongle
    syscall
    li $v0, 1
    move $a0, $s5 
    syscall
    li $v0, 10
    syscall