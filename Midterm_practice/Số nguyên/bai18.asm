.data
messengerM: .asciiz "Nhap M (M > N): "
messengerN: .asciiz "Nhap N: "
ketqua: .asciiz "So nguyen thoa man de bai la: "
khongtimthay: .asciiz "Khong tim thay so nguyen thoa man!"
newline: .asciiz "\n"
.text
main:
   li $v0, 4
   la $a0, messengerM
   syscall
   li $v0, 5
   syscall
   move $s0, $v0  # $s0 = M

   li $v0, 4
   la $a0, messengerN
   syscall
   li $v0, 5
   syscall
   move $s1, $v0  # $s0 = N
   li $t0, 1      # start từ 1
check_loop:
   addi $t0, $t0, 1  # i++
   beq $t0, $s0, end_check  # i -> M thì dừng
   div $s0, $t0        # M / i
   mfhi $t1            # Lấy dư
   beq $t1, $zero, la_uocM # Nếu dư = 0 thì ước này hợp lệ
   j check_loop
la_uocM:
   bgt $t0, $s1, print  # Ước > n thì print
   j check_loop
print:
   li $v0, 4
   la $a0, ketqua
   syscall
   move $a0, $t0
   li $v0, 1
   syscall
   j endmain
end_check:
   li $v0, 4
   la $a0, khongtimthay
   syscall
endmain:
   li $v0, 10
   syscall
