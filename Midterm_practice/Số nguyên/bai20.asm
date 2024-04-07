.data
messenger: .asciiz "Nhap N: "
ketqua: .asciiz "So chinh phuong nho nhat lon hon N la: "
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
    move $s1, $s0    # temp = n (temp chạy từ n để tìm scp nhỏ nhất lớn hơn n)
    j loop
endmain:
    li $v0, 10
    syscall
loop:
    addi $s1, $s1, 1 # temp++
    li $t0, 0        # gán biến i = 0
checkscp:
    addi $t0, $t0, 1 # i++
    mult $t0, $t0    # i*i
    mflo $t1         # $t1 = i*i
    beq $t1, $s1, print_ketqua # nếu i*i = temp thì temp là số chính phương lớn hơn n
    blt $t1, $s1, checkscp     # nếu i*i < temp thì chạy tiếp vòng for tăng biến i lên
    j loop                     # nếu i*i > temp thì tăng tìm số tiếp theo (temp++)
print_ketqua:
    li $v0, 4
    la $a0, ketqua
    syscall
    li $v0, 1
    move $a0, $s1
    syscall
    j endmain 
