
.text
main:
	# init $t0 = 5
	li $t0, 5
	loop_start:
	# print integer
	# li $v0, 1 # integer
	li $v0, 34 # hex
	move $a0, $t0
	syscall
	# add 1
	addi $t0, $t0, 1
	# print new line
	li $v0, 11
	li $a0, 10 
	syscall
	# jump if $t0 <= 20
	ble $t0, 20, loop_start
	
	li $v0, 10
	syscall
