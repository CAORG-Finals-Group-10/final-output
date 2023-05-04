# djb2 hash algorithm in MIPS for MARS
# $t0 - 5381 (This value constatly gets updated for every character in the string
# $t1 - pointer 
# $t2 - temporary variable used to hold value of  string shifted to 5
# $s0 - user string is here
.data
	prompt: .asciiz "Enter a string: "
	result: .asciiz "Hash value: "
	buffer: .space 256	
.text
.globl main
main:
	# print prompt for user input
	li $v0, 4
	la $a0, prompt
	syscall

	# read user input into buffer
	li $v0, 8
	la $a0, buffer
	li $a1, 256
	syscall

	# set $s0 to the start of the string
	move $s0, $a0

	# initialize hash to 5381
	li $t0, 5381

hash_loop:
	# load the next character from the input into $t1
	lbu $t1, ($s0)

	# if $t1 is zero, we've reached the end of the input, so exit the loop
	beqz $t1, done

	# exclude null terminator from hash computation
	bne $t1, 10, skip

	# exit the loop if the null terminator is encountered
	j done

skip:
	# update the hash: hash = hash * 33 + c
	sll $t2, $t0, 5
	addu $t0, $t2, $t0
	addu $t0, $t0, $t1

	# advance to the next character in the input
	addiu $s0, $s0, 1

	# repeat the loop for the next character
	j hash_loop

done:
	# print the hash value
	li $v0, 4
	la $a0, result
	syscall

	li $v0, 36
	move $a0, $t0
	syscall

	# exit the program
	li $v0, 10
	syscall
