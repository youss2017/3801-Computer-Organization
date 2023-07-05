# Youssef Samwel 6/21/2023
# s0 is f_ten
# s1 is g_ten
# v0 syscall arguments; syscall id
# a0 syscall arguments
# s0, s1 used to compute f_ten
# s3, s4; compute division and remainder/mod
# t0, t1 compute g_ten
# t0 t1 t2 compute division/remainder; t1 used for loop counter

.text
start:
	############### Read user input
	
	li $v0, 4 # load print string syscall id
	la $a0, f_ten_str # load string address
	syscall
	
	li $v0, 5 # load read integer syscall id
	syscall
	move $s0, $v0 # temporarily store value in v0 to s0 (f_ten)
	sw $v0, f_ten_var # store the value of f_ten in stack memory
	
	jal print_new_line
	
	li $v0, 4 # load print string syscall id
	la $a0, g_ten_str # load string address
	syscall
	
	li $v0, 5 # load read integer syscall id
	syscall
	move $s1, $v0 # temporarily store value in v0 to s1 (g_ten)
	
	# Compute f_ten + 2
	addi $s0, $s0, 2
	# Compute g_ten - 2
	addi $s1, $s1, -2
	
	# branch if g_ten - 2 <= 0
	ble $s1, 0, error_handler
	# ble $s0, 27, error_handler
	
	###################### Compute (f_ten + 2) / (g_ten - 2)
	# store quotient in s3
	# store remainder in s4
	div_loop:
	# substract s1 from s0; s0 - s1
	sub $s0, $s0, $s1
	addi $s3, $s3, 1
	# if s0 > 0 then add 1 to s3 and jump to div_start
	# otherwise add s1 to s0; s0 + s1
	# and set s4 to s1 (which is the remainder)
	bgt $s0, 0, div_loop
	# jump to print output if s0==0
	beqz $s0, print_output
	
	############## Compute remainder
	add $s0, $s0, $s1 # s0 += s1
	subi $s3, $s3, 1 # s3 += 1
	move $s4, $s0 # s4=s0
	
	################# Display results (part 1)
	print_output:
	jal print_new_line
	
	li $v0, 4 # print syscall id
	la $a0, h_quotient_str # load string address
	syscall
	
	li $v0, 1 # print integer syscall id
	move $a0, $s3 # set a0 to s3
	syscall
	
	jal print_new_line # jump to print new line
	jal print_new_line # jump to print new line
	
	li $v0, 4 # load print id syscall id
	la $a0, h_remainder_str # load string address
	syscall
	
	li $v0, 1 # load print number syscall id
	move $a0, $s4 # put number in syscall argument
	syscall
	
	################### Compute division to determine remainder
	# store quotient in t1
	# store remainder in t2
	# if h_remainder or s4 is zero then jump to print_output2 because mod is 0
	# compute (f_ten-25) into t0
	lw $t0, f_ten_var
	addi $t0, $t0, -25
	
	li $t2, 0 # t2 = 0 ; loop counter
	beqz $s4, print_output2 # s4 != 0
	div_loop2:
	# substract t0 from s4; t0 - s4
	sub $t0, $t0, $s4
	addi $t1, $t1, 1
	# if t0 > 0 then add 1 to t1 and jump to div_start
	# otherwise add s4 to t0; t0 + s4
	# and set t2 to s0 (which is the remainder)
	bgt $t0, 0, div_loop2
	# jump to print output if s0==0
	beqz $t0, print_output2
	
	# compute remainder
	add $t0, $t0, $s4 # t0+=s4
	subi $t1, $t1, 1 # t1+=1
	move $t2, $t0 # t2=t0
	
	######################## Display results (part 2)
	print_output2:
	# ble $t2, 0, exit # do not show i_mod if i_mod < 0
	
	jal print_new_line  # jump to print new line
	jal print_new_line  # jump to print new line
	
	li $v0, 4 # load print string syscall id
	la $a0, i_mod_str # load string address
	syscall
	
	li $v0, 1 # load print int syscall id
	move $a0, $t2 # setargument
	syscall	# print number
	
	jal print_new_line # jump to routuine 
	
	exit:
	# exit
	li $v0, 10 # load exit syscall id
	syscall # exit
	
print_new_line:
	li $v0, 11 # print character syscall id
	li $a0, 10 # ascii '\n' '\
	syscall
	jr $ra # return statement
	
error_handler:
	jal print_new_line # jump to print new line
	li $v0, 4 # load print string syscall id
	la $a0, error_str # load string address
	syscall
	jal print_new_line  # jump to print new line
	# ask users again for inputs
	j start # return to start of program
	
.data
	# strings
	f_ten_str: .asciiz "f_ten = "
	g_ten_str: .asciiz "g_ten = "
	error_str: .asciiz "g_ten must be greater than 2 (e.g. g_ten - 2 > 0)\n"
	h_quotient_str: .asciiz "h_quotient = "
	h_remainder_str: .asciiz "h_remainder = "
	i_mod_str: .asciiz "i_mod = "
	# use variable to reduce complex logic required
	# it would be more complicated to only store f_ten in
	# registers because the program flow would be more
	# convoluted.
	f_ten_var: .word 0
	
	
	
	
	
