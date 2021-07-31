        .data
buf:    .space 256

        .text
        .globl main

main:
        li $v0, 8
        la $a0, buf
        li $a1, 256
        syscall

        la $t2, buf
        move $t4, $t2

find_last_seq:
        lbu $t3, ($t2)
        bltu $t3, ' ', continue

        addiu $t2, $t2, 1
        bltu $t3, '0', find_last_seq
        bgtu $t3, '9', find_last_seq

        move $t4, $t2
        subiu $t4, $t4, 1

find_next_nondigit:
        lbu $t3, ($t2)
        addiu $t2, $t2, 1

        bltu $t3, '0', find_last_seq
        bgtu $t3, '9', find_last_seq
        b find_next_nondigit

continue:
        move $t5, $t4 # dest

replace:
        lbu $t3, ($t4)
        bltu $t3, ' ', exit

        addiu $t4, $t4, 1

        bltu $t3, '0', do_replace
        bleu $t3, '9', replace

do_replace:
        sb $t3, ($t5)
        addiu $t5, $t5, 1

        b replace

exit:
        li $t3, '\0'
        sb $t3, ($t5)

        li $v0, 4
        la $a0, buf
        syscall

        li $v0, 10
        syscall