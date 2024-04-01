.data
   A: .word  9,8,7,6,5,4,3
   Aend: .word
   comma: .asciiz ", "
   newline: .asciiz "\n"
.text
main: 
   la $a0, A
   la $a1, Aend 
   addi $a1, $a1, -4 #$a1 = Address(A[n-1])
   addi $t3, $a1, 0 # $t3 = Address(A[n-1])
   j sort
after_sort:
   li $v0, 10 #exitsyscall
   syscall
end_main:
sort: 
   beq $a0,$a1, done #single element list is sorted
   j bubble_sort
bubble_sort:
   beq $a0, $a1, endbubble_sort
   lw $s0, 0($a0) # s0 = A[i]
   lw $s1, 4($a0) # s1 = A[i+1]
   slt $t0, $s0, $s1 # A[i] < A[i+1] ?
   bne $t0, $0, skip_swap
swap:
   sw $s0, 4($a0) # A[i+1] = $s0 = A[i]
   sw $s1, 0($a0) # A[i] = $s1 = A[i+1]
skip_swap:
   addi $a0, $a0, 4 # trỏ tiếp lên A[i+1]
   j bubble_sort
endbubble_sort: 
   la $s0, A
print: 
   li $v0, 1
   lw $a0, 0($s0)
   syscall
   beq $s0, $t3, endprint # so sánh với A[i] chạy baoh tới A[n-1]
   li $v0, 4
   la $a0, comma
   syscall
   addi $s0, $s0, 4
   j print
endprint:
   li $v0, 4
   la $a0, newline
   syscall
   la $a0, A
   addi $a1, $a1, -4 # giảm con trỏ xuống A[n-2] rồi A[n-3] ....
   j sort
done: j after_sort
