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
	
	la $t0, str # $t0 points to last element of text

go_to_end:
	lb $t1, ($t0)
	beqz $t1, continue
	addi $t0, $t0, 1
	j go_to_end
					
continue:
	subi $t0, $t0, 2 # -2, because pointer point to '\0' and before '\0' there is '\n'
	
	la $t1, str # address of first element
	
reverse:
	bge $t1, $t0, end
	
	lb $t2, ($t1) # character from left
	lb $t3, ($t0) # character from right
	
	sb $t2, ($t0)
	sb $t3, ($t1)
	
	addi $t1, $t1, 1
	subi $t0, $t0, 1
	
	j reverse

end:
	li $v0, 4
	la $a0, str
	syscall
	
	li $v0, 10
	syscall
