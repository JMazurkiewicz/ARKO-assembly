	.data
prompt:	.asciiz "Podaj tekst: "
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
	
	la $t0, str # w $t0 bedzie adres ostatniego elementu tekstu

go_to_end:
	lb $t1, ($t0)
	beqz $t1, continue
	addi $t0, $t0, 1
	j go_to_end
					
continue:
	subi $t0, $t0, 2 # -2, gdyz wskaznik wskazuje na '\0', a przed '\0' jest '\n'
	
	la $t1, str # adres pierwszego elementu
	
reverse:
	bge $t1, $t0, end
	
	lb $t2, ($t1) # bierzemy znak od lewej
	lb $t3, ($t0) # bierzemy znak od prawej
	
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
