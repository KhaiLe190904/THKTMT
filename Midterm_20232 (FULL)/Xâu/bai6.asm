.data
string: .space 100 
newline: .asciiz "\n"
messenger1: .asciiz "Nhap chuoi ki tu: "
messenger2: .asciiz "Nhap ky tu C: "
messenger3: .asciiz "\nSo lan xuat hien cua ky tu C trong chuoi la: "
.text
main:
   li $v0, 4
   la $a0, messenger1
   syscall
   li $v0, 8
   la $a0, string 
   li $a1, 100 
   syscall

   li $v0, 4
   la $a0, messenger2
   syscall
   li $v0, 12
   syscall
   move $s1, $v0  # $s1 = kí tự C
   la $s0, string
   bge $s1, 'a', toupcase_C
   j count_occurrences
toupcase_C:
   bgt $s1, 'z', count_occurrences
   addi $s1, $s1, -32
   j count_occurrences
count_occurrences:
   li $t0, 0     # Khởi tạo biến đếm $t0 = 0
count_loop:
   lb $t1, 0($s0)   # Lấy ký tự đầu tiên của chuỗi vào $t1
   beq $t1, 10, end_count   # Nếu đã đến kí tự enter kết thúc vòng lặp
   j to_upper
to_upper:
   bge $t1, 'a', toupcase
   j check
toupcase:
   bgt $t1, 'z', check # lớn hơn 'z' thì giữ nguyên
   addi $t1, $t1, -32 
check:
   beq $t1, $s1, increase_count   # Nếu hai ký tự giống nhau, tăng biến đếm lên 1
   addi $s0, $s0, 1
   j count_loop
increase_count:
   addi $t0, $t0, 1   # Tăng biến đếm lên 1
   # Di chuyển đến ký tự tiếp theo trong chuỗi
   addi $s0, $s0, 1
   j count_loop
end_count:
   li $v0, 4
   la $a0, messenger3
   syscall
   li $v0, 1
   move $a0, $t0
   syscall
   
