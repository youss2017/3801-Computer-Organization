# Register used
# t0-t4 used for loop counters and multipcation
# a0 used for arguments
# v0 syscall id

.text
start:
	# Prompt User to enter input
	la $a0, Prompt # load prompt text address
	li $v0, 4 # load print syscall id
	syscall
	jal print_new_line # print new line
	# Read User Input; read into memory (stack)
	li $v0, 5 # read integer
	syscall
	sw $v0, A # store integer value into A
	
	jal print_new_line # print new line
	
	li $v0, 5 # read integer
	syscall
	sw $v0, B # store integer value into B
	
	jal print_new_line
	
	li $v0, 5 # read integer
	syscall
	sw $v0, C # store integer value into C
	
	jal print_new_line
	
	li $v0, 5 # read integer
	syscall
	sw $v0, D # store integer value into D
	
	jal print_new_line
	
	# compute f=5 * B * D + A
	li $t0, 5 # load 5 into $t0
	lw $t1, B # load B into $t1
	# t2 = 5 * B

	# init t2
	li $t2, 0 # reset loop counter
	loop_start1:
	add $t2, $t2, $t1 # perform multiply add
	addi $t0, $t0, -1 # decrement loop counter by 1
	bgtz $t0, loop_start1 # $t0 > 0
	
	move $t0, $t2 # move multiplication result into $t0
	lw $t1, D # read value at address (D) into $t1
	# t2 = 5 * B * D

	# init t2
	li $t2, 0 # reset counter
	loop_start2:
	add $t2, $t2, $t1 # perform multiply add
	addi $t0, $t0, -1 #  decrement loop counter by 1
	bgtz $t0, loop_start2 # $t0 > 0
	lw $t0, A # Read value at address A into $t0
	add $t2, $t2, $t0 # Add to value of A to t2 register to create f
	
	# print f result
	# print F_ten
	la $a0, F_Ten # Load memory address of F_ten
	li $v0, 4 # Load print string syscall id
	syscall
		
	li $v0, 1 # load print integer syscall
	move $a0, $t2 # set a0 to t2
	syscall

	jal print_new_line
	jal print_new_line

	# print result in binary
	# print F_two
	la $a0, F_Two # Load F_two string address into register
	li $v0, 4 # Load print string syscall
	syscall
	
	li $v0, 35 # load print integer as binary syscall id
	move $a0, $t2 # set argument value to t2
	syscall
	
	jal print_new_line
	
	# compute g=D*D - C*A
	lw $t0, D # Load value of D from memory
	lw $t1, D # Load value of D from memory
	#compute D*D into t2

	# init t2
	li $t2, 0 # reset counter
	loop_start3:
	add $t2, $t2, $t1 # multiplication add
	addi $t0, $t0, -1 # decrement loop counter
	bgtz $t0, loop_start3 # if greater than 0
	
	# set t4 to D*D
	move $t4, $t2 # Save multiplication value to t4
	lw $t0, C # load value of C
	lw $t1, A # load value of A
	# compute C*A

	# init t2
	li $t2, 0 # reset counter
	loop_start4:
	add $t2, $t2, $t1 # Multication addition
	addi $t0, $t0, -1 # decerement loop counter
	bgtz $t0, loop_start4 # jump if > 0
	
	# compute D*D - C*A ==> t0 = t4 - t2
	sub $t0, $t4, $t2
	
	jal print_new_line

	# print G_ten
	la $a0, G_Ten # load g_ten string address
	li $v0, 4 # load print address
	syscall
	
	#print g
	move $a0, $t0 # load integer value
	li $v0, 1 # print integer syscall id
	syscall
	
	jal print_new_line
	jal print_new_line
	
	# print G_two
	la $a0, G_Two # load G_two string address
	li $v0, 4 # print string syscall id
	syscall
	
	# print in binary
	move $a0, $t0 # load g result into a0
	li $v0, 35 # print integer in binary form
	syscall
	
	jal print_new_line
	jal print_new_line
				
	#exit
	li $v0, 10
	syscall
	
.data:
# Variables to store user input and string constants
	A: .word 0
	B: .word 0
	C: .word 0
	D: .word 0
	Prompt: .asciiz "Enter 4 integers A, B, C, D respectively:\n"
	
	F_Ten: .asciiz "f_ten = "
	F_Two: .asciiz "f_two = "
	
	G_Ten: .asciiz "g_ten = "
	G_Two: .asciiz "g_two = "
	
