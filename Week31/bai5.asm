.data 
Messenger1a: .asciiz "The largest element is stored in $s"
Messenger1b: .asciiz " ,largest value is "
Messenger2a: .asciiz "The smallest element is stored in $s"
Messenger2b: .asciiz " ,smallest value is "
newline: .asciiz "\n"
.text
main:    
    li $s0, 4
    li $s1, 3
    li $s2, 99
    li $s3, 3
    li $s4, 54
    li $s5, -5
    li $s6, 5
    li $s7, 123
    jal find_maxmin
print:
    li $v0, 4
    la $a0, Messenger1a
    syscall
    li $v0, 1
    lw $a0, 8($sp) # $a0 = maxid
    syscall
    li $v0, 4
    la $a0, Messenger1b
    syscall
    li $v0, 1
    lw $a0, 12($sp) # $a0 = max
    syscall
    
    li $v0, 4
    la $a0, newline
    syscall
    
    li $v0, 4
    la $a0, Messenger2a
    syscall
    li $v0, 1
    lw $a0, 0($sp) # $a0 = min_id
    syscall
    li $v0, 4
    la $a0, Messenger2b
    syscall
    li $v0, 1
    lw $a0, 4($sp) # $a0 = min
    syscall
quit: 
    addi $sp, $sp, 48
    li $v0, 10 #terminate 
    syscall 
endmain: 

find_maxmin:
    add $fp, $sp, $0 # fp points to the bottom of the stack
    addi $sp, $sp, -48 # 8 thanh ghi từ $s0-$s7 và 4 giá trị max và min địa chỉ của max và min
    sw $s0, 44($sp)
    sw $s1, 40($sp)
    sw $s2, 36($sp)
    sw $s3, 32($sp)
    sw $s4, 28($sp)
    sw $s5, 24($sp)
    sw $s6, 20($sp)
    sw $s7, 16($sp) # push 8 thanh ghi vào stack
    
    li $t0, 0 # gán $t0 = i = 0
    li $t1, 7 # n = 7
    lw $a0, 44($sp) # $a0 = $s0 (= A[0])
    sw $a0, 12($sp) # push max = A[0]
    sw $t0, 8($sp) # push maxid = 0
    sw $a0, 4($sp) # push min = A[0]
    sw $t0, 0($sp) # push minid = 0
    addi $t0, $t0, 1 # chạy từ i = 1
loop:
    bgt $t0, $t1, done
    addi $t2, $t0 , 1 # gán $t2 = i + 1
    add $t2, $t2, $t2 # $t2 = 2*i + 2
    add $t2, $t2, $t2 # $t2 = 4*i + 4
    sub $t2, $fp, $t2 # $t2 = address(A[i])
    lw $a0, 0($t2) # $a0 = A[i]
    lw $a1, 12($sp) # $a1 = max_hientai
    lw $a2, 4($sp) # $a2 = min_hientai
max: 
    ble $a0, $a1, min # $a0 <= $a1 ? (A[i] < max) nếu đúng thì tìm min, nếu sai thì gán max = A[i]
    sw $a0, 12($sp) # max = A[i]
    sw $t0, 8($sp) # maxid = i
min: 
    bge $a0, $a2, then # $a0 >= $a2 ? (A[i] > min) nếu đúng thì nhảy tới then, nếu sai thì gán min = A[i]
    sw $a0, 4($sp) # min = A[i]
    sw $t0, 0($sp) # minid = i
then:
    addi $t0, $t0, 1 # i++
    j loop
done: jr $ra
    
