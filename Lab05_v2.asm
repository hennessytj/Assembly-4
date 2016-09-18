%include "asm_io.inc"
segment .data 
    a dd 0
    b dd 0
    result dd 0

    ; format strings
    print_form db "Op %d %c %d = %d",0xA,0
    test_form db "%d",0xA,0

segment .bss 
    ; section for char variables
    op resb 1

segment .text
        global  asm_main
        extern printf
asm_main:
        enter   0,0               ; setup routine
        pusha
	;***************CODE STARTS HERE***************************
top:
        ; read in values
        mov eax, 0
        call read_int
        mov [a], eax
        call read_int
        mov [b], eax
        call read_char      ; throw away '\n'
        call read_char
        mov [op], al

        ; determine what operation
        mov cl, 'E'
        cmp [op], cl
            je exit

        mov cl, '+'
        cmp [op], cl
            je setup_add

        mov cl, '*'
        cmp [op], cl
            je setup_mult
        
        mov cl, '^'
        cmp [op], cl
            je setup_exponent

        ; if it falls through to this point
        ; there is a problem and program exits
        jmp exit
        
setup_add:
        push dword [b]
        push dword [a]
        call add
        add esp, 8h
        jmp print_results

setup_mult:
        push dword [b]
        push dword [a]
        call mult
        add esp, 8h
        jmp print_results

setup_exponent:
        push dword [b]
        push dword [a]
        call exponent
        add esp, 8h
        jmp print_results

print_results:
        ; printf("Op %d %c %d = %d, a, op, b, results);
        push dword [result]
        push dword [b]
        push dword [op]
        push dword [a]
        push print_form
        call printf
        add esp, 14h

        ; unconditional branch to top of loop
        jmp top

exit:
        ; program exits

        ;***************CODE ENDS HERE*****************************
        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret

add:
    mov eax, [esp+4]
    mov ebx, [esp+8]
    add eax, ebx
    mov [result], eax
    ret

mult:
   mov eax, [esp+4]
   mov ebx, [esp+8]
   imul eax, ebx
   mov [result], eax
   ret

exponent:
    mov eax, [esp+4]
    mov ebx, [esp+8]
    mov ecx, 1
    exp_top:
        cmp ebx, 0
            jle exp_done
        imul ecx, eax
        dec ebx
        jmp exp_top
    exp_done:
    mov [result], ecx
    ret
