.data
string: .space 100 
messenger1: .asciiz "Nhap xau ki tu: "
.text
   li $v0, 4
   la $a0, messenger1
   syscall
   li $v0, 8
   la $a0, string   # save address of inputString
   li $a1, 100
   syscall
   li $t0, -1
loop: 
   addi $t0, $t0, 1 # i++
   lb $t1, string($t0)
   beq $t1, 10, exit
   bge $t1, 'a', toupcase
   ble $t1, 'Z', tolowcase
toupcase:
   bgt $t1, 'z', loop # lớn hơn 'z' thì giữ nguyên
   addi $t1, $t1, -32 
   sb $t1, string($t0)
   j loop 
tolowcase:
   blt $t1, 'A', loop # nhỏ hơn 'A' thì giữ nguyên
   add $t1, $t1, 32
   sb $t1, string($t0)
   j loop
exit:
   li $v0, 4
   la $a0, string 
   syscall
   li $v0, 10		# exit program 
   syscall