.data
messenger: .asciiz "Nhap n: "
ketqua: .asciiz "Day Fibonacci nho hon n la: "
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
    li $t0, 0
    li $t1, 1
main:    
    li $v0, 4
    la $a0, ketqua
    syscall
    li $v0, 1
    move $a0, $t0
    syscall
    li $v0, 4
    la $a0, comma
    syscall
    li $v0, 1
    move $a0, $t1
    syscall
loop:
    
    add $t2, $t0, $t1
    bge $t2, $s0, endloop
    li $v0, 4
    la $a0, comma
    syscall 
    move $t0, $t1
    move $t1, $t2
    li $v0, 1 # in ra so fibonacci tiep theo
    move $a0, $t2
    syscall
    j loop
endloop:
    li $v0, 4
    la $a0, cham
    syscall
    
    