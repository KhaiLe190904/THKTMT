.data
messengerA: .asciiz "Nhap A: "
messengerB: .asciiz "Nhap B: "
messengerC: .asciiz "Nhap C: "
tamgiac: .asciiz "3 so nay la do dai cua tam giac."
khonglatamgiac: .asciiz "3 so nay khong la do dai cua tam giac."
tamgiaccan: .asciiz " 3 so nay tao thanh mot tam giac can."
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
    beq $s0, $s1, print_can
    beq $s0, $s2, print_can
    beq $s1, $s2, print_can
    j print_khongcan
print_can:
    li $v0, 4
    la $a0, tamgiac
    syscall
    li $v0, 4
    la $a0, tamgiaccan
    syscall
    j end
print_khongcan:
    li $v0, 4
    la $a0, tamgiac
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
