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
# v0 - used for syscall # invoke os to execute current function id 
# a0 - used for syscall # invoke os to execute current function arguments
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
	syscall # invoke os to execute current function # syscall # invoke os to execute current function

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
	# if not k check n
	bne $s7, 'k', n_check
	# increment k counter
	addi $s0, $s0, 1
	# return
	jr $ra
	n_check:
	# if not n check i
	bne $s7, 'n', i_check
	# increment n counter
	addi $s1, $s1, 1
	# return
	jr $ra
	i_check:
	# if not i check g
	bne $s7, 'i', g_check
	# increment i counter
	addi $s2, $s2, 1
	# return
	jr $ra
	g_check:
	# if not g check h
	bne $s7, 'g', h_check
	# increment g counter
	addi $s3, $s3, 1
	# return
	jr $ra
	h_check:
	# if not h check t
	bne $s7, 'h', t_check
	# increment h counter
	addi $s4, $s4, 1
	# return
	jr $ra
	t_check:
	# if not t check s
	bne $s7, 't', s_check
	# increment t counter
	addi $s5, $s5, 1
	# return
	jr $ra
	s_check:
	# if not s then return
	bne $s7, 's', none_pass
	# increment s counter
	addi $s6, $s6, 1
	none_pass:
	# return
	jr $ra
	
	
