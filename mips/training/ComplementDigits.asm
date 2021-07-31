	.data
prompt:	.asciiz "Enter digit sequence: "
str:	.space 100

	.text
	.globl main
	
main:
	li $v0, 4
	la $a0, prompt
	syscall
	
	li $v0, 8
	la $a0, str
	li $a1, 100
	syscall
	
	la $t0, str
	
	li $t3, '0'
	li $t4, '9'
	li $t5, 9 # difference between '0' and '9'
	
loop:
	lb $t1, ($t0)
	beqz $t1, end
	
	blt $t1, $t3, step
	bgt $t1, $t4, step
	
	sub $t1, $t1, $t3
	sub $t1, $t5, $t1
	add $t1, $t1, $t3
	
step:
	sb $t1, ($t0)
	addi $t0, $t0, 1
	j loop

end:
	li $v0, 4
	la $a0, str
	syscall

	li $v0, 10
	syscall
