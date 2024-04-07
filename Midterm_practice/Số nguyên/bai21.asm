.data
messenger: .asciiz "Nhap N: "
ketqua: .asciiz "Luy thua cua 2 lon nhat nho hon N la: "
.text
main:
    li $v0, 4
    la $a0, messenger
    syscall
    li $v0, 5
    syscall
    addi $s0, $v0, 0 # n = $s0
    li $t0, 1    
    j find
endmain:
    li $v0, 4
    la $a0, ketqua
    syscall
    li $v0, 1
    move $a0, $t1
    syscall
    li $v0, 10
    syscall 
find:
    sll $t0, $t0, 1  # $t0 = $t0 * 2
    bgt $t0, $s0, endmain # khi lũy thừa của 2 lớn hơn N thì dừng luôn, nếu không thì cập nhật lên $t1
    addi $t1, $t0, 0  # $t1 = $t0
    j find   