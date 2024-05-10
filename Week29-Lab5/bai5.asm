.data
Messenge1: .asciiz "Nhap 1 mang ki tu: "
string: .space 32 
reverseString: .space 32
Messenge2: .asciiz "Sau khi dao nguoc xau la: "
.text
getString:
   li $v0, 54
   la $a0, Messenge1
   la $a1, string
   li $a2, 20 
   syscall # Nhap vao tung ki tu
   la $a0, reverseString # $a0 = address of 'reverseString'
   la $a1, string
   addi $s0, $0, 0 # gan i = 0
count: 
   add $t0, $s0, $a1  # $t0 = address of 'string'
   lb $t1, 0($t0) # $t1 = string[i]
   beq $t1, $zero, reverse # Khi ket thuc thi se tra gia tri Length of string
   nop
   addi $s0, $s0, 1 # i = i + 1
   j count 
   addi $s1, $0, 0 # gan j = 0
reverse:
   addi $s0, $s0, -1  # i = i - 1
   add $t0, $s0, $a1 # $t0 = address of 'string' + i
   lb $t1, 0($t0) # $t1 = string[i]
   add $t2, $s1, $a0 # $t2 = address of 'reverseString'
   sb $t1, 0($t2) # reverseString[j] = string[n-1]
   addi $s1, $s1, 1
   beq $s0, $0, printReverse
   j reverse
printReverse: 
   li $v0, 59
   la $a0, Messenge2
   la $a1, reverseString
   syscall

