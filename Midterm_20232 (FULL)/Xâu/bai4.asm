.data
string:	.space 100
string_dif: .space 100
newline: .asciiz "\n"
messenger1: .asciiz "Nhap xau ki tu: "
ketqua: .asciiz "Ki tu dau tien co so lan xuat hien it nhat trong xau la: "
space: .asciiz " "
.text 
input_data:
    li $v0, 4
    la $a0, messenger1
    syscall
    li $v0, 8
    la $a0, string 
    li $a1, 100 # Số lượng ký tự tối đa cho phép nhập   
    syscall
main:
    li $t0, -1	# i = 0
    la $t2, string # $t2 -> &string[0] 
    la $t3, string_dif # $t3 ->$string_dif[0]
    li $v0, 4
    la $a0, ketqua
    syscall
    j check_khac
check_khac:
    li $t8, 0 # count_string_dif = 0
loop_i:
   addi	$t0, $t0, 1	# i++
   add	$s0, $t2, $t0	# $s0 = &string[i]
   lb	$s1, 0($s0)	# s1 = string[i]
   beq	$s1, 10, find_min # có phải là '\n' ?
   li	$t1, 0	# j = 0 so sanh cac ki tu truoc do voi ki tu hien tai
loop_j: 
   beq	$t1, $t0, store # i = j tức là từ đầu tới chính nó chỉ có kí tự đó nên in ra
   add	$s2, $t2, $t1	# s2 = &string[j]
   lb	$s3, 0($s2)	# s3 = string[j]
   beq	$s3, $s1, loop_i # if $s2 = $s3 thì skip không in ra
   addi	$t1, $t1, 1	# j++
   j loop_j
store:
   sb $s1, 0($t3) # string_dif sẽ chứa các kí tự khác nhau
   addi $t3, $t3, 1 # trỏ tới vị trí tiếp theo trong xâu string_dif
   addi $t8, $t8, 1
   j loop_i				

find_min:
   move $t0, $t8 # i = length_string_dif
   li $t4, 0x7fffffff # min_count = số lớn nhất của 32 bit
   la $t3, string_dif
loop_stringdif:
   addi $t0, $t0, -1 # i--
   li $t1, -1 # j = -1 reset lại j từ ban đầu
   li $t7, 0 # reset đếm count = 0
   add $s0, $t3, $t0 # $s0 = &string_dif[i]
   lb $s1, 0($s0) # $s1 = string_dif[i]
   beq $s1, 0, end_main # gặp dấu khoảng cách ' ' kết thúc của string_dif thì print
   j loop_string
loop_string:
   addi $t1, $t1, 1 # j++
   add $s2, $t2, $t1 # $s2 = &string[j]
   lb $s3, 0($s2) # $s3 = string[j]
   beq $s3, 10, compare_count # duyệt hết string thì đi so sánh count_kitu
   bne $s3, $s1, loop_string # không bằng thì duyệt kí tự tiếp của string
   addi $t7, $t7, 1 # count++
   j loop_string
compare_count:
   bgt $t7, $t4, loop_stringdif # count >=  count_min
   move $t4, $t7 # update count_min
   lb $t6, 0($s0) # lưu kí tự đầu tiên mà có số lần xuất hiện nhiều nhất ra $t6
   j loop_stringdif
end_main:
   li $v0, 11
   move $a0, $t6
   syscall
   li $v0, 10
   syscall				
							
								
									
										
											
												
														