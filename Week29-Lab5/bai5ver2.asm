.data
Messenge1: .asciiz "Nhap 1 mang ki tu: "
string: .space 50 
reverseString: .space 50
Messenge2: .asciiz "Sau khi dao nguoc xau la: "
.text
   addi $s0, $0, 0 # gan i = 0
   addi $s1, $0, 0 # gan j = 0
   li $s2, 20
   li $s3, 0x0a
   la $a0, reverseString # $a0 = address of 'reverseString'
   la $a1, string
getString:
   li $v0, 12
   syscall
count: 
   beq $v0, $s3, reverse # end khi nhan xuong dong
   add $t0, $s0, $a1  # $t0 = address of 'string + i'
   sb $v0, 0($t0)     # string[i] = $v0
   addi $s0, $s0, 1 # i = i + 1
   bge $s0, $s2, reverse # end khi i > 20 ki tu
   j getString
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