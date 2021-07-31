	.data
prompt:	.asciiz "Enter text: "
str:	.space 128

	.text
	.globl main
main:
	li $v0, 4
	la $a0, prompt
	syscall
	
	li $v0, 8
	la $a0, str
	li $a1, 128
	syscall
	
	la $t0, str # source
	la $t1, str # target
	
	# we are going to remove all small letters
	li $t3, 'A'
	li $t4, 'Z'
	
loop:
	lbu $t2, ($t0)
	bltu $t2, ' ', exit
	
	addiu $t0, $t0, 1
	
	# "don't remove" conditions
	bltu $t2, $t3, no_remove
	bgtu $t2, $t4, no_remove
	
	b loop
	
no_remove:
	sb $t2, ($t1)
	addiu $t1, $t1, 1	
	b loop
	
exit:
	sb $zero, ($t1)

	li $v0, 4
	la $a0, str
	syscall

	li $v0, 10
	syscall