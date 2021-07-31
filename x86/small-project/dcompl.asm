        global dcompl
        section .text

dcompl:
        push ebp
        mov ebp, esp

        mov eaxe, [ebp+8]

        mov ch, [ebp+12]
        add ch, '0'

main_loop:
        mov cl, [eax]
        mov dl, ch

        cmp cl, 0
        je dcompl_exit

        cmp cl, '0'
        jb step

        cmp cl, dl
        ja step

        sub dl, cl
        add dl, '0'
        mov cl, dl

step:
        mov [eax], cl
        inc eax
        jmp main_loop

dcompl_exit:
        mov eax, [ebp+8]
        mov esp, ebp
        pop ebp
        ret
