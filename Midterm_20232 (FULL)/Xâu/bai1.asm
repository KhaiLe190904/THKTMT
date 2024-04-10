.data
string: .space 100 # Khai báo một mảng để lưu trữ chuỗi
newline: .asciiz "\n"
messenger1: .asciiz "Nhap chuoi ki tu can kiem tra: "
messenger2: .asciiz "Chuoi doi xung!"
messenger3: .asciiz "Chuoi khong doi xung!"
.text
main:
   li $v0, 4
   la $a0, messenger1
   syscall
   li $v0, 8
   la $a0, string 
   li $a1, 100 # Số lượng ký tự tối đa cho phép nhập   
   syscall
   la $s0, string
   li $t3, 0 # soluongkitu = 0
   j count_length
endmain:
   li $v0, 10
   syscall
count_length:
   addi $s0, $s0, 1
   lb $t0, 0($s0) # $t0 = string[i]
   addi $t3, $t3, 1 # count++
   beq $t0, 10, end_count
   j count_length
end_count:
   j check_doixung
check_doixung:
   la $s0, string
   add $t3, $t3, -1 # cộng từ A[0] thì phải trừ đi chính nó
   add $s1, $t3, $s0 # $s1 trỏ address của A[n-1]
check_loop:
   lb $t1, 0($s0) # $t1 = string[i]
   lb $t2, 0($s1) # $t2 = string[n-1]
   beq $t1, $t2, doixung  # Nếu đã kiểm tra qua tất cả các ký tự, chương trình quay về hàm main
   bne $t1, $t2, khongdoixung # Nếu các ký tự khác nhau, chuỗi không đối xứng
   addi $s0, $s0, 1
   addi $s1, $s1, -1
   j check_loop
doixung:
   # In ra thông báo "Chuỗi là đối xứng."
   li $v0, 4
   la $a0, messenger2
   syscall
   j endmain # kết thúc
khongdoixung:
   # In ra thông báo "Chuỗi không đối xứng."
   li $v0, 4
   la $a0, messenger3
   syscall
   j endmain    # kết thúc

