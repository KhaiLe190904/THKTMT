start:
li $s1, 0x7fffffff
li $s2, 0x80000000
li $t0, 0 
addu $s3, $s1,$s2 # s3 = s1 + s2
xor $t1, $s1, $s3  # Test if $s1 and $s3 have the same sign
bgtz $t1, exit
xor $t2, $s2, $s3
bgtz $t2, exit
j overflow
overflow: 
li $t0, 1 # bằng 1 là tràn số
exit:
