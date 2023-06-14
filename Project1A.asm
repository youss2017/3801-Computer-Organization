
.text
start:
	# Prompt User to enter input
	la $a0, Prompt
	li $v0, 4
	syscall
	# Read User Input; read into memory (stack)
	li $v0, 5
	syscall
	sw $v0, A
	
	li $v0, 5
	syscall
	sw $v0, B
	
	li $v0, 5
	syscall
	sw $v0, C
	
	li $v0, 5
	syscall
	sw $v0, D
	
	# compute f=5 * B * D + A
	li $t0, 5
	lw $t1, B
	# t2 = 5 * B

	# init t2
	li $t2, 0
	loop_start1:
	add $t2, $t2, $t1
	addi $t0, $t0, -1
	bgtz $t0, loop_start1
	
	move $t0, $t2
	lw $t1, D
	# t2 = 5 * B * D

	# init t2
	li $t2, 0
	loop_start2:
	add $t2, $t2, $t1
	addi $t0, $t0, -1
	bgtz $t0, loop_start2
	
	lw $t0, A
	add $t2, $t2, $t0
	
	# print f result
	# print F_ten
	la $a0, F_Ten
	li $v0, 4
	syscall
	
	li $v0, 1
	move $a0, $t2
	syscall
	
	# new line
	jal print_new_line
	
	# print result in binary
	# print F_two
	la $a0, F_Two
	li $v0, 4
	syscall
	
	li $v0, 35
	move $a0, $t2
	syscall
	
	# compute g=D*D - C*A
	lw $t0, D
	lw $t1, D
	#compute D*D into t2

	# init t2
	li $t2, 0
	loop_start3:
	add $t2, $t2, $t1
	addi $t0, $t0, -1
	bgtz $t0, loop_start3
	
	# set t4 to D*D
	move $t4, $t2
	lw $t0, C
	lw $t1, A
	# compute C*A

	# init t2
	li $t2, 0
	loop_start4:
	add $t2, $t2, $t1
	addi $t0, $t0, -1
	bgtz $t0, loop_start4
	
	# compute D*D - C*A ==> t0 = t4 - t2
	sub $t0, $t4, $t2
	
	# new line
	jal print_new_line
	
	# print G_ten
	la $a0, G_Ten
	li $v0, 4
	syscall
	
	#print g
	move $a0, $t0
	li $v0, 1
	syscall
	
	# new line
	jal print_new_line
	
	# print G_two
	la $a0, G_Two
	li $v0, 4
	syscall
	
	# print in binary
	move $a0, $t0
	li $v0, 35
	syscall
		
	#exit
	li $v0, 10
	syscall

# multiples value in $t0 with $t1 and outputs in $t2
loop_mul:
	# init t2
	li $t2, 0
	loop_start:
	add $t2, $t2, $t1
	addi $t0, $t0, -1
	bgtz $t0, loop_start
	jr $ra
	
print_new_line:
	li $v0, 11
	li $a0, 10
	syscall
	jr $ra
	
.data:
	A: .word 0
	B: .word 0
	C: .word 0
	D: .word 0
	Prompt: .asciiz "Enter 4 integers A, B, C, D respectively:\n"
	
	F_Ten: .asciiz "f_ten = "
	F_Two: .asciiz "f_two = "
	
	G_Ten: .asciiz "g_ten = "
	G_Two: .asciiz "g_two = "
	