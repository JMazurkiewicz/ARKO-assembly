	.data
info:	.asciiz "Program arguments:\n"

	.text
	.globl main
main:

	move $t0, $a0
	move $t1, $a1
	
	li $v0, 4
	la $a0, info
	syscall
	
loop:
	beqz $t0, end
	
	li $v0, 4
	lw $a0, ($t1)
	syscall
	
	li $v0, 11
	li $a0, '\n'
	syscall
	
	subi $t0, $t0, 1
	addi $t1, $t1, 4
	j loop
			
end:
	li $v0, 10
	syscall
