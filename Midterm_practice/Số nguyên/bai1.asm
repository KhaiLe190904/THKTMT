.data
messenger: .asciiz "Nhap n: "
ketqua: .asciiz "Cac so chia het cho 3 hoac cho 5 nho hon n la: "
comma: .asciiz ", "
newline: .asciiz "\n"
cham: .asciiz ". "
.text
   
    li $v0, 4
    la $a0, messenger
    syscall
    li $v0, 5 # Nhap n
    syscall
    addi $s0, $v0, 0 # Gan $s0 = $v0 = n
    li $v0, 4
    la $a0, newline
    syscall
    li $t0, 0 # i=0
    li $t3, 3 
    li $t5, 5
main:    
    li $v0, 4
    la $a0, ketqua
    syscall
    li $v0, 1
    li $a0, 0
    syscall
loop:
    beq $t0, $s0, endloop # i=n thì dừng
    addi $t0, $t0, 1
chiahetcho3:
    div $t0, $t3 # i/3
    mfhi $t1
    bne $t1, $0, chiahetcho5
    li $v0, 4
    la $a0, comma
    syscall
    li $v0, 1
    addi $a0, $t0, 0
    syscall
    j loop
chiahetcho5:
    div $t0, $t5 # i/5
    mfhi $t1
    bne $t1, $0, loop
    li $v0, 4
    la $a0, comma
    syscall
    li $v0, 1
    addi $a0, $t0, 0
    syscall
    j loop
endloop:    
    li $v0, 4
    la $a0, cham
    syscall
    
    