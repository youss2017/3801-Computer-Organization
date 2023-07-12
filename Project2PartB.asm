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
# s0 - count of letters K
# s1 - count of letters N
# s2 - count of letters I
# s3 - count of letters G
# s4 - count of letters H
# s5 - count of letters T
# s6 - count of letters S
# t7 - address of current character
# s7 - current character

.text
start:
	# load sample text address in t0
	la $t7, sample_text
	# step through text until null termination
	text_loop:
	# t1 contain the current character value
	lb $s7, ($t7)
	# if current character is 0 then we have reached the end of string
	# and must exit
	beq $s7, 0, text_loop_end
	# jump to routine to count character
	jal count_letter
	# increment sample text address pointer to read next character
	addi $t7, $t7, 1
	j text_loop # jump to text_loop
	
	text_loop_end:
	jal print_output # print output in integer form
	
	exit:
	# exit program
	li $v0, 10
	syscall # syscall

# determines if letter is in the character set (not-case sensitive), character must be in $t1
# note that t1 will be converted to a lowercase letter upon return
count_letter:
	# convert letter to lowercase if it is uppercase
	bge $s7, 'a', check
	addi $s7, $s7, 32
	# $s0 contains character_set address
	# $s1 contains current character in address
	# $s2 used to determine the index of character
	check:
	k_check:
	bne $s7, 'k', n_check
	addi $s0, $s0, 1
	jr $ra
	n_check:
	bne $s7, 'n', i_check
	addi $s1, $s1, 1
	jr $ra
	i_check:
	bne $s7, 'i', g_check
	addi $s2, $s2, 1
	jr $ra
	g_check:
	bne $s7, 'g', h_check
	addi $s3, $s3, 1
	jr $ra
	h_check:
	bne $s7, 'h', t_check
	addi $s4, $s4, 1
	jr $ra
	t_check:
	bne $s7, 't', s_check
	addi $s5, $s5, 1
	jr $ra
	s_check:
	bne $s7, 's', none_pass
	addi $s6, $s6, 1
	none_pass:
	jr $ra
	
	
print_output:
	k_print:
	li $v0, 11
	li $a0, 'K'
	syscall
	li $a0, ':'
	syscall
	move $a0, $s0
	li $v0, 1
	syscall
	
	li $a0, 10
	li $v0, 11
	syscall
	
	n_print:
	li $v0, 11
	li $a0, 'N'
	syscall
	li $a0, ':'
	syscall
	move $a0, $s1
	li $v0, 1
	syscall
	
	li $a0, 10
	li $v0, 11
	syscall
	
	i_print:
	li $v0, 11
	li $a0, 'I'
	syscall
	li $a0, ':'
	syscall
	move $a0, $s2
	li $v0, 1
	syscall
	
	li $a0, 10
	li $v0, 11
	syscall
	
	g_print:
	li $v0, 11
	li $a0, 'g'
	syscall
	li $a0, ':'
	syscall
	move $a0, $s3
	li $v0, 1
	syscall
	
	li $a0, 10
	li $v0, 11
	syscall
	
	h_print:
	li $v0, 11
	li $a0, 'H'
	syscall
	li $a0, ':'
	syscall
	move $a0, $s4
	li $v0, 1
	syscall
	
	li $a0, 10
	li $v0, 11
	syscall
	
	t_print:
	li $v0, 11
	li $a0, 'T'
	syscall
	li $a0, ':'
	syscall
	move $a0, $s5
	li $v0, 1
	syscall
	
	li $a0, 10
	li $v0, 11
	syscall
	
	s_print:
	li $v0, 11
	li $a0, 'S'
	syscall
	li $a0, ':'
	syscall
	move $a0, $s6
	li $v0, 1
	syscall
	
	########## Histograms	
	k_hist:
	li $a0, 10
	li $v0, 11
	syscall
	li $v0, 11
	li $a0, 'K'
	syscall
	li $a0, ':'
	syscall
	
	li $v0, 11
	li $a0, '#'
	bgtz $s0, k_loop
	j n_hist
	k_loop:
	addi $s0, $s0, -1
	syscall
	bgtz $s0, k_loop
	
	########## Histograms	
	n_hist:
	li $a0, 10
	li $v0, 11
	syscall
	li $v0, 11
	li $a0, 'N'
	syscall
	li $a0, ':'
	syscall
	
	li $v0, 11
	li $a0, '#'
	bgtz $s1, n_loop
	j i_hist
	n_loop:
	addi $s1, $s1, -1
	syscall
	bgtz $s1, n_loop
	
	########## Histograms	
	i_hist:
	li $a0, 10
	li $v0, 11
	syscall
	li $v0, 11
	li $a0, 'I'
	syscall
	li $a0, ':'
	syscall
	
	li $v0, 11
	li $a0, '#'
	bgtz $s2, i_loop
	j g_hist
	i_loop:
	addi $s2, $s2, -1
	syscall
	bgtz $s2, i_loop
	
	########## Histograms	
	g_hist:
	li $a0, 10
	li $v0, 11
	syscall
	li $v0, 11
	li $a0, 'G'
	syscall
	li $a0, ':'
	syscall
	
	li $v0, 11
	li $a0, '#'
	bgtz $s3, g_loop
	j h_hist
	g_loop:
	addi $s3, $s3, -1
	syscall
	bgtz $s3, g_loop
	
	########## Histograms	
	h_hist:
	li $a0, 10
	li $v0, 11
	syscall
	li $v0, 11
	li $a0, 'H'
	syscall
	li $a0, ':'
	syscall
	
	li $v0, 11
	li $a0, '#'
	bgtz $s4, h_loop
	j t_hist
	h_loop:
	addi $s4, $s4, -1
	syscall
	bgtz $s4, h_loop
	
	########## Histograms	
	t_hist:
	li $a0, 10
	li $v0, 11
	syscall
	li $v0, 11
	li $a0, 'T'
	syscall
	li $a0, ':'
	syscall
	
	li $v0, 11
	li $a0, '#'
	bgtz $s5, t_loop
	j s_hist
	t_loop:
	addi $s5, $s5, -1
	syscall
	bgtz $s5, t_loop
	
	########## Histograms	
	s_hist:
	li $a0, 10
	li $v0, 11
	syscall
	li $v0, 11
	li $a0, 'S'
	syscall
	li $a0, ':'
	syscall
	
	li $v0, 11
	li $a0, '#'
	bgtz $s6, s_loop
	jr $ra
	s_loop:
	addi $s6, $s6, -1
	syscall
	bgtz $s6, s_loop
	
	jr $ra	
.data 
	sample_text: .asciiz "knightsUCF was originally founded in 1963 and is the largest university in the country today per enrollment.\nThe College of Engineering and Computer Science (CECS) hosts an assortment of 17 Engineering\nprograms for students to choose from. In fact, Computer Engineering ranks fifth place in the top 5\nCECS degrees offered by UCF."
	
	
	
	
	