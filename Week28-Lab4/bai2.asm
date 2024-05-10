.text
# Extract MSB of $s0
li $s0,  0x12345678 
andi $t0, $s0, 0xff000000
srl $t0, $t0, 24
# Clear LSB of $s0
andi $t1, $s0, 0xffffff00
# Set LSB of $s0 (bits 7 to 0 are set to 1)
ori $t2, $s0, 0x000000ff
# Clear $s0 ($s0=0, must use logical instructions)
andi $t3, $s0, 0
