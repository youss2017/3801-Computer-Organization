# Youssef Samwel -- 06/7/2023
# 

.text
main:
	# read number 1 from user
	li $v0, 5
	syscall
	move $t0, $v0

	# read number 2 from user
	li $v0, 5
	syscall
	move $t1, $v0

	# read number 3 from user
	li $v0, 5
	syscall
	move $t2, $v0

	# compute $t0 + $t1 + $t2
	add $t3, $t0, $t1
	add $t3, $t3, $t2
	
	# print sum
	li $v0, 1
	move $a0, $t3
	syscall
	
	#exit							
	li $v0, 10
	syscall
