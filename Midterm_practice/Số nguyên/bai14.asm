.data
messengerA: .asciiz "Nhap A: "
messengerB: .asciiz "Nhap B: "
messengerC: .asciiz "Nhap C: "
tamgiac: .asciiz "3 so nay la do dai cua tam giac."
khonglatamgiac: .asciiz "3 so nay khong la do dai cua tam giac."
tamgiacvuong: .asciiz " 3 so nay tao thanh mot tam giac vuong."
newline: .asciiz "\n"
.text
main:
    # nhap A
    li $v0, 4
    la $a0, messengerA
    syscall
    li $v0, 5
    syscall
    move $s0, $v0 # $s0 = A

    # nhap B
    li $v0, 4
    la $a0, messengerB
    syscall
    li $v0, 5
    syscall
    move $s1, $v0 # $s1 = B

    # nhap C
    li $v0, 4
    la $a0, messengerC
    syscall
    li $v0, 5
    syscall
    move $s2, $v0 # $s2 = C

    add $t0, $s0, $s1
    ble $t0, $s2, khong_latamgiac
    add $t0, $s0, $s2
    ble $t0, $s1, khong_latamgiac
    add $t0, $s1, $s2
    ble $t0, $s0, khong_latamgiac
la_tamgiac:
    # check_vuong
    mul $t0, $s0, $s0 # Tính A^2
    mul $t1, $s1, $s1 # Tính B^2
    mul $t2, $s2, $s2 # Tính C^2
    add $t3, $t0, $t1 # Tính $t3 = A^2 + B^2
    add $t4, $t1, $t2 # Tính $t4 = B^2 + C^2
    add $t5, $t0, $t2 # Tính $t5 = A^2 + C^2
    beq $t3, $t2, print_vuong
    beq $t4, $t0, print_vuong
    beq $t5, $t1, print_vuong
print_khongvuong:
    # In ra màn hình kết quả nếu không phải tam giác vuông
    li $v0, 4
    la $a0, tamgiac
    syscall
    j end

print_vuong:
    # In ra màn hình kết quả nếu là tam giác vuông
    li $v0, 4
    la $a0, tamgiac
    syscall
    li $v0, 4
    la $a0, tamgiacvuong
    syscall
    j end
khong_latamgiac:
    li $v0, 4
    la $a0, khonglatamgiac
    syscall
    j end
end:
    li $v0, 4
    la $a0, newline
    syscall
    li $v0, 10
    syscall
