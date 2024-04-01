.text
main: li $a0, 5
      li $a1, -10
      li $a2, 16
      jal max
      nop
      li $v0, 10
      syscall
end_main:
 
max: 
      add $s0, $a0, $zero # gán a0 là max
      sub $t0, $a1, $s0 # t0 = a1 - s0
      bltz $t0, then # if a1 < s0 thì nhảy tới then
      nop
      add $s0, $a1, $zero # gán a1 làm max mới
then: 
      sub $t0, $a2, $s0 # t0 = a2 - s0
      bltz $t0, done
      nop
      add $s0, $a2, $zero 
done: jr $ra
      