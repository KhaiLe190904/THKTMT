.data
messenger: .asciiz "Nhap n: "
socp: .asciiz " la so chinh phuong."
khongsocp: .asciiz " khong la so chinh phuong."
space: .asciiz " "
.text
main: 
    li $v0, 4
    la $a0, messenger
    syscall
    li $v0, 5
    syscall
    addi $s0, $v0, 0 # n = $s0
    li $t0, 0
    j checkscp
endmain:
    li $v0, 10
    syscall
checkscp:
    addi $t0, $t0, 1 # i++
    mult $t0, $t0
    mflo $t1
    beq $t1, $s0, print_scp
    blt $t1, $s0, checkscp  
    j print_0scp
print_scp:
    li $v0, 1
    move $a0, $s0
    syscall
    li $v0, 4
    la $a0, socp
    syscall
    j endmain 
print_0scp:
    li $v0, 1
    move $a0, $s0
    syscall
    li $v0, 4
    la $a0, khongsocp
    syscall
    j endmain 