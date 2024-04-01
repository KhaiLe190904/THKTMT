# ble $s1,$s2,label
addi $s1, $s1, 10
addi $s2, $s2, 7
sub $s0, $s1, $s2 # s1 - s2
blez $s0, label # s1-s2 <= 0
else: addi $t0, $t0, -1 # sai
j exit
label: addi $t0, $t0, 1 # đúng
exit: