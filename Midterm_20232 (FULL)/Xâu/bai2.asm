.data
string:	.space 100
newline: .asciiz "\n"
messenger1: .asciiz "Nhap xau ki tu: "
ketqua: .asciiz "Cac ki tu khac nhau trong xau la: "
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
    li $v0, 4
    la $a0, ketqua
    syscall
    j check_khac
check_khac:
   li $t1, 0 # count = 0  
loop_i:
   addi	$t0, $t0, 1	# i++
   add	$s0, $t2, $t0	# $s0 = &string[i]
   lb	$s1, 0($s0)	# s1 = string[i]
   beq	$s1, 10, end_main	# is '\n' ?
   li	$t1, 0			# j = 0 so sanh cac ki tu truoc do voi ki tu hien tai
loop_j: 
   beq	$t1, $t0, print_kitu # i = j tức là từ đầu tới chính nó chỉ có kí tự đó nên in ra
   add	$s2, $t2, $t1	# s2 = &string[j]
   lb	$s3, 0($s2)	# s3 = string[j]
   beq	$s3, $s1, loop_i # if $s2 = $s3 thì skip không in ra
   addi	$t1, $t1, 1	# j++
   j loop_j
print_kitu:
   li $v0, 11
   lb $a0, 0($s0)
   syscall
   li $v0, 4
   la $a0, space
   syscall
   addi	$t1, $t1, 1	# count++
   j loop_i				
end_main:
   li $v0, 10
   syscall				
							
								
									
										
											
												
														