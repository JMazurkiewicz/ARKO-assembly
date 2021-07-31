	.data
prompt: .asciiz "Enter text: "
str:	.space 64

	.text
	.globl main
main:
	li $v0, 4
	la $a0, prompt
	syscall
	
	li $v0, 8
	la $a0, str
	li $a1, 64
	syscall
	
	la $t0, str   # $t0 points to first character of text
	move $t1, $t0 # $t1 points to last printable character of text
	
goto_end:
	lbu $t2, ($t1)
	blt $t2, ' ', prepare_algo
	addiu $t1, $t1, 1
	b goto_end
	
prepare_algo:
	subiu $t1, $t1, 1
	
	# we are going to reverse order of small letters only
	li $t2, 'a'
	li $t3, 'z'

from_start:
	beq $t0, $t1, exit
	lbu $t4, ($t0)
	addiu $t0, $t0, 1
	blt $t4, $t2, from_start
	bgt $t4, $t3, from_start
	
from_end:
	beq $t1, $t0, exit
	lbu $t5, ($t1)
	subiu $t1, $t1, 1
	blt $t5, $t2, from_end
	bgt $t5, $t3, from_end
	
	sb $t4, 1($t1)
	sb $t5, -1($t0)
	b from_start
	
exit:
	li $v0, 4
	la $a0, str
	syscall

	li $v0, 10
	syscall