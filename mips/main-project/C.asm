# Program zamieniajacy dowolny plik na plik zrodlowy w jezyku C,
# reprezentujacy ten plik jako wektor bajtow zapisanych w postaci
# szesnastkowej. Plik wyjsciowy powinien byc rozsadnie sformatowany
# (16 bajtow w wierszu, co 16 wierszy komentarz z licznikiem bajtow,
# na koncu komentarz z calkowita liczba bajtow).
	
	.data
fout:	.asciiz "output.txt"
	
iferr:	.asciiz "Nie udalo sie otworzyc pliku wejsciowego!"
oferr:	.asciiz "Nie udalo sie otworzyc pliku wyjsciowego!"

intro:	.ascii "unsigned char vector[] = {\n\n" # sizeof = 28
outro:	.ascii "\n}; // " # sizeof = 7

linebeg:.ascii "\t" # sizeof = 1
lineend:.ascii "\n" # sizeof = 1

commbeg:.ascii "\t// " # sizeof = 4
commend:.ascii " bytes\n\n" # sizeof = 7

buf:	.space 16
byte:	.ascii "0xXX, " # 2($) -> druga cyfra, 3($) -> pierwsza cyfra, sizeof = 6
digits:	.ascii "0123456789ABCDEF"

itos:	.space 10

	.text
	.globl main
main:
	bltu $a0, 1, quick_exit

	li $v0, 13
	lw $a0, ($a1)
	li $a1, 0
	li $a2, 0
	syscall
	
	bltz $v0, input_file_error
	move $s0, $v0
	
	li $v0, 13
	la $a0, fout
	li $a1, 1
	li $a2, 0
	syscall
	
	bltz $v0, output_file_error
	move $s1, $v0
	
	li $v0, 15
	move $a0, $s1
	la $a1, intro
	li $a2, 28
	syscall
	
	# $s2 zawiera licznik bajtow
	# $s3 zawiera licznik linii
	# $s4 zawiera bufor na akutalnie wypisywany bajt
	li $s2, 0
	li $s3, 0
	la $s4, byte

process_file:
	li $v0, 14
	move $a0, $s0
	la $a1, buf
	li $a2, 16
	syscall
	
	move $t0, $v0
	beqz $t0, print_outro
		
	bne $s3, 16, no_comment
	li $s3, 0
	
	li $v0, 15
	move $a0, $s1
	la $a1, commbeg
	li $a2, 4
	syscall
	
	move $a0, $s2
	jal int_to_string
	move $t1, $v0
	
	li $v0, 15
	move $a0, $s1
	la $a1, itos
	move $a2, $t1
	syscall
	
	li $v0, 15
	move $a0, $s1
	la $a1, commend
	li $a2, 8
	syscall
	
no_comment:
	addu $s2, $s2, $t0
	addiu $s3, $s3, 1

	li $v0, 15
	move $a0, $s1
	la $a1, linebeg
	li $a2, 1
	syscall
	
	la $t1, buf
	move $t2, $t1
	addu $t2, $t2, $t0
	
process_byte:
	lbu $t3, ($t1)
	and $t5, $t3, 0x0F
	sra $t3, $t3, 4
	subu $t5, $t5, $t3
	
	la $t4, digits
	addu $t4, $t4, $t3
	lbu $t3, ($t4)
	sb $t3, 2($s4)
	
	addu $t4, $t4, $t5
	lbu $t3, ($t4)
	sb $t3, 3($s4)
	
	li $v0, 15
	move $a0, $s1
	la $a1, byte
	li $a2, 6
	syscall
	
	addiu $t1, $t1, 1
	bltu $t1, $t2, process_byte
	
	li $v0, 15
	move $a0, $s1
	la $a1, lineend
	li $a2, 1
	syscall
	
	b process_file
	
print_outro:
	li $v0, 15
	move $a0, $s1
	la $a1, outro
	li $a2, 7
	syscall
	
	move $a0, $s2
	jal int_to_string
	move $t0, $v0
	
	li $v0, 15
	move $a0, $s1
	la $a1, itos
	move $a2, $t0
	syscall
	
	b exit
	
input_file_error:
	li $v0, 4
	la $a0, iferr
	syscall
	b quick_exit
	
output_file_error:
	li $v0, 4
	la $a0, oferr
	syscall
	b quick_exit
	
exit:
	move $a0, $s0
	li $v0, 16
	syscall
	
	move $a0, $s1
	li $v0, 16
	syscall

quick_exit:
	li $v0, 10
	syscall
	
int_to_string:
	la $t9, itos
	
push_digits:
	li $t6, 10
	divu $a0, $t6
	
	mfhi $t8
	mflo $a0
	
	addiu $t8, $t8, '0'
	sb $t8, ($t9)
	
	addiu $t9, $t9, 1
	bnez $a0, push_digits

	la $t8, itos
	subu $v0, $t9, $t8
	subiu $t9, $t9, 1

reverse:	
	lbu $t7, ($t9)
	lbu $t6, ($t8)

	sb $t6, ($t9)
	sb $t7, ($t8)
	
	addiu $t8, $t8, 1
	subiu $t9, $t9, 1
	
	bltu $t8, $t9, reverse
	
	jr $ra