print_output:
	k_print:
	li $v0, 11 # print characer syscall id
	li $a0, 'K'
	syscall # invoke os to execute current function
	li $a0, ':' # Load ASCII Character
	syscall # invoke os to execute current function
	move $a0, $s0 # set K value
	li $v0, 1 # print integer syscall id
	syscall # invoke os to execute current function
	
	li $a0, 10 # new line ascii code
	li $v0, 11 # print characer syscall id
	syscall # invoke os to execute current function
	
	n_print:
	li $v0, 11 # print characer syscall id
	li $a0, 'N'
	syscall # invoke os to execute current function
	li $a0, ':' # Load ASCII Character
	syscall # invoke os to execute current function
	move $a0, $s1 # set N value
	li $v0, 1 # print integer syscall id
	syscall # invoke os to execute current function
	
	li $a0, 10 # new line ascii code
	li $v0, 11 # print characer syscall id
	syscall # invoke os to execute current function
	
	i_print:
	li $v0, 11 # print characer syscall id
	li $a0, 'I' 
	syscall # invoke os to execute current function
	li $a0, ':' # Load ASCII Character
	syscall # invoke os to execute current function
	move $a0, $s2 # set I value
	li $v0, 1 # print integer syscall id
	syscall # invoke os to execute current function
	
	li $a0, 10 # new line ascii code
	li $v0, 11 # print characer syscall id
	syscall # invoke os to execute current function
	
	g_print:
	li $v0, 11 # print characer syscall id
	li $a0, 'g' # set g value
	syscall # invoke os to execute current function
	li $a0, ':' # Load ASCII Character
	syscall # invoke os to execute current function
	move $a0, $s3
	li $v0, 1 # print integer syscall id
	syscall # invoke os to execute current function
	
	li $a0, 10 # new line ascii code
	li $v0, 11 # print characer syscall id
	syscall # invoke os to execute current function
	
	h_print:
	li $v0, 11 # print characer syscall id
	li $a0, 'H' # se
	syscall # invoke os to execute current function
	li $a0, ':' # Load ASCII Character
	syscall # invoke os to execute current function
	move $a0, $s4
	li $v0, 1 # print integer syscall id
	syscall # invoke os to execute current function
	
	li $a0, 10 # new line ascii code
	li $v0, 11 # print characer syscall id
	syscall # invoke os to execute current function
	
	t_print:
	li $v0, 11 # print characer syscall id
	li $a0, 'T'
	syscall # invoke os to execute current function
	li $a0, ':' # Load ASCII Character
	syscall # invoke os to execute current function
	move $a0, $s5
	li $v0, 1 # print integer syscall id
	syscall # invoke os to execute current function
	
	li $a0, 10 # new line ascii code
	li $v0, 11 # print characer syscall id
	syscall # invoke os to execute current function
	
	s_print:
	li $v0, 11 # print characer syscall id
	li $a0, 'S'
	syscall # invoke os to execute current function
	li $a0, ':' # Load ASCII Character
	syscall # invoke os to execute current function
	move $a0, $s6
	li $v0, 1 # print integer syscall id
	syscall # invoke os to execute current function
	
	########## Histograms	
	k_hist:
	li $a0, 10 # new line ascii code
	li $v0, 11 # print characer syscall id
	syscall # invoke os to execute current function
	li $v0, 11 # print characer syscall id
	li $a0, 'K'
	syscall # invoke os to execute current function
	li $a0, ':' # Load ASCII Character
	syscall # invoke os to execute current function
	
	li $v0, 11 # print characer syscall id
	li $a0, '#'
	bgtz $s0, k_loop
	j n_hist
	k_loop:
	addi $s0, $s0, -1
	syscall # invoke os to execute current function
	bgtz $s0, k_loop
	
	########## Histograms	
	n_hist:
	li $a0, 10 # new line ascii code
	li $v0, 11 # print characer syscall id
	syscall # invoke os to execute current function
	li $v0, 11 # print characer syscall id
	li $a0, 'N'
	syscall # invoke os to execute current function
	li $a0, ':' # Load ASCII Character
	syscall # invoke os to execute current function
	
	li $v0, 11 # print characer syscall id
	li $a0, '#'
	bgtz $s1, n_loop
	j i_hist
	n_loop:
	addi $s1, $s1, -1
	syscall # invoke os to execute current function
	bgtz $s1, n_loop
	
	########## Histograms	
	i_hist:
	li $a0, 10 # new line ascii code
	li $v0, 11 # print characer syscall id
	syscall # invoke os to execute current function
	li $v0, 11 # print characer syscall id
	li $a0, 'I'
	syscall # invoke os to execute current function
	li $a0, ':' # Load ASCII Character
	syscall # invoke os to execute current function
	
	li $v0, 11 # print characer syscall id
	li $a0, '#'
	bgtz $s2, i_loop
	j g_hist
	i_loop:
	addi $s2, $s2, -1
	syscall # invoke os to execute current function
	bgtz $s2, i_loop
	
	########## Histograms	
	g_hist:
	li $a0, 10 # new line ascii code
	li $v0, 11 # print characer syscall id
	syscall # invoke os to execute current function
	li $v0, 11 # print characer syscall id
	li $a0, 'G'
	syscall # invoke os to execute current function
	li $a0, ':' # Load ASCII Character
	syscall # invoke os to execute current function
	
	li $v0, 11 # print characer syscall id
	li $a0, '#'
	bgtz $s3, g_loop
	j h_hist
	g_loop:
	addi $s3, $s3, -1
	syscall # invoke os to execute current function
	bgtz $s3, g_loop
	
	########## Histograms	
	h_hist:
	li $a0, 10 # new line ascii code
	li $v0, 11 # print characer syscall id
	syscall # invoke os to execute current function
	li $v0, 11 # print characer syscall id
	li $a0, 'H'
	syscall # invoke os to execute current function
	li $a0, ':' # Load ASCII Character
	syscall # invoke os to execute current function
	
	li $v0, 11 # print characer syscall id
	li $a0, '#'
	bgtz $s4, h_loop # goto h_loop
	j t_hist
	h_loop:
	addi $s4, $s4, -1
	syscall # invoke os to execute current function
	bgtz $s4, h_loop # goto h_loop
	
	########## Histograms	
	t_hist:
	li $a0, 10 # new line ascii code
	li $v0, 11 # print characer syscall id
	syscall # invoke os to execute current function
	li $v0, 11 # print characer syscall id
	li $a0, 'T'
	syscall # invoke os to execute current function
	li $a0, ':' # Load ASCII Character
	syscall # invoke os to execute current function
	
	li $v0, 11 # print characer syscall id
	li $a0, '#'
	bgtz $s5, t_loop
	j s_hist
	t_loop:
	addi $s5, $s5, -1
	syscall # invoke os to execute current function
	bgtz $s5, t_loop
	
	########## Histograms	
	s_hist:
	li $a0, 10 # new line ascii code
	li $v0, 11 # print characer syscall id
	syscall # invoke os to execute current function
	li $v0, 11 # print characer syscall id
	li $a0, 'S'
	syscall # invoke os to execute current function
	li $a0, ':' # Load ASCII Character
	syscall # invoke os to execute current function
	
	li $v0, 11 # print characer syscall id
	li $a0, '#'
	bgtz $s6, s_loop # goto s_loop
	jr $ra
	s_loop:
	addi $s6, $s6, -1
	syscall # invoke os to execute current function
	bgtz $s6, s_loop # goto s_loop 
	
	jr $ra	
.data 
# sample_text: .asciiz "Lorem, ipsum."
# sample_text: .asciiz "Lorem ipsum dolor sit."
# sample_text: .asciiz "Lorem ipsum dolor sit amet, consectetur adipisicing elit."
# sample_text: .asciiz "Lorem ipsum dolor sit amet consectetur adipisicing elit. Harum maxime magni nostrum soluta est dolores ad?"
 sample_text: .asciiz "Lorem, ipsum dolor sit amet consectetur adipisicing elit. Modi quas, voluptatum laudantium incidunt voluptatibus blanditiis provident vitae voluptate exercitationem recusandae ullam distinctio libero sit quos delectus vero nostrum ex cupiditate ipsa atque."	
