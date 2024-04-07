.data
messenger: .asciiz "Nhap n: "
socp: .asciiz "Cac so la so chinh phuong nho hon n la:\""
space: .asciiz " "
dongngoac: .asciiz " \""
.text
main: 
    li $v0, 4
    la $a0, messenger
    syscall
    li $v0, 5
    syscall
    addi $s0, $v0, 0 # n = $s0 
    li $s1, 0 # k = 0
    li $v0, 4
    la $a0, socp
    syscall
    j checkscp
endmain:
    li $v0, 4
    la $a0, dongngoac
    syscall
    li $v0, 10
    syscall
checkscp:
    addi $s1, $s1, 1 # k++    
    beq $s1, $s0, endmain # k chạy tới n
    li $t0, 0 # 
loop:
    addi $t0, $t0, 1 # i++
    mult $t0, $t0
    mflo $t1
    beq $t1, $s1, print_scp
    blt $t1, $s1, loop  
    j checkscp
print_scp:
    li $v0, 4
    la $a0, space
    syscall
    li $v0, 1
    move $a0, $s1
    syscall
    j checkscp  
