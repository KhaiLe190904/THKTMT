.data
A: .word 9,8,7,6,5,4,3
Aend: .word 
comma: .asciiz ", "
newline: .asciiz "\n"
.text
main: 
   la $a0, A # address A into $a0
   move $a2, $a0 # address $a2 = A[0]
   la $a1, Aend 
   addi $a1, $a1, -4 #address A[n-1] into $a1
   addi $t3, $a1, 0 #address A[n-1] into $t3
   j sort
after_sort:
   li $v0, 10 #exitsyscall
   syscall
end_main:
sort:  
   addi $t0, $a0, 0 # address A[j] into $t0
insert_sort:
   beq $t0, $a2, endinsert_sort
   lw $s0, 0($t0) # $s0 = A[j]
   lw $s1, -4($t0) # $s1 = A[j-1]
   slt $t1, $s1, $s0 # so sánh A[j-1] < A[j]?
   bne $t1, $0, skip_insert
insert:
   sw $s0, -4($t0) # A[j-1] = $s0 = A[j]
   sw $s1, 0($t0) # A[j] = $s1 = A[j-1]
skip_insert:
   addi $t0, $t0, -4 # j--
   j insert_sort
endinsert_sort:
   addi $t3, $a0, 0 # $t3 = $a0
   la $s0, A 
print: 
   li $v0, 1
   lw $a0, 0($s0)
   syscall
   beq $s0, $a1, end_print
   li $v0, 4
   la $a0, comma
   syscall
   addi $s0, $s0, 4
   j print
end_print:
   addi $a0, $t3, 0
   beq $a0, $a1, done #single element list is sorted
   li $v0, 4
   la $a0, newline
   syscall
   addi $a0, $t3, 0
   addi $a0, $a0, 4
   j sort
done: j after_sort
   
