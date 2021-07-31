	.data
prompt:	.asciiz "Enter text: "
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
	
	li $t0, 'A'
	li $t1, 'Z'
	li $t2, 0x20
	
	la $t3, str
	
loop:
	
	lb $t4, ($t3)
	beqz $t4, end
	
	blt $t4, $t0, step
	bgt $t4, $t1, step
	
	addi $t4, $t4, 0x20
	sb $t4, ($t3)
	
step:
	addi $t3, $t3, 1
	j loop

end:
	li $v0, 4
	la $a0, str
	syscall	

	li $v0, 10
	syscall