.data
messenge1: .asciiz "The sum of "
messenge2: .asciiz " and "
messenge3: .asciiz " is "
.text
li $s0, 12
li $s1, 23
add $s2, $s0, $s1
   li $v0, 4
la $a0, messenge1
syscall
   li $v0, 1
add $a0, $0, $s0
syscall
   li $v0, 4
la $a0, messenge2
syscall
   li $v0, 1
add $a0, $0, $s1
syscall
   li $v0, 4
la $a0, messenge3
syscall
   li $v0, 1
add $a0, $0, $s2
syscall
