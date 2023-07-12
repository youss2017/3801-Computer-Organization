.data
A: .word 5, 3, 2, 1, 0, 0, 0, 5, 3, 2, 1, 4, 0, 0, 0, 1, 1, 1

.text
start:
	# addressof A
	la $s0, A
	# sizeof array
	li $s1, 100
	# hold num of zeros
	li $a0, 0
	loop_start:
	# read value
	lw $t1, ($s0)
	bnez $t1, loop_continue
	addi $a0, $a0, 1
	loop_continue:
	addi $s0, $s0, 4
	subi $s1, $s1, 1
	bgtz $s1, loop_start

	# print count
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall
			