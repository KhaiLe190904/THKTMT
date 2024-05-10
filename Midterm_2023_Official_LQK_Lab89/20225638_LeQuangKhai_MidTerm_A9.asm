.data
messenger: .asciiz "Nhap n duong (2 chu so tro len): "
tongchan: .asciiz "Tong so chan trong n la: "
tongle: .asciiz "Tong so le trong n la: "
nhapsai: .asciiz "So n phai duong va co 2 chu so tro len!"
newline: .asciiz "\n"
.text
main:
    li $v0, 4
    la $a0, messenger # in ra màn hình nhập n
    syscall
    li $v0, 5
    syscall
    move $s1, $v0 # $s1 = n
    li $s2, 10    # $s2 = 10
    blt $s1, $0, end_main_sai
    li $s3, 2     # $s3 = 2
    li $s4, 0 # sumchan=0
    li $s5, 0 # sumle=0
    j loop
loop:
    beq $s1, $0, endloop # khi nào n / 10 = 0 thì đã duyệt hết thì dừng
    div $s1, $s2 # temp chia 10
    mflo $s1 # lấy phần thương (temp = temp/10)
    mfhi $t1 # lấy dư của phép chia (chữ số cuối cùng của n)
    div $t1, $s3 # chữ số cuối chia 2
    mfhi $t2 # lưu số dư của phép chia 2 vào $t2
    beq $t2, $0, tong_chan # dư = 0 thì là chẵn thì ta nhảy tới tính tổng
    add $s5, $s5, $t1 # sumle = sumle + le
    j loop 
tong_chan:
    add $s4, $s4, $t1 # sumchan = sumchan + chan
    j loop
endloop:
    li $v0, 4
    la $a0, tongchan # in ra tổng chữ số là chẵn của n
    syscall
    li $v0, 1
    move $a0, $s4
    syscall
    
    li $v0, 4
    la $a0, newline # xuống dòng
    syscall
    
    li $v0, 4
    la $a0, tongle # in ra tổng chữ số là lẻ của n
    syscall
    li $v0, 1
    move $a0, $s5 
    syscall
    li $v0, 10
    syscall
end_main_sai:
    li $v0, 4
    la $a0, nhapsai # in ra thông báo nhập sai và kết thúc ctrinh
    syscall
    li $v0, 10
    syscall
