## tab set to 6 spaces

# Author:			Jonathan Diller -- 09 Apr 18 
# E-mail:			jad85@psu.edu 
# Course:			CMPSC 312 
# Assignment:		MIPS Programming Project 
# Due date:			4/11/2018 
# File:			triangleWithLoop.asm 
# Purpose:			This program prompts a user to enter 3 positive integers 
# 					and reports whether or not they form a triangle. 
# Simulator:		MARS 4.5 
# Operating system:	ubuntu 16.04 LTS
# References:		MIPS Assembly Language Programming, CS50 Discussion and Project Book
#					-- Daniel J. Ellard
#					-- https://www.cs.ucsb.edu/~franklin/64/lectures/mipsassemblytutorial.pdf
# Registers used:
# $t0 -- holds side A / check against user continue input
# $t1 -- holds side B
# $t2 -- holds side C
# $t3 -- holds sum of each combination of sides / user continue selection
# $v0 -- syscall parameters / return values
# $a0 -- syscall parameter

	.text
main:
	li	$v0, 4			# load "print_string" into v0
	la	$a0, greeting		# load address of greating into a0
	syscall
	
main_loop:
	li	$v0, 4			# load "print_string" into v0
	la	$a0, instruction		# load address of greating into a0
	syscall
	
	## get numbers from user
read_A:
	li	$v0, 5			# load syscall read_int into v0
	syscall				# make syscall
	move	$t0, $v0			# move A into t0
	
	bgtz	$t0, read_B			# if(t0 > 0) -> read_B
						#  else this is an invalid entry
	li	$v0, 4			# load "print_string" into v0
	la	$a0, invalid_entry	# load address of invalid_entry into a0
	syscall
	
	b	read_A			# re-read A
	
read_B:
	li	$v0, 5			# load syscall read_int into v0
	syscall				# make syscall
	move	$t1, $v0			# move B into t1
	
	bgtz	$t1, read_C			# if(t1 > 0) -> read_C
						#  else this is an invalid entry
	li	$v0, 4			# load "print_string" into v0
	la	$a0, invalid_entry	# load address of invalid_entry into a0
	syscall
	
	b	read_B			# re-read B
	
read_C:
	li	$v0, 5			# load syscall read_int into v0
	syscall				# make syscall
	move	$t2, $v0			# move C into t2
	
	bgtz	$t2, check_sides		# if(t2 > 0) -> check_sides
						#  else this is an invalid entry
	li	$v0, 4			# load "print_string" into v0
	la	$a0, invalid_entry	# load address of invalid_entry into a0
	syscall
	
	b	read_C			# re-read C
	
check_sides:
	## Check the sum of each comination of side and compare them to the third side
	add	$t3, $t0, $t1		# Add A and B, store in t3
	bge	$t2, $t3, not_triangle	# if(t2 >= t3) -> not_triangle
	
	add	$t3, $t0, $t2		# Add A and B, store in t3
	bge	$t1, $t3, not_triangle	# if(t1 >= t3) -> not_triangle
	
	add	$t3, $t1, $t2		# Add A and B, store in t3
	bge	$t0, $t3, not_triangle	# if(t0 >= t3) -> not_triangle
	
	li	$v0, 4			# load "print_string" into v0
	la	$a0, is_t			# load address of is_t into a0
	syscall
	
	b	continue			# branch to continue
	
not_triangle:
	li	$v0, 4			# load "print_string" into v0
	la	$a0, not_t			# load address of not_t into a0
	syscall
	
continue:
	## Ask user if they would like to continue running the program
	li	$v0, 4			# load "print_string" into v0
	la	$a0, cont_promt		# load address of cont_promt into a0
	syscall
	
	li	$v0, 5			# load syscall read_int into v0
	syscall				# make syscall
	move	$t3, $v0			# move A into t3
	
	li	$t0, 1			# store 1 in t0
	
	beq	$zero, $t3, end		# if(t3 == 0) -> end
	beq	$t0, $t3, main_loop	# if(t3 == 1) -> main_loop
						#  else this is an invalid entry
	li	$v0, 4			# load "print_string" into v0
	la	$a0, invalid_entry	# load address of invalid_entry into a0
	syscall
	
	b	continue			# branch back to top of continue
	
end:
	li	$v0, 10			# load exit code into v0
	syscall
	
	.data
greeting:		.asciiz "Welcome.\n"
instruction:	.asciiz "Enter 3 integers to be checked:\n"
not_t:		.asciiz "These sides do not form a triangle\n"
is_t:			.asciiz "These sides form a triangle\n"
cont_promt:		.asciiz "\nWould you like to continue?\nEnter 1 for yes.\nEnter 0 to exit.\n::"
invalid_entry:	.asciiz "Invalid Entry\n"

# end of triangleWithLoop.asm
