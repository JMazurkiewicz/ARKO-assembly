	.data
msg:	.asciiz "Hello world!"

	.text
	.globl main
	
main:
	la $a0dd, msg
	li $v0, 4
	syscall
	
	li $v0, 10
	syscall