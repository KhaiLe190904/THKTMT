.data
s1: .space 100 # Khai báo một mảng để lưu trữ chuỗi s1
s2: .space 100 # Khai báo một mảng để lưu trữ chuỗi s2
newline: .asciiz "\n"
messenger1: .asciiz "Nhap chuoi s1: "
messenger2: .asciiz "Nhap chuoi s2: "
messenger3: .asciiz "Hai chuoi giong nhau!"
messenger4: .asciiz "Hai chuoi khong giong nhau!"
.text
main:
   # Nhập chuỗi s1 từ người dùng
   li $v0, 4
   la $a0, messenger1
   syscall
   li $v0, 8
   la $a0, s1
   li $a1, 100 # Số lượng ký tự tối đa cho phép nhập   
   syscall
   
   # Nhập chuỗi s2 từ người dùng
   li $v0, 4
   la $a0, messenger2
   syscall
   li $v0, 8
   la $a0, s2
   li $a1, 100 # Số lượng ký tự tối đa cho phép nhập   
   syscall 
   j compare_strings
# Hàm so sánh hai chuỗi
compare_strings:
   la $s0, s1      # Lưu địa chỉ của chuỗi s1 vào $s0
   addi $s0, $s0, -1
   la $s1, s2     # Lưu địa chỉ của chuỗi s2 vào $s1
   addi $s1, $s1, -1
compare_loop:
   addi $s0, $s0, 1
   addi $s1, $s1, 1
   lb $t0, 0($s0)      
   lb $t1, 0($s1)      
   beq $t0, 10, end_compare    # Nếu đã đến ký tự kết thúc chuỗi s1, kết thúc vòng lặp
   beq $t1, 10, end_compare    # Nếu đã đến ký tự kết thúc chuỗi s2, kết thúc vòng lặp
   bge $t0, 'a', s1_toupcase
check_s2:   
   bge $t1, 'a', s2_toupcase
   j compare
s1_toupcase:
   addi $t0, $t0, -32   # Chuyển đổi chữ thường trong s1 thành chữ hoa
   j check_s2
s2_toupcase:
   addi $t1, $t1, -32  
compare:
   beq $t0, $t1, compare_loop
   j not_equal
not_equal:
   # In ra thông báo "Hai chuoi khong giong nhau!"
   li $v0, 4
   la $a0, messenger4
   syscall
   # Kết thúc chương trình
   li $v0, 10
   syscall
end_compare:
   # Nếu đã kiểm tra hết tất cả các ký tự và không có sự khác biệt nào, in ra thông báo "Hai chuoi giong nhau!"
   li $v0, 4
   la $a0, messenger3
   syscall
   # Kết thúc chương trình
   li $v0, 10
   syscall
