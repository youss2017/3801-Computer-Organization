# Youssef Samwel -- 06/7/2023
# add.asm-- A program that computes the sum of 4 and 1,
# leaving the result in register $t0.
# Registers used:
# t0 - used to hold the result.

# Registers used:
# t0 - used to hold the result.
# t1 - used to hold the constant 4.

.text
start:
	li $t0, 4 # load 4 into $t0
	addi $t0, $t0, 1 # add 1 to $t0 register
	
	li $v0, 1 # load print integer syscall id
	move $a0, $t0 # move contents of $t0 to $a0
	syscall # issue syscall to print contents of $a0 in Mar's display
	
	li $v0, 10 # set $v0 to 10 the exist syscall
	syscall	# exit program

# end of add.asm
