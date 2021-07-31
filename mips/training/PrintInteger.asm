	.data
msg:	.asciiz "You entered: "
value:	.word 0
	
	.text
	.globl main
	
main:
	li $v0, 5
	syscall
	
	sw $v0, value
	
	li $v0, 4
	la $a0, msg
	syscall
	
	li $v0, 1
	lw $a0, value
	syscall
	
	li $v0, 10
	syscall
