# Youssef Samwel - 7/5/2023
# Purpose of this project is to increase your understanding of data, address, memory contents, and strings.
# You will be expected to apply selected MIPS assembly language instructions, assembler directives and
# system calls sufficient enough to handle string manipulation tasks. You are tasked to find the number of
# selected letters present in a user input string. Specifically, the number of the occurrences of the letters
# K, N, I, G, H, T, and S (upper and lower cases both to be counted) within an input sentence
# t0 - used to hold memory address of sample_text
# t1 - used to hold character's in sample_text
# t6 - used to read current value in counter_array when printing output
# t7 - used for as subroutine argument for print_output
# v0 - used for syscall id 
# a0 - used for syscall arguments
# s0 - holds the character set address
# s1 - hold the current character in character set
# s2 - used as an index for counter_array
# s7 - used to load, add, and store values from counter_array

.text
start:
	# load sample text address in t0
	la $t0, sample_text
	# step through text until null termination
	text_loop:
	# t1 contain the current character value
	lb $t1, ($t0)
	# if current character is 0 then we have reached the end of string
	# and must exit
	beq $t1, 0, text_loop_end
	# jump to routine to count character
	jal count_letter
	# increment sample text address pointer to read next character
	addi $t0, $t0, 1
	j text_loop # jump to text_loop
	
	text_loop_end:
	li $t7, 0 # set subroutine argument
	jal print_output # print output in integer form
	li $t7, 1 # set subroutine argument to print histograms
	jal print_output # print output in histogram form
	
	exit:
	# exit program
	li $v0, 10
	syscall # syscall

# determines if letter is in the character set (not-case sensitive), character must be in $t1
# note that t1 will be converted to a lowercase letter upon return
count_letter:
	# convert letter to lowercase if it is uppercase
	bge $t1, 'a', charset_init
	addi $t1, $t1, 32
	# $s0 contains character_set address
	# $s1 contains current character in address
	# $s2 used to determine the index of character
	charset_init:
	la $s0, character_set # load address
	li $s2, 0 # set value
	charset_loop:
	# read current character in charset
	lb $s1, ($s0)
	# check if we reached the end of the character set (NULL termination)
	beq $s1, 0, charset_end
	# is t1 equal to current character in the character set
	beq $s1, $t1, valid_charset_letter
	
	######## end loop operations
	# increment character_set address pointer
	addi $s0, $s0, 1
	# increment counter_array counter (4 bytes because array is 32-bit integer)
	addi $s2, $s2, 4
	j charset_loop # jump to charset_loop
	charset_end:
	jr $ra # return from subroutine
	
	valid_charset_letter:
	# counter_array[$s2] into $s7
	lw $s7, counter_array($s2)
	# s2 += 1
	addi $s7, $s7, 1
	sw $s7, counter_array($s2) # save result of addition to memory
	jr $ra # return from subroutine
	
# set t7 to 0 to print integer values and any other value to print historgram
print_output:
	# display letter counts
	# $s0 contains character_set address
	# $s1 contains current character in address
	# $s2 used to determine the index of character
	la $s0, character_set # load address
	li $s2, 0 # set value to 0
	charset_display_loop:
	# read current character in charset
	lb $s1, ($s0)
	# are we at the end
	beq $s1, 0, print_exit
	# otherwise print value for current character
	# first convert the letter from lowercase to uppercase by substraction
	addi $s1, $s1, -32
	# print letter using syscall
	li $v0, 11 # set value to 11
	move $a0, $s1 # copy value to a0
	syscall # syscall
	
	# print colon character
	li $v0, 11 # print character syscall id
	li $a0, ':' # colon ascii value
	syscall # syscall
	
	# print colon character
	li $v0, 11 # print character syscall id
	li $a0, ' ' # space ascii value
	syscall # syscall
	
	lw $t6, counter_array($s2) # read count inside array at byte offset $s2
	bne $t7, 0, histogram_loop # check which mode were in
	
	# print integer value
	move $a0, $t6 # set a0 to t6
	li $v0, 1 # set print integer syscall
	syscall # syscall
	j continue # skip histogram loop
	
	histogram_loop:
	beq $t6, 0, continue # is the value 0, then don't print #, this could happen if t6 is initial zero
	li $v0, 11 # load print character syscall id
	li $a0, '#' # # ascii value
	addi $t6, $t6, -1 # substract t6 (we only print # t6 amount of times)
	syscall # print #
	j histogram_loop # jump to histogram_loop
	
	continue:
	# print new line character
	li $v0, 11
	li $a0, 10 # new line ascii value
	syscall
	
	######## end loop operations
	# increment character_set address pointer
	addi $s0, $s0, 1
	# increment counter_array counter (4 bytes because array is 32-bit integer)
	addi $s2, $s2, 4
	j charset_display_loop # jump to charset_display_loop
	
	print_exit:
	jr $ra # return from subroutine
	
.data 
	# we convert to all letters to lowercase therefore we only have to do a single if condition per letter instead of two
	character_set: .asciiz "knights"
	# int array to contain letter counts
	# indexes [K] [N] [I] [G] [H] [T] [S]
	counter_array: .space 28
# sample_text: .asciiz "Lorem, ipsum."
# sample_text: .asciiz "Lorem ipsum dolor sit."
# sample_text: .asciiz "Lorem ipsum dolor sit amet, consectetur adipisicing elit."
# sample_text: .asciiz "Lorem ipsum dolor sit amet consectetur adipisicing elit. Harum maxime magni nostrum soluta est dolores ad?"
# sample_text: .asciiz "Lorem, ipsum dolor sit amet consectetur adipisicing elit. Modi quas, voluptatum laudantium incidunt voluptatibus blanditiis provident vitae voluptate exercitationem recusandae ullam distinctio libero sit quos delectus vero nostrum ex cupiditate ipsa atque."
#sample_text: .asciiz "!@#$%%^&*()_+135790-="
#sample_text: .asciiz "KNIGHTS ABCDEFGHIJKLMNOPQRSTUVWXYZ"
#sample_text: .asciiz "knights abcdefghijklmnopqrstuvwxyz"
